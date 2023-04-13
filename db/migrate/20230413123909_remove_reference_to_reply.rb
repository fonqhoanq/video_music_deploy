class RemoveReferenceToReply < ActiveRecord::Migration[6.1]
  def change
    remove_reference :replies, :singer, null: false, foreign_key: true
  end
end
