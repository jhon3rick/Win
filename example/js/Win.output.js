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
    Get/Set text to a given instance element
    @method text
    @param  {string} [OPTIONAL] Value of text
     */
    $W.fn.text = function(value) {
      if (value != null) {
        return this.each(function() {
          return this.textContent = value;
        });
      } else {
        if (this.length > 0) {
          return this[0].textContent;
        } else {
          return "";
        }
      }
    };

    /*
    Get/Set html to a given instance element
    @method html
    @param  {variable} [OPTIONAL] Value of html
     */
    $W.fn.html = function(value) {
      var type;
      if (value != null) {
        type = $W.toType(value);
        return this.each(function() {
          if (type === "string") {
            return this.innerHTML = value;
          } else if (type === "array") {
            return value.forEach((function(_this) {
              return function(slice) {
                return $W(_this).html(slice);
              };
            })(this));
          } else {
            return this.innerHTML += $W(value).html();
          }
        });
      } else {
        if (this.length > 0) {
          return this[0].innerHTML;
        } else {
          return "";
        }
      }
    };

    /*
    Remove the set of matched elements to a given instance element
    @method remove
     */
    $W.fn.remove = function() {
      return this.each(function() {
        if (this.parentNode != null) {
          return this.parentNode.removeChild(this);
        }
      });
    };

    /*
    Remove all child nodes of the set of matched elements to a given instance element
    @method remove
     */
    $W.fn.empty = function() {
      return this.each(function() {
        return this.innerHTML = null;
      });
    };

    /*
    Append a html to a given instance element
    @method append
    @param  {html} Value of html
     */
    $W.fn.append = function(value) {
      var type;
      type = $W.toType(value);
      return this.each(function() {
        if (type === "string") {
          return this.insertAdjacentHTML("beforeend", value);
        } else if (type === "array") {
          return value.forEach((function(_this) {
            return function(slice) {
              return $W(_this).append(slice);
            };
          })(this));
        } else {
          return this.appendChild(value);
        }
      });
    };

    /*
    Prepend a html to a given instance element
    @method prepend
    @param  {html} Value of html
     */
    $W.fn.prepend = function(value) {
      var type;
      type = $W.toType(value);
      return this.each(function() {
        if (type === "string") {
          return this.insertAdjacentHTML("afterbegin", value);
        } else if (type === "array") {
          return value.each((function(_this) {
            return function(index, value) {
              return _this.insertBefore(value, _this.firstChild);
            };
          })(this));
        } else {
          return this.insertBefore(value, this.firstChild);
        }
      });
    };

    /*
    Replace each element in the set of matched elements with the provided new
    content and return the set of elements that was removed.
    @method replaceWith
    @param  {html} The content to insert (HTML string, DOMelement, array of DOMelements)
     */
    return $W.fn.replaceWith = function(value) {
      var type;
      type = $W.toType(value);
      this.each(function() {
        if (this.parentNode) {
          if (type === "string") {
            return this.insertAdjacentHTML("beforeBegin", value);
          } else if (type === "array") {
            return value.each((function(_this) {
              return function(index, value) {
                return _this.parentNode.insertBefore(value, _this);
              };
            })(this));
          } else {
            return this.parentNode.insertBefore(value, this);
          }
        }
      });
      return this.remove();
    };
  })(Win);

}).call(this);
