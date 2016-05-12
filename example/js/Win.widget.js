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
  var hasProp = {}.hasOwnProperty;

  (function($W) {
    var CONTWIDGET, CTXMENU, ELEMENT_ARRAY, _body, _button, _buttonGroup, _deleteCtxMenu, _draggMove, _draggStart, _draggStop, _findResizeBody, _menuOption, _panel, _resize, _resizeBody, _router, _separator, _separatorHeight, _tab, _tabPanel, _tbText, _tbar;
    CONTWIDGET = 0;
    ELEMENT_ARRAY = {};
    CTXMENU = false;
    $W.Window = function(obj) {
      var autoDestroy, autoLoad, bgBody, bgTitle, body, bodyColor, bodyStyle, clsBody, divClose, drag, height, heightVentana, html, id, left, modal, parent, style, theme, title, titleStyle, top, width, widthVentana, winModal;
      width = obj.width || 300;
      height = obj.height || 300;
      id = obj.id || '';
      title = obj.title || '';
      titleStyle = obj.titleStyle || '';
      modal = obj.modal || '';
      autoDestroy = obj.autoDestroy || '';
      autoLoad = obj.autoLoad || '';
      html = obj.html || '';
      drag = obj.drag || '';
      theme = obj.theme || '';
      style = obj.style || '';
      bodyStyle = obj.bodyStyle || '';
      bodyColor = obj.bodyColor || '#FFF';
      body = $W('body')[0];
      parent = this;
      clsBody = typeof obj.type !== 'undefined' && obj.type !== '' ? 'alert' : '';
      winModal = document.createElement('div');
      bgBody = obj.bgBody ? 'background-color:' + obj.bgBody + ';' : '';
      bgTitle = obj.bgTitle ? 'background-color:' + obj.bgTitle + ';' : '';
      divClose = obj.closable !== false ? "<div class=\"win-title-btn\" id=\"btn_close_ventana_" + id + "\" onclick=\"" + id + ".close()\"></div>" : "";
      if (!isNaN(width)) {
        width = width + 'px';
      } else if (width === 'auto') {
        width = 'calc(100% - 20px)';
      }
      if (!isNaN(height)) {
        height = height + 'px';
      } else if (height === 'auto') {
        height = 'calc(100% - 20px)';
      }
      if (id === '') {
        CONTWIDGET++;
        id === CONTWIDGET;
      }
      winModal.innerHTML += "<div id=\"win-modal-" + id + "\" class=\"win-modal\"> <div id=\"" + id + "\" style=\"width:" + width + "; height:" + height + "; " + bgBody + " " + style + "\" class=\"win-marco\"> <div class=\"win-file-resize\" data-resize=\"top\" id=\"win-resize-top-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"bottom\" id=\"win-resize-bottom-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"left\" id=\"win-resize-left-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"right\" id=\"win-resize-right-" + id + "\"></div> <div class=\"win-modal-parent\" id=\"win-modal-window_" + id + "\"> <div class=\"win-modal-content\"> <div class=\"win-loader-default\" id=\"win-loader-" + id + "\"></div> <div class=\"win-modal-label\" id=\"label-load-" + id + "\"></div> </div> </div> <header id=\"win-header-" + id + "\"> <div class=\"win-title\" id=\"win-title-" + id + "\" style=\"" + bgTitle + " " + titleStyle + "\"> <div class=\"win-title-txt\">" + title + "</div> " + divClose + " </div> </header> <section id=\"win-section-" + id + "\" style=\"height:calc(100% - 27px);\" data-role=\"win-section\"></section> </div> </div>";
      body.appendChild(winModal);
      widthVentana = document.getElementById(id).offsetWidth;
      heightVentana = document.getElementById(id).offsetHeight;
      left = body.offsetWidth < (widthVentana / 2) ? 0 : (body.offsetWidth - widthVentana) / 2;
      top = body.offsetHeight < (heightVentana / 2) ? 0 : (body.offsetHeight - heightVentana) / 2;
      $W("#" + id).css("left", left + "px").css("top", top + "px");
      if (obj.resize) {
        _resize($W("#win-resize-top-" + id)[0]);
        _resize($W("#win-resize-bottom-" + id)[0]);
        _resize($W("#win-resize-left-" + id)[0]);
        _resize($W("#win-resize-right-" + id)[0]);
      }
      if (obj.tbar) {
        console.log(obj.tbar);
      }
      if (obj.tbar) {
        _tbar({
          items: obj.tbar
        }, "win-section-" + id);
      }
      if (obj.items) {
        _router(obj.items, "win-section-" + id);
      }
      if (obj.autoLoad) {
        _body(obj, "win-section-" + id);
      }
      return {
        close: function() {
          return $W("\#win-modal-" + id)[0].parentNode.removeChild($W("\#win-modal-" + id)[0]);
        }
      };
    };
    $W.TabPanel = function(obj) {
      var html, id;
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tab-" + CONTWIDGET;
      }
      html = "";
      obj.items.forEach(json, index, element)(function() {
        return html += "<div id=\"" + id + "\">" + json.title + "</div>";
      });
      return "<div id=\"" + obj.id + "\">" + html + "</div>";
    };
    $W.Add = function(obj) {
      var lastDiv, type, typeParent;
      typeParent = document.getElementById(obj.idApply).getAttribute("data-role");
      if (typeParent === "win-tbar") {
        lastDiv = document.getElementById(obj.idApply).lastChild;
        if (lastDiv !== null) {
          type = lastDiv.getAttribute("data-role");
          if (type === "div-empty") {
            lastDiv.parentNode.removeChild(lastDiv);
          }
        }
      }
      if (obj.items) {
        _router(obj.items, obj.idApply);
      }
      if (obj.autoLoad) {
        return _body(obj, obj.idApply);
      }
    };
    $W.Tbar = function(obj) {
      var parent;
      parent = document.getElementById("" + obj.idApply);
      parent.className = "win-tbar";
      parent.setAttribute("data-role", "win-tbar");
      _router(obj.items, obj.idApply);
      return setTimeout(function() {
        return _resizeBody(document.getElementById(obj.idApply).parentNode.id);
      });
    };
    $W.Element = function(id) {
      this.hidden = function() {
        $W('#' + id).style('display', 'none');
        _findResizeBody(id);
        return ELEMENT_ARRAY[id].hidden = true;
      };
      this.show = function() {
        $W('#' + id).style('display', 'block');
        _findResizeBody(id);
        return ELEMENT_ARRAY[id].hidden = false;
      };
      this.enable = function() {
        document.getElementById(id).setAttribute('data-state', 'enable');
        return ELEMENT_ARRAY[id].state = "enable";
      };
      this.disable = function() {
        document.getElementById(id).setAttribute('data-state', 'disable');
        return ELEMENT_ARRAY[id].state = "disable";
      };
      return this;
    };
    $W.BlockBtn = function(id) {
      if (ELEMENT_ARRAY[id].state === "disable") {
        return;
      }
      $W.Element(id).disable();
      return setTimeout(function() {
        if (document.getElementById(id)) {
          return $W.Element(id).enable();
        }
      }, 1500);
    };
    $W.Loading = function(obj) {
      var duracion, estilo_texto, evento_icono, icono, iconos, id, loader, mask, text, texto;
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-loading-" + CONTWIDGET;
      }
      if (typeof obj.id_ventana === 'undefined' || typeof obj.estado === 'undefined') {
        console.warn('Funcion: Loading (Mostrar ventana modal)\nFaltan parametros en el objeto\nParametro Obligatorios: id_ventana ,estado');
        return;
      }
      if (!$W("#win-body-" + obj.id_ventana)[0]) {
        console.warn('Funcion: Loading (Mostrar ventana modal)\nEl id de la ventana es incorrecto no se encuentra la ventana ' + id_ventana);
        return;
      }
      mask = $W("#win-modal-window_" + obj.id_ventana)[0];
      text = obj.text || 'Load...';
      loader = obj.loader || 'default';
      if (obj.estado === 'on') {
        $W("#win-modal-window_" + obj.id_ventana)[0].innerHTML = "<div class=\"win-modal-content\"> <div class=\"win-loader-default\" id=\"win-loader-" + obj.id_ventana + "\"></div> <div class=\"win-modal-label\" id=\"label-load-" + obj.id_ventana + "\"></div> </div>";
        mask.style.visibility = 'visible';
        $W("#win-loader-" + obj.id_ventana)[0].setAttribute('class', 'win-loader-' + loader);
        return $W("#label-load-" + obj.id_ventana)[0].innerHTML = text;
      } else if (obj.estado === 'off') {
        iconos = {
          sucess: '',
          fail: '',
          warm: ''
        };
        if (obj) {
          icono = iconos[obj.icono] || iconos['sucess'];
          evento_icono = obj.evento_icono || '';
          texto = obj.texto || 'OK...';
          duracion = obj.duracion || '2000';
          return estilo_texto = obj.estilo_texto || 'padding-top: 10px;font-size: 12px;color:#FFF;';
        } else {
          icono = iconos.sucess;
          evento_icono = '';
          texto = 'Informacion Almacenada';
          duracion = '2000';
          estilo_texto = 'padding-top:10px; font-size:12px; color:#FFF;';
          $W("#win-modal-window_" + obj.id_ventana)[0].innerHTML = "<div class=\"win-modal-content\"> <div class=\"win-modal-img-finish\"> <img src=\"" + icono + "\" onclick=\"" + evento_icono + "\"><br> </div> <div class=\"win-modal-label label-finish\">" + texto + "</div> <div>";
          return setTimeout((function() {
            return mask.style.visibility = 'hidden';
          }), duracion);
        }
      }
    };
    $W.Alert = function(obj) {
      var height, text, title, width;
      width = 250;
      height = 120;
      title = obj.title || 'Alert';
      text = obj.text || '';
      text += "<div class=\"content-btn\"> <input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_alert')[0].parentNode.parentNode.removeChild($W('#Win_ventana_alert')[0].parentNode)\"> </div>";
      return new $W.Window({
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
      text += "<div class=\"content-btn\"> <input type=\"button\" value=\"Aceptar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode); " + obj.functionOK + ";\"> <input type=\"button\" value=\"Cancelar\" onclick=\"$W('#Win_ventana_confirm')[0].parentNode.parentNode.removeChild($W('#Win_ventana_confirm')[0].parentNode); return false;\"> </div>";
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
    $W.CtxMenu = function(obj) {
      return document.getElementById(obj.idApply).oncontextmenu = function(e) {
        obj.objApply = e.srcElement;
        obj.clientX = event.clientX;
        obj.clientY = event.clientY;
        $W.Menu(obj);
        return false;
      };
    };
    $W.Menu = function(obj) {
      var arr, divHtml, html, key, ref;
      html = "";
      _deleteCtxMenu();
      CTXMENU = true;
      if (obj.items) {
        ref = obj.items;
        for (key in ref) {
          if (!hasProp.call(ref, key)) continue;
          arr = ref[key];
          html += "<div data-option=\"top-" + key + "\"> <div>" + arr.text + "</div> </div>";
        }
      }
      divHtml = obj.objApply ? obj.objApply : document.getElementById(obj.idElement);
      divHtml.innerHTML += "<div class=\"win-menu\" data-role=\"win-menu\" style=\"top:" + event.clientY + "px; left:" + event.clientX + "px;\">" + html + "</div>";
      if (obj.items) {
        return setTimeout(function() {
          var ref1, results;
          ref1 = obj.items;
          results = [];
          for (key in ref1) {
            if (!hasProp.call(ref1, key)) continue;
            arr = ref1[key];
            results.push(_menuOption(obj.idApply, key, arr.handler));
          }
          return results;
        });
      }
    };
    _menuOption = function(idApply, key, handler) {
      return document.getElementById(idApply).querySelector("[data-option=top-" + key + "]").onclick = function() {
        _deleteCtxMenu();
        return handler(this);
      };
    };

    /*
    	@method _deleteCtxMenu
     */
    _deleteCtxMenu = function() {
      var array;
      if (CTXMENU === true) {
        array = document.querySelectorAll("[data-role=win-menu]");
        [].forEach.call(array, function(menu) {
          return menu.parentNode.removeChild(menu);
        });
      }
      return CTXMENU = false;
    };

    /*
    	@method _router
    	@param  arr child
    	@param  obj ObjetoDom idParent
     */
    _router = function(obj, idParent) {
      var float;
      if (typeof obj === 'object') {
        float = 'left';
        obj.forEach(function(json, index, element) {
          switch (json.xtype) {
            case 'button':
              return _button(json, idParent);
            case 'buttongroup':
              return _buttonGroup(json, idParent);
            case 'tbar':
              return _tbar(json, idParent);
            case 'panel':
              return _panel(json, idParent);
            case 'tabpanel':
              return _tabPanel(json, idParent);
            case 'tab':
              return _tab(json, idParent);
            case 'tbtext':
              return _tbText(json, idParent);
            default:
              if (json === '-') {
                return _separator(idParent);
              } else if (json === '--') {
                return _separatorHeight(idParent);
              } else if (json === '->') {
                float = 'right';
                return document.getElementById(idParent).innerHTML += '<div data-role="div-empty"></div>';
              }
          }
        });
        if (float === 'left') {
          return document.getElementById(idParent).innerHTML += '<div data-role="div-empty"></div>';
        }
      }
    };

    /*
    	@method _tabPanel
    	@param  obj objectDom parent and config
     */
    _tabPanel = function(obj, idParent) {
      var bodyHeight, height, heightTabPanel, html, id, style, width;
      style = obj.style || '';
      height = obj.height || '';
      bodyHeight = '';
      if (!isNaN(width)) {
        width = width + 'px';
      }
      if (!isNaN(height)) {
        height = height + 'px';
      }
      if (height !== '') {
        bodyHeight = "calc(100% - " + height + ")";
      }
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tabpanel-" + CONTWIDGET;
      }
      html = "<div id=\"" + id + "\" class=\"win-tabpanel\" style=\"height:" + height + "; " + style + "\" data-role=\"win-tabpanel\"></div> <div id=\"win-tabpanel-body-" + id + "\" class=\"win-tabpanel-body\" style=\"height:" + bodyHeight + ";\"></div>";
      document.getElementById(idParent).innerHTML += html;
      if (obj.items) {
        _router(obj.items, id);
      }
      heightTabPanel = document.getElementById(id).offsetHeight;
      return document.getElementById("win-tabpanel-body-" + id).style.height = "calc(100% - " + heightTabPanel + "px)";
    };
    _tab = function(obj, idParent) {
      var iconCls, id, title;
      title = obj.title || '';
      iconCls = obj.iconCls || '';
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tab-" + CONTWIDGET;
      }
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\"class=\"win-tab\" data-activo=\"false\" data-load=\"false\"><span class=\"icon-tab form\"></span><span>" + title + "</span></div>";
      document.getElementById("win-tabpanel-body-" + idParent).innerHTML += "<div id=\"win-tab-body-" + id + "\" class=\"win-tab-body\" style=\"height:100%; overflow:hidden;\" data-activo=\"false\">" + id + "</div>";
      return setTimeout(function() {
        return document.getElementById(id).onclick = function() {
          var load;
          $W("#" + idParent + " > [data-activo=true]").attr("data-activo", "false");
          this.setAttribute("data-activo", "true");
          $W("#win-tabpanel-body-" + idParent + " > [data-activo=true]").attr("data-activo", "false");
          $W("#win-tab-body-" + id).attr("data-activo", "true");
          load = this.getAttribute("data-load");
          if (load === "false") {
            this.setAttribute("data-load", "true");
            obj.autoLoad.idApply = "win-tab-body-" + id;
            return $W.Load(obj.autoLoad);
          }
        };
      });
    };

    /*
    	@method _panel
    	@param  obj objectDom config
    	@param  obj objectDom parent
     */
    _panel = function(obj, idParent) {
      var height, html, id, style, title, width;
      width = obj.width || '160';
      height = obj.height || '60';
      html = obj.html || '';
      style = obj.style || '';
      title = obj.title || '';
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = CONTWIDGET;
      }
      if (title !== '') {
        height = height - 20;
        title = "<div id=\"win-panel-title-" + id + "\" style=\"width:" + width + "; height:20px; " + style + "\" class=\"win-panel-title\">" + title + "</div>";
      }
      if (!isNaN(width)) {
        width = width + 'px';
      }
      if (!isNaN(height)) {
        height = height + 'px';
      }
      html = "<div id=\"win-panel-" + id + "\" class=\"win-panel\" style=\"width:" + width + "; height:" + height + "; " + style + "\" data-role=\"win-panel\"> " + title + " <div id=\"win-panel-load-" + id + "\" class=\"win-panel-load\" style=\"width:" + width + "; height:" + height + "; " + style + "\"> " + html + " </div> </div>";
      document.getElementById(idParent).innerHTML += html;
      if (obj.autoLoad) {
        return setTimeout(function() {
          obj.autoLoad.idApply = 'win-panel-load-' + id;
          return $W.Load(obj.autoLoad);
        });
      } else if (obj.items) {
        return _router(obj.items, "win-panel-load-" + id);
      }
    };

    /*
    	@method _tbar
    	@param  obj objectDom parent and config
     */
    _tbar = function(obj, idParent) {
      var id;
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tbar-" + CONTWIDGET;
      }
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-tbar\" data-role=\"win-tbar\"></div>";
      if (obj.items) {
        _router(obj.items, "" + id);
      }
      return setTimeout(function() {
        return _resizeBody(document.getElementById(id).parentNode.id);
      });
    };
    _buttonGroup = function(obj, idParent) {
      var hidden, i, id, item, len, ref, style, title, width;
      hidden = obj.hidden || '';
      width = obj.width || 0;
      style = obj.style || '';
      title = obj.title || '';
      if (width === 0 && obj.items) {
        ref = obj.items;
        for (i = 0, len = ref.length; i < len; i++) {
          item = ref[i];
          if (!item.hidden) {
            width += item.width > 0 ? item.width || 60 : void 0;
          }
        }
      }
      if (!isNaN(width)) {
        width = width + 'px';
      }
      if (hidden === true) {
        hidden = "display:none;";
      }
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = CONTWIDGET;
      }
      ELEMENT_ARRAY[id] = {
        state: "enable",
        hidden: hidden
      };
      if (title !== '') {
        title = "<div id=\"win-buttongroup-title-" + id + "\" style=\"height:20px;\" class=\"win-buttongroup-title\">" + title + "</div>";
      }
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-buttongroup\" style=\"width:" + width + "; " + hidden + " " + style + "\" data-role=\"win-buttongroup\"> " + title + " <div id=\"win-buttongroup-body-" + id + "\" class=\"win-buttongroup-body\" style=\"" + style + "\"></div> </div>";
      if (obj.items) {
        return _router(obj.items, "win-buttongroup-body-" + id);
      }
    };

    /*
    	@method _button
    	@param  obj objectDom parent and config
     */
    _button = function(obj, idParent) {
      var align, cls, hidden, id, text, width;
      text = obj.text || '';
      cls = obj.cls || 'save';
      align = obj.align || 'top';
      width = obj.width || 50;
      hidden = obj.hidden || false;
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-btn-" + CONTWIDGET;
      }
      ELEMENT_ARRAY[id] = {
        state: "enable",
        hidden: hidden
      };
      if (!isNaN(width)) {
        width = width + 'px';
      }
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-btn\" style=\"width:" + width + ";\" data-role=\"win-btn\"> <button class=\"" + cls + "\">" + text + "</button> </div>";
      _findResizeBody(id);
      if (obj.handler) {
        return setTimeout(function() {
          return document.querySelector("\#" + idParent + " > \#" + id).onclick = function() {
            if (ELEMENT_ARRAY[id].state === "disable") {
              return;
            }
            $W.BlockBtn(id);
            return obj.handler(this);
          };
        });
      }
    };

    /*
    	@method _tbText
    	@param  obj objectDom parent and config
     */
    _tbText = function(obj, idParent) {
      var id, style, text, width;
      text = obj.text || '';
      width = obj.width || 120;
      style = obj.style || 'left';
      if (width > 0) {
        width = width + 'px';
      }
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tbtext-" + CONTWIDGET;
      }
      return document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-tbtext\" style=\"width:" + width + "; " + style + "\" data-role=\"win-tbtext\">" + text + "</div>";
    };

    /*
    	@method _separator
    	@param  obj objectDom parent
     */
    _separator = function(idParent) {
      return document.getElementById(idParent).innerHTML += "<div class=\"win-separator\" data-role=\"win-separator\">|</div>";
    };

    /*
    	@method _separatorHeight
    	@param  obj objectDom parent
     */
    _separatorHeight = function(idParent) {
      return document.getElementById(idParent).innerHTML += "<div class=\"win-separatorHeight\" data-role=\"win-separatorHeight\"></div>";
    };

    /*
    	@method _body
    	@param  obj objectDom parent and config
     */
    _body = function(obj, idParent) {
      var bodyStyle, clsBody, html, id, items, parent, style;
      items = obj.items || '';
      html = obj.html || '';
      style = 'overflow:hidden;';
      clsBody = obj.clsBody || '';
      bodyStyle = obj.bodyStyle || '';
      if (obj.scrollY === true) {
        style += 'overflow-y:auto;';
      } else if (obj.scrollX === true) {
        style += 'overflow-x:auto;';
      }
      if (obj.scroll === true) {
        style = 'overflow:auto;';
      }
      if (obj.idApply) {
        id = obj.idApply;
      } else {
        CONTWIDGET++;
        id = "win-body-" + CONTWIDGET;
      }
      parent = document.getElementById(idParent);
      parent.innerHTML += "<div id=\"" + id + "\" class=\"win-body " + clsBody + "\" style=\"" + style + " " + bodyStyle + "\" data-role=\"win-body\">" + html + "</div>";
      return setTimeout(function() {
        _resizeBody(idParent);
        if (typeof obj.autoLoad) {
          obj.autoLoad.idApply = id;
          return $W.Load(obj.autoLoad);
        }
      });
    };
    _findResizeBody = function(id) {
      var body, div1, div2, div3, role, role1, role2, role3;
      if (!document.getElementById(id)) {
        return;
      }
      role = document.getElementById(id).getAttribute("data-role");
      if (role = "win-btn" || (role = "win-buttongroup")) {
        div1 = document.getElementById(id).parentNode;
        div2 = document.getElementById(id).parentNode.parentNode;
        div3 = document.getElementById(id).parentNode.parentNode.parentNode;
        body = '';
        role1 = div1.getAttribute("data-role");
        role2 = div2.getAttribute("data-role");
        role3 = div3.getAttribute("data-role");
        if (role1 === "win-body" || role1 === "win-section") {
          body = div1;
        } else if (role2 === "win-body" || role2 === "win-section") {
          body = div2;
        } else if (role3 === "win-body" || role3 === "win-section") {
          body = div3;
        }
        if (body !== '') {
          return setTimeout(function() {
            return _resizeBody(body.id);
          });
        }
      }
    };
    _resizeBody = function(idParent) {
      var alto, arrayDiv, body, height;
      if (!document.getElementById(idParent)) {
        return;
      }
      alto = 0;
      body = '';
      arrayDiv = document.querySelectorAll('#' + idParent + ' > [data-role]');
      [].forEach.call(arrayDiv, function(element) {
        var role;
        role = element.getAttribute("data-role");
        if (body !== '') {
          return;
        } else if (role === "win-body") {
          body = element;
          return;
        }
        return alto += element.offsetHeight;
      });
      height = alto === 0 ? '100%' : 'calc(100% - ' + (alto + 1) + 'px)';
      if (body !== '') {
        return setTimeout(function() {
          return body.style.height = height;
        });
      }
    };
    _draggStart = function(id, divParent, evt) {
      var cHe, cWi, diffX, diffY, divLeft, divTop, domMove, eHe, eWi, posX, posY;
      domMove = document.getElementById(id);
      evt = evt || window.event;
      posX = evt.clientX;
      posY = evt.clientY;
      divTop = domMove.style.top.replace('px', '');
      divLeft = domMove.style.left.replace('px', '');
      eWi = parseInt(domMove.offsetWidth);
      eHe = parseInt(domMove.offsetHeight);
      cWi = parseInt(divParent.offsetWidth);
      cHe = parseInt(divParent.offsetHeight);
      divParent.style.cursor = 'move';
      diffX = posX - divLeft;
      diffY = posY - divTop;
      return document.onmousemove = function(evt) {
        var aX, aY;
        evt = evt || window.event;
        posX = evt.clientX;
        posY = evt.clientY;
        aX = posX - diffX;
        aY = posY - diffY;
        if (aX < 0) {
          aX = 0;
        }
        if (aY < 0) {
          aY = 0;
        }
        if (aX + eWi > cWi) {
          aX = cWi - eWi;
        }
        if (aY + eHe > cHe) {
          aY = cHe - eHe;
        }
        return _draggMove(domMove, aX, aY);
      };
    };

    /*
    	@method _draggMove
    	@param obj object DOM move
    	@param int position x
    	@param int position y
     */
    _draggMove = function(objDom, xpos, ypos) {
      objDom.style.left = xpos + 'px';
      return objDom.style.top = ypos + 'px';
    };

    /*
    	@method _draggMove
    	@param obj object parent DOM move
     */
    _draggStop = function(objDom) {
      objDom.style.cursor = 'default';
      return document.onmousemove = function(e) {
        return e.preventDefault;
      };
    };

    /*
    	@method _resize
    	@param obj object DOM resize
     */
    return _resize = function(objDom) {
      var _doDrag, _initDrag, _resizeXLeft, _resizeXRight, _resizeYBottom, _resizeYTop, _stopDrag, attrData, objParent, positionX, positionY, startHeight, startWidth, startX, startY;
      startX = 0;
      startY = 0;
      startWidth = 0;
      startHeight = 0;
      positionY = objDom.parentNode.style.top.replace('px', '') * 1;
      positionX = objDom.parentNode.style.left.replace('px', '') * 1;
      objParent = objDom.parentNode;
      attrData = objDom.getAttribute("data-resize");
      objDom.onmousedown = function(e) {
        return _initDrag(e);
      };
      _initDrag = function(e) {
        startX = e.clientX;
        startY = e.clientY;
        startWidth = parseInt(document.defaultView.getComputedStyle(objParent).width, 10);
        startHeight = parseInt(document.defaultView.getComputedStyle(objParent).height, 10);
        document.documentElement.addEventListener('mousemove', _doDrag, false);
        return document.documentElement.addEventListener('mouseup', _stopDrag, false);
      };
      _doDrag = function(e) {
        if (attrData === 'left') {
          return _resizeXLeft(e);
        } else if (attrData === 'right') {
          return _resizeXRight(e);
        } else if (attrData === 'top') {
          return _resizeYTop(e);
        } else if (attrData === 'bottom') {
          return _resizeYBottom(e);
        }
      };
      _stopDrag = function(e) {
        document.documentElement.removeEventListener('mousemove', _doDrag, false);
        return document.documentElement.removeEventListener('mouseup', _stopDrag, false);
      };
      _resizeXLeft = function(e) {
        objParent.style.left = (positionX + e.clientX - startX) + 'px';
        return objParent.style.width = (startWidth - e.clientX + startX) + 'px';
      };
      _resizeYTop = function(e) {
        objParent.style.top = (positionY + e.clientY - startY) + 'px';
        return objParent.style.height = (startHeight - e.clientY + startY) + 'px';
      };
      _resizeXRight = function(e) {
        if (e.clientX >= 500) {
          return objParent.style.width = (startWidth + e.clientX - startX) + 'px';
        }
      };
      return _resizeYBottom = function(e) {
        if (e.clientY >= 340) {
          return objParent.style.height = (startHeight + e.clientY - startY) + 'px';
        }
      };
    };
  })(Win);

}).call(this);
