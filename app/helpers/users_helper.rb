module UsersHelper
	# Returns the Gravatar for the given user.
	def gravatar_for(user, options = { size: 80 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	# Returns the Gravatar for the given user.
	def image_for(user, options = { width: 80 })
		width = options[:width]
		image_url = user.picture.url
		image_tag(image_url, alt: user.name, class: "gravatar", width: width)
	end
end