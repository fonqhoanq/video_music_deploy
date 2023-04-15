class RemoveReferenceToVideo < ActiveRecord::Migration[6.1]
  def change
    remove_reference :videos, :hash_tag, null: false, foreign_key: true
  end
end
