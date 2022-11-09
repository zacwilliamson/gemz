class User < ApplicationRecord
  has_many :friendships, class_name: 'Friendship', dependent: :destroy
  has_many :friends, through: :friendships
  has_many :recived_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :recived_friends, through: :recived_friendships, source: 'user'
  has_many :notifications, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  after_create :welcome_send
  def welcome_send
    WelcomeMailer.welcome_send(self).deliver
  end

  def active_friends
    friends.select { |their| their.friends.include?(self) }
  end

  def pending_friends
    friends.reject { |their| their.friends.include?(self) }
  end

  def new_notifications
    notifications.order('created_at DESC').reject(&:was_read)
  end

  def old_notifications
    notifications.order('created_at DESC').select(&:was_read)
  end

  def add_friend(other_user)
    return if other_user == self || friends.include?(other_user)

    friends << other_user
  end

  def unfriend(other_user)
    friends.destroy(other_user)
    other_user.friends.destroy(self)
  end

  def friends_with?(other_user)
    active_friends.include?(other_user)
  end

  def recived_request?(other_user)
    recived_friends.include?(other_user) && !friends_with?(other_user)
  end

  def reacted?(reactable)
    all_reactions = reactable.reactions.map(&:user)
    all_reactions.include?(self)
  end

  def self.find_friends(username)
    where(['username LIKE ? ', "#{username}%"])
  end

  def self.from_omniauth(auth)
    username = auth.info.name.gsub(/\s+/, '').downcase
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, username: username,
                          email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
  end
end
