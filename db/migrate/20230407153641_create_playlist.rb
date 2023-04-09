class CreatePlaylist < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :description
      t.references :hash_tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
