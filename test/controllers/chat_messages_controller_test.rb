require "test_helper"

class ChatMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @member = User.create!(email_address: "message-member@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: @member, role: :member)
    BandMembership.create!(band: @band, user: @member, role: :member)
    @channel = ChatChannel.create!(band: @band, kind: :general, name: "General")
    @message = @channel.chat_messages.create!(user: users(:one), body: "Practice starts at seven")
  end

  test "creates a threaded reply and notifies the parent author" do
    sign_in_as @member

    assert_difference([ "ChatMessage.count", "Notification.count" ], 1) do
      post chat_messages_path, params: {
        chat_channel_id: @channel.id,
        chat_message: { body: "I will be there.", parent_id: @message.id }
      }
    end

    reply = ChatMessage.last
    assert_redirected_to chat_band_path(@band, channel_id: @channel.id)
    assert_equal @message, reply.parent
    assert_equal users(:one), Notification.last.user
    assert_equal "chat_reply", Notification.last.kind
    assert_enqueued_with(job: PushNotificationJob, args: [ Notification.last ])
  end

  test "rejects a reply whose parent belongs to another channel" do
    other_channel = ChatChannel.create!(band: @band, kind: :gigs, name: "Gigs")
    other_message = other_channel.chat_messages.create!(user: users(:one), body: "Soundcheck details")
    sign_in_as @member

    assert_no_difference("ChatMessage.count") do
      post chat_messages_path, params: {
        chat_channel_id: @channel.id,
        chat_message: { body: "Wrong thread", parent_id: other_message.id }
      }
    end

    assert_redirected_to chat_band_path(@band, channel_id: @channel.id)
  end

  test "does not allow a non-participant to message a direct channel" do
    direct_channel = ChatChannel.create!(band: @band, kind: :direct, name: "Private")
    direct_channel.chat_channel_participants.create!(user: users(:one))
    sign_in_as @member

    assert_no_difference("ChatMessage.count") do
      post chat_messages_path, params: { chat_channel_id: direct_channel.id, chat_message: { body: "Can you see this?" } }
    end

    assert_response :not_found
  end
end
