class RemoveUrlFromVideos < ActiveRecord::Migration[6.1]
  def change
    remove_column :videos, :url, :string
  end
end
