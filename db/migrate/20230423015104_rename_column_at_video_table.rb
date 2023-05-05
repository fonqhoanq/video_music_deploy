class RenameColumnAtVideoTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :videos, :upload_video_at, :uploaded_video_at
  end
end
