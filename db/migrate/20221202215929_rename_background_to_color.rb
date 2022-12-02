class RenameBackgroundToColor < ActiveRecord::Migration[7.0]
  def change
    rename_column :profiles, :background, :color
  end
end
