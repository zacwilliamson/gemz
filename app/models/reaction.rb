class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[reactionable_id reactionable_type category] }
end
