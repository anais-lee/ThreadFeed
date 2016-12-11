class AddMainImgFileToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :main_img_file, :image
  end
end
