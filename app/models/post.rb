class Post < ApplicationRecord
  belongs_to :user
  has_many :reactions, as: :reactable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: 'must be a valid image format' },
                      size: { less_than: 5.megabytes,
                              message: 'should be less than 5MB' }
end
