class Notification < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
    if friend_request?
      'sent you a friend request'
    elsif friend_accept?
      'accepted your friend request'
    else
      'im just here to party'
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
