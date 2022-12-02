class AddBgColorToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :background, :string
  end
end
