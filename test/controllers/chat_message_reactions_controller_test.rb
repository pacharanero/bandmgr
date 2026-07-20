require "test_helper"

class ChatMessageReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @member = User.create!(email_address: "chat-member@example.com", password: "password", password_confirmation: "password")
    @account_only_user = User.create!(email_address: "account-only@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: @member, role: :member)
    Membership.create!(account: accounts(:one), user: @account_only_user, role: :member)
    BandMembership.create!(band: @band, user: @member, role: :member)

    @direct_channel = ChatChannel.create!(band: @band, kind: :direct, name: "One and member")
    @direct_channel.chat_channel_participants.create!(user: users(:one))
    @direct_channel.chat_channel_participants.create!(user: @member)
    @message = @direct_channel.chat_messages.create!(user: users(:one), body: "Private chat message")
  end

  test "allows a direct-channel participant to react" do
    sign_in_as @member

    assert_difference("ChatMessageReaction.count", 1) do
      post toggle_chat_message_reaction_path(@message)
    end

    assert_redirected_to chat_band_path(@band, channel_id: @direct_channel.id)
  end

  test "does not allow an account member outside the band to react" do
    sign_in_as @account_only_user

    assert_no_difference("ChatMessageReaction.count") do
      post toggle_chat_message_reaction_path(@message)
    end

    assert_response :not_found
  end

  test "does not allow a non-participant band member to react" do
    sign_in_as users(:one)
    @direct_channel.chat_channel_participants.where(user: users(:one)).delete_all

    assert_no_difference("ChatMessageReaction.count") do
      post toggle_chat_message_reaction_path(@message)
    end

    assert_response :not_found
  end
end
