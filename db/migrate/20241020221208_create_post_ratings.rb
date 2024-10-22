class CreatePostRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :post_ratings do |t|
      t.references :post, null: false, foreign_key: true
      t.references :rating, null: false, foreign_key: true
      t.integer :score, null: false, default: 0
      t.timestamps
    end
  end
end
