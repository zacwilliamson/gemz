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

  def request_sender
    return unless notifiable_type == 'Friendship'

    request = Friendship.find(notifiable_id)
    request.user
  end
end
