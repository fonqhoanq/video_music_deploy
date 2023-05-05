class AddUploadVideoAtToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :upload_video_at, :datetime
    remove_column :videos, :public
    add_column :videos, :video_status, :integer
  end
end
