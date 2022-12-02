class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  after_create :set_color

  def set_color
    self.color = color_list.sample
  end

  def color_list
    %w[red orange yellow green cyan lightblue darkblue purple pink]
  end
end
