class Shop < ApplicationRecord
	has_many :shop_posts, dependent: :destroy
	has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
    has_many :followers, through: :passive_relationships, source: :follower

	before_save { url.downcase! }
	validates :name,  presence: true, length: { minimum: 1 }
	validates :url, presence: true, uniqueness: {case_sensitive: false}
end
