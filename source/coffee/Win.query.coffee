###
# Validacion campos formulario
#
# tecla==8 		//BACKSPACE
# tecla==9 		//TAB
# tecla==0 		//TAB
# tecla==13 	//ENTER
#
###

"use strict"

do ($W = Win) ->

  PARENT_NODE    = "parentNode"

  ###
  Get the descendants of each element in the current instance
  @method find
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $W.fn.find = (selector) ->
    if @length is 1
      result = Quo.query @[0], selector
    else
      result = @map -> Quo.query(@, selector)
    $W result


  ###
  Get the parent of each element in the current instance
  @method parent
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $W.fn.parent = (selector) ->
    ancestors = if selector then _findAncestors(@) else @instance(PARENT_NODE)
    _filtered ancestors, selector


  ###
  Get the children of each element in the current instance
  @method children
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $W.fn.children = (selector) ->
    elements = @map -> Array::slice.call @children
    _filtered elements, selector


  ###
  Get the siblings of each element in the current instance
  @method siblings
  @param  {string} A string containing a selector expression to match elements against.
  ###
  $W.fn.siblings = (selector) ->
    elements = @map((index, element) ->
      Array::slice.call(element.parentNode.children).filter (child) ->
        child isnt element
    )
    _filtered elements, selector


  ###
  Retrieve the DOM elements matched by the QuoJS object.
  @method get
  @param  {number} [OPTIONAL] A zero-based integer indicating which element to retrieve
  ###
  $W.fn.get = (index) ->
    @[index] or null


  ###
  Reduce the set of matched elements to the first in the set.
  @method first
  ###
  $W.fn.first = ->
    $W @[0]


  ###
  Reduce the set of matched elements to the final one in the set.
  @method last
  ###
  $W.fn.last = ->
    $W @[@length - 1]


  ###
  Reduce the set of matched elements to the final one in the set.
  @method closest
  @param  {string} A string containing a selector expression to match elements against.
  @param  {instance} [OPTIONAL] A DOM element within which a matching element may be found.
  ###
  $W.fn.closest = (selector, context) ->
    node = @[0]
    candidates = $W(selector)
    node = null  unless candidates.length
    while node and candidates.indexOf(node) < 0
      node = node isnt context and node isnt document and node.parentNode
    $W node


  ###
  Get the immediately following sibling of each element in the instance.
  @method next
  ###
  $W.fn.next = ->
    _getSibling.call @, "nextSibling"


  ###
  Get the immediately preceding sibling of each element in the instance.
  @method prev
  ###
  $W.fn.prev = ->
    _getSibling.call @, "previousSibling"


  $W.fn.instance = (property) ->
    @map -> @[property]


  $W.fn.map = (callback) ->
    $W.map @, (el, i) -> callback.call el, i, el

  # ---------------------------------------------------------------------------
  # Private Methods
  # ---------------------------------------------------------------------------
  _findAncestors = (nodes) ->
    ancestors = []
    while nodes.length > 0
      nodes = $W.map(nodes, (node) ->
        node = node.parentNode
        if node isnt document and ancestors.indexOf(node) < 0
          ancestors.push node
          node
      )
    ancestors

  _filtered = (nodes, selector) ->
    if selector? then $W(nodes).filter(selector) else $W(nodes)

  _getSibling = (command) ->
    element = @[0][command]
    element = element[command] while element and element.nodeType isnt 1
    $W element