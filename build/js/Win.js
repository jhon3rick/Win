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
"use strict";
var Win;

Win = (function() {
  return {

    /*
    	 * Widges ventana
     */
    Window: function(obj) {
      var autoDestroy, autoLoad, autoScroll, bgBody, bgTitle, body, bodyColor, bodyStyle, closable, drag, height, id, left, modal, resize, theme, title, titleStyle, top, width, win, winModal;
      width = obj.width || 300;
      height = obj.height || 300;
      id = obj.id || '';
      title = obj.title || '';
      titleStyle = obj.titleStyle || '';
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
      body = document.querySelector('body');
      winModal = document.createElement('div');
      win = this;
      bgBody = obj.bgBody ? 'background-color:' + obj.bgBody + ';' : '';
      bgTitle = obj.bgTitle ? 'background-color:' + obj.bgTitle + ';' : '';
      winModal.setAttribute("id", "win_modal_" + id);
      winModal.setAttribute("class", "win-modal");
      left = body.offsetWidth < width ? 0 : (body.offsetWidth - width) / 2;
      top = body.offsetHeight < height ? 0 : (body.offsetHeight - height) / 2;
      winModal.innerHTML = "<div style=\"width:" + width + "; height:" + height + "; top:" + top + "; left:" + left + "; " + bgBody + " " + bodyStyle + "\" id=\"" + id + "\" class=\"win-marco\">\n	<div class=\"win-title\" id=\"win_title_" + id + "\" style=\"" + bgTitle + " " + titleStyle + "\">\n		<div class=\"win-title-txt\">" + title + "</div>\n		<div class=\"win-title-btn\" id=\"btn_close_ventana_" + id + "\" onclick=\"document.querySelector('body').removeChild(document.querySelector('#win_modal_" + id + "'));\"></div>\n	</div>\n	<div class=\"win-div-resize\" id=\"win_div_resize_" + id + "\"></div>\n	<div class=\"win-tbar\" id=\"win_tbar_" + id + "\"></div>\n	<div class=\"win-window-body\" id=\"win_window_" + id + "\">Contenido</div>\n</div>\n<script onload>alert(1);</script>";
      body.appendChild(winModal);
      obj.tbar.id = id;
      Win.tbar(obj.tbar);
      return Win.Ajax.load(document.querySelector('#win_window_' + id), obj.autoLoad);
    },
    tbar: function(obj) {
      var align, objDiv;
      if (typeof obj === 'object') {
        align = '';
        objDiv = document.getElementById('win_tbar_' + obj.id);
        return obj.forEach(function(json, index, element) {
          if (json.xtype === 'button') {
            return Win.button({
              tbar: objDiv,
              align: align,
              json: json
            });
          } else if (json.xtype === 'buttongroup') {
            json.tbar = objDiv;
            return Win.buttongroup(json);
          } else if (json.xtype === 'tbtext') {
            return Win.tbtext({
              tbar: objDiv,
              align: align,
              json: json
            });
          } else if (json === '-') {
            return Win.separator({
              tbar: objDiv,
              align: align
            });
          } else if (json === '->') {
            return align = 'right';
          }
        });
      }
    },
    buttongroup: function(obj) {},
    button: function(obj) {
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
    },
    tbtext: function(obj) {
      var clsAling, text;
      text = document.createElement('div');
      clsAling = obj.align === 'right' ? 'widge-right' : '';
      text.setAttribute("id", "win_tbtext_" + obj.json.id);
      text.setAttribute("class", "win-tbtext " + clsAling);
      text.innerHTML = "<div>" + obj.json.text + "</div>";
      return obj.tbar.appendChild(text);
    },
    separator: function(obj) {
      var clsAling, div;
      div = document.createElement('div');
      clsAling = obj.align === 'right' ? 'widge-right' : '';
      div.setAttribute("class", "win-separator " + clsAling);
      div.innerHTML = "<div>|</div>";
      return obj.tbar.appendChild(div);
    },

    /*
    	 * Get Elements
     */
    getButton: function(id) {
      this.hiden = function(id) {
        return document.getElementById('id').style.display = 'none';
      };
      this.show = function(id) {
        return document.getElementById('id').style.display = 'block';
      };
      return id;
    },
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
