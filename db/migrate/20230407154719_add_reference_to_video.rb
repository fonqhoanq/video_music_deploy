class AddReferenceToVideo < ActiveRecord::Migration[6.1]
  def change
    add_reference :videos, :hash_tag, foreign_key: true
  end
end
