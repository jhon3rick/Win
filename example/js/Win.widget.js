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
    var CONTWIDGET, _body, _button, _buttongroup, _draggMove, _draggStart, _draggStop, _panel, _resize, _router, _separator, _separatorHeight, _tab, _tabPanel, _tbar, _tbtext;
    CONTWIDGET = 0;
    $W.Window = function(obj) {
      var autoDestroy, autoLoad, autoScroll, bgBody, bgTitle, body, bodyColor, bodyStyle, clsBody, divClose, drag, height, html, id, left, modal, theme, title, titleStyle, top, width, win, winModal;
      width = obj.width || 300;
      height = obj.height || 300;
      id = obj.id || '';
      title = obj.title || '';
      titleStyle = obj.titleStyle || '';
      modal = obj.modal || '';
      autoScroll = obj.autoScroll || '';
      autoDestroy = obj.autoDestroy || '';
      autoLoad = obj.autoLoad || '';
      html = obj.html || '';
      drag = obj.drag || '';
      theme = obj.theme || '';
      bodyStyle = obj.bodyStyle || '';
      bodyColor = obj.bodyColor || '#FFF';
      body = $W('body')[0];
      win = this;
      clsBody = typeof obj.type !== 'undefined' && obj.type !== '' ? 'alert' : '';
      winModal = document.createElement('div');
      bgBody = obj.bgBody ? 'background-color:' + obj.bgBody + ';' : '';
      bgTitle = obj.bgTitle ? 'background-color:' + obj.bgTitle + ';' : '';
      divClose = obj.closable !== false ? "<div class=\"win-title-btn\" id=\"btn_close_ventana_" + id + "\" onclick=\"" + id + ".close()\"></div>" : "";
      left = body.offsetWidth < (width / 2) ? 0 : (body.offsetWidth - width) / 2;
      top = body.offsetHeight < (height / 2) ? 0 : (body.offsetHeight - height) / 2;
      if (!isNaN(width)) {
        width = width + 'px';
      }
      if (!isNaN(height)) {
        height = height + 'px';
      }
      if (id === '') {
        CONTWIDGET++;
        id === CONTWIDGET;
      }
      left = left + 'px';
      top = top + 'px';
      winModal.innerHTML += "<div id=\"win-modal-" + id + "\" class=\"win-modal\"> <div id=\"" + id + "\" style=\"width:" + width + "; height:" + height + "; top:" + top + "; left:" + left + "; " + bgBody + " " + bodyStyle + "\" class=\"win-marco\"> <div class=\"win-file-resize\" data-resize=\"top\" id=\"win-resize-top-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"bottom\" id=\"win-resize-bottom-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"left\" id=\"win-resize-left-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"right\" id=\"win-resize-right-" + id + "\"></div> <div class=\"win-modal-parent\" id=\"win-modal-window_" + id + "\"> <div class=\"win-modal-content\"> <div class=\"win-loader-default\" id=\"win-loader-" + id + "\"></div> <div class=\"win-modal-label\" id=\"label-load-" + id + "\"></div> </div> </div> <header id=\"win-header-" + id + "\"> <div class=\"win-title\" id=\"win-title-" + id + "\" style=\"" + bgTitle + " " + titleStyle + "\"> <div class=\"win-title-txt\">" + title + "</div> " + divClose + " </div> </header> <section id=\"win-section-" + id + "\" style=\"height:calc(100% - 27px);\"></section> </div> </div>";
      body.appendChild(winModal);
      $W("#win-title-" + id)[0].onmousedown = function() {
        return _draggStart(id, document.getElementById("win-modal-" + id), event);
      };
      $W("#win-title-" + id)[0].onmouseup = function() {
        return _draggStop(document.getElementById("win-modal-" + id));
      };
      if (obj.resize) {
        _resize($W("#win-resize-top-" + id)[0]);
        _resize($W("#win-resize-bottom-" + id)[0]);
        _resize($W("#win-resize-left-" + id)[0]);
        _resize($W("#win-resize-right-" + id)[0]);
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
    $W.Add = function(obj) {
      var parent;
      parent = document.getElementById("" + obj.idApply);
      if (obj.items) {
        _router(obj.items, obj.idApply);
      }
      if (obj.autoLoad) {
        return _body(obj, obj.idApply);
      }
    };
    $W.tbar = function(obj) {
      var parent;
      parent = document.getElementById("" + obj.idApply);
      parent.className = "win-tbar";
      return _router(obj.items, obj.idApply);
    };
    $W.Element = function(id) {
      this.hiden = function() {
        return $W('#' + id).style('display', 'none');
      };
      this.show = function() {
        return $W('#' + id).style('display', 'block');
      };
      this.enable = function() {
        return $W('#' + id).style('display', 'none');
      };
      this.disable = function() {
        return $W('#' + id).style('display', 'block');
      };
      return this;
    };
    $W.loading = function(obj) {
      var duracion, estilo_texto, evento_icono, icono, iconos, loader, mask, text, texto;
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
          texto = obj.texto || 'Informacion Almacenada';
          duracion = obj.duracion || '2000';
          estilo_texto = obj.estilo_texto || 'padding-top: 10px;font-size: 12px;color:#FFF;';
        } else {
          icono = iconos.sucess;
          evento_icono = '';
          texto = 'Informacion Almacenada';
          duracion = '2000';
          estilo_texto = 'padding-top:10px; font-size:12px; color:#FFF;';
        }
        if (duracion === 'infinito') {
          return $W("#win-modal-window_" + obj.id_ventana)[0].innerHTML = "<div class=\"win-modal-content\"><div class=\"win-modal-img-finish\"> <img src=\"" + icono + "\" onclick=\"" + evento_icono + "\"><br> <div class=\"win-modal-label label-finish\">" + texto + "</div> </div>";
        } else {
          $W("#win-modal-window_" + obj.id_ventana)[0].innerHTML = "<div class=\"win-modal-content\"><div class=\"win-modal-img-finish\"> <img src=\"" + icono + "\" onclick=\"" + evento_icono + "\"><br> <div class=\"win-modal-label label-finish\">" + texto + "</div> </div>";
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
              return _buttongroup(json, idParent);
            case 'tbar':
              return _tbar(json, idParent);
            case 'panel':
              return _panel(json, idParent);
            case 'tabPanel':
              return _tabPanel(json, idParent);
            case 'tab':
              return _tab(json, idParent);
            case 'tbtext':
              return _tbtext(json, idParent);
            default:
              if (json === '-') {
                return _separator(idParent);
              } else if (json === '--') {
                return _separatorHeight(idParent);
              } else if (json === '->') {
                float = 'right';
                return document.getElementById(idParent).innerHTML += '<div></div>';
              }
          }
        });
        if (float === 'left') {
          return document.getElementById(idParent).innerHTML += '<div></div>';
        }
      }
    };

    /*
    	@method _tabPanel
    	@param  obj objectDom parent and config
     */
    _tabPanel = function(obj, idParent) {
      var bodyHeight, height, html, id, style, width;
      style = obj.style || '';
      height = obj.height || '30';
      if (!isNaN(width)) {
        width = width + 'px';
      }
      if (!isNaN(height)) {
        height = height + 'px';
      }
      bodyHeight = "calc:(100% - " + height + ")";
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = CONTWIDGET;
      }
      html = "<div id=\"win-tabpanel-" + id + "\" class=\"win-tabpanel\" style=\"width:100%; height:100%; " + style + "\"> <div id=\"win-tabpanel-head-" + id + "\" class=\"win-tabpanel-head\" style=\"width:100%; height:" + height + "; " + style + "\"></div> <div id=\"win-tabpanel-body-" + id + "\" class=\"win-tabpanel-body\" style=\"height:" + bodyHeight + ";\"></div> </div>";
      document.getElementById(idParent).innerHTML += html;
      if (obj.items) {
        return _router(obj.items, "win-tabpanel-head-" + id);
      }
    };
    _tab = function(obj, idParent) {
      var div, icon, id, title;
      title = obj.title || '';
      icon = obj.icon || '';
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tab-" + CONTWIDGET;
      }
      console.log(idParent);
      div = document.createElement("div");
      div.id = id;
      document.getElementById(idParent).appendChild(div);
      document.querySelectorAll('#' + id).__proto__.estate = 'enable';
      return setTimeout(function() {
        return console.log(document.querySelectorAll('#' + id).estate);
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
      html = "<div id=\"win-panel-" + id + "\" class=\"win-panel\" style=\"width:" + width + "; height:" + height + "; " + style + "\"> " + title + " <div id=\"win-panel-load-" + id + "\" class=\"win-panel-load\" style=\"width:" + width + "; height:" + height + "; " + style + "\"> " + html + " </div> </div>";
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
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-tbar\"></div>";
      if (obj.items) {
        return _router(obj.items, "" + id);
      }
    };
    _buttongroup = function(obj, idParent) {
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
      if (title !== '') {
        title = "<div id=\"win-buttongroup-title-" + id + "\" style=\"height:20px;\" class=\"win-buttongroup-title\">" + title + "</div>";
      }
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-buttongroup\" style=\"width:" + width + "; " + hidden + " " + style + "\"> " + title + " <div id=\"win-buttongroup-body-" + id + "\" class=\"win-buttongroup-body\" style=\"" + style + "\"></div> </div>";
      if (obj.items) {
        return _router(obj.items, "win-buttongroup-body-" + id);
      }
    };

    /*
    	@method _button
    	@param  obj objectDom parent and config
     */
    _button = function(obj, idParent) {
      var cls, id, text, width;
      text = obj.text || '';
      cls = obj.cls || '';
      width = obj.width || 50;
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-btn-" + CONTWIDGET;
      }
      if (!isNaN(width)) {
        width = width + 'px';
      }
      document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-btn\" style=\"width:" + width + ";\"> <button class=\"" + cls + "\">" + text + "</button> </div>";
      if (obj.handler) {
        return setTimeout(function() {
          return document.querySelector("\#" + idParent + " > \#" + id).onclick = obj.handler;
        });
      }
    };

    /*
    	@method _tbtext
    	@param  obj objectDom parent and config
     */
    _tbtext = function(obj, idParent) {
      var id, style, text, width;
      text = obj.text || '';
      width = obj.width || '120';
      style = obj.style || 'left';
      if (obj.id) {
        id = obj.id;
      } else {
        CONTWIDGET++;
        id = "win-tbtext-" + CONTWIDGET;
      }
      return document.getElementById(idParent).innerHTML += "<div id=\"" + id + "\" class=\"win-tbtext\" style=\"width:" + width + "; " + style + "\">" + text + "</div>";
    };

    /*
    	@method _separator
    	@param  obj objectDom parent
     */
    _separator = function(idParent) {
      return document.getElementById(idParent).innerHTML += "<div class=\"win-separator\">|</div>";
    };

    /*
    	@method _separatorHeight
    	@param  obj objectDom parent
     */
    _separatorHeight = function(idParent) {
      return document.getElementById(idParent).innerHTML += "<div class=\"win-separatorHeight\"></div>";
    };

    /*
    	@method _body
    	@param  obj objectDom parent and config
     */
    _body = function(obj, idParent) {
      var alto, arrayDiv, clsBody, cont, height, heightParent, html, id, items, parent, style;
      items = obj.items || '';
      html = obj.html || '';
      clsBody = obj.clsBody || '';
      style = 'overflow:auto;';
      if (obj.scroll === false) {
        style = 'overflow:hidden;';
      } else if (obj.scrollX === false) {
        style += 'overflow-x:hidden;';
      } else if (obj.scrollY === false) {
        style += 'overflow-y:hidden;';
      }
      if (obj.idApply) {
        id = obj.idApply;
      } else {
        CONTWIDGET++;
        id = "win-body-" + CONTWIDGET;
      }
      parent = document.getElementById(idParent);
      heightParent = parent.offsetHeight;
      parent.innerHTML += "<div id=\"" + id + "\" class=\"win-body " + clsBody + "\" style=\"" + style + "\">" + html + "</div>";
      alto = 0;
      cont = 0;
      arrayDiv = document.querySelectorAll('#' + idParent + ' > div');
      [].forEach.call(arrayDiv, function(element) {
        if (cont === 1) {
          return;
        } else if (element.id === id) {
          cont++;
          return;
        }
        return alto += element.offsetHeight;
      });
      height = alto === 0 ? '100%' : 'calc(100% - ' + alto + 'px)';
      if (typeof obj.autoLoad) {
        return setTimeout(function() {
          document.getElementById(id).style.height = height;
          obj.autoLoad.idApply = id;
          return $W.Load(obj.autoLoad);
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
