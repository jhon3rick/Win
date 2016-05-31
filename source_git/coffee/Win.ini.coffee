###
# CONFIG INI
###

do ($W = Win) ->

	$W.ini = (obj) ->

		if(obj.theme)
			link = $W('head > link')

			for i in link
				if /Win-theme/g.test(i.getAttribute('href'))
					dir = i.getAttribute('href').split('Win-theme',1)
					i.setAttribute('href', dir+obj.theme)
					return

			theme = document.createElement("link")
			theme.setAttribute("rel", "stylesheet")
			theme.setAttribute("href", obj.theme)

			$W('head')[0].appendChild(theme)


