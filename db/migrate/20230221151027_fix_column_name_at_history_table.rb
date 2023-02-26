class FixColumnNameAtHistoryTable < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :histories, :type, :history_type
  end
end
