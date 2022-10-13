class AddIndexToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_index :notifications, %i[user_id notifiable_id notifiable_type], unique: true, name: 'unique_notifications'
    add_index :notifications, %i[notifiable_id notifiable_type]
  end
end
