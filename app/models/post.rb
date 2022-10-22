class Post < ApplicationRecord
  belongs_to :user
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
