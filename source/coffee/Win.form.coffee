###
# Validacion campos formulario
#
# tecla==8 		//BACKSPACE
# tecla==9 		//TAB
# tecla==0 		//TAB
# tecla==13 	//ENTER
#
###

Win.form = do->
	intField: (obj) ->
		document.getElementById(obj.applyTo).className += " win-input-number";

		document.getElementById(obj.applyTo).onkeypress = (event)->
			return Win.form.validateIntField({ event:event, eventType:'keypress', input:this })

		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateIntField({ event:event, eventType:'change', input:this })

	doubleField: (obj) ->
		document.getElementById(obj.applyTo).className += " win-input-number";

		document.getElementById(obj.applyTo).onkeypress = (event)->
			return Win.form.validateDoubleField({ event:event, eventType:'keypress', input:this })

		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateDoubleField({ event:event, eventType:'change', input:this })

	textField: (obj) ->
		document.getElementById(obj.applyTo).onkeyup = (event)->
			return Win.form.validateTextField({ event:event, eventType:'keyup', input:this, type:obj.type })

		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateTextField({ event:event, eventType:'change', input:this, type:obj.type })

	emailField: (obj) ->
		document.getElementById(obj.applyTo).onchange = (event)->
			return Win.form.validateEmailField({ event:event, input:this })

	globalField: (obj) ->

	validateIntField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/\d/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')

	validateDoubleField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keypress'
			return (/[\d.]/).test(String.fromCharCode(tecla))
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[^\d.]/g,'')
			console.log(!!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/))
			validate = !!(obj.input.value).toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/)
			if !validate
				arrayValue = (obj.input.value).split(".")
				obj.input.value = arrayValue[0]+'.'+arrayValue[1]

	validateTextField: (obj) ->
		tecla = if document.all then obj.event.keyCode else obj.event.which
		if tecla==8 or tecla==9 or tecla==0 or tecla==13
		 	return true
		else if obj.eventType == 'keyup'
			if obj.type=='uppercase'
				obj.input.value =obj.input.value.toUpperCase()
			else if obj.type=='lowercase'
				obj.input.value = obj.input.value.toLowerCase()
		else if obj.eventType == 'change'
			obj.input.value = (obj.input.value).replace(/[\#\-\"\']/g,'')

	validateEmailField: (obj) ->
		validate = !!(obj.input.value).toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i)
		if !validate
			obj.input.value=""
			obj.input.focus()


