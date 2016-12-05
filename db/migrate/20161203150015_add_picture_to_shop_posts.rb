class AddPictureToShopPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :shop_posts, :picture, :string
  end
end
