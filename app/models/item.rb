class Item < ApplicationRecord
	belongs_to :shop_post

	default_scope -> { order(created_at: :desc) }
	validates :name, presence: true
	validates :price, presence: true
	validates :main_img_url, presence: true
	validates :thumbnail_img_url, presence: true

	#downloads image from url and returns the downloaded img
	def get_main_img
		if (self.main_img_file == nil)
			puts "downloading main_img for " << self.name
	  		self.main_img_file = URI.parse(self.main_img_url)
	  	end
	  	self.main_img_file
	end

	def get_thumbnail_img
		if (self.thumbnail_img_file == nil)
			puts "downloading thumbnail_img for " << self.name
	  		self.thumbnail_img_file = URI.parse(self.main_img_url)
	  	end
	  	self.thumbnail_img_file
	end
end
