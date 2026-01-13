# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if User.none?
  user = User.create!(
    email_address: "development@bandmgr.band",
    password: "password",
    password_confirmation: "password"
  )

  account = Account.create!(name: "Development Account", slug: "development-account")
  Membership.create!(account: account, user: user, role: :owner)

  band = Band.create!(account: account, name: "Development Band", description: "Example band for development.")
  BandMembership.create!(band: band, user: user, role: :band_admin)

  song = Song.create!(account: account, band: band, title: "Demo Song", artist: "Demo Artist", album: "Demo Album", key: "C", tempo: 120)
  tag = Tag.create!(account: account, name: "rehearsal")
  Tagging.create!(tag: tag, taggable: song)

  Event.create!(band: band, kind: :gig, starts_at: 1.week.from_now, venue: "The Jolly Sailor", notes: "Load-in at 6pm.")
end
