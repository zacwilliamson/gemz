class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :reactionable_id
      t.string :reactionable_type
      t.string :type, default: 'Like'

      t.timestamps
    end
  end
end
