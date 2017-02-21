class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :image_url
      t.text :description
      t.integer :telescope_id

      t.timestamps
    end
  end
end
