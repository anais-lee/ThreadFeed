module ShopsHelper

	# Returns the Gravatar for the given user.
	def logo_for(shop, options = { size: 80 })
		size = options[:size]
		logo_url = "https://www.madewell.com/media/images/globalheader/logo_v1_m56577569831502741.png"
		image_tag(logo_url, alt: shop.name, class: "logo", width:"100")
	end
end
