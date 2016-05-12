/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */
(function() {
  var hasProp = {}.hasOwnProperty;

  (function($W) {
    var GRILLA, _createAside, _createCol, _createContent, _createPagination, _createRows, _createTbar, _createTitle, _createToolbar, _insertUpdateRow, _jsonParams;
    $W.Grilla = {};
    GRILLA = {};
    $W.Grilla.ini = function(obj, varPost) {
      var advancedToolbar, eventInsert, eventUpdate, fAlto, fAncho, fPermisoInsert, fTitle, filterAside, grillaHeight, htmlAside, htmlContent, htmlGrilla, htmlToolbar, idApply, maxPage, name, opcionClass, pagina, parentHtml, rows, style, tbar, tbarHeight, textBtnNuevo, titleItems, toolbar, url, valueToolbar, widthGrilla;
      if (obj === null) {
        return;
      }
      name = obj.name || '';
      style = '';
      url = obj.url || '';
      idApply = obj.idApply || '';
      opcionClass = obj.opcionClass || '';
      rows = obj.rows || {};
      titleItems = obj.titleItems || {};
      widthGrilla = '100%';
      parentHtml = idApply;
      tbar = obj.tbar || '';
      tbarHeight = obj.tbarHeight || '';
      toolbar = obj.toolbar || false;
      valueToolbar = obj.valueToolbar || '';
      advancedToolbar = obj.advancedToolbar || 'disable';
      filterAside = obj.filterAside || '';
      pagina = obj.pagina || '';
      maxPage = obj.maxPage || '';
      varPost = varPost || {};
      textBtnNuevo = obj.textBtnNuevo || 'Nuevo';
      fPermisoInsert = obj.fPermisoInsert || false;
      fTitle = obj.fTitle || '';
      fAncho = obj.fAncho || 'auto';
      fAlto = obj.fAlto || 'auto';
      eventInsert = obj.eventInsert || '';
      eventUpdate = obj.eventUpdate || '';
      grillaHeight = "";
      GRILLA[name] = {
        url: url,
        varPost: varPost
      };
      if (tbar === true && opcionClass === '') {
        _createTbar(name, idApply, fAncho, fAlto, fTitle, textBtnNuevo, fPermisoInsert, eventInsert);
        tbarHeight = document.getElementById("grilla_tbar_" + name).offsetHeight;
        grillaHeight = "height:calc(100% - " + tbarHeight + "px)";
      } else {
        grillaHeight = 'height:100%';
      }
      if (toolbar !== false) {
        style = 'style="height:calc(100% - 28px);"';
        htmlToolbar = _createToolbar(name, advancedToolbar);
      }
      htmlAside = _createAside(name, filterAside);
      htmlContent = _createContent(name, opcionClass, pagina, maxPage, style, titleItems, rows, eventUpdate, fAncho, fAlto, fTitle);
      if (htmlAside !== "") {
        widthGrilla = "calc(100% - 205px)";
      }
      if (opcionClass === '') {
        htmlGrilla = "<div id=\"grilla_ventana_" + name + "\" class=\"grilla_ventana\" style=\"" + grillaHeight + ";\" data-role=\"win-body\"> <div id=\"grilla_" + name + "\" class=\"grilla_load\" style=\"width:" + widthGrilla + ";\"> " + htmlToolbar + " " + htmlContent + " </div> </div>";
      } else {
        parentHtml = "grilla_" + name;
        htmlGrilla = "" + htmlToolbar + htmlContent;
      }
      document.getElementById(parentHtml).innerHTML += htmlGrilla;
      $W("\#grilla_toolbar_reload_" + name).on("click", function() {
        return $W.Grilla.buscar(name);
      });
      $W("\#grilla_content_page_" + name + " .grilla_page").on("click", function() {
        return $W.Grilla.pagination(this, name, valueToolbar, pagina, maxPage);
      });
      if (opcionClass === "filterField") {
        document.getElementById("field_buscar_" + name).value = valueToolbar;
        return document.getElementById("field_buscar_" + name).focus();
      }
    };
    $W.Grilla.fOpen = function(name, id, width, height, title, autoScroll) {
      var opcionClass, params, state, url;
      url = GRILLA[name]["url"];
      if (id > 0) {
        state = document.getElementById("grilla_fila_" + name + "_" + id).getAttribute('data-state');
        if (state === 'fDelete') {
          return;
        }
      }
      opcionClass = id > 0 ? 'vUpdate' : 'vInsert';
      params = GRILLA[name]["varPost"];
      params.indexClass = id;
      params.opcionClass = opcionClass;
      return eval("window.Win_grilla_form_" + name + " = $W.Window({ id       : \"Win_grilla_form_" + name + "\", width    : width, height   : height, title    : title, modal    : true, closable : true, drag     : true, resize   : true, scroll   : false, autoLoad : { url    : url, params : params } })");
    };
    $W.Grilla.inputBuscar = function(e, name) {
      var tecla;
      tecla = document.all ? e.keyCode : e.which;
      if (tecla === 13) {
        $W.Grilla.buscar(name);
      }
      return true;
    };
    _jsonParams = function(name) {
      var arrayOrder, divOrder, field, params, state;
      params = GRILLA[name]["varPost"];
      params.activeOrder = "";
      params.valueToolbar = "";
      params.advancedToolbar = "disable";
      if (document.getElementById("field_buscar_" + name)) {
        params.valueToolbar = document.getElementById("field_buscar_" + name).value;
        params.advancedToolbar = document.getElementById("grilla_type_search_" + name).getAttribute("data-search");
      }
      arrayOrder = document.querySelectorAll("#grilla_title_" + name + " [data-order=upOn], #grilla_title_" + name + " [data-order=downOn]");
      if (arrayOrder[0]) {
        divOrder = arrayOrder[0];
        field = divOrder.getAttribute("data-field");
        state = divOrder.getAttribute("data-order");
        params.activeOrder = JSON.stringify({
          field: field,
          state: state
        });
      }
      return params;
    };
    $W.Grilla.eventAside = function(title, name) {
      var aside, grilla, state;
      state = title.getAttribute('data-state');
      grilla = document.getElementById("grilla_" + name);
      aside = document.getElementById("grilla_aside_" + name);
      if (state === 'open') {
        aside.style.width = '16px';
        grilla.style.width = 'calc(100% - 21px)';
        return title.setAttribute('data-state', 'close');
      } else {
        aside.style.width = '200px';
        grilla.style.width = 'calc(100% - 205px)';
        return title.setAttribute('data-state', 'open');
      }
    };
    $W.Grilla.buscar = function(name) {
      var params, url;
      url = GRILLA[name]["url"];
      params = _jsonParams(name);
      params.opcionClass = "filterField";
      return $W.Load({
        idApply: "grilla_" + name,
        url: url,
        params: params
      });
    };
    $W.Grilla.pagination = function(elementDom, name, valueToolbar, pag_actual, page_max) {
      var action, pagina, params, parentDom, url;
      url = GRILLA[name]["url"];
      pagina = 0;
      page_max = page_max * 1;
      pag_actual = pag_actual * 1;
      action = elementDom.getAttribute("data-type");
      parentDom = document.getElementById("grilla_content_" + name).parentNode;
      if (action === 'next' && pag_actual === page_max) {
        return;
      } else if (action === 'prev' && pag_actual === 1) {
        return;
      } else if (action === 'last' && pag_actual === page_max) {
        return;
      } else if (action === 'first' && pag_actual === 1) {
        return;
      } else if (action === 'next') {
        pagina = pag_actual + 1;
      } else if (action === 'prev') {
        pagina = pag_actual - 1;
      } else if (action === 'last') {
        pagina = page_max;
      } else if (action === 'first') {
        pagina = 1;
      }
      params = GRILLA[name]["varPost"];
      params.pagina = pagina;
      params.opcionClass = 'paginacion';
      params.valueToolbar = valueToolbar;
      return $W.Load({
        idApply: parentDom.id,
        url: url,
        params: params
      });
    };
    $W.Grilla.updateRow = function(name, id) {
      var cont, opcionClass, params, url;
      url = GRILLA[name]["url"];
      opcionClass = 'updateRow';
      params = GRILLA[name]["varPost"];
      params.indexClass = id;
      params.opcionClass = opcionClass;
      if (!document.getElementById("grilla_fila_cont_" + name + "_" + id)) {
        return;
      }
      cont = document.getElementById("grilla_fila_cont_" + name + "_" + id).innerHTML;
      return $W.Ajax({
        url: url,
        params: params,
        success: function(result, xhr) {
          var json;
          if (!$W.Script.isJSON(result.responseText)) {
            console.log(result.responseText);
            return;
          }
          json = JSON.parse(result.responseText);
          document.getElementById("grilla_content_fila_" + name + "_" + id).innerHTML = _createRows(name, opcionClass, json.rows, json.eventUpdate, json.fAncho, json.fAlto, json.fTitle);
          document.getElementById("grilla_fila_cont_" + name + "_" + id).innerHTML = cont;
          return document.getElementById("grilla_fila_image_" + name + "_" + id).setAttribute('data-icon', 'fUpdate');
        },
        failure: function(xhr) {
          return console.log("fail");
        }
      });
    };
    _insertUpdateRow = function(name, url, xhrResponse, opcionClass) {
      var body, contDiv, eventUpdate, fAlto, fAncho, fTitle, json, rows, type;
      if (!$W.Script.isJSON(xhrResponse.responseText)) {
        console.log(xhrResponse.responseText);
        return;
      }
      json = JSON.parse(xhrResponse.responseText);
      if (json.estado === 'true') {
        type = json.type || '';
        if (type === 'form') {
          eval(json.name + ".close();");
          return;
        }
        rows = json.rows || {};
        fTitle = json.fTitle || '';
        fAncho = json.fAncho || '';
        fAlto = json.fAlto || '';
        eventUpdate = json.eventUpdate || '';
        if (opcionClass === 'fInsert' || opcionClass === 'insertRow') {
          body = document.getElementById("grilla_body_" + name);
          if (body.lastChild) {
            contDiv = body.lastChild.getAttribute("data-cont");
            contDiv++;
          }
          body.innerHTML += _createRows(name, opcionClass, rows, eventUpdate, fAncho, fAlto, fTitle);
          if (contDiv > 0) {
            document.getElementById(("grilla_fila_cont_" + name + "_") + json.idRow).innerHTML = contDiv;
            document.getElementById(("grilla_content_fila_" + name + "_") + json.idRow).setAttribute("data-cont", contDiv);
          }
        } else if (opcionClass === "fUpdate") {
          contDiv = document.getElementById(("grilla_fila_cont_" + name + "_") + json.idRow).innerHTML;
          document.getElementById(("grilla_content_fila_" + name + "_") + json.idRow).innerHTML = _createRows(name, opcionClass, rows, eventUpdate, fAncho, fAlto, fTitle);
          document.getElementById(("grilla_fila_cont_" + name + "_") + json.idRow).innerHTML = contDiv;
        }
        if (opcionClass === 'fInsert' || opcionClass === 'fUpdate') {
          return eval("Win_grilla_form_" + name + ".close();");
        }
      } else {
        return alert(json.msj);
      }
    };
    $W.Grilla.insertRow = function(name, id) {
      var opcionClass, params, url;
      url = GRILLA[name]["url"];
      opcionClass = 'insertRow';
      params = GRILLA[name]["varPost"];
      params.indexClass = id;
      params.opcionClass = opcionClass;
      return $W.Ajax({
        url: url,
        params: params,
        success: function(xhrResponse, xhr) {
          return _insertUpdateRow(name, url, xhrResponse, opcionClass);
        },
        failure: function(xhr) {
          return console.log("fail");
        }
      });
    };
    $W.Form.fSave = function(name, url, indexClass, varPost) {
      var arrayInput, contRequired, i, j, jsonForm, len, msjRequired, objForm, opcionClass, params;
      objForm = {};
      arrayInput = [];
      msjRequired = '';
      contRequired = 0;
      opcionClass = indexClass > 0 ? 'fUpdate' : 'fInsert';
      arrayInput[0] = document.querySelectorAll("#form_" + name + " input");
      arrayInput[1] = document.querySelectorAll("#form_" + name + " select");
      arrayInput[2] = document.querySelectorAll("#form_" + name + " textarea");
      for (j = 0, len = arrayInput.length; j < len; j++) {
        i = arrayInput[j];
        [].forEach.call(i, function(objDom) {
          var data, field, id, label, required, value;
          id = objDom.id;
          value = objDom.value;
          label = objDom.getAttribute('data-label');
          required = objDom.getAttribute('data-required');
          if (value === '' && required === 'true') {
            contRequired++;
            msjRequired += '\n* ' + label;
          }
          field = id.replace("form_" + name + "_", '');
          objForm[field] = value;
          if (objDom.tagName === "select" || objDom.tagName === "SELECT") {
            data = objDom.getAttribute("data-textdb");
            if (data !== "") {
              return objForm[data] = objDom.options[objDom.selectedIndex].text;
            }
          }
        });
      }
      jsonForm = JSON.stringify(objForm);
      if (contRequired === 1) {
        alert('El siguiente campo es obligatorio' + msjRequired);
        return;
      } else if (contRequired > 1) {
        alert('Los siguientes campos son obligatorios' + msjRequired);
        return;
      }
      params = varPost;
      params.indexClass = indexClass;
      params.opcionClass = opcionClass;
      params.jsonFormValue = jsonForm;
      return $W.Ajax({
        url: url,
        params: params,
        success: function(xhrResponse, xhr) {
          return _insertUpdateRow(name, url, xhrResponse, opcionClass);
        },
        failure: function(xhr) {
          return console.log("fail");
        }
      });
    };
    $W.Form.fDelete = function(name, url, indexClass, varPost) {
      var params;
      params = varPost;
      params.indexClass = indexClass;
      params.opcionClass = 'fDelete';
      return $W.Ajax({
        url: url,
        params: params,
        success: function(result, xhr) {
          var arrayDivHtml, json;
          if (!$W.Script.isJSON(result.responseText)) {
            console.log(result.responseText);
            return;
          }
          json = JSON.parse(result.responseText);
          if (json.estado === 'true') {
            document.getElementById("grilla_fila_" + name + "_" + indexClass).setAttribute('data-state', 'fDelete');
            document.getElementById("grilla_fila_image_" + name + "_" + indexClass).setAttribute('data-icon', 'fDelete');
            arrayDivHtml = document.querySelectorAll("#grilla_fila_" + name + "_" + indexClass + " [data-type=html]");
            [].forEach.call(arrayDivHtml, function(input) {
              return input.innerHTML = '';
            });
            return eval("Win_grilla_form_" + name + ".close();");
          } else {
            return console.log("false");
          }
        },
        failure: function(xhr) {
          return console.log("fail");
        }
      });
    };
    $W.Grilla.typeSearch = function(input) {
      var type;
      type = input.getAttribute("data-search");
      if (type === "disable") {
        if (!confirm("Desea habilitar la busqueda avanzada?")) {
          return;
        }
        return input.setAttribute("data-search", "enable");
      } else {
        return input.setAttribute("data-search", "disable");
      }
    };
    _createAside = function(name, filterAside) {
      var html, key, value;
      html = "";
      for (key in filterAside) {
        if (!hasProp.call(filterAside, key)) continue;
        value = filterAside[key];
        html += "<div class=\"grilla-aside-title\">" + value.title + "</div>";
      }
      if (html !== "") {
        html = "<aside id=\"grilla_aside_" + name + "\" style=\"width:200px;\"> <div class=\"grilla-aside-head\" data-state=\"open\" onclick=\"$W.Grilla.eventAside(this, '" + name + "')\">TITLE OR ICON</div> " + html + " </aside>";
      }
      return html;
    };
    _createToolbar = function(name, advancedToolbar) {
      return "<div id=\"grilla_toolbar_" + name + "\" class=\"grilla_toolbar\"> <div> <div class=\"grilla_toolbar_input\"> <input type=\"text\" id=\"field_buscar_" + name + "\" onKeyUp=\"$W.Grilla.inputBuscar(event,\'" + name + "\')\"/> </div> <div data-search=\"" + advancedToolbar + "\" title=\"Busquedas avanzada\" id=\"grilla_type_search_" + name + "\" class=\"grilla_type_search\" onclick=\"$W.Grilla.typeSearch(this)\"></div> <div id=\"grilla_toolbar_reload_" + name + "\" class=\"grilla_toolbar_reload\"></div> </div> </div>";
    };
    _createContent = function(name, opcionClass, pagina, maxPage, style, titleItems, rows, eventUpdate, fAncho, fAlto, fTitle) {
      var htmlItems, htmlPage, objTitle;
      htmlItems = _createRows(name, opcionClass, rows, eventUpdate, fAncho, fAlto, fTitle);
      htmlPage = _createPagination(name, pagina, maxPage);
      objTitle = _createTitle(name, titleItems);
      return "<div id=\"grilla_content_" + name + "\" class=\"grilla_content\" " + style + "> <div id=\"grilla_title_" + name + "\" class=\"grilla_title\" style=\"min-width:" + objTitle.width + "px;\">" + objTitle.html + "</div> <div id=\"grilla_body_" + name + "\" class=\"grilla_body\" style=\"min-width:" + objTitle.width + "px;\">" + htmlItems + "</div> <div class=\"grilla_footer\" style=\"min-width:" + objTitle.width + "px;\">" + htmlPage + "</div> </div>";
    };
    _createTitle = function(name, titleItems) {
      var dataDown, dataUp, html, htmlOrder, item, key, width;
      width = 75;
      html = "<div class=\"grilla_title_label\">No.</div>";
      for (key in titleItems) {
        if (!hasProp.call(titleItems, key)) continue;
        item = titleItems[key];
        htmlOrder = "";
        if (item.order === "true") {
          dataUp = "upOff";
          dataDown = "downOff";
          if (item.state === "upOn") {
            dataUp = "upOn";
          } else if (item.state === "downOn") {
            dataDown = "downOn";
          }
          htmlOrder = "<div class=\"grilla_title_order\"> <div data-order=\"" + dataUp + "\" data-field=\"" + item.field + "\" onclick=\"$W.Grilla.orderUser('" + name + "',this)\"></div> <div data-order=\"" + dataDown + "\" data-field=\"" + item.field + "\" onclick=\"$W.Grilla.orderUser('" + name + "',this)\"></div> </div>";
        }
        width += item.width;
        html += "<div class=\"grilla_title_label\" style=\"width:" + item.width + "px;\"> <div style=\"float:left; width:100%; height:100%;\">" + item.title + "</div> " + htmlOrder + " </div>";
      }
      return {
        html: html,
        width: width
      };
    };
    $W.Grilla.orderUser = function(name, divOrder) {
      var order;
      order = divOrder.getAttribute("data-order");
      $W(".grilla_title_order [data-order=upOn]").attr("data-order", "upOff");
      $W(".grilla_title_order [data-order=downOn]").attr("data-order", "downOff");
      switch (order) {
        case 'upOff':
          divOrder.setAttribute("data-order", "upOn");
          break;
        case 'downOff':
          divOrder.setAttribute("data-order", "downOn");
          break;
        case 'upOn':
          divOrder.setAttribute("data-order", "upOff");
          break;
        case 'downOn':
          divOrder.setAttribute("data-order", "downOff");
      }
      return $W.Grilla.buscar(name);
    };
    _createRows = function(name, opcionClass, rows, eventUpdate, fAncho, fAlto, fTitle) {
      var contRow, eventDbclick, html, htmlCol, index, row, rowHtml, url;
      url = GRILLA[name]["url"];
      html = "";
      contRow = 0;
      for (index in rows) {
        if (!hasProp.call(rows, index)) continue;
        row = rows[index];
        contRow++;
        htmlCol = _createCol(name, row.idRow, row.cols);
        eventDbclick = "";
        if (eventUpdate === true) {
          eventDbclick = "$W.Grilla.fOpen('" + name + "', '" + row.idRow + "', '" + fAncho + "', '" + fAlto + "', '" + fTitle + "',true)";
        } else if (eventUpdate === '') {
          eventDbclick = '';
        } else {
          eventDbclick = eventUpdate + "(" + row.idRow + ", this, this.id)";
        }
        rowHtml = "<div id=\"grilla_fila_" + name + "_" + row.idRow + "\" class=\"grilla_fila\" ondblclick=\"" + eventDbclick + "\" data-state=\"" + opcionClass + "\" data-index=\"" + row.idRow + "\"> <div id=\"MuestraToltip_" + name + "_" + row.idRow + "\" class=\"grilla_col_first\"> <div id=\"grilla_fila_cont_" + name + "_" + row.idRow + "\" class=\"grilla_fila_cont\">" + contRow + "</div> <div id=\"grilla_fila_image_" + name + "_" + row.idRow + "\" class=\"grilla_fila_image\" data-icon=\"" + opcionClass + "\"></div> </div> " + htmlCol + " </div>";
        if (opcionClass !== 'fUpdate' && opcionClass !== 'updateRow') {
          html += "<div id=\"grilla_content_fila_" + name + "_" + row.idRow + "\" class=\"grilla_content_fila\" data-index=\"" + row.idRow + "\" data-cont=\"" + contRow + "\" style=\"float:left; width:100%;\">" + rowHtml + "</div>";
        } else {
          html += rowHtml;
        }
      }
      return html;
    };
    _createCol = function(name, idRow, cols) {
      var html, idCol, obj;
      html = "";
      for (idCol in cols) {
        if (!hasProp.call(cols, idCol)) continue;
        obj = cols[idCol];
        html += "<div id=\"div_" + name + "_" + idCol + "_" + idRow + "\" class=\"grilla_celdas\" style=\"width:" + obj.width + "px; " + obj.style + "\" data-type=\"" + obj.type + "\">" + obj.html + "</div>";
      }
      return html;
    };
    _createTbar = function(name, idApply, fAncho, fAlto, fTitle, textBtnNuevo, fPermisoInsert, eventInsert) {
      var url;
      url = GRILLA[name]["url"];
      document.getElementById(idApply).innerHTML += "<div id=\"grilla_tbar_" + name + "\"></div>";
      if (fPermisoInsert === true || fPermisoInsert === "true") {
        return $W.Tbar({
          idApply: "grilla_tbar_" + name,
          items: [
            {
              xtype: "button",
              id: "btn_" + name + "_new",
              cls: "grilla_add",
              text: textBtnNuevo,
              handler: function() {
                if (eventInsert === true) {
                  return $W.Grilla.fOpen(name, "", fAncho, fAlto, fTitle, true);
                } else if (eventInsert !== "") {
                  return eval(eventInsert + "()");
                }
              }
            }
          ]
        });
      }
    };
    return _createPagination = function(name, page, maxPage) {
      var html;
      html = "";
      if (maxPage > 1) {
        html = "<div id=\"grilla_content_page_" + name + "\" class=\"grilla_content_page\"> <div>Pagina " + page + " de " + maxPage + "</div> <div data-type=\"first\" class=\"grilla_page\"></div> <div data-type=\"prev\" class=\"grilla_page\"></div> <div data-type=\"next\" class=\"grilla_page\"></div> <div data-type=\"last\" class=\"grilla_page\"></div> </div>";
      }
      return html;
    };
  })(Win);

}).call(this);
