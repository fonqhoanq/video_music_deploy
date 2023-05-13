class CreateWatchLaterVideo < ActiveRecord::Migration[6.1]
  def change
    create_table :watch_later_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
