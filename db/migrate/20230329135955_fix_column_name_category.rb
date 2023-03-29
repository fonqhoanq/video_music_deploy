class FixColumnNameCategory < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :categories, :name, :title
  end
end
