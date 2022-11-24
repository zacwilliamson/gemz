class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :notifications, as: :notifiable, dependent: :destroy # has_one?

  validates :user_id, presence: true
  validates :friend_id, presence: true
  
  def message
    if friend.recived_request?(user)
      'sent you a friend request'
    else
      'is your new friend'
    end
  end
end
