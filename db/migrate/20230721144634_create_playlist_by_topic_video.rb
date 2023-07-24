class CreatePlaylistByTopicVideo < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_by_topic_videos do |t|
      t.references :video, null: false, foreign_key: true
      t.references :playlist_by_topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
