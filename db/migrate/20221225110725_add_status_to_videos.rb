class AddStatusToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :status, :integer
  end
end
