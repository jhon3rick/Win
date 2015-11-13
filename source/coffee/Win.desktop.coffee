###
# Desktop
###

Win.Desktop = (obj) ->


	background      = if obj.background then 'background-color:'+obj.background+';' else ''
	backgroundImage = if obj.backgroundImage then 'background-image:'+obj.background+';' else ''

	if typeof(obj.modulos) == 'object'
		@modulos(obj)

	@modulos = (obj) ->

		obj.forEach (obj,index,element)->
			console.log(obj)
			console.log(index)
			console.log(element)

