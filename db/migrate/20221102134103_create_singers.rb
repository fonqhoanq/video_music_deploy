class CreateSingers < ActiveRecord::Migration[6.1]
  def change
    create_table :singers do |t|
      t.string :name
      t.integer :age
      t.integer :music_type
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
