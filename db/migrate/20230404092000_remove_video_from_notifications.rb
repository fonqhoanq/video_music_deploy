class RemoveVideoFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :member_notifications, :video_id, :integer
  end
end
