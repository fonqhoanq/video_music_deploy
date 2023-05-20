class CreateOwnPlaylist < ActiveRecord::Migration[6.1]
  def change
    create_table :own_playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :playlist_status

      t.timestamps
    end
  end
end
