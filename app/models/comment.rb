class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }

  def message
    "commented on your post: #{content.truncate(50)}"
  end
end
