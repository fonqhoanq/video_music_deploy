class AddNewColumnToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :update_trending_at, :datetime
  end
end
