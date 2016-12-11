class AddThumbnailImgFileToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :thumbnail_img_file, :image
  end
end
