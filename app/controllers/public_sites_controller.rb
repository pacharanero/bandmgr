class PublicSitesController < ApplicationController
  allow_unauthenticated_access only: :show

  def show
    skip_authorization
    @band = Band.find_by(public_domain: request.host.downcase, public_site_enabled: true)
    return redirect_to(current_user ? bands_path : new_session_path) unless @band

    @rendered_content = PublicSites::Renderer.new(@band).render
    @public_links = public_links
    render layout: "public_site"
  end

  private

    def public_links
      {
        "Bandcamp" => @band.bandcamp,
        "Facebook" => @band.facebook,
        "Instagram" => @band.instagram,
        "SoundCloud" => @band.soundcloud,
        "Twitter" => @band.twitter,
        "YouTube" => @band.youtube,
        "Merch" => @band.merch_url
      }.filter_map do |label, url|
        [ label, url ] if valid_https_url?(url)
      end
    end

    def valid_https_url?(value)
      uri = URI.parse(value)
      uri.is_a?(URI::HTTPS) && uri.host.present?
    rescue URI::InvalidURIError
      false
    end
end
