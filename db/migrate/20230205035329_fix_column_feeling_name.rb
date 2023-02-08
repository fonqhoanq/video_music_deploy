class FixColumnFeelingName < ActiveRecord::Migration[6.1]
  def change
    rename_column :feelings, :type, :status
  end
end
