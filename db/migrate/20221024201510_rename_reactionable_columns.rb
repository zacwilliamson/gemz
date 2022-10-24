class RenameReactionableColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :reactions, :reactionable_id, :reactable_id
    rename_column :reactions, :reactionable_type, :reactable_type
  end
end
