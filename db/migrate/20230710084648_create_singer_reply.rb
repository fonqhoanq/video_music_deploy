class CreateSingerReply < ActiveRecord::Migration[6.1]
  def change
    create_table :singer_replies do |t|
      t.string :text
      t.references :singer, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
