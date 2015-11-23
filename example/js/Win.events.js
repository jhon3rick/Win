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
    var ELEMENT_ID, EVENTS_DESKTOP, EVENT_METHODS, HANDLERS, READY_EXPRESSION, _createProxy, _createProxyCallback, _environmentEvent, _event, _findHandlers, _getElementId, _subscribe, _unsubscribe;
    ELEMENT_ID = 1;
    HANDLERS = {};
    EVENT_METHODS = {
      preventDefault: "isDefaultPrevented",
      stopImmediatePropagation: "isImmediatePropagationStopped",
      stopPropagation: "isPropagationStopped"
    };
    EVENTS_DESKTOP = {
      touchstart: "mousedown",
      touchmove: "mousemove",
      touchend: "mouseup",
      touch: "click",
      orientationchange: "resize"
    };
    READY_EXPRESSION = /complete|loaded|interactive/;

    /*
    Attach an event handler function for one or more events to a given instance element
    @method on
    @param  {string} One or more space-separated event types
    @param  {string} A selector string to filter the descendants of the selected elements that trigger the event
    @param  {function} A function to execute when the event is triggered
     */
    $W.fn.on = function(event, selector, callback) {
      if ((selector == null) || $W.toType(selector) === "function") {
        return this.bind(event, selector);
      } else {
        return this.delegate(selector, event, callback);
      }
    };

    /*
    Remove an event handler.
    @method off
    @param  {string} One or more space-separated event types
    @param  {string} [OPTIONAL] A selector string to filter the descendants of the selected elements that trigger the event
    @param  {function} [OPTIONAL] A function to execute when the event is triggered
     */
    $W.fn.off = function(event, selector, callback) {
      if ((selector == null) || $W.toType(selector) === "function") {
        return this.unbind(event, selector);
      } else {
        return this.undelegate(selector, event, callback);
      }
    };

    /*
    Specify a function to execute when the DOM is fully loaded.
    @method ready
    @param  {function} A function to execute after the DOM is ready.
     */
    $W.fn.ready = function(callback) {
      if (READY_EXPRESSION.test(document.readyState)) {
        return callback.call(this, $W);
      } else {
        return $W.fn.addEvent(document, "DOMContentLoaded", function() {
          return callback.call(this, $W);
        });
      }
    };

    /*
    Attach a handler to an event for the elements.
    @method bind
    @param  {string} One or more space-separated event types
    @param  {function} A function to execute when the event is triggered
     */
    $W.fn.bind = function(event, callback) {
      return this.forEach(function(element) {
        return _subscribe(element, event, callback);
      });
    };

    /*
    Remove a previously-attached event handler from the elements.
    @method unbind
    @param  {string} One or more space-separated event types
    @param  {function} [OPTIONAL] A function to execute when the event is triggered
     */
    $W.fn.unbind = function(event, callback) {
      return this.each(function() {
        return _unsubscribe(this, event, callback);
      });
    };

    /*
    Attach a handler to one or more events for all elements that match the selector
    @method delegate
     */
    $W.fn.delegate = function(selector, event, callback) {
      return this.each(function(i, element) {
        return _subscribe(element, event, callback, selector, function(fn) {
          return function(e) {
            var evt, match;
            match = $W(e.target).closest(selector, element).get(0);
            if (match) {
              evt = $W.extend(_createProxy(e), {
                currentTarget: match,
                liveFired: element
              });
              return fn.apply(match, [evt].concat([].slice.call(arguments, 1)));
            }
          };
        });
      });
    };

    /*
    Remove a handler from the event for all elements which match the current selector
    @method undelegate
     */
    $W.fn.undelegate = function(selector, event, callback) {
      return this.each(function() {
        return _unsubscribe(this, event, callback, selector);
      });
    };

    /*
    Execute all handlers and behaviors attached to the matched elements for the given event type.
    @method trigger
     */
    $W.fn.trigger = function(event, touch, originalEvent) {
      if ($W.toType(event) === "string") {
        event = _event(event, touch);
      }
      if (originalEvent != null) {
        event.originalEvent = originalEvent;
      }
      return this.each(function() {
        return this.dispatchEvent(event);
      });
    };
    $W.fn.addEvent = function(element, event_name, callback) {
      if (element.addEventListener) {
        return element.addEventListener(event_name, callback, false);
      } else if (element.attachEvent) {
        return element.attachEvent("on" + event_name, callback);
      } else {
        return element["on" + event_name] = callback;
      }
    };
    $W.fn.removeEvent = function(element, event_name, callback) {
      if (element.removeEventListener) {
        return element.removeEventListener(event_name, callback, false);
      } else if (element.detachEvent) {
        return element.detachEvent("on" + event_name, callback);
      } else {
        return element["on" + event_name] = null;
      }
    };
    _event = function(type, touch) {
      var event;
      event = document.createEvent("Events");
      event.initEvent(type, true, true, null, null, null, null, null, null, null, null, null, null, null, null);
      if (touch) {
        event.touch = touch;
      }
      return event;
    };
    _subscribe = function(element, event, callback, selector, delegate_callback) {
      var delegate, element_handlers, element_id, handler;
      event = _environmentEvent(event);
      element_id = _getElementId(element);
      element_handlers = HANDLERS[element_id] || (HANDLERS[element_id] = []);
      delegate = delegate_callback && delegate_callback(callback, event);
      handler = {
        event: event,
        callback: callback,
        selector: selector,
        proxy: _createProxyCallback(delegate, callback, element),
        delegate: delegate,
        index: element_handlers.length
      };
      element_handlers.push(handler);
      return $W.fn.addEvent(element, handler.event, handler.proxy);
    };
    _unsubscribe = function(element, event, callback, selector) {
      var element_id;
      event = _environmentEvent(event);
      element_id = _getElementId(element);
      return _findHandlers(element_id, event, callback, selector).forEach(function(handler) {
        delete HANDLERS[element_id][handler.index];
        return $W.fn.removeEvent(element, handler.event, handler.proxy);
      });
    };
    _getElementId = function(element) {
      return element._id || (element._id = ELEMENT_ID++);
    };
    _environmentEvent = function(event) {
      var environment_event;
      environment_event = (typeof $W.isMobile === "function" ? $W.isMobile() : void 0) ? event : EVENTS_DESKTOP[event];
      return environment_event || event;
    };
    _createProxyCallback = function(delegate, callback, element) {
      var proxy;
      callback = delegate || callback;
      proxy = function(event) {
        var result;
        result = callback.apply(element, [event].concat(event.data));
        if (result === false) {
          event.preventDefault();
        }
        return result;
      };
      return proxy;
    };
    _findHandlers = function(element_id, event, fn, selector) {
      return (HANDLERS[element_id] || []).filter(function(handler) {
        return handler && (!event || handler.event === event) && (!fn || handler.callback === fn) && (!selector || handler.selector === selector);
      });
    };
    return _createProxy = function(event) {
      var proxy;
      proxy = $W.extend({
        originalEvent: event
      }, event);
      $W.each(EVENT_METHODS, function(name, method) {
        proxy[name] = function() {
          this[method] = function() {
            return true;
          };
          return event[name].apply(event, arguments);
        };
        return proxy[method] = function() {
          return false;
        };
      });
      return proxy;
    };
  })(Win);

}).call(this);