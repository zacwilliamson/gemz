class Post < ApplicationRecord
  belongs_to :user
  has_many :reactions, as: :reactable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end
