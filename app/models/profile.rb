class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
end
