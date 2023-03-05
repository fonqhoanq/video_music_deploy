class RemovePasswordDigest < ActiveRecord::Migration[6.1]
  def change
    remove_column :singers, :password_digest
  end
end
