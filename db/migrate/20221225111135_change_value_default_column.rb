class ChangeValueDefaultColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_default :videos, :views, 0
  end
end
