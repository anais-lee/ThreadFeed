class CreateShopPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_posts do |t|
      t.text :content
      t.references :shop, foreign_key: true

      t.timestamps
    end
    add_index :shop_posts, [:shop_id, :created_at]
  end
end
