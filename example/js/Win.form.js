/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */
(function() {
  "use strict";
  var hasProp = {}.hasOwnProperty;

  (function($W) {
    var _createBtnTbar, _createComboBox, _createOptionCombo, _createSeparador, _createTextArea, _createTextField, _keyEnable, _routerForm, _validateDate, _validateDouble, _validateEmail, _validateInteger, _validateLowerCase, _validatePercent, _validateText, _validateUpperCase;
    $W.Form = {};
    $W.Form.ini = function(obj, varPost) {
      var fPermisoDelete, fPermisoInsert, fPermisoUpdate, fTbar, field, htmlForm, idApply, indexClass, name, opcionClass, size, url;
      if (obj === null) {
        return;
      }
      indexClass = obj.indexClass || '';
      name = obj.name || '';
      url = obj.url || '';
      size = obj.size || {};
      field = obj.field || {};
      opcionClass = obj.opcionClass || '';
      idApply = "parent_form_" + name;
      fTbar = obj.fTbar || false;
      fPermisoInsert = obj.fPermisoInsert || false;
      fPermisoUpdate = obj.fPermisoUpdate || false;
      fPermisoDelete = obj.fPermisoDelete || false;
      varPost = varPost || {};
      if (opcionClass === 'vInsert' && fPermisoInsert !== true && fPermisoInsert !== "true") {
        return;
      }
      htmlForm = _routerForm(opcionClass, name, field, size);
      document.getElementById(idApply).innerHTML += "<div id=\"form_tbar_" + name + "\"></div> <form name=\"form_" + name + "\" id=\"form_" + name + "\" onsubmit=\"return false;\" data-role=\"win-body\" style=\"float:left; width:100%; height:100%; overflow:auto;\"> <div style=\"float:left; padding:10px; width:" + size.fBodyAncho + "px;\">" + htmlForm + "<div> </form>";
      if (fTbar === true) {
        _createBtnTbar(name, opcionClass, url, indexClass, fPermisoInsert, fPermisoUpdate, fPermisoDelete, varPost);
      }
      if (opcionClass === 'vUpdate' && fPermisoUpdate !== true && fPermisoUpdate !== "true") {
        $W("#form_" + name + " input, #form_" + name + " select, #form_" + name + " textarea").attr("disabled", "true");
      }
      return $W.Form.validate(idApply);
    };
    _createBtnTbar = function(name, opcionClass, url, indexClass, fPermisoInsert, fPermisoUpdate, fPermisoDelete, varPost) {
      var arrayBtn;
      arrayBtn = [];
      console.log(url);
      if (opcionClass === 'vInsert' && fPermisoInsert !== false && fPermisoInsert !== "false") {
        arrayBtn.push({
          xtype: "button",
          id: "fInsert_" + name,
          cls: "grilla_save",
          text: "Guardar",
          handler: function() {
            return $W.Form.fSave(name, url, indexClass, varPost);
          }
        });
      } else if (opcionClass === 'vUpdate' && fPermisoUpdate !== false && fPermisoUpdate !== "false") {
        arrayBtn.push({
          xtype: "button",
          id: "fUpdate_" + name,
          cls: "grilla_save",
          text: "Actualizar",
          handler: function() {
            return $W.Form.fSave(name, url, indexClass, varPost);
          }
        });
      }
      if (opcionClass === 'vUpdate' && fPermisoDelete !== false && fPermisoDelete !== "false") {
        arrayBtn.push({
          xtype: "button",
          id: "fDelete_" + name,
          cls: "grilla_delete",
          text: "Eliminar",
          handler: function() {
            return $W.Form.fDelete(name, url, indexClass, varPost);
          }
        });
      }
      return $W.Tbar({
        idApply: "form_tbar_" + name,
        items: arrayBtn
      });
    };
    _routerForm = function(opcionClass, name, obj, size) {
      var field, html, value;
      html = "";
      for (field in obj) {
        if (!hasProp.call(obj, field)) continue;
        value = obj[field];
        switch (value.type) {
          case 'TextField':
            html += _createTextField(name, field, value, size);
            break;
          case 'ComboBox':
            html += _createComboBox(name, field, value, size);
            break;
          case 'TextArea':
            html += _createTextArea(name, field, value, size);
            break;
          case 'Separador':
            html += _createSeparador(value);
        }
      }
      return html;
    };

    /*
    	 * METHOD STATIC
    	 * CREATE FIELD INPUT
     */
    _createTextField = function(name, field, obj, size) {
      var display, style, type, validate;
      type = 'text';
      display = 'table';
      validate = obj.validate || '';
      if (validate !== '') {
        validate = "data-validate=\"" + validate + "\"";
      }
      if (obj.hidden === true || obj.hidden === "true" || obj.hidden === "hidden") {
        type = 'hidden';
        display = 'none';
      }
      style = obj.required === true && obj.value === '' ? 'empy' : 'none';
      return "<div id=\"form_content_field_" + name + "_" + field + "\" class=\"form_content_field\" style=\"width:" + size.fDivAncho + "px; min-height:" + size.fDivAlto + "px; position:relative; display:" + display + "\"> <div id=\"form_label_" + name + "_" + field + "\" class=\"form_label\" style=\"width:" + size.fLabelAncho + "px; position:relative;\">" + obj.label + "</div> <div id=\"form_field_" + name + "_" + field + "\" class=\"form_field\" style=\"" + size.fFieldAncho + "px; position:relative;\"> <input type=\"" + type + "\" id=\"form_" + name + "_" + field + "\" value=\"" + obj.value + "\" style=\"width:" + obj.width + "px;\" data-value=\"" + obj.value + "\" data-required=\"" + obj.required + "\" data-style=\"" + style + "\" data-label=\"" + obj.label + "\" " + validate + "/> </div> </div>";
    };

    /*
    	 * METHOD STATIC
    	 * CREATE FIELD SELECT
     */
    _createComboBox = function(name, field, obj, size) {
      var htmlOption, option, style;
      style = obj.required === true && obj.value === '' ? 'empy' : 'none';
      option = obj.option || {};
      htmlOption = _createOptionCombo(obj.value, option);
      return "<div id=\"form_content_field_" + name + "_" + field + "\" class=\"form_content_field\" style=\"width:" + size.fDivAncho + "px; min-height:" + size.fDivAlto + "px;\"> <div id=\"form_label_" + name + "_" + field + "\" class=\"form_label\" style=\"width:" + size.fLabelAncho + "px;\">" + obj.label + "</div> <div id=\"form_field_" + name + "_" + field + "\" class=\"form_field\" style=\"" + size.fFieldAncho + "\"> <select id=\"form_" + name + "_" + field + "\" style=\"width:" + obj.width + "px;\" data-value=\"" + obj.value + "\" data-textdb=\"" + obj.textdb + "\" data-required=\"" + obj.required + "\" data-style=\"" + style + "\" data-label=\"" + obj.label + "\">" + htmlOption + "</select> </div> </div>";
    };
    _createOptionCombo = function(value, obj) {
      var html, key, option, selected;
      html = "<option value=\"\">Seleccione...</option>";
      for (key in obj) {
        if (!hasProp.call(obj, key)) continue;
        option = obj[key];
        selected = option.index === value ? "selected" : "";
        html += "<option value=\"" + option.index + "\" " + selected + ">" + option.value + "</option>";
      }
      return html;
    };

    /*
    	 * METHOD STATIC
    	 * CREATE FIELD TEXTAREA
     */
    _createTextArea = function(name, field, obj, size) {
      var style;
      style = obj.required === true && obj.value === '' ? 'empy' : 'none';
      return "<div id=\"form_content_field_" + name + "_" + field + "\" class=\"form_content_field\" style=\"width:" + size.fDivAncho + "px; min-height:" + size.fDivAlto + "px;\"> <div id=\"form_label_" + name + "_" + field + "\" class=\"form_label\" style=\"width:" + size.fLabelAncho + "px;\">" + obj.label + "</div> <div id=\"form_field_" + name + "_" + field + "\" class=\"form_field\" style=\"" + size.fFieldAncho + "\"> <textarea id=\"form_" + name + "_" + field + "\" style=\"width:" + obj.width + "px; height:" + obj.height + "px;\" data-required=\"" + obj.required + "\" data-style=\"" + style + "\" data-label=\"" + obj.label + "\">" + obj.value + "</textarea> </div> </div>";
    };

    /*
    	 * METHOD STATIC
    	 * CREATE SEPARATOR
     */
    _createSeparador = function(obj) {
      return "<div class=\"form_separador\"> <div style=\"width:80%; float:left\">" + obj.text + "</div> </div>";
    };
    $W.Form.field = function(obj) {
      switch (obj.type) {
        case 'integer':
          $W('#' + obj.idApply).addClass += " win-input-number";
          $W('#' + obj.idApply)[0].onkeypress = function(event) {
            return _validateInteger({
              event: event,
              eventType: 'keypress',
              input: this
            });
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateInteger({
              event: event,
              eventType: 'change',
              input: this
            });
          };
        case 'double':
          $W('#' + obj.idApply).addClass += " win-input-number";
          $W('#' + obj.idApply)[0].onkeypress = function(event) {
            return _validateDouble({
              event: event,
              eventType: 'keypress',
              input: this
            });
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateDouble({
              event: event,
              eventType: 'change',
              input: this
            });
          };
        case 'text':
          $W('#' + obj.idApply)[0].onkeyup = function(event) {
            return _validateText({
              event: event,
              eventType: 'keyup',
              input: this,
              option: obj.option
            });
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateText({
              event: event,
              eventType: 'change',
              input: this,
              option: obj.option
            });
          };
        case 'email':
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateEmail({
              event: event,
              input: this
            });
          };
        case 'date':
          return _validateDate(obj);
        case 'percent':
          $W('#' + obj.idApply)[0].onkeydown = function(event) {
            if (event.keyCode === 13) {
              return _validatePercent({
                event: event,
                eventType: 'keypress',
                input: this
              });
            }
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validatePercent({
              event: event,
              input: this
            });
          };
      }
    };

    /*
    	 * VALIDATE INPUT FORM
     */
    $W.Form.validate = function(id) {
      var campos;
      campos = document.getElementById(id).querySelectorAll("input, textarea, select");
      return [].forEach.call(campos, function(input) {
        var type;
        type = input.getAttribute('data-validate');
        switch (type) {
          case 'integer':
            input.className += " win-input-number";
            input.onkeypress = function(event) {
              return _validateInteger({
                event: event,
                eventType: 'keypress',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateInteger({
                event: event,
                eventType: 'change',
                input: this
              });
            };
          case 'double':
            input.className += " win-input-number";
            input.onkeypress = function(event) {
              return _validateDouble({
                event: event,
                eventType: 'keypress',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateDouble({
                event: event,
                eventType: 'change',
                input: this
              });
            };
          case 'uppercase':
            input.onkeyup = function(event) {
              return _validateUpperCase({
                event: event,
                eventType: 'keyup',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateUpperCase({
                event: event,
                eventType: 'change',
                input: this
              });
            };
          case 'lowercase':
            input.onkeyup = function(event) {
              return _validateLowerCase({
                event: event,
                eventType: 'keyup',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateLowerCase({
                event: event,
                eventType: 'change',
                input: this
              });
            };
          case 'email':
            return input.onchange = function(event) {
              return _validateEmail({
                event: event,
                input: this
              });
            };
          case 'percent':
            return input.onchange = function(event) {
              return _validatePercent({
                event: event,
                input: this
              });
            };
          case 'date':
            return _validateDate(input);
          default:
            input.onkeyup = function(event) {
              return _validateText({
                event: event,
                eventType: 'keyup',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateText({
                event: event,
                eventType: 'change',
                input: this
              });
            };
        }
      });
    };

    /*
    	 * METHOD STATIC VALIDATE
     */
    _validateInteger = function(obj) {
      var key;
      key = document.all ? obj.event.keyCode : obj.event.which;
      if (_keyEnable(key)) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /\d/.test(String.fromCharCode(key));
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
      }
    };
    _validateDouble = function(obj) {
      var arrayValue, key, validate;
      key = document.all ? obj.event.keyCode : obj.event.which;
      if (_keyEnable(key)) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /[\d.]/.test(String.fromCharCode(key));
      } else if (obj.eventType === 'change') {
        obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
        validate = !!obj.input.value.toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/);
        if (!validate) {
          arrayValue = obj.input.value.split(".");
          return obj.input.value = arrayValue[0] + '.' + arrayValue[1];
        }
      }
    };
    _validateText = function(obj) {
      var key;
      key = document.all ? obj.event.keyCode : obj.event.which;
      if (_keyEnable(key)) {
        return true;
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[\#\-\"\']/g, '');
      }
    };
    _validateUpperCase = function(obj) {
      var key;
      key = document.all ? obj.event.keyCode : obj.event.which;
      if (_keyEnable(key)) {
        return true;
      } else if (obj.eventType === 'keyup') {
        obj.input.value = obj.input.value.toUpperCase();
        return obj.input.value = obj.input.value.replace(/[\#\-\"\']/g, '');
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[\#\-\"\']/g, '');
      }
    };
    _validateLowerCase = function(obj) {
      var key;
      key = document.all ? obj.event.keyCode : obj.event.which;
      if (_keyEnable(key)) {
        return true;
      } else if (obj.eventType === 'keyup') {
        if (obj.option === 'uppercase') {
          return obj.input.value = obj.input.value.toLowerCase();
        }
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[\#\-\"\']/g, '');
      }
    };
    _validateEmail = function(obj) {
      var validate;
      validate = !!obj.input.value.toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i);
      if (!validate) {
        obj.input.value = "";
        return obj.input.focus();
      }
    };
    _validatePercent = function(obj) {
      var max, min, result;
      max = obj.input.getAttribute('data-max') * 1;
      min = obj.input.getAttribute('data-min') * 1;
      result = obj.input.value * 1;
      if (result <= max) {
        if (result >= min) {
          console.log('valor aceptado');
        } else {
          alert('no se aceptan  menores a ' + min);
          obj.input.value = '';
          obj.input.focus();
        }
      } else {
        alert('no se aceptan muneros mayores a' + max);
        obj.input.value = '';
        obj.input.focus();
      }
      return true;
    };

    /*
    	 * KEY CODE
    	 *
    	 * key==8 		// BACKSPACE
    	 * key==9 		// TAB
    	 * key==0 		// TAB
    	 * key==13 		// ENTER
    	 * key==37 		// CURSOR LEFT
    	 * key==39 		// CURSOR RIGHT
    	 * key==38 		// CURSOR TOP
    	 * key==40 		// CURSOR BOTTOM
    	 *
     */
    _keyEnable = function(key) {
      if (key === 8 || key === 9 || key === 0 || key === 13 || key === 37 || key === 38 || key === 39 || key === 40) {
        return true;
      }
      return false;
    };

    /*
    	 * Calendar
     */
    return _validateDate = function(obj) {
      var _changeToCalendarDay, _changeYear, _drawCalendar, _findXY, _formatDate, _getDayName, _getDaysInMonth, _getFirstDayofMonth, _getMonthName, _removeCalendar, _setLocate, _setMonth, _setYear, _setupDays, arrayDate, dayNames, format, formatField, id, inputCalendar, monthNames, selected, selectedDay, selectedMonth, selectedYear, separator, valueField, weekDays;
      if (obj === null) {
        return;
      }
      separator = '-';
      id = obj.idApply || obj.id;
      format = obj.format || 'y-m-d';
      selected = obj.selected || '';
      monthNames = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
      dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      weekDays = ['D', 'L', 'M', 'M', 'J', 'V', 'S'];
      inputCalendar = id !== '' ? document.getElementById(id) || obj : void 0;
      inputCalendar.dataset.icon = 'date';
      if (typeof obj.value !== 'undefined') {
        inputCalendar.value = obj.value;
      }
      arrayDate = [];
      separator = (format.replace(/[a-zA-Z\d\s]/g, ''))[0];
      formatField = format.replace(/[^a-zA-Z\d\s]/g, '');
      valueField = inputCalendar.value.replace(/[^\d]/g, '');
      if (inputCalendar.value === '') {
        selectedYear = new Date().getFullYear();
        selectedMonth = new Date().getMonth();
        selectedDay = new Date().getDate();
      } else {
        arrayDate[formatField[0]] = valueField[0];
        arrayDate[formatField[1]] = valueField[1];
        arrayDate[formatField[2]] = valueField[2];
        selectedYear = new Date(arrayDate.y).getFullYear();
        selectedMonth = new Date(arrayDate.m).getMonth();
        selectedDay = new Date(arrayDate.d).getDate();
      }
      inputCalendar.readOnly = true;
      inputCalendar.onclick = function() {
        if ($W('#date_' + id)[0]) {
          _removeCalendar($W('#date_' + id)[0]);
          return;
        }
        _drawCalendar(this);
        return _setupDays(this);
      };

      /*
      		_drawCalendar
      		@paran obj this
       */
      _drawCalendar = function(inputObj) {
        var day, daysInMonth, divCalendar, e, f, html, k, l, len, m, noPrintDays, numRows, printDate, ref, startDay, thisMonth, thisYear, today;
        html = ("<table id=\"win-calendar-year-" + id + "\" cellpadding=\"0\" cellspacing=\"0\" class=\"win-calendar-year\" style=\"display:table;\"></table> <table id=\"win-calendar-" + id + "\" cellpadding=\"0\" cellspacing=\"0\" class=\"win-calendar\"> <tr class=\"calendar-controls\"> <td id=\"prev-month-" + id + "\" class=\"calendar-change previous\">  </td> <td id=\"title-date-" + id + "\" colspan=\"5\" class=\"calendar-header\">") + _getMonthName(selectedMonth) + " " + selectedYear + ("</td> <td id=\"next-month-" + id + "\" class=\"calendar-change next\">  </td> </tr> <tr class=\"weekDaysTitleRow\">");
        for (k = 0, len = weekDays.length; k < len; k++) {
          day = weekDays[k];
          html += "<td>" + day + "</td>";
        }
        daysInMonth = _getDaysInMonth(selectedYear, selectedMonth);
        startDay = _getFirstDayofMonth(selectedYear, selectedMonth);
        numRows = 0;
        printDate = 1;
        if (startDay !== 7) {
          numRows = Math.ceil((startDay + 1 + daysInMonth) / 7);
          noPrintDays = startDay + 1;
        } else {
          noPrintDays = 0;
        }
        today = new Date().getDate();
        thisMonth = new Date().getMonth();
        thisYear = new Date().getFullYear();
        for (e = l = 0, ref = numRows; 0 <= ref ? l < ref : l > ref; e = 0 <= ref ? ++l : --l) {
          html += "<tr class=\"weekDaysRow\">";
          for (f = m = 0; m < 7; f = ++m) {
            if (printDate === today && selectedYear === thisYear && selectedMonth === thisMonth && noPrintDays === 0) {
              html += "<td id=\"today\" class=\"weekDaysCell\">";
            } else {
              html += "<td class=\"weekDaysCell\">";
            }
            if (noPrintDays === 0) {
              if (printDate <= daysInMonth) {
                html += "<a>" + printDate + "</a>";
              }
              printDate++;
            }
            html += "</td>";
            if (noPrintDays > 0) {
              noPrintDays--;
            }
          }
          html += "</tr>";
        }
        html += "</table>";
        if ($W('#date_' + id).length > 0) {
          $W('#date_' + id).html(html);
        } else {
          divCalendar = document.createElement("div");
          divCalendar.innerHTML = html;
          divCalendar.setAttribute("id", "date_" + id);
          divCalendar.setAttribute("class", "win-calendar-parent");
          $W('#' + id)[0].parentNode.insertBefore(divCalendar, $W('#' + id)[0].nextSibling);
          _setLocate(inputCalendar, divCalendar);
        }
        $W('#title-date-' + id)[0].onclick = function() {
          var year;
          year = this.innerHTML.split(' ')[1] * 1;
          return _changeYear(year - 5, inputObj);
        };
        $W('#prev-month-' + id)[0].onclick = function() {
          selectedMonth--;
          if (selectedMonth < 0) {
            selectedMonth = 11;
            selectedYear--;
          }
          _drawCalendar(inputObj);
          return _setupDays(inputObj);
        };
        return $W('#next-month-' + id)[0].onclick = function() {
          selectedMonth++;
          if (selectedMonth > 11) {
            selectedMonth = 0;
            selectedYear++;
          }
          _drawCalendar(inputObj);
          return _setupDays(inputObj);
        };
      };

      /*
      		_changeYear
      		@param str year
       */
      _changeYear = function(year, inputObj) {
        var html, i, j, k, l, option, year1, year2;
        year1 = year;
        year2 = year + 6;
        option = "";
        for (i = k = 0; k < 6; i = ++k) {
          j = i + 6;
          option += "<div> <div class=\"date-change-month\" data-value=\"" + i + "\">" + (monthNames[i].substr(0, 3)) + "</div> <div class=\"date-change-month\" data-value=\"" + j + "\">" + (monthNames[j].substr(0, 3)) + "</div> </div>";
        }
        html = "<tr> <td colspan=\"2\" rowspan=\"7\" class=\"content-month\">" + option + "</td> <td colspan=\"2\" class=\"content-year\"> <div id=\"change-year-down-" + id + "\" class=\"calendar-change\" style=\"float:left;\"> < </div> <div id=\"change-year-top-" + id + "\" class=\"calendar-change\" style=\"float:right;\"> > </div> </td> </tr>";
        for (i = l = 0; l < 6; i = ++l) {
          html += "<tr> <td data-year=\"false\">" + (year1++) + "</td> <td data-year=\"false\">" + (year2++) + "</td> </tr>";
        }
        html += "<tr style=\"border-top:1px solid #fff;\"> <td colspan=2 style=\"padding:0px; border-right:1px solid #fff;\"> <input type=\"button\" style=\"width:100%; padding:3px;\" id=\"boton-done-calendar-" + id + "\" value=\"Aceptar\"> </td> <td colspan=2 style=\"padding:0px;\"> <input type=\"button\" style=\"width:100%; padding:3px;\" value=\"Volver\" id=\"boton-back-calendar-" + id + "\"> </td> </tr>";
        $W('#win-calendar-year-' + id).style('display', 'table');
        $W('#win-calendar-' + id).style('display', 'none');
        $W('#win-calendar-year-' + id).html(html);
        $W('#win-calendar-year-' + id + ' td').onclick = function() {
          return console.log(this);
        };
        $W("#change-year-top-" + id)[0].onclick = function() {
          return _changeYear(year2, inputObj);
        };
        $W("#change-year-down-" + id)[0].onclick = function() {
          return _changeYear(year - 12, inputObj);
        };
        $W("#boton-back-calendar-" + id)[0].onclick = function() {
          return _changeToCalendarDay();
        };
        $W(".date-change-month").on('click', function(element) {
          return _setMonth(element, id);
        });
        $W("#win-calendar-year-" + id + " [data-year] ").on('click', function(element) {
          return _setYear(element, id);
        });
        return $W("#boton-done-calendar-" + id)[0].onclick = function() {
          var new_month, new_year;
          new_month = document.getElementById(id).getAttribute('data-month');
          new_year = selectedYear - document.getElementById(id).getAttribute('data-year');
          selectedMonth = new_month;
          selectedYear = new_year < 0 ? selectedYear + Math.abs(new_year) : selectedYear - new_year;
          if (selectedMonth !== null && selectedYear !== 0) {
            _drawCalendar(inputObj);
            return _setupDays(inputObj);
          }
        };
      };

      /*
      		_removeCalendar
       */
      _changeToCalendarDay = function() {
        $W('#win-calendar-year-' + id).style('display', 'none');
        return $W('#win-calendar-' + id).style('display', 'table');
      };

      /*
      		_removeCalendar
      		@param obj calendar $W('#date_'+id)[0]
       */
      _removeCalendar = function(obj) {
        return obj.parentNode.removeChild(obj);
      };

      /*
      		_setupDays
      		@param obj input date $W('#'+id)[0]
       */
      _setupDays = function(inputObj) {
        var i, k, len, results, x, y;
        y = $W('#win-calendar-' + id)[0];
        x = y.getElementsByTagName('a');
        results = [];
        for (k = 0, len = x.length; k < len; k++) {
          i = x[k];
          results.push(i.onclick = function() {
            selectedDay = this.innerHTML;
            inputObj.value = _formatDate(selectedDay, selectedMonth, selectedYear);
            return _removeCalendar($W('#date_' + id)[0]);
          });
        }
        return results;
      };

      /*
      		_formatDate
      		@param int dia
      		@param int mes
      		@param int año
       */
      _formatDate = function(Day, Month, Year) {
        var array, dateString;
        Month++;
        if (Month < 10) {
          Month = '0' + Month;
        }
        if (Day < 10) {
          Day = '0' + Day;
        }
        array = [];
        array['y'] = Year;
        array['m'] = Month;
        array['d'] = Day;
        return dateString = array[formatField[0]] + separator + array[formatField[1]] + separator + array[formatField[2]];
      };

      /*
      		_getMonthName
      		@param  int month
      		@return str name month
       */
      _getMonthName = function(month) {
        return monthNames[month];
      };

      /*
      		_getDayName
      		@param  int dia
      		@return str name day
       */
      _getDayName = function(day) {
        return dayNames[day];
      };
      _getDaysInMonth = function(year, month) {
        return 32 - new Date(year, month, 32).getDate();
      };
      _getFirstDayofMonth = function(year, month) {
        var day;
        return day = new Date(year, month, 0).getDay();
      };

      /*
      		_setLocate
      		@param obj input date $W('#'+id)[0]
      		@param obj calendar $W('#date_'+id)[0]
       */
      _setLocate = function(targetObj, moveObj) {
        var coors;
        coors = _findXY(targetObj);
        return moveObj.getAttribute("style", "position:absolute; z-index:8000;");
      };

      /*
      		_findXY
      		@param  obj dom XY Coord
      		@return arr [left.px, top.px]
       */
      _findXY = function(obj) {
        var curleft, curtop;
        curleft = curtop = 0;
        if (obj.offsetParent) {
          curleft = obj.offsetLeft;
          curtop = obj.offsetTop;
          while ((obj = obj.offsetParent)) {
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
          }
        }
        return [curleft, curtop];
      };

      /*
      		_setYear
      		@param obj dom input
      		@param id id input
       */
      _setYear = function(obj, id) {
        $W("#win-calendar-year-" + id + " [data-year] ").style('background-color', '');
        $W("#win-calendar-year-" + id + " [data-year] ").style('color', '');
        obj.toElement.setAttribute('style', 'background-color:#ADADAD;color:#000;');
        return document.getElementById(id).dataset.year = obj.toElement.innerHTML;
      };

      /*
      		_setMonth
      		@param obj dom input
      		@param id id input
       */
      return _setMonth = function(obj, id) {
        $W(".date-change-month").style('background-color', '');
        $W(".date-change-month").style('color', '');
        obj.toElement.setAttribute('style', 'background-color:#ADADAD;color:#000;');
        return document.getElementById(id).dataset.month = obj.toElement.getAttribute('data-value');
      };
    };
  })(Win);

}).call(this);
