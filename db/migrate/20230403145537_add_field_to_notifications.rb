class AddFieldToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :member_notifications, :noti_type, :integer
    add_column :member_notifications, :video_id, :integer
  end
end
