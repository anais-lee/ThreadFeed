class Shop < ApplicationRecord
	has_many :shop_posts, dependent: :destroy

	before_save { url.downcase! }
	validates :name,  presence: true, length: { minimum: 1 }
	validates :url, presence: true, uniqueness: {case_sensitive: false}
end
