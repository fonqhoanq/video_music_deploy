class CreatePlaylistByTopic < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_by_topics do |t|
      t.string :title
      t.integer :playlist_type
      t.integer :video_numbers, default: 0

      t.timestamps
    end
  end
end
