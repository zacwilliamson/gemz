class User < ApplicationRecord
  has_many :friendships, class_name: 'Friendship', dependent: :destroy
  has_many :friends, through: :friendships
  has_many :recived_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :recived_friends, through: :recived_friendships, source: 'user'
  has_many :notifications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  def active_friends
    friends.select { |their| their.friends.include?(self) }
  end

  def pending_friends
    friends.reject { |their| their.friends.include?(self) }
  end

  def add_friend(other_user)
    return if other_user == self || friends.include?(other_user)

    friends << other_user
  end

  def unfriend(other_user)
    friends.delete(other_user)
    other_user.friends.delete(self)
  end

  def friends_with?(other_user)
    active_friends.include?(other_user)
  end

  def recived_request?(other_user)
    recived_friends.include?(other_user) && !friends_with?(other_user)
  end
end
