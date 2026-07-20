module NotificationsHelper
  def notification_destination(notification)
    case notification.notifiable
    when Task
      tasks_path(band_id: notification.notifiable.band_id)
    when Comment
      notification_destination_for_comment(notification.notifiable)
    when ChatMessage
      chat_band_path(notification.notifiable.chat_channel.band, channel_id: notification.notifiable.chat_channel_id)
    when Event
      event_path(notification.notifiable)
    end
  end

  private

    def notification_destination_for_comment(comment)
      case comment.commentable
      when Task then tasks_path(band_id: comment.commentable.band_id)
      else polymorphic_path(comment.commentable)
      end
    end
end
