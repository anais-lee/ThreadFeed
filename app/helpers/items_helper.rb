module ItemsHelper
	# Returns the main image for the given item.
	def main_img_for(item, options = { size: 200 })
		size = options[:size]
		main_img_url = item.main_img_url
		image_tag(main_img_url, alt: item.name, class: "item_img", size: size)
	end
end
