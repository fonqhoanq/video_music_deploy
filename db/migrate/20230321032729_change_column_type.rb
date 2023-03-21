class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :videos, :description, :text, :limit => 1000 
  end
end
