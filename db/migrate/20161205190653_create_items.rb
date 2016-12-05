class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :price
      t.text :description
      t.string :main_img_url
      t.references :shop_post, foreign_key: true

      t.timestamps
    end
    add_index :items, [:shop_post_id, :created_at]
  end
end
