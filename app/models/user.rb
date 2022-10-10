class User < ApplicationRecord
  has_many :friend_requests, class_name: 'Friendship', dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
end
