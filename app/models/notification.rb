class Notification < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
    "sent you a friend request" if notifiable_type == 'Friendship'
  end

  def request_sender
    return unless notifiable_type == 'Friendship'

    request = Friendship.find(notifiable_id)
    request.user
  end
end
