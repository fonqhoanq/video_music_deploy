class AddReferencesToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :member_notifications, :video, null: true, foreign_key: true
  end
end
