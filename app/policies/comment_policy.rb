class CommentPolicy < ApplicationPolicy
  def create?
    commentable_access?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      task_comment_ids = scope.where(commentable_type: "Task", band_id: user.bands.select(:id)).select(:id)
      account_comment_ids = scope
        .where(commentable_type: %w[Event Song])
        .joins(band: { account: :memberships })
        .where(memberships: { user_id: user.id })
        .select(:id)

      scope.where(id: task_comment_ids).or(scope.where(id: account_comment_ids))
    end
  end

  private

    def commentable_access?
      case record.commentable
      when Task then TaskPolicy.new(user, record.commentable).show?
      when Event then EventPolicy.new(user, record.commentable).show?
      when Song then SongPolicy.new(user, record.commentable).show?
      else false
      end
    end
end
