class CreateOwnPlaylistVideo < ActiveRecord::Migration[6.1]
  def change
    create_table :own_playlist_videos do |t|
      t.references :own_playlist, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
