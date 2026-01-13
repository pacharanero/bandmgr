require "net/http"
require "json"

class PlaylistImporter
  class ImportError < StandardError; end

  Item = Struct.new(:title, :artist, :external_url, :video_url, :notes, keyword_init: true)
  Playlist = Struct.new(:title, :description, :items, :source, keyword_init: true)
  Result = Struct.new(:setlist, :created_count, :existing_count, :source, keyword_init: true)

  def initialize(url:, account:, band:, title: nil, description: nil)
    @url = url
    @account = account
    @band = band
    @title = title
    @description = description
  end

  def import!
    importer = importer_for(@url)
    raise ImportError, "Unsupported playlist URL." unless importer

    playlist = importer.fetch
    raise ImportError, "No songs found in that playlist." if playlist.items.empty?

    setlist = Setlist.new(
      title: @title.presence || playlist.title.presence || "Imported Setlist",
      description: @description.presence || playlist.description,
      band: @band
    )
    setlist.save!

    created_count = 0
    existing_count = 0

    playlist.items.each_with_index do |item, index|
      song = find_or_build_song(item)
      if song.new_record?
        song.save!
        created_count += 1
      else
        existing_count += 1
        hydrate_song_metadata(song, item)
      end

      setlist.setlist_songs.create!(song: song, position: index + 1)
    end

    Result.new(setlist: setlist, created_count: created_count, existing_count: existing_count, source: playlist.source)
  end

  private
    def importer_for(url)
      return SpotifyImporter.new(url: url) if SpotifyImporter.match?(url)
      return YouTubeImporter.new(url: url) if YouTubeImporter.match?(url)

      nil
    end

    def find_or_build_song(item)
      Song.find_or_initialize_by(band: @band, title: item.title, artist: item.artist)
    end

    def hydrate_song_metadata(song, item)
      updates = {}
      updates[:chart_url] = item.external_url if item.external_url.present? && song.chart_url.blank?
      updates[:video_url] = item.video_url if item.video_url.present? && song.video_url.blank?
      updates[:notes] = item.notes if item.notes.present? && song.notes.blank?
      song.update!(updates) if updates.any?
    end

    class SpotifyImporter
      SPOTIFY_HOST = "https://api.spotify.com/v1"
      ACCOUNTS_HOST = "https://accounts.spotify.com"

      def self.match?(url)
        url.include?("open.spotify.com/playlist/")
      end

      def initialize(url:)
        @url = url
      end

      def fetch
        playlist_id = extract_playlist_id
        raise ImportError, "Invalid Spotify playlist URL." if playlist_id.blank?

        token = fetch_access_token
        raise ImportError, "Missing Spotify API credentials." if token.blank?

        playlist = fetch_playlist(playlist_id, token)
        items = playlist.fetch("tracks", {}).fetch("items", []).filter_map do |item|
          track = item["track"]
          next unless track

          title = track["name"].to_s.strip
          next if title.blank?

          artist = track.fetch("artists", []).map { |a| a["name"] }.compact.join(", ").presence
          Item.new(
            title: title,
            artist: artist,
            external_url: track.dig("external_urls", "spotify")
          )
        end

        Playlist.new(
          title: playlist["name"].to_s.strip.presence,
          description: strip_html(playlist["description"].to_s).presence,
          items: items,
          source: :spotify
        )
      end

      private
        def extract_playlist_id
          uri = URI.parse(@url)
          parts = uri.path.to_s.split("/")
          parts[parts.index("playlist") + 1] if parts.include?("playlist")
        rescue URI::InvalidURIError
          nil
        end

        def fetch_access_token
          client_id = ENV["SPOTIFY_CLIENT_ID"].to_s
          client_secret = ENV["SPOTIFY_CLIENT_SECRET"].to_s
          return if client_id.blank? || client_secret.blank?

          uri = URI.parse("#{ACCOUNTS_HOST}/api/token")
          request = Net::HTTP::Post.new(uri)
          request.basic_auth(client_id, client_secret)
          request.set_form_data("grant_type" => "client_credentials")
          response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(request) }
          return if response.code.to_i >= 400

          JSON.parse(response.body)["access_token"]
        end

        def fetch_playlist(playlist_id, token)
          uri = URI.parse("#{SPOTIFY_HOST}/playlists/#{playlist_id}")
          request = Net::HTTP::Get.new(uri)
          request["Authorization"] = "Bearer #{token}"
          response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(request) }
          raise ImportError, "Spotify playlist fetch failed (#{response.code})." if response.code.to_i >= 400

          JSON.parse(response.body)
        end

        def strip_html(text)
          text.gsub(/<[^>]*>/, "").strip
        end
    end

    class YouTubeImporter
      YOUTUBE_HOST = "https://www.youtube.com"

      def self.match?(url)
        url.include?("youtube.com") || url.include?("youtu.be")
      end

      def initialize(url:)
        @url = url
      end

      def fetch
        playlist_id = extract_playlist_id
        raise ImportError, "Invalid YouTube playlist URL." if playlist_id.blank?

        html = fetch_html(playlist_id)
        data = extract_initial_data(html)
        raise ImportError, "Unable to read playlist data from YouTube." unless data

        title = data.dig("metadata", "playlistMetadataRenderer", "title").to_s.strip.presence
        items = extract_video_items(data).filter_map do |video|
          video_id = video["videoId"].to_s
          raw_title = extract_video_title(video)
          next if video_id.blank? || raw_title.blank?
          next if raw_title =~ /(private video|deleted video)/i

          channel = extract_channel_name(video)
          song_title, artist = split_title_and_artist(raw_title, channel)
          Item.new(
            title: song_title,
            artist: artist,
            video_url: "#{YOUTUBE_HOST}/watch?v=#{video_id}"
          )
        end

        Playlist.new(title: title, description: nil, items: items, source: :youtube)
      end

      private
        def extract_playlist_id
          uri = URI.parse(@url)
          params = URI.decode_www_form(uri.query.to_s).to_h
          params["list"]
        rescue URI::InvalidURIError
          nil
        end

        def fetch_html(playlist_id)
          uri = URI.parse("#{YOUTUBE_HOST}/playlist?list=#{playlist_id}")
          Net::HTTP.get(uri)
        end

        def extract_initial_data(html)
          marker = "ytInitialData"
          index = html.index(marker)
          return if index.nil?

          start_index = html.index("{", index)
          return if start_index.nil?

          depth = 0
          i = start_index
          while i < html.length
            char = html[i]
            depth += 1 if char == "{"
            depth -= 1 if char == "}"
            if depth.zero?
              json = html[start_index..i]
              return JSON.parse(json)
            end
            i += 1
          end

          nil
        rescue JSON::ParserError
          nil
        end

        def extract_video_items(data)
          items = []
          stack = [ data ]
          until stack.empty?
            node = stack.pop
            case node
            when Hash
              if node.key?("playlistVideoRenderer")
                items << node["playlistVideoRenderer"]
              else
                node.each_value { |value| stack << value }
              end
            when Array
              node.each { |value| stack << value }
            end
          end
          items
        end

        def extract_video_title(video)
          title = video.dig("title", "simpleText").to_s
          title = video.dig("title", "runs", 0, "text").to_s if title.blank?
          title.strip
        end

        def extract_channel_name(video)
          name = video.dig("shortBylineText", "runs", 0, "text").to_s
          name = video.dig("longBylineText", "runs", 0, "text").to_s if name.blank?
          cleaned = name.strip
          cleaned = cleaned.delete_suffix(" - Topic")
          cleaned.presence
        end

        def split_title_and_artist(raw_title, channel_name)
          title = raw_title.strip
          artist = channel_name

          return [ title, artist ] unless title.include?(" - ")

          left, right = title.split(" - ", 2).map(&:strip)
          if artist.present?
            if left.casecmp?(artist)
              return [ right, artist ]
            elsif right.casecmp?(artist)
              return [ left, artist ]
            end
          end

          [ right, left.presence ]
        end
    end
end
