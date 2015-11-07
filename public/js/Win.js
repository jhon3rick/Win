
/*
 * Win.js
 *
 * @namespeace Win
 *
 * @version 0.1
 * @author Jonatan Herran  || @jonatan2874
 *
 */
"use strict";
var Win;

Win = (function() {
  return {
    Window: function(obj) {
      var autoDestroy, autoLoad, autoScroll, backgroundTitle, body, bodyColor, bodyStyle, closable, drag, height, id, left, modal, resize, tbar, theme, title, top, width, win, winModal;
      width = obj.width || 200;
      height = obj.height || 200;
      id = obj.id || '';
      title = obj.title || '';
      modal = obj.modal || '';
      autoScroll = obj.autoScroll || '';
      closable = obj.closable || '';
      autoDestroy = obj.autoDestroy || '';
      autoLoad = obj.autoLoad || '';
      drag = obj.drag || '';
      resize = obj.resize || '';
      theme = obj.theme || '';
      bodyStyle = obj.bodyStyle || '';
      bodyColor = obj.bodyColor || '#FFF';
      backgroundTitle = obj.backgroundTitle || '#000';
      body = document.querySelector('body');
      winModal = document.createElement('div');
      win = this;
      winModal.setAttribute("id", "win_modal_" + id);
      winModal.setAttribute("class", "win-modal");
      if (body.offsetWidth < width) {
        width = body.offsetWidth;
      }
      if (body.offsetHeight < height) {
        height = body.offsetHeight;
      }
      left = body.offsetWidth < width ? 0 : (body.offsetWidth - width) / 2;
      top = body.offsetHeight < height ? 0 : (body.offsetHeight - height) / 2;
      winModal.innerHTML = "<div style=\"width:" + width + "; height:" + height + "; top:" + top + "; left:" + left + "; background-color:" + bodyColor + "; " + bodyStyle + ";\" id=\"" + id + "\">\n	<div class=\"win-title\" id=\"win_title_" + id + "\" style=\"background-color:" + backgroundTitle + ";\">\n		<div class=\"win-title_txt\">" + title + "</div>\n		<div class=\"win-title-btn\" id=\"btn_close_ventana_" + id + "\" onclick=\"document.querySelector('body').removeChild(document.querySelector('#win_modal_" + id + "'));\">X</div>\n	</div>\n	<div class=\"win-tbar\" id=\"win_tbar_" + id + "\"></div>\n	<div class=\"win-window-body\" id=\"win_window_" + id + "\">Contenido</div>\n	<div class=\"win-div-resize\" id=\"win_div_resize_" + id + "\"></div>\n</div>\n<script onload>alert(1);</script>";
      body.appendChild(winModal);
      obj.tbar.id = id;
      tbar = Win.tbar(obj.tbar);
      obj.autoLoad.id = id;
      console.log(Win);
    },
    tbar: function(obj) {
      var div, objDiv;
      div = '';
      if (typeof obj === 'object') {
        objDiv = document.getElementById('win_tbar_' + obj.id);
        obj.forEach(function(elemento, index, element) {
          elemento.tbar = objDiv;
          if (elemento.xtype === 'button') {
            return div += Win.button(elemento);
          } else if (elemento.xtype === 'buttongroup') {
            return div += Win.buttongroup(elemento);
          }
        });
      }
      return div += "</div>";
    },
    button: function(obj) {
      var boton, id, text;
      text = obj.text || '';
      id = obj.id || '';
      boton = document.createElement('div');
      boton.setAttribute("id", id);
      boton.setAttribute("class", "win-btn");
      boton.innerHTML = "<button>" + text + "</button>";
      boton.onclick = obj.handler;
      return obj.tbar.appendChild(boton);
    },
    getButton: function(id) {
      this.hiden = function(id) {
        document.getElementById('id').style.display = 'none';
      };
      this.show = function(id) {
        return document.getElementById('id').style.display = 'block';
      };
      return id;
    },
    buttongroup: function(obj) {},
    autoLoad: function(obj) {
      var bodyXhr, xhr;
      xhr = new XMLHttpRequest;
      bodyXhr = 'bd.php?nameFileUpload=prueba&opc=cancelUploadFile';
      xhr.open('POST', bodyXhr, true);
      xhr.onreadystatechange = function() {
        var response;
        if (xhr.readyState === 4) {
          response = xhr.responseText;
          document.getElementById('win_window_' + obj.id).innerHTML = response;
          if (response === 'true') {

          } else {

          }
        }
      };
      return xhr.send(null);
    },
    Ajax: (function() {
      return {
        request: function(obj) {
          var bodyXhr, method, parametros, value, xhr;
          if (typeof obj === 'undefined') {
            console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.request(obj) \nConsulte la documentacion del proyecto");
            return;
          }
          if (typeof obj.params !== 'undefined') {
            parametros = '';
            for (value in obj.params) {
              parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
            }
          }
          xhr = new XMLHttpRequest;
          bodyXhr = obj.url + '?' + parametros;
          method = obj.method || 'POST';
          xhr.open(method, bodyXhr, true);
          xhr.onreadystatechange = function() {
            var response;
            if (xhr.readyState === 4) {
              response = xhr.responseText;
              return obj.success(response, xhr);
            } else {
              return obj.failure(xhr);
            }
          };
          return xhr.send(null);
        },
        load: function(dom_element, obj) {
          var bodyXhr, method, parametros, tagScript, value, xhr;
          tagScript = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)';
          if (typeof obj === 'undefined') {
            console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.load(obj) \nConsulte la documentacion del proyecto");
            return;
          }
          if (typeof obj.params !== 'undefined') {
            parametros = '';
            for (value in obj.params) {
              parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
            }
          }
          xhr = new XMLHttpRequest;
          bodyXhr = obj.url + '?' + parametros;
          method = obj.method || 'POST';
          xhr.open(method, bodyXhr, true);
          xhr.onreadystatechange = function() {
            var response;
            if (xhr.readyState === 4) {
              return response = xhr.responseText;
            }
          };
          return xhr.send(null);
        }
      };
    })(),
    get: function(element_id) {
      return {
        load: function(obj) {
          var dom_element;
          dom_element = document.getElementById(element_id);
          return Win.Ajax.load(dom_element, obj);
        },
        element: function() {
          return document.getElementById(element_id);
        }
      };
    }
  };
})();

this.Win = Win;


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
