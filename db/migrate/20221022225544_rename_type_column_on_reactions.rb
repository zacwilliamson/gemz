class RenameTypeColumnOnReactions < ActiveRecord::Migration[7.0]
  def change
    rename_column :reactions, :type, :category
  end
end
