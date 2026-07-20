require "test_helper"

class BandChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @member = User.create!(email_address: "band-member@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: @member, role: :member)
    BandMembership.create!(band: @band, user: @member, role: :member)

    @direct_channel = ChatChannel.create!(band: @band, kind: :direct, name: "Private channel")
    @direct_channel.chat_channel_participants.create!(user: users(:one))
    @direct_channel.chat_messages.create!(user: users(:one), body: "This must stay private")
  end

  test "does not expose direct channels to a non-participant band member" do
    sign_in_as @member

    get chat_band_path(@band, channel_id: @direct_channel.id)

    assert_response :success
    assert_select "body", text: /Private channel/, count: 0
    assert_select "body", text: /This must stay private/, count: 0
  end

  test "does not allow an account member without band membership to view chat" do
    account_member = User.create!(email_address: "account-member@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: account_member, role: :member)
    sign_in_as account_member

    get chat_band_path(@band)

    assert_redirected_to root_path
  end
end
