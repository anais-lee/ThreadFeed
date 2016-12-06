class Item < ApplicationRecord
  belongs_to :shop_post
  
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :price, presence: true
  validates :main_img_url, presence: true
  
end
