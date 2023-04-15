class CreateVideoHastagTable < ActiveRecord::Migration[6.1]
  def change
    create_table :video_hastags do |t|
      t.references :video, null: false, foreign_key: true
      t.references :hash_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
