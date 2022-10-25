class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }

  def message
    notifiable.message
  end

  def friend_request?
    return unless notifiable_type == 'Friendship'

    friendship = Friendship.find(notifiable_id)
    user.recived_request?(friendship.user)
  end

  def reaction?
    notifiable_type == 'Reaction'
  end

  def sender
    notifiable_type.constantize.find(notifiable_id).user
  end

  def read
    self.was_read = true
    save
  end
end
