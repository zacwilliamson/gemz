class Notification < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
    if notifiable_type == 'Friendship'
      'sent you a friend request'
    else
      'accepted your friend request'
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