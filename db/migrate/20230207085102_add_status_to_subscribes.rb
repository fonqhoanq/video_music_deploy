class AddStatusToSubscribes < ActiveRecord::Migration[6.1]
  def change
    add_column :subscribes, :status, :integer
  end
end
