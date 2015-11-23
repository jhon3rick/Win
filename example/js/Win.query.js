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
    var PARENT_NODE, _filtered, _findAncestors, _getSibling;
    PARENT_NODE = "parentNode";

    /*
    Get the descendants of each element in the current instance
    @method find
    @param  {string} A string containing a selector expression to match elements against.
     */
    $W.fn.find = function(selector) {
      var result;
      if (this.length === 1) {
        result = Quo.query(this[0], selector);
      } else {
        result = this.map(function() {
          return Quo.query(this, selector);
        });
      }
      return $W(result);
    };

    /*
    Get the parent of each element in the current instance
    @method parent
    @param  {string} A string containing a selector expression to match elements against.
     */
    $W.fn.parent = function(selector) {
      var ancestors;
      ancestors = selector ? _findAncestors(this) : this.instance(PARENT_NODE);
      return _filtered(ancestors, selector);
    };

    /*
    Get the children of each element in the current instance
    @method children
    @param  {string} A string containing a selector expression to match elements against.
     */
    $W.fn.children = function(selector) {
      var elements;
      elements = this.map(function() {
        return Array.prototype.slice.call(this.children);
      });
      return _filtered(elements, selector);
    };

    /*
    Get the siblings of each element in the current instance
    @method siblings
    @param  {string} A string containing a selector expression to match elements against.
     */
    $W.fn.siblings = function(selector) {
      var elements;
      elements = this.map(function(index, element) {
        return Array.prototype.slice.call(element.parentNode.children).filter(function(child) {
          return child !== element;
        });
      });
      return _filtered(elements, selector);
    };

    /*
    Retrieve the DOM elements matched by the QuoJS object.
    @method get
    @param  {number} [OPTIONAL] A zero-based integer indicating which element to retrieve
     */
    $W.fn.get = function(index) {
      return this[index] || null;
    };

    /*
    Reduce the set of matched elements to the first in the set.
    @method first
     */
    $W.fn.first = function() {
      return $W(this[0]);
    };

    /*
    Reduce the set of matched elements to the final one in the set.
    @method last
     */
    $W.fn.last = function() {
      return $W(this[this.length - 1]);
    };

    /*
    Reduce the set of matched elements to the final one in the set.
    @method closest
    @param  {string} A string containing a selector expression to match elements against.
    @param  {instance} [OPTIONAL] A DOM element within which a matching element may be found.
     */
    $W.fn.closest = function(selector, context) {
      var candidates, node;
      node = this[0];
      candidates = $W(selector);
      if (!candidates.length) {
        node = null;
      }
      while (node && candidates.indexOf(node) < 0) {
        node = node !== context && node !== document && node.parentNode;
      }
      return $W(node);
    };

    /*
    Get the immediately following sibling of each element in the instance.
    @method next
     */
    $W.fn.next = function() {
      return _getSibling.call(this, "nextSibling");
    };

    /*
    Get the immediately preceding sibling of each element in the instance.
    @method prev
     */
    $W.fn.prev = function() {
      return _getSibling.call(this, "previousSibling");
    };
    $W.fn.instance = function(property) {
      return this.map(function() {
        return this[property];
      });
    };
    $W.fn.map = function(callback) {
      return $W.map(this, function(el, i) {
        return callback.call(el, i, el);
      });
    };
    _findAncestors = function(nodes) {
      var ancestors;
      ancestors = [];
      while (nodes.length > 0) {
        nodes = $W.map(nodes, function(node) {
          node = node.parentNode;
          if (node !== document && ancestors.indexOf(node) < 0) {
            ancestors.push(node);
            return node;
          }
        });
      }
      return ancestors;
    };
    _filtered = function(nodes, selector) {
      if (selector != null) {
        return $W(nodes).filter(selector);
      } else {
        return $W(nodes);
      }
    };
    return _getSibling = function(command) {
      var element;
      element = this[0][command];
      while (element && element.nodeType !== 1) {
        element = element[command];
      }
      return $W(element);
    };
  })(Win);

}).call(this);
