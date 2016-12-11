class AddProductUrlToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :product_url, :string
  end
end
