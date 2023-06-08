class ChangeColumnOnHistory < ActiveRecord::Migration[6.1]
  def change
    remove_column :histories, :watch_at
    remove_column :histories, :length
    add_column :histories, :duration, :float, default: 0.0
    add_column :histories, :current_time, :float, default: 0.0
  end
end
