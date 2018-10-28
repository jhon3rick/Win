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


  ###
  Get/Set attribute to a given instance element
  @method attr
  @param  {string} Name of attribute
  @param  {string} [OPTIONAL] Value of attribute
  ###
  $W.fn.attr = (name, value) ->

    if @length > 0 and $W.toType(name) is "string"
      if value?
        # console.log(@setAttribute)
        # console.log("atributo")
        # return
        @each -> @setAttribute name, value
      else
        @[0].getAttribute name


  ###
  Remove attribute to a given instance element
  @method removeAttr
  @param  {string} Name of attribute
  ###
  $W.fn.removeAttr = (name) ->
    if @length > 0 and $W.toType(name) is "string"
      @each -> @removeAttribute name


  ###
  Get/Set data attribute to a given instance element
  @method data
  @param  {string} Name of data attribute
  @param  {string} [OPTIONAL] Value of data atribbute
  ###
  $W.fn.data = (name, value) ->
    @attr "data-#{name}", value


  ###
  Remove data attribute to a given instance element
  @method removeAttr
  @param  {string} Name of data attribute
  ###
  $W.fn.removeData = (name) ->
    @removeAttr "data-#{name}"


  ###
  Remove data attribute to a given instance element
  @method val
  @param  {string} Name of data attribute
  ###
  $W.fn.val = (value) ->
    if value?
      @each -> @value = value.toString()
    else
      if @length > 0 then @[0].value else null


  ###
  Shows a given instance element
  @method show
  ###
  $W.fn.show = ->
    @style "display", "block"


  ###
  Hides a given instance element
  @method hide
  ###
  $W.fn.hide = ->
    @style "display", "none"

  ###
  Trigger that event on an element
  @method focus
  ###
  $W.fn.focus = ->
    do @[0].focus

  ###
  Trigger that event on an element
  @method blur
  ###
  $W.fn.blur = ->
    do @[0].blur

  ###
  Get a offset of a given instance element
  @method offset
  ###
  $W.fn.offset = ->
    if @length > 0
      bounding = @[0].getBoundingClientRect()
      offset =
        left  : bounding.left + window.pageXOffset
        top   : bounding.top + window.pageYOffset
        width : bounding.width
        height: bounding.height
    offset