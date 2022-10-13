class Notification < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
end
