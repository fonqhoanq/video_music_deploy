class AddChannelNameToSingers < ActiveRecord::Migration[6.1]
  def change
    add_column :singers, :channel_name, :string
  end
end
