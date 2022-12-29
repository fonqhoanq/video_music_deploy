class ChangeTableVideos < ActiveRecord::Migration[6.1]
  def change
    remove_column :videos, :status
    add_column :videos, :public, :boolean, default: false
  end
end
