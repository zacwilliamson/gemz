class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def message
    "commented on your post: #{content.truncate(50)}"
  end
end
