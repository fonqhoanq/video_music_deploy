class AddSearchTextToHistories < ActiveRecord::Migration[6.1]
  def change
    add_column :histories, :search_text, :string
    add_column :histories, :type, :integer
  end
end
