class FixColumnName < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :singers, :password, :password_digest
  end
end
