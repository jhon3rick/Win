/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * Validacion campos formulario
 *
 * tecla==8 		//BACKSPACE
 * tecla==9 		//TAB
 * tecla==0 		//TAB
 * tecla==13 	//ENTER
 *
 */

(function() {
  "use strict";
  (function($W) {

    /*
    Get/Set attribute to a given instance element
    @method attr
    @param  {string} Name of attribute
    @param  {string} [OPTIONAL] Value of attribute
     */
    $W.fn.attr = function(name, value) {
      if (this.length > 0 && $W.toType(name) === "string") {
        if (value != null) {
          return this.each(function() {
            return this.setAttribute(name, value);
          });
        } else {
          return this[0].getAttribute(name);
        }
      }
    };

    /*
    Remove attribute to a given instance element
    @method removeAttr
    @param  {string} Name of attribute
     */
    $W.fn.removeAttr = function(name) {
      if (this.length > 0 && $W.toType(name) === "string") {
        return this.each(function() {
          return this.removeAttribute(name);
        });
      }
    };

    /*
    Get/Set data attribute to a given instance element
    @method data
    @param  {string} Name of data attribute
    @param  {string} [OPTIONAL] Value of data atribbute
     */
    $W.fn.data = function(name, value) {
      return this.attr("data-" + name, value);
    };

    /*
    Remove data attribute to a given instance element
    @method removeAttr
    @param  {string} Name of data attribute
     */
    $W.fn.removeData = function(name) {
      return this.removeAttr("data-" + name);
    };

    /*
    Remove data attribute to a given instance element
    @method val
    @param  {string} Name of data attribute
     */
    $W.fn.val = function(value) {
      if (value != null) {
        return this.each(function() {
          return this.value = value.toString();
        });
      } else {
        if (this.length > 0) {
          return this[0].value;
        } else {
          return null;
        }
      }
    };

    /*
    Shows a given instance element
    @method show
     */
    $W.fn.show = function() {
      return this.style("display", "block");
    };

    /*
    Hides a given instance element
    @method hide
     */
    $W.fn.hide = function() {
      return this.style("display", "none");
    };

    /*
    Trigger that event on an element
    @method focus
     */
    $W.fn.focus = function() {
      return this[0].focus();
    };

    /*
    Trigger that event on an element
    @method blur
     */
    $W.fn.blur = function() {
      return this[0].blur();
    };

    /*
    Get a offset of a given instance element
    @method offset
     */
    return $W.fn.offset = function() {
      var bounding, offset;
      if (this.length > 0) {
        bounding = this[0].getBoundingClientRect();
        offset = {
          left: bounding.left + window.pageXOffset,
          top: bounding.top + window.pageYOffset,
          width: bounding.width,
          height: bounding.height
        };
      }
      return offset;
    };
  })(Win);

}).call(this);
