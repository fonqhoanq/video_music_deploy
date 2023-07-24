class AddColumnToOwnPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_column :own_playlists, :playlist_type, :integer, default: 0
  end
end
