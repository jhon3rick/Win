###
# Win.js
# @namespeace Win
#
# @version 0.1
# @author Jhon Marroquin || @jhon3rick
# @author Jonatan Herran || @jonatan2874
#
###

"use strict"

Win = do ->

	EMPTY_ARRAY = []
	OBJECT_PROTOTYPE  = Object::

	IS_HTML_FRAGMENT  = /^\s*<(\w+|!)[^>]*>/

	ELEMENT_TYPES     = [ 1, 9, 11 ]
	CLASS_SELECTOR    = /^\.([\w-]+)$/
	ID_SELECTOR       = /^#[\w\d-]+$/
	TAG_SELECTOR      = /^[\w-]+$/

	###
		Basic Instance of WinJs
		@method $W
		@param  {string/instance} [OPTIONAL] Selector for handler
		@param  {string} [OPTIONAL] Children in selector
	###
	$W = (selector, children) ->
		unless selector
			_instance()
		else if $W.toType(selector) is "function"
			$W(document).ready selector
		else
			dom = _getDOMObject(selector, children)
			_instance(dom, selector)

	$W.query = (domain, selector) ->
		if CLASS_SELECTOR.test(selector)
			elements = domain.getElementsByClassName selector.replace(".", "")
		else if TAG_SELECTOR.test(selector)
			elements = domain.getElementsByTagName(selector)
		else if ID_SELECTOR.test(selector) and domain is document
			elements = domain.getElementById selector.replace("#", "")
			unless elements then elements = []
			# unless elements then elements else false
		else
			elements = domain.querySelectorAll selector
		if elements.nodeType then [elements] else Array::slice.call(elements)

	$W.toType = (obj) ->
		match = OBJECT_PROTOTYPE.toString.call(obj).match(/\s([a-z|A-Z]+)/)
		if match.length > 1 then match[1].toLowerCase() else "object"

	$W.each = (elements, callback) ->
		i = undefined
		key = undefined
		if $W.toType(elements) is "array"
			for element, i in elements
				elements if callback.call(element, i, element) is false
		else
			for key of elements
				elements if callback.call(elements[key], key, elements[key]) is false
		elements


	_instance = (dom, selector = "") ->
		dom = dom or EMPTY_ARRAY
		dom.selector = selector
		dom.__proto__ = _instance::
		dom

	_getDOMObject = (selector, children) ->
		domain = null
		type = $W.toType selector

		if type is "array"
			domain = _compact selector

		else if type is "string" and IS_HTML_FRAGMENT.test(selector)
			domain = _fragment(selector.trim(), RegExp.$1)
			selector = null

		else if type is "string"
			domain = $W.query(document, selector)
			if children
				if domain.length is 1
					domain = $W.query(domain[0], children)
				else
					#@TODO: BUG if selector count > 1
					domain = $W.map(-> $W.query domain, children)

		else if ELEMENT_TYPES.indexOf(selector.nodeType) >= 0 or selector is window
			domain = [selector]
			selector = null

		domain


	_instance:: = $W.fn = {}

	$W.fn.each = (callback) ->
		@forEach (element, index) -> callback.call element, index, element
		@

	$W.fn.forEach = EMPTY_ARRAY.forEach


	$W.version = "0.0.1"

	$W

@Win = @$W = Win

module?.exports = Win

# retur

