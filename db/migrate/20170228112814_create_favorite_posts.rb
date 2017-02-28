class CreateFavoritePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_posts do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
    add_index :favorite_posts, [:user_id,:post_id], unique: true
  end
end
