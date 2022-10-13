class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps
    end
  end
end
