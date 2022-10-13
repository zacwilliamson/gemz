class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_many :notifications, as: :notifiable

  validates :user_id, presence: true
  validates :friend_id, presence: true
end
