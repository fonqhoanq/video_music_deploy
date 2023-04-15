class RenameTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :video_hastags, :video_hash_tags
  end
end
