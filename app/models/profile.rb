class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  after_create :set_background

  def set_background
    self.background = colors.values.sample
  end

  def colors
    { red: 'bg-[#ff5769]',
      orange: 'bg-[#ff5769]',
      yellow: 'bg-[#ffae40]',
      green: 'bg-[#68be61]',
      cyan: 'bg-[#30cdbf]',
      lightblue: 'bg-[#6cb0f3]',
      darkblue: 'bg-[#5082e7]',
      purple: 'bg-[#7670cc]',
      pink: 'bg-[#f57aae]' }
  end
end
