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
    var _button, _draggMove, _draggStart, _draggStop, _panel, _resize, _router, _separator, _separatorHeight, _tabpanel, _tbar, _tbtext;
    $W.Window = function(obj) {
      var autoDestroy, autoLoad, autoScroll, bgBody, bgTitle, body, bodyColor, bodyStyle, clsBody, divClose, drag, elementsNav, height, html, id, left, modal, theme, title, titleStyle, top, width, win, winModal;
      elementsNav = '';
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
      winModal = document.createElement('div');
      win = this;
      clsBody = typeof obj.type !== 'undefined' && obj.type !== '' ? 'alert' : '';
      bgBody = obj.bgBody ? 'background-color:' + obj.bgBody + ';' : '';
      bgTitle = obj.bgTitle ? 'background-color:' + obj.bgTitle + ';' : '';
      divClose = obj.closable !== false ? "<div class=\"win-title-btn\" id=\"btn_close_ventana_" + id + "\" onclick=\"" + id + ".close()\"></div>" : "";
      winModal.setAttribute("id", "win-modal-" + id);
      winModal.setAttribute("class", "win-modal");
      left = body.offsetWidth < width ? 0 : (body.offsetWidth - width) / 2;
      top = body.offsetHeight < height ? 0 : (body.offsetHeight - height) / 2;
      if (typeof obj.items !== 'undefined') {
        elementsNav = _router(obj.items);
      }
      winModal.innerHTML = "<div style=\"width:" + width + "; height:" + height + "; top:" + top + "; left:" + left + "; " + bgBody + " " + bodyStyle + "\" id=\"" + id + "\" class=\"win-marco\"> <div class=\"win-file-resize\" data-resize=\"top\" id=\"win-resize-top-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"bottom\" id=\"win-resize-bottom-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"left\" id=\"win-resize-left-" + id + "\"></div> <div class=\"win-file-resize\" data-resize=\"right\" id=\"win-resize-right-" + id + "\"></div> <div class=\"win-modal-parent\" id=\"win-modal-window_" + id + "\"> <div class=\"win-modal-content\"> <div class=\"win-loader-default\" id=\"win-loader-" + id + "\"></div> <div class=\"win-modal-label\" id=\"label-load-" + id + "\"></div> </div> </div> <header> <div class=\"win-title\" id=\"win-title-" + id + "\" style=\"" + bgTitle + " " + titleStyle + "\"> <div class=\"win-title-txt\">" + title + "</div> " + divClose + " </div> </header> <nav>" + elementsNav + "</nav> <div class=\"win-window-body " + clsBody + "\" id=\"win_window_" + id + "\">" + html + "</div> </div>";
      body.appendChild(winModal);
      $W("#win-title-" + id)[0].onmousedown = function() {
        return _draggStart(id, winModal, event);
      };
      $W("#win-title-" + id)[0].onmouseup = function() {
        return _draggStop(winModal);
      };
      if (obj.resize !== false) {
        _resize($W("#win-resize-top-" + id)[0]);
        _resize($W("#win-resize-bottom-" + id)[0]);
        _resize($W("#win-resize-left-" + id)[0]);
        _resize($W("#win-resize-right-" + id)[0]);
      }
      if (typeof obj.autoLoad !== 'undefined') {
        $W.Ajax.load($W("#win_window_" + id)[0], obj.autoLoad);
      }
      return {
        close: function() {
          return $W("\#win-modal-" + id)[0].parentNode.removeChild($W("\#win-modal-" + id)[0]);
        }
      };
    };
    $W.aside = function(obj) {};
    $W.tabpanel = function(obj) {
      var html;
      console.log(obj);
      html = "<div id=\"" + obj.id + "\">";
      obj.items.forEach(json, index, element)(function() {
        return html += "<div id=\"" + json.id + "\">" + json.title + "</div>";
      });
      return html += "</div>";
    };
    $W.tbar = function(obj) {
      return document.getElementById("\#" + obj.applyTo).innerHTML = ("<div class=\"win-tbar\" id=\"win-tbar-" + id + "\">") + _router(obj.items, tbar) + "</div>";
    };
    $W.getButton = function(id) {
      this.hiden = function(id) {
        return $W('#id').style('display', 'none');
      };
      this.show = function(id) {
        return $W('#id').style('display', 'block');
      };
      this.enable = function(id) {
        return $W('#id').style('display', 'none');
      };
      this.disable = function(id) {
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
      if (!$W("#win_window_" + obj.id_ventana)[0]) {
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
    	_draggMove
    	@param obj object DOM move
    	@param int position x
    	@param int position y
     */
    _draggMove = function(objDom, xpos, ypos) {
      objDom.style.left = xpos + 'px';
      return objDom.style.top = ypos + 'px';
    };

    /*
    	_draggMove
    	@param obj object parent DOM move
     */
    _draggStop = function(objDom) {
      objDom.style.cursor = 'default';
      return document.onmousemove = function(e) {
        return e.preventDefault;
      };
    };

    /*
    	_resize
    	@param obj object DOM resize
     */
    _resize = function(objDom) {
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
        console.log(positionX + (e.clientX - startX));
        objParent.style.left = (positionX + e.clientX - startX) + 'px';
        return objParent.style.width = (startWidth - e.clientX + startX) + 'px';
      };
      _resizeYTop = function(e) {
        console.log(attrData);
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

    /*
    	@method _router
    	@param  arr child
    	@param  obj ObjetoDom parent
     */
    _router = function(obj, parent) {
      var align, html;
      html = "";
      if (typeof obj === 'object') {
        align = 'left';
        obj.forEach(function(json, index, element) {
          console.log(json.xtype);
          if (json.xtype === 'button') {
            return html += _button(json);
          } else if (json.xtype === 'buttongroup') {
            return html += $W.buttongroup(json);
          } else if (json.xtype === 'tbar') {
            return html += _tbar(json);
          } else if (json.xtype === 'panel') {
            return html += _panel(json);
          } else if (json.xtype === 'tabpanel') {
            return html += $W.tabpanel(json);
          } else if (json.xtype === 'tbtext') {
            json.align = align;
            return html += _tbtext(json);
          } else if (json === '-') {
            return html += _separator();
          } else if (json === '--') {
            return html += _separatorHeight();
          } else if (json === '->') {
            align = 'right';
            return html += "<div></div>";
          }
        });
        if (align === '') {
          html += '<div></div>';
        }
      }
      return html;
    };

    /*
    		@method _separator
    		@param  obj objectDom parent
     */
    _separator = function() {
      var html;
      return html = "<div class=\"win-separator\">|</div>";
    };

    /*
    		@method _separatorHeight
    		@param  obj objectDom parent
     */
    _separatorHeight = function() {
      var html;
      return html = "<div class=\"win-separatorHeight\"></div>";
    };
    $W.buttongroup = function(obj) {};

    /*
    		@method _button
    		@param  obj objectDom parent and config
     */
    _button = function(obj) {
      var click, cls, html, id, text, width;
      text = obj.text || '';
      id = obj.id || '';
      cls = obj.cls || '';
      width = obj.width || 50;
      click = obj.handler || '';
      return html = "<div id=\"" + id + "\" class=\"win-btn\" style=\"width: " + width + "px;\" onclick=\"" + click + "\"> <button class=\"" + cls + "\">" + text + "</button> </div>";
    };

    /*
    		@method _panel
    		@param  obj objectDom parent and config
     */
    _panel = function(obj) {
      var bodyStyle, height, html, id, width;
      id = obj.id || '';
      width = obj.width || 'auto';
      height = obj.height || 'auto';
      html = obj.html || '';
      bodyStyle = obj.bodyStyle || '';
      console.log(html);
      return html = "<div id=\"" + id + "\" class=\"win-panel\" style=\"width:" + width + "; height:" + height + "; " + bodyStyle + "\" onload=\"alert(3)\">" + html + "</div>";
    };

    /*
    		@method _tabpanel
    		@param  obj objectDom parent and config
     */
    _tabpanel = function(obj) {};

    /*
    		@method _tbtext
    		@param  obj objectDom parent and config
     */
    _tbtext = function(obj) {
      var align, html, id, text;
      id = obj.id || '';
      text = obj.text || '';
      align = obj.align || 'left';
      return html = "<div id=\"win-tbtext-" + id + "\" class=\"win-tbtext\" style=\"text-align:" + align + ";\">" + text + "</div>";
    };

    /*
    		@method _tbar
    		@param  obj objectDom parent and config
     */
    return _tbar = function(obj) {
      var id, items, tbar;
      id = obj.id || '';
      items = obj.items || '';
      tbar = $W("#win-tbar-" + obj.applyTo)[0];
      return ("<div class=\"win-tbar\" id=\"win-tbar-" + id + "\">") + _router(obj.items, tbar) + "</div>";
    };
  })(Win);

}).call(this);
