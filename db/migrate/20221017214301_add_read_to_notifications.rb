class AddReadToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :was_read, :boolean, default: false
  end
end
