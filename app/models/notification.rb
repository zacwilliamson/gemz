class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }

  def message
    if friend_request?
      'sent you a friend request'
    elsif friend_accept?
      'is your new friend'
    else
      'default'
    end
  end

  def friend_request?
    return unless notifiable_type == 'Friendship'

    friendship = Friendship.find(notifiable_id)
    user.recived_request?(friendship.user)
  end

  def friend_accept?
    return unless notifiable_type == 'Friendship'

    friendship = Friendship.find(notifiable_id)
    user.friends_with?(friendship.user)
  end

  def sender
    return unless notifiable_type == 'Friendship'

    friendship = Friendship.find(notifiable_id)
    friendship.user
  end
end
