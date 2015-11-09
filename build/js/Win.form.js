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
Win.form = (function() {
  return {
    intField: function(obj) {
      document.getElementById(obj.applyTo).className += " win-input-number";
      document.getElementById(obj.applyTo).onkeypress = function(event) {
        return Win.form.validateIntField({
          event: event,
          eventType: 'keypress',
          input: this
        });
      };
      return document.getElementById(obj.applyTo).onchange = function(event) {
        return Win.form.validateIntField({
          event: event,
          eventType: 'change',
          input: this
        });
      };
    },
    doubleField: function(obj) {
      document.getElementById(obj.applyTo).className += " win-input-number";
      document.getElementById(obj.applyTo).onkeypress = function(event) {
        return Win.form.validateDoubleField({
          event: event,
          eventType: 'keypress',
          input: this
        });
      };
      return document.getElementById(obj.applyTo).onchange = function(event) {
        return Win.form.validateDoubleField({
          event: event,
          eventType: 'change',
          input: this
        });
      };
    },
    textField: function(obj) {
      document.getElementById(obj.applyTo).onkeyup = function(event) {
        return Win.form.validateTextField({
          event: event,
          eventType: 'keyup',
          input: this,
          type: obj.type
        });
      };
      return document.getElementById(obj.applyTo).onchange = function(event) {
        return Win.form.validateTextField({
          event: event,
          eventType: 'change',
          input: this,
          type: obj.type
        });
      };
    },
    emailField: function(obj) {
      return document.getElementById(obj.applyTo).onchange = function(event) {
        return Win.form.validateEmailField({
          event: event,
          input: this
        });
      };
    },
    globalField: function(obj) {},
    validateIntField: function(obj) {
      var tecla;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /\d/.test(String.fromCharCode(tecla));
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
      }
    },
    validateDoubleField: function(obj) {
      var arrayValue, tecla, validate;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /[\d.]/.test(String.fromCharCode(tecla));
      } else if (obj.eventType === 'change') {
        obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
        console.log(!!obj.input.value.toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/));
        validate = !!obj.input.value.toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/);
        if (!validate) {
          arrayValue = obj.input.value.split(".");
          return obj.input.value = arrayValue[0] + '.' + arrayValue[1];
        }
      }
    },
    validateTextField: function(obj) {
      var tecla;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keyup') {
        if (obj.type === 'uppercase') {
          return obj.input.value = obj.input.value.toUpperCase();
        } else if (obj.type === 'lowercase') {
          return obj.input.value = obj.input.value.toLowerCase();
        }
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[\#\-\"\']/g, '');
      }
    },
    validateEmailField: function(obj) {
      var validate;
      validate = !!obj.input.value.toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i);
      if (!validate) {
        obj.input.value = "";
        return obj.input.focus();
      }
    }
  };
})();
