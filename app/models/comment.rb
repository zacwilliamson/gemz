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
    if parent.nil?
      'commented on your post'
    else
      "replied to your comment: #{parent.content.truncate(85)}"
    end
  end
end
