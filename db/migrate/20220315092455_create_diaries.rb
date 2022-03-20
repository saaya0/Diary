class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.string :url
      t.string :sentence
      t.string :learning_time
      t.integer :point

      t.timestamps
    end
  end
end
