class AddColumnToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :likes, :integer, :default => 0
    add_column :videos, :dislikes, :integer, :default => 0
  end
end
