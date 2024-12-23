class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :store_name,            null: false
      t.text :memo,                    null: false
      t.integer :genre_id,          null: false
      t.integer :prefecture_id,        null: false
      t.references :user,              null: false, foreign_key: true
      t.timestamps
    end
  end
end
