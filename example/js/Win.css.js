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
    var VENDORS, _arrayOf, _computedStyle;
    VENDORS = ["-webkit-", "-moz-", "-ms-", "-o-", ""];

    /*
    Add class to a given instance element
    @method addClass
    @param  {string} Name of stylesheet class
     */
    $W.fn.addClass = function(values) {
      return this.each(function() {
        var i, len, ref, results, value;
        ref = _arrayOf(values);
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          value = ref[i];
          results.push(this.classList.add(value));
        }
        return results;
      });
    };

    /*
    Remove stylesheet class to a given instance element
    @method addClass
    @param  {string} Name of stylesheet class
     */
    $W.fn.removeClass = function(values) {
      return this.each(function() {
        var i, len, ref, results, value;
        ref = _arrayOf(values);
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          value = ref[i];
          results.push(this.classList.remove(value));
        }
        return results;
      });
    };

    /*
    Toggle stylesheet class to a given instance element
    @method addClass
    @param  {string} Name of stylesheet class
     */
    $W.fn.toggleClass = function(values) {
      return this.each(function() {
        var i, len, ref, results, value;
        ref = _arrayOf(values);
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          value = ref[i];
          results.push(this.classList.toggle(value));
        }
        return results;
      });
    };

    /*
    Test if a stylesheet class is in the giben instance element
    @method hasClass
    @param  {string} Name of stylesheet class
     */
    $W.fn.hasClass = function(name) {
      return this.length > 0 && this[0].classList.contains(name);
    };

    /*
    List a object with all classes in a given instance element
    @method listClass
    @param  {string} Name of stylesheet class
     */
    $W.fn.listClass = function() {
      if (this.length > 0) {
        return this[0].classList;
      }
    };

    /*
    Set/Get a stylesheet property in a given instance element
    @method style
    @param  {string} Name of property
    @param  {string} [OPTIONAL] Value for property
     */
    $W.fn.style = $W.fn.css = function(property, value) {
      var el;
      if (value != null) {
        return this.each(function() {
          return this.style[property] = value;
        });
      } else {
        el = this[0];
        return el.style[property] || _computedStyle(el, property);
      }
    };

    /*
    Set/Get a stylesheet vendor-prefix property in a given instance element
    @method vendor
    @param  {string} Name of property
    @param  {string} Value for property
     */
    $W.fn.vendor = function(property, value) {
      var i, len, prefix, results;
      results = [];
      for (i = 0, len = VENDORS.length; i < len; i++) {
        prefix = VENDORS[i];
        results.push(this.style("" + prefix + property, value));
      }
      return results;
    };
    _computedStyle = function(element, property) {
      return document.defaultView.getComputedStyle(element, "")[property];
    };
    return _arrayOf = function(values) {
      if (!Array.isArray(values)) {
        values = [values];
      }
      return values;
    };
  })(Win);

}).call(this);
