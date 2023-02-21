class RemoveVideoFromReply < ActiveRecord::Migration[6.1]
  def change
    remove_reference :replies, :video, null: false, foreign_key: true
  end
end
