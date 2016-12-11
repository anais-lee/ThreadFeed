class AddImgFileToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :image_file, :image
  end
end
