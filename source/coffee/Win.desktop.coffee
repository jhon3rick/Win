###
# Desktop
###

Win.Desktop = (obj) ->

	widthIcon           = obj.widthIcon or 20
	heightIcon          = obj.heightIcon or 20

	background      = if obj.background then 'background-color:'+obj.background+';' else ''
	backgroundImage = if obj.backgroundImage then 'background-image:'+obj.background+';' else ''

	@modulos = (obj) ->

		div= '<div style="height:100%">
				<div class="desk-content-modulos">
				';

		obj.forEach (array,index,element)->
			div += """
							<div class="desk-modulo" style="width:#{widthIcon}; height:#{heightIcon};">
								<div></div>
								<div>#{obj.text}</div>
							</div>
						"""
			# console.log(index)
			# console.log(element)
		div += '</div></div>';

		document.querySelector('body').innerHTML = div;

	if typeof(obj.modulos) == 'object'
		@modulos(obj.modulos)


