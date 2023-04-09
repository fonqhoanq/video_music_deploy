class CreateHashTag < ActiveRecord::Migration[6.1]
  def change
    create_table :hash_tags do |t|
      t.string :title

      t.timestamps
    end
  end
end
