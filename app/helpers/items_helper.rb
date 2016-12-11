module ItemsHelper
	# Returns the main image for the given item.
	# def main_img_for(item, options = { size: 200 })
	# 	size = options[:size]
	# 	main_img_url = item.main_img_url
	# 	image_tag(main_img_url, alt: item.name, class: "item_img", size: size)
	# end

	def main_img_for(item, options={size: 200})
		size=options[:size]
		main_img = item.get_main_img
		image_tag(main_img, alt: item.name, class: "item_img", size: size)
	end

	def thumbnail_img_for(item, options={size: 265})
		size=options[:size]
		thumbnail_img = item.get_thumbnail_img
		image_tag(thumbnail_img, alt:item.name, class: "item_img", size: size)
	end

end
