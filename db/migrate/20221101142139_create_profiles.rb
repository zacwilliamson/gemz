class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :full_name
      t.string :bio
      t.string :link

      t.timestamps
    end
  end
end
