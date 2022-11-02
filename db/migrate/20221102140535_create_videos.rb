class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.integer :category_id
      t.string :url
      t.integer :views
      t.references :singer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
