class BandCalendarsController < ApplicationController
  allow_unauthenticated_access only: %i[public_feed private_feed]

  def private_feed
    band = Band.find(params[:band_id])
    return head :not_found unless secure_token_match?(band.private_calendar_token, params[:token])

    events = band.events.order(starts_at: :asc)
    render_calendar(band: band, events: events, public_feed: false)
  end

  def public_feed
    band = Band.find(params[:band_id])
    return head :not_found unless band.public_calendar_enabled?
    return head :not_found unless secure_token_match?(band.public_calendar_token, params[:token])

    events = band.events.order(starts_at: :asc)
    events = events.where(kind: :gig) unless band.public_calendar_include_rehearsals?
    render_calendar(band: band, events: events, public_feed: true)
  end

  private
    def render_calendar(band:, events:, public_feed:)
      calendar = BandCalendarIcs.new(band: band, events: events, public_feed: public_feed).render
      render plain: calendar, content_type: "text/calendar; charset=utf-8"
    end

    def secure_token_match?(token, provided)
      token.present? && ActiveSupport::SecurityUtils.secure_compare(token, provided.to_s)
    end
end
