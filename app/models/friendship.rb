class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, presence: true
  validates :friend_id, presence: true

  def message
    if friend.recived_request?(user)
      'sent you a friend request'
    elsif initial_request?
      'accepted your friend request'
    else
      "'s friend request was accepted"
    end
  end

  def initial_request?
    return unless user.friends_with?(friend)

    other_friendship = friend.friendships.find_by(friend_id: user_id)
    created_at < other_friendship.created_at
  end
end
