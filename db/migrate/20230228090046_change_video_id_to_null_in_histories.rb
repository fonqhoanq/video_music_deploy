class ChangeVideoIdToNullInHistories < ActiveRecord::Migration[6.1]
  def change
    change_column_null :histories, :video_id, true
  end
end
