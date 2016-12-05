module UsersHelper

	# Returns the uploaded skin tone image for the given user.
	def image_for(user, options = { width: 80 })
		width = options[:width]
		image_url = user.picture.url
		image_tag(image_url, alt: user.name, class: "gravatar", width: width)
	end
end