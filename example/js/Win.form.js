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

(function() {
  "use strict";
  (function($W) {
    var _validateDateField, _validateDoubleField, _validateEmailField, _validateIntField, _validatePorcentField, _validateTextField;
    $W.form = {};
    $W.form.field = function(obj) {
      switch (obj.type) {
        case 'integer':
          $W('#' + obj.idApply).addClass += " win-input-number";
          $W('#' + obj.idApply)[0].onkeypress = function(event) {
            return _validateIntField({
              event: event,
              eventType: 'keypress',
              input: this
            });
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateIntField({
              event: event,
              eventType: 'change',
              input: this
            });
          };
        case 'double':
          $W('#' + obj.idApply).addClass += " win-input-number";
          $W('#' + obj.idApply)[0].onkeypress = function(event) {
            return _validateDoubleField({
              event: event,
              eventType: 'keypress',
              input: this
            });
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateDoubleField({
              event: event,
              eventType: 'change',
              input: this
            });
          };
        case 'text':
          $W('#' + obj.idApply)[0].onkeyup = function(event) {
            return _validateTextField({
              event: event,
              eventType: 'keyup',
              input: this,
              option: obj.option
            });
          };
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateTextField({
              event: event,
              eventType: 'change',
              input: this,
              option: obj.option
            });
          };
        case 'email':
          return $W('#' + obj.idApply)[0].onchange = function(event) {
            return _validateEmailField({
              event: event,
              input: this
            });
          };
        case 'date':
          return _validateDateField(obj);
        case 'porcentaje':
          return _validatePorcentField(obj);
      }
    };
    $W.form.validate = function(id) {
      var campos;
      campos = document.getElementById(id).querySelectorAll("input, textarea, select");
      return [].forEach.call(arrayinput, function(input) {
        var type;
        type = input.getAttribute('data-validate');
        switch (type) {
          case 'integer':
            input.addClass += " win-input-number";
            input.onkeypress = function(event) {
              return _validateIntField({
                event: event,
                eventType: 'keypress',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateIntField({
                event: event,
                eventType: 'change',
                input: this
              });
            };
          case 'double':
            input.addClass += " win-input-number";
            input.onkeypress = function(event) {
              return _validateDoubleField({
                event: event,
                eventType: 'keypress',
                input: this
              });
            };
            return input.onchange = function(event) {
              return _validateDoubleField({
                event: event,
                eventType: 'change',
                input: this
              });
            };
          case 'text':
            input.onkeyup = function(event) {
              return _validateTextField({
                event: event,
                eventType: 'keyup',
                input: this,
                option: obj.option
              });
            };
            return input.onchange = function(event) {
              return _validateTextField({
                event: event,
                eventType: 'change',
                input: this,
                option: obj.option
              });
            };
          case 'email':
            return input.onchange = function(event) {
              return _validateEmailField({
                event: event,
                input: this
              });
            };
          case 'porcent':
            return input.onchange = function(event) {
              return _validatePorcentField({
                event: event,
                input: this
              });
            };
          case 'date':
            return _validateDateField(obj);
        }
      });
    };
    _validateIntField = function(obj) {
      var tecla;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /\d/.test(String.fromCharCode(tecla));
      } else if (obj.eventType === 'change') {
        return obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
      }
    };
    _validateDoubleField = function(obj) {
      var arrayValue, tecla, validate;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keypress') {
        return /[\d.]/.test(String.fromCharCode(tecla));
      } else if (obj.eventType === 'change') {
        obj.input.value = obj.input.value.replace(/[^\d.]/g, '');
        validate = !!obj.input.value.toString().match(/(^-?\d\d*[\.|,]\d*$)|(^-?\d\d*$)|(^-?[\.|,]\d\d*$)/);
        if (!validate) {
          arrayValue = obj.input.value.split(".");
          return obj.input.value = arrayValue[0] + '.' + arrayValue[1];
        }
      }
    };
    _validateTextField = function(obj) {
      var tecla;
      tecla = document.all ? obj.event.keyCode : obj.event.which;
      if (tecla === 8 || tecla === 9 || tecla === 0 || tecla === 13) {
        return true;
      } else if (obj.eventType === 'keyup') {
        if (obj.option === 'uppercase') {
          return obj.input.value = obj.input.value.toUpperCase();
        } else if (obj.option === 'lowercase') {
          return obj.input.value = obj.input.value.toLowerCase();
        }
      } else if (obj.eventType === 'change') {
        console.log('-' + obj.input.value + '-');
        return obj.input.value = obj.input.value.replace(/[\#\-\"\'|^\s+|\s+$]/g, '');
      }
    };
    _validateEmailField = function(obj) {
      var validate;
      validate = !!obj.input.value.toString().match(/(^[a-z0-9]([0-9a-z\-_\.]*)@([0-9a-z_\-\.]*)([.][a-z]{3})$)|(^[a-z]([0-9a-z_\.\-]*)@([0-9a-z_\-\.]*)(\.[a-z]{2,4})$)/i);
      if (!validate) {
        obj.input.value = "";
        return obj.input.focus();
      }
    };
    _validatePorcentField = function(obj) {
      return console.log('udhdh');
    };

    /*
    	 * Calendar
     */
    return _validateDateField = function(obj) {
      var _changeToCalendarDay, _changeYear, _drawCalendar, _findXY, _formatDate, _getDayName, _getDaysInMonth, _getFirstDayofMonth, _getMonthName, _removeCalendar, _setLocate, _setupDays, arrayDate, dayNames, format, formatField, id, inputCalendar, monthNames, selected, selectedDay, selectedMonth, selectedYear, separator, valueField, weekDays;
      separator = '-';
      id = obj.idApply;
      format = obj.format || 'y-m-d';
      selected = obj.selected || '';
      monthNames = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
      dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      weekDays = ['D', 'L', 'M', 'M', 'J', 'V', 'S'];
      inputCalendar = $W('#' + id)[0];
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
        html = ("<table id=\"win-calendar-year-" + id + "\" cellpadding=\"0\" cellspacing=\"0\" class=\"win-calendar-year\" style=\"display:block;\"></table>\n<table id=\"win-calendar-" + id + "\" cellpadding=\"0\" cellspacing=\"0\" class=\"win-calendar\">\n	<tr>\n		<td id=\"prev-month-" + id + "\" class=\"calendar-change\"> < </td>\n		<td id=\"title-date-" + id + "\" colspan=\"5\" class=\"calendar-header\">") + _getMonthName(selectedMonth) + ' ' + selectedYear + ("</td>\n	<td id=\"next-month-" + id + "\" class=\"calendar-change\"> > </td>\n</tr>\n<tr class=\"weekDaysTitleRow\">");
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
          html += '<tr class="weekDaysRow">';
          for (f = m = 0; m < 7; f = ++m) {
            if (printDate === today && selectedYear === thisYear && selectedMonth === thisMonth && noPrintDays === 0) {
              html += '<td id="today" class="weekDaysCell">';
            } else {
              html += '<td class="weekDaysCell">';
            }
            if (noPrintDays === 0) {
              if (printDate <= daysInMonth) {
                html += "<a>" + printDate + "</a>";
              }
              printDate++;
            }
            html += '</td>';
            if (noPrintDays > 0) {
              noPrintDays--;
            }
          }
          html += '</tr>';
        }
        html += '</table>';
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
          return _changeYear(year - 5);
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
      _changeYear = function(year) {
        var html, i, j, k, l, option, year1, year2;
        year1 = year;
        year2 = year + 6;
        option = "";
        for (i = k = 0; k < 6; i = ++k) {
          j = i + 6;
          option += "<div>\n	<div class=\"date-change-month\">" + (monthNames[i].substr(0, 3)) + "</div>\n	<div class=\"date-change-month\">" + (monthNames[j].substr(0, 3)) + "</div>\n</div>";
        }
        html = "<tr>\n	<td colspan=\"2\" rowspan=\"7\" class=\"content-month\">" + option + "</td>\n	<td colspan=\"2\" class=\"content-year\">\n		<div id=\"change-year-down-" + id + "\" class=\"calendar-change\" style=\"float:left;\"> < </div>\n		<div id=\"change-year-top-" + id + "\" class=\"calendar-change\" style=\"float:right;\"> > </div>\n	</td>\n</tr>";
        for (i = l = 0; l < 6; i = ++l) {
          html += "<tr>\n	<td>" + (year1++) + "</td>\n	<td>" + (year2++) + "</td>\n</tr>";
        }
        html += "<tr style=\"border-top:1px solid #fff;\">\n	<td colspan=2 style=\"padding:0px; border-right:1px solid #fff;\">\n		<input type=\"button\" style=\"width:100%; padding:3px;\" value=\"Aceptar\">\n	</td>\n	<td colspan=2 style=\"padding:0px;\">\n		<input type=\"button\" style=\"width:100%; padding:3px;\" value=\"Volver\" id=\"boton-back-calendar-" + id + "\">\n	</td>\n</tr>";
        $W('#win-calendar-' + id).hide();
        $W('#win-calendar-year-' + id).show().html(html);
        $W("#change-year-top-" + id)[0].onclick = function() {
          return _changeYear(year2);
        };
        $W("#change-year-down-" + id)[0].onclick = function() {
          return _changeYear(year - 12);
        };
        return $W("#boton-back-calendar-" + id)[0].onclick = function() {
          return _changeToCalendarDay();
        };
      };

      /*
      		_removeCalendar
       */
      _changeToCalendarDay = function() {
        $W('#win-calendar-year-' + id).hide().html('');
        return $W('#win-calendar-' + id).show();
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
        console.log(targetObj);
        coors = _findXY(targetObj);
        console.log(coors);
        return moveObj.getAttribute("style", "position:absolute; z-index:8000;");
      };

      /*
      		_findXY
      		@param  obj dom XY Coord
      		@return arr [left.px, top.px]
       */
      return _findXY = function(obj) {
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
    };
  })(Win);

}).call(this);
