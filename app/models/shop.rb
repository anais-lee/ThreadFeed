class Shop < ApplicationRecord
	before_save { url.downcase! }
	validates :name,  presence: true, length: { minimum: 1 }
	validates :url, presence: true, uniqueness: {case_sensitive: false}
end
