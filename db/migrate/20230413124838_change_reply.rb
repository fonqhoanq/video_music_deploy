class ChangeReply < ActiveRecord::Migration[6.1]
  def change
    add_reference :replies, :user, null: true, foreign_key: true
    add_reference :replies, :singer, null: true, foreign_key: true
  end
end
