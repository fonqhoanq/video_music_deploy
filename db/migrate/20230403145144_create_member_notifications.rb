class CreateMemberNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :member_notifications do |t|
      t.integer :noti_status
      t.string :content
      t.datetime :read_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
