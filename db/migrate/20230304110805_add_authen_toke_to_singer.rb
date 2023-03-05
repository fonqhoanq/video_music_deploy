class AddAuthenTokeToSinger < ActiveRecord::Migration[6.1]
  def change
    add_column :singers, :authentication_token, :string, :limit => 30
    add_index :singers, :authentication_token
  end
end
