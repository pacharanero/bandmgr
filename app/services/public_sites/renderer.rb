class PublicSites::Renderer
  def initialize(band)
    @band = band
  end

  def render
    html = Commonmarker.to_html(expanded_markdown, options: { extension: { header_ids: nil }, render: { unsafe: false } }, plugins: { syntax_highlighter: nil })
    ActionController::Base.helpers.sanitize(html, tags: allowed_tags, attributes: %w[href title])
  end

  private

    attr_reader :band

    def expanded_markdown
      band.public_site_markdown
        .gsub("{{ bandName }}", escaped_markdown(band.name))
        .gsub("{{ description }}", escaped_markdown(band.description))
        .gsub("{{ contact }}", contact_markdown)
        .gsub("{{ gigList | future }}", future_gigs_markdown)
        .gsub("{{ merchUrl }}", merch_markdown)
    end

    def contact_markdown
      return "" if band.public_contact_email.blank?

      "[#{escaped_markdown(band.public_contact_email)}](mailto:#{band.public_contact_email})"
    end

    def future_gigs_markdown
      gigs = band.events.gig.where("starts_at >= ?", Time.current).order(:starts_at)
      return "No upcoming shows are listed." if gigs.empty?

      gigs.map do |gig|
        venue = gig.venue.presence || "Venue to be announced"
        "- **#{gig.starts_at.strftime('%-d %B %Y')}** - #{escaped_markdown(venue)}"
      end.join("\n")
    end

    def merch_markdown
      return "" unless valid_https_url?(band.merch_url)

      "[Visit our merch shop](#{band.merch_url})"
    end

    def escaped_markdown(value)
      value.to_s.gsub(/([\\`*_{}\[\]<>()#+.!|-])/, "\\\\\\1")
    end

    def valid_https_url?(value)
      uri = URI.parse(value)
      uri.is_a?(URI::HTTPS) && uri.host.present?
    rescue URI::InvalidURIError
      false
    end

    def allowed_tags
      %w[a blockquote br code em h1 h2 h3 h4 hr li ol p pre strong ul]
    end
end
