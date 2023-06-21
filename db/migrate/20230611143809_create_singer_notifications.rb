class CreateSingerNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :singer_notifications do |t|
      t.text :content
      t.datetime :read_at
      t.integer :noti_status
      t.integer :noti_type
      t.references :singer, null: false, foreign_key: true
      t.references :video, foreign_key: true

      t.timestamps
    end
  end
end
