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
  (function($W) {
    var _button, _panel, _router, _separator, _separatorHeight, _tbtext;
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
      winModal.setAttribute("id", "win-modal-" + id);
      winModal.setAttribute("class", "win-modal");
      left = body.offsetWidth < width ? 0 : (body.offsetWidth - width) / 2;
      top = body.offsetHeight < height ? 0 : (body.offsetHeight - height) / 2;
      winModal.innerHTML = "<div style=\"width:" + width + "; height:" + height + "; top:" + top + "; left:" + left + "; " + bgBody + " " + bodyStyle + "\" id=\"" + id + "\" class=\"win-marco\">\n	<div class=\"win-modal-parent\" id=\"win-modal-window_" + id + "\">\n		<div class=\"win-modal-content\">\n			<div class=\"win-loader-default\" id=\"win_loader_" + id + "\"></div>\n			<div class=\"win-modal-label\" id=\"label_cargando_" + id + "\"></div>\n		</div>\n	</div>\n	<header class=\"win-title\" id=\"win_title_" + id + "\" style=\"" + bgTitle + " " + titleStyle + "\">\n		<div class=\"win-title-txt\">" + title + "</div>\n		" + divClose + "\n	</header>\n	" + divResize + "\n	<div class=\"win-tbar\" id=\"win_tbar_" + id + "\"></div>\n	<div class=\"win-window-body " + clsBody + "\" id=\"win_window_" + id + "\">" + html + "</div>\n</div>";
      body.appendChild(winModal);
      if (typeof obj.tbar !== 'undefined') {
        obj.tbar.applyTo = id;
        $W.tbar(obj.tbar);
      }
      if (typeof obj.autoLoad !== 'undefined') {
        $W.Ajax.load($W('#win_window_' + id)[0], obj.autoLoad);
      }
      return {
        close: function() {
          return $W("\#win-modal-" + id)[0].parentNode.removeChild($W("\#win-modal-" + id)[0]);
        }
      };
    };
    $W.aside = function(obj) {};
    $W.tabpanel = function(obj) {};
    $W.tbar = function(obj) {
      var tbar;
      tbar = $W('#win_tbar_' + obj.applyTo)[0];
      return _router(obj, tbar);
    };
    $W.getButton = function(id) {
      this.hiden = function(id) {
        return $W('#id').style('display', 'none');
      };
      this.show = function(id) {
        return $W('#id').style('display', 'block');
      };
      return id;
    };
    $W.get = function(element_id) {
      return {
        load: function(obj) {
          var dom_element;
          dom_element = $W(element_id)[0];
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
      if (!$W('#win_window_' + obj.id_ventana)[0]) {
        console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana ' + id_ventana);
        return;
      }
      mask = $W('#win-modal-window_' + obj.id_ventana)[0];
      text = obj.text || 'Cargando...';
      loader = obj.loader || 'default';
      if (obj.estado === 'on') {
        $W('#win-modal-window_' + obj.id_ventana)[0].innerHTML = '<div class="win-modal-content"><div class="win-loader-default" id="win_loader_' + obj.id_ventana + '"></div><div class="win-modal-label" id="label_cargando_' + obj.id_ventana + '"></div></div>';
        mask.style.visibility = 'visible';
        $W('#win_loader_' + obj.id_ventana)[0].setAttribute('class', 'win-loader-' + loader);
        return $W('#label_cargando_' + obj.id_ventana)[0].innerHTML = text;
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
          return $W('#win-modal-window_' + obj.id_ventana)[0].innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='" + icono + "' onclick='" + evento_icono + "'; ><br><div class='win-modal-label label-finish' >" + texto + "</div></div></div>";
        } else {
          $W('#win-modal-window_' + obj.id_ventana)[0].innerHTML = "<div class='win-modal-content'><div class='win-modal-img-finish'><img src='" + icono + "' onclick='" + evento_icono + "'; ><br><div class='win-modal-label label-finish' >" + texto + "</div></div></div>";
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
      text += "<div class=\"content-btn\"><input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_alert')[0].parentNode.parentNode.removeChild($W('#Win_ventana_alert')[0].parentNode)\"></div>";
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
      width = 250;
      height = 120;
      title = obj.title || 'Confirm';
      text = obj.text || '';
      text += "<div class=\"content-btn\">\n	<input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode);'+obj.functionOK+';\">\n	<input type=\"button\" value=\"Cancelar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode);return false;\">\n</div>";
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

    /*
    		@method _router
    		@param  arr child
    		@param  obj ObjetoDom parent
     */
    _router = function(obj, parent) {
      var align, div;
      if (typeof obj === 'object') {
        align = 'left';
        obj.forEach(function(json, index, element) {
          var div;
          if (json.xtype === 'button') {
            json.parent = parent;
            return _button(json);
          } else if (json.xtype === 'buttongroup') {
            json.parent = parent;
            return $W.buttongroup(json);
          } else if (json.xtype === 'panel') {
            json.parent = parent;
            return _panel(json);
          } else if (json.xtype === 'tbtext') {
            json.align = align;
            json.parent = parent;
            return _tbtext(json);
          } else if (json === '-') {
            return _separator(parent);
          } else if (json === '--') {
            return _separatorHeight(parent);
          } else if (json === '->') {
            align = 'right';
            div = document.createElement('div');
            return parent.appendChild(div);
          }
        });
        if (align === '') {
          div = document.createElement('div');
          return parent.appendChild(div);
        }
      }
    };

    /*
    		@method _separator
    		@param  obj objectDom parent
     */
    _separator = function(obj) {
      var div;
      div = document.createElement('div');
      div.setAttribute("class", "win-separator");
      div.innerHTML = "|";
      return obj.appendChild(div);
    };

    /*
    		@method _separatorHeight
    		@param  obj objectDom parent
     */
    _separatorHeight = function(obj) {
      var div;
      div = document.createElement('div');
      div.setAttribute("class", "win-separatorHeight");
      obj.appendChild(div);
      return $W.buttongroup = function(obj) {};
    };

    /*
    		@method _button
    		@param  obj objectDom parent and config
     */
    _button = function(obj) {
      var boton, cls, id, text;
      text = obj.text || '';
      id = obj.id || '';
      cls = obj.cls || '';
      boton = document.createElement('div');
      boton.setAttribute("id", id);
      boton.setAttribute("class", "win-btn");
      if (obj.width > 0) {
        boton.setAttribute("style", "width: " + obj.width + "px;");
      }
      boton.innerHTML = "<button class=\"" + cls + "\">" + text + "</button>";
      boton.onclick = obj.handler;
      return obj.parent.appendChild(boton);
    };

    /*
    		@method _panel
    		@param  obj objectDom parent and config
     */
    _panel = function(obj) {
      var bodyStyle, height, id, panel, width;
      id = obj.id || '';
      width = obj.width || 'auto';
      height = obj.height || 'auto';
      bodyStyle = obj.bodyStyle || '';
      panel = document.createElement('div');
      panel.setAttribute("id", id);
      panel.setAttribute("class", "win-panel ");
      panel.setAttribute("style", 'width:' + width + ';height:' + height + ';' + bodyStyle);
      obj.parent.appendChild(panel);
      if (typeof obj.autoLoad !== 'undefined') {
        return $W.Ajax.load(panel, obj.autoLoad);
      } else if (typeof obj.html !== 'undefined') {
        return panel.innerHTML = obj.html;
      }
    };

    /*
    		@method _tbtext
    		@param  obj objectDom parent and config
     */
    return _tbtext = function(obj) {
      var text;
      text = document.createElement('div');
      text.setAttribute("id", "win_tbtext_" + obj.id);
      text.setAttribute("class", "win-tbtext ");
      if (obj.align === 'right') {
        text.setAttribute("style", "text-align:right;");
      }
      text.innerHTML = obj.text;
      return obj.parent.appendChild(text);
    };
  })(Win);

}).call(this);
