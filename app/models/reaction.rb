class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[reactable_id reactable_type category] }
end
