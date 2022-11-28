class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
  has_many :reactions, as: :reactable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }

  def message
    'commented on your post'
  end
end
