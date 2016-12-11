class AddThumbnailImgUrlToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :thumbnail_img_url, :string
  end
end
