class AddIndexToReaction < ActiveRecord::Migration[7.0]
  def change
    add_index :reactions, %i[user_id reactionable_id reactionable_type type], unique: true, name: 'unique_reactions'
  end
end
