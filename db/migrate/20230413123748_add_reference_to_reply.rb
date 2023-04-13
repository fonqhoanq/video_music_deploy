class AddReferenceToReply < ActiveRecord::Migration[6.1]
  def change
    remove_reference :replies, :user, null: false, foreign_key: true
  end
end
