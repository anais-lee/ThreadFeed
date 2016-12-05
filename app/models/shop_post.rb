class ShopPost < ApplicationRecord
  belongs_to :shop
  has_many :items, dependent: :destroy
  default_scope -> { order(created_at: :desc) } #orders them last created first
  mount_uploader :picture, PictureUploader
  validates :shop_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
