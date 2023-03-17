class AddDescriptionToSingers < ActiveRecord::Migration[6.1]
  def change
    add_column :singers, :description, :string
  end
end
