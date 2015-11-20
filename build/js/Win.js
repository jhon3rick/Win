/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * Win.js
 * @namespeace Win
 *
 * @version 0.1
 * @author Jhon Marroquin || @jhon3rick
 * @author Jonatan Herran || @jonatan2874
 *
 */

(function() {
  "use strict";
  var Win;

  Win = (function() {
    var $W, CLASS_SELECTOR, HTML_CONTAINERS, ID_SELECTOR, TABLE, TABLE_ROW, TAG_SELECTOR;
    CLASS_SELECTOR = /^\.([\w-]+)$/;
    ID_SELECTOR = /^#[\w\d-]+$/;
    TAG_SELECTOR = /^[\w-]+$/;
    TABLE = document.createElement('table');
    TABLE_ROW = document.createElement('tr');
    HTML_CONTAINERS = {
      "tr": document.createElement("tbody"),
      "tbody": TABLE,
      "thead": TABLE,
      "tfoot": TABLE,
      "td": TABLE_ROW,
      "th": TABLE_ROW,
      "div": document.createElement("div")
    };
    $W = function(selector) {
      var elements;
      if (CLASS_SELECTOR.test(selector)) {
        elements = document.getElementsByClassName(selector.replace(".", ""));
      } else if (TAG_SELECTOR.test(selector)) {
        elements = document.getElementsByTagName(selector);
      } else if (ID_SELECTOR.test(selector)) {
        elements = document.getElementById(selector.replace("#", ""));
        if (!elements) {
          elements = [];
        }
      } else {
        elements = document.querySelectorAll(selector);
      }
      return elements;
      if (elements.nodeType) {
        return [elements];
      } else {
        return Array.prototype.slice.call(elements);
      }
    };

    /*
    	 * Widges ventana
     */
    $W.Window = function(obj) {
      var autoDestroy, autoLoad, autoScroll, bgBody, bgTitle, body, bodyColor, bodyStyle, closable, clsBody, divClose, divResize, drag, height, html, id, left, modal, resize, theme, title, titleStyle, top, width, win, winModal;
      width = obj.width || 300;
      height = obj.height || 300;
      id = obj.id || '';
      title = obj.title || '';
      titleStyle = obj.titleStyle || '';
      modal = obj.modal || '';
      autoScroll = obj.autoScroll || '';
      closable = typeof obj.closable !== 'undefined' ? obj.closable : true;
      autoDestroy = obj.autoDestroy || '';
      autoLoad = obj.autoLoad || '';
      html = obj.html || '';
      drag = obj.drag || '';
      resize = typeof obj.resize !== 'undefined' ? obj.resize : true;
      theme = obj.theme || '';
      bodyStyle = obj.bodyStyle || '';
      bodyColor = obj.bodyColor || '#FFF';
      body = $W('body')[0];
      winModal = document.createElement('div');
      win = this;
      clsBody = typeof obj.type !== 'undefined' && obj.type !== '' ? 'alert' : '';
      bgBody = obj.bgBody ? 'background-color:' + obj.bgBody + ';' : '';
      bgTitle = obj.bgTitle ? 'background-color:' + obj.bgTitle + ';' : '';
      divClose = resize === true || resize === '' ? "<div class=\"win-title-btn\" id=\"btn_close_ventana_" + id + "\" onclick=\"" + id + ".close()\"></div>" : '';
      divResize = resize === true || resize === '' ? "<div class=\"win-div-resize\" id=\"win_div_resize_" + id + "\"></div>" : '';
      winModal.setAttribute("id", "win_modal_" + id);
      winModal.setAttribute("class", "win-modal");
      left = body.offsetWidth < width ? 0 : (body.offsetWidth - width) / 2;
      top = body.offsetHeight < height ? 0 : (body.offsetHeight - height) / 2;
      winModal.innerHTML = "<div style=\"width:" + width + "; height:" + height + "; top:" + top + "; left:" + left + "; " + bgBody + " " + bodyStyle + "\" id=\"" + id + "\" class=\"win-marco\">\n	<div class=\"win-modal-parent\" id=\"win_modal_window_" + id + "\"><div class=\"win-modal-content\"><div class=\"win-loader-default\" id=\"win_loader_" + id + "\"></div><div class=\"win-modal-label\" id=\"label_cargando_" + id + "\"></div></div></div>\n	<div class=\"win-title\" id=\"win_title_" + id + "\" style=\"" + bgTitle + " " + titleStyle + "\">\n		<div class=\"win-title-txt\">" + title + "</div>\n		" + divClose + "\n	</div>\n	" + divResize + "\n	<div class=\"win-tbar\" id=\"win_tbar_" + id + "\"></div>\n	<div class=\"win-window-body " + clsBody + "\" id=\"win_window_" + id + "\">" + html + "</div>\n</div>\n<script onload>alert(1);</script>";
      body.appendChild(winModal);
      if (typeof obj.tbar !== 'undefined') {
        obj.tbar.id = id;
        $W.tbar(obj.tbar);
      } else {
        $W('#win_tbar_' + id).parentNode.removeChild($W('#win_tbar_' + id));
      }
      if (typeof obj.autoLoad !== 'undefined') {
        $W.Ajax.load($W('#win_window_' + id), obj.autoLoad);
      }
      return {
        close: function() {
          return document.getElementById("" + id).parentNode.parentNode.removeChild(document.getElementById("" + id).parentNode);
        }
      };
    };
    $W.tbar = function(obj) {
      var align, objDiv;
      if (typeof obj === 'object') {
        align = '';
        objDiv = $W('#win_tbar_' + obj.id);
        return obj.forEach(function(json, index, element) {
          if (json.xtype === 'button') {
            return $W.button({
              tbar: objDiv,
              align: align,
              json: json
            });
          } else if (json.xtype === 'buttongroup') {
            json.tbar = objDiv;
            return $W.buttongroup(json);
          } else if (typeof json.items !== 'undefined') {
            json.items.tbar = objDiv;
            return $W.items(json.items);
          } else if (json.xtype === 'tbtext') {
            return $W.tbtext({
              tbar: objDiv,
              align: align,
              json: json
            });
          } else if (json === '-') {
            return $W.separator({
              tbar: objDiv,
              align: align
            });
          } else if (json === '->') {
            return align = 'right';
          }
        });
      }
    };
    $W.items = function(obj) {
      if (typeof obj === 'object') {
        return obj.forEach(function(json, index, element) {
          if (json.xtype === 'panel') {
            json.tbar = obj.tbar;
            return $W.panel(json);
          }
        });
      }
    };
    $W.buttongroup = function(obj) {};
    $W.button = function(obj) {
      var boton, cls, clsAling, id, text;
      text = obj.json.text || '';
      id = obj.json.id || '';
      cls = obj.json.cls || '';
      clsAling = obj.align === 'right' ? 'widge-right' : '';
      boton = document.createElement('div');
      boton.setAttribute("id", id);
      boton.setAttribute("class", "win-btn " + clsAling);
      boton.innerHTML = "<button class=\"" + cls + "\">" + text + "</button>";
      boton.onclick = obj.json.handler;
      return obj.tbar.appendChild(boton);
    };
    $W.panel = function(obj) {
      var bodyStyle, height, id, panel, width;
      id = obj.id || '';
      width = obj.width || 'auto';
      height = obj.height || '100%';
      bodyStyle = obj.bodyStyle || '';
      panel = document.createElement('div');
      panel.setAttribute("id", id);
      panel.setAttribute("class", "win-panel ");
      panel.setAttribute("style", 'width:' + width + ';height:' + height + ';' + bodyStyle);
      obj.tbar.appendChild(panel);
      if (typeof obj.autoLoad !== 'undefined') {
        return $W.Ajax.load(panel, obj.autoLoad);
      } else if (typeof obj.html !== 'undefined') {
        return panel.innerHTML = obj.html;
      }
    };
    $W.tbtext = function(obj) {
      var clsAling, text;
      text = document.createElement('div');
      clsAling = obj.align === 'right' ? 'widge-right' : '';
      text.setAttribute("id", "win_tbtext_" + obj.json.id);
      text.setAttribute("class", "win-tbtext " + clsAling);
      text.innerHTML = "<div>" + obj.json.text + "</div>";
      return obj.tbar.appendChild(text);
    };
    $W.separator = function(obj) {
      var clsAling, div;
      div = document.createElement('div');
      clsAling = obj.align === 'right' ? 'widge-right' : '';
      div.setAttribute("class", "win-separator " + clsAling);
      div.innerHTML = "<div>|</div>";
      return obj.tbar.appendChild(div);
    };

    /*
    	 * Get Elements
     */
    $W.getButton = function(id) {
      this.hiden = function(id) {
        return $W('#id').style.display = 'none';
      };
      this.show = function(id) {
        return $W('#id').style.display = 'block';
      };
      return id;
    };
    $W.get = function(element_id) {
      return {
        load: function(obj) {
          var dom_element;
          dom_element = $W(element_id);
          return $W.Ajax.load(dom_element, obj);
        },
        element: function() {
          return $W(element_id);
        }
      };
    };
    $W.loading = function(obj) {
      var duracion, estilo_texto, evento_icono, icono, iconos, loader, mask, text, texto;
      if (typeof obj.id_ventana === 'undefined' || typeof obj.estado === 'undefined') {
        console.warn('Funcion: Loading (Mostrar ventana modal)\nFaltan parametros en el objeto\nParametro Obligatorios: id_ventana ,estado');
        return;
      }
      if (!$W('#win_window_' + obj.id_ventana)) {
        console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana ' + id_ventana);
        return;
      }
      mask = $W('#win_modal_window_' + obj.id_ventana);
      text = obj.text || 'Cargando...';
      loader = obj.loader || 'default';
      if (obj.estado === 'on') {
        $W('#win_modal_window_' + obj.id_ventana).innerHTML = '<div class="win-modal-content"><div class="win-loader-default" id="win_loader_' + obj.id_ventana + '"></div><div class="win-modal-label" id="label_cargando_' + obj.id_ventana + '"></div></div>';
        mask.style.visibility = 'visible';
        $W('#win_loader_' + obj.id_ventana).setAttribute('class', 'win-loader-' + loader);
        return $W('#label_cargando_' + obj.id_ventana).innerHTML = text;
      } else if (obj.estado === 'off') {
        iconos = {
          sucess: '',
          fail: '',
          warm: ''
        };
        if (obj) {
          icono = iconos[obj.icono] || iconos['sucess'];
          evento_icono = obj.evento_icono || '';
          texto = obj.texto || 'Informacion Almacenada';
          duracion = obj.duracion || '2000';
          estilo_texto = obj.estilo_texto || 'padding-top: 10px;font-size: 12px;color:#FFF;';
        } else {
          icono = iconos.sucess;
          evento_icono = '';
          texto = 'Informacion Almacenada';
          duracion = '2000';
          estilo_texto = 'padding-top: 10px;font-size: 12px;color:#FFF;';
        }
        if (duracion === 'infinito') {
          return $W('#win_modal_window_' + obj.id_ventana).innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='" + icono + "' onclick='" + evento_icono + "'; ><br><div class='win-modal-label label-finish' >" + texto + "</div></div></div>";
        } else {
          $W('#win_modal_window_' + obj.id_ventana).innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='" + icono + "' onclick='" + evento_icono + "'; ><br><div class='win-modal-label label-finish' >" + texto + "</div></div></div>";
          return setTimeout((function() {
            return mask.style.visibility = 'hidden';
          }), duracion);
        }
      }
    };
    $W.Alert = function(obj) {
      var Win_ventana_alert, height, text, title, width;
      if (typeof obj === 'undefined') {
        console.warn('Para utiliza la propiedad alert debe enviar el objeto con los parametros\nConsulte la documentacion');
        return;
      }
      width = 250;
      height = 120;
      title = obj.title || 'Alert';
      text = obj.text || '';
      text += '<div class="content-btn"><input type="button" value="Aceptar" onclick="document.getElementById(\'Win_ventana_alert\').parentNode.parentNode.removeChild(document.getElementById(\'Win_ventana_alert\').parentNode)"></div>';
      return Win_ventana_alert = new $W.Window({
        width: width,
        height: height,
        id: 'Win_ventana_alert',
        title: title,
        html: text,
        type: 'alert',
        modal: true,
        autoScroll: true,
        closable: false,
        autoDestroy: true,
        drag: false,
        resize: false
      });
    };
    $W.Confirm = function(obj) {
      var height, text, title, width;
      if (typeof obj === 'undefined') {
        console.warn('Para utiliza la propiedad alert debe enviar el objeto con los parametros\nConsulte la documentacion');
        return;
      }
      width = 250;
      height = 120;
      title = obj.title || 'Confirm';
      text = obj.text || '';
      text += '<div class="content-btn"><input type="button" value="Aceptar" onclick="document.getElementById(\'Win_ventana_confirm\').parentNode.parentNode.removeChild(document.getElementById(\'Win_ventana_confirm\').parentNode);' + obj.functionOK + ';"> <input type="button" value="Cancelar" onclick="document.getElementById(\'Win_ventana_confirm\').parentNode.parentNode.removeChild(document.getElementById(\'Win_ventana_confirm\').parentNode);return false;"></div>';
      return new $W.Window({
        width: width,
        height: height,
        id: 'Win_ventana_confirm',
        title: title,
        html: text,
        type: 'alert',
        modal: true,
        autoScroll: true,
        closable: false,
        autoDestroy: true,
        drag: false,
        resize: false
      });
    };
    $W.version = "0.0.1";
    return $W;
  })();

  this.Win = this.$W = Win;

}).call(this);
