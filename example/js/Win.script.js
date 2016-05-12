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
    $W.Script = {};

    /*
    	@method strReplace Reemplaza string en una cadena
    	@param str cadena de texto
    	@param str string a reemplazar
    	@param str string que reemplaza
    	@return str cadena con string reemplazados
     */
    $W.Script.strReplace = function(cadena, buscada, reemplazo) {
      while (cadena.toString().indexOf(buscada) !== -1) {
        cadena = cadena.toString().replace(buscada, reemplazo);
      }
      return cadena;
    };

    /*
    	@method dateNow
    	@param int id_pais (49=>colombia)
    	@param str valor numero de identificacion
    	@return str numero de verificacion (DV)
     */
    $W.Script.numberTechnical = function(id_pais, valor) {
      var dv, i, k, len, vpri, x, y, z;
      dv = '';
      if (id_pais === 49) {
        if (!isNaN(valor)) {
          x = 0;
          y = 0;
          z = valor.length;
          vpri = [16];
          vpri[1] = 3;
          vpri[2] = 7;
          vpri[3] = 13;
          vpri[4] = 17;
          vpri[5] = 19;
          vpri[6] = 23;
          vpri[7] = 29;
          vpri[8] = 37;
          vpri[9] = 41;
          vpri[10] = 43;
          vpri[11] = 47;
          vpri[12] = 53;
          vpri[13] = 59;
          vpri[14] = 67;
          vpri[15] = 71;
          for (k = 0, len = z.length; k < len; k++) {
            i = z[k];
            y = valor.substr(i, 1);
            x += y * vpri[z - i];
          }
          y = x % 11;
          if (y > 1) {
            dv = 11 - y;
          } else {
            dv = y;
          }
        }
      }
      return dv;
    };

    /*
    	@method dateNow
    	@return str fecha en "yyyy-mm-dd"
     */
    $W.Script.dateNow = function() {
      var date, day, month, year;
      day = 0;
      month = 0;
      date = new Date();
      year = date.getFullYear();
      if ((date.getMonth()) + 1 < 10) {
        month = "0" + (date.getMonth() + 1);
      } else {
        month = date.getMonth() + 1;
      }
      if (date.getDate() < 10) {
        day = "0" + date.getDate();
      } else {
        day = date.getDate();
      }
      return year + "-" + month + "-" + day;
    };

    /*
    	@method timeMeridian
    	@param str Hora en fortmato (00:00:00) 24Hrs
    	@return str Hora en fortmato (00:00 AM/PM)
     */
    $W.Script.timeMeridian = function(formato) {
      var A, H, HORA, M, hr;
      if (formato === null) {
        formato = 'AM/PM';
      }
      hr = new Date();
      H = hr.getHours();
      M = hr.getMinutes();
      if (H < 12) {
        A = "AM";
      } else {
        A = "PM";
      }
      if (M < 10) {
        M = "0" + M;
      }
      if (formato === 'AM/PM') {
        if (H > 12) {
          H = H - 12;
        }
        if (H < 10) {
          H = "0" + H;
        }
        HORA = H + ":" + M + " " + A;
      }
      if (formato === '24Hrs') {
        if (H < 10) {
          H = "0" + H;
        }
        HORA = H + ":" + M;
      }
      return HORA;
    };

    /*
    	@method timeMysql
    	@param str Hora en fortmato (00:00 AM) o (00:00)
    	@return str Hora MYSQL(00:00:00)
     */
    $W.Script.timeMysql = function(hora) {
      var A, B, H;
      A = hora.split(' ');
      if (A.length === 1) {
        H = A[0] + ":00";
      } else if (A.length === 2) {
        B = A[0].split(':');
        if (A[1] === 'PM') {
          B[0] = eval(B[0]) + eval(12);
        }
        H = B[0] + ":" + B[1] + ":00";
      }
      return H;
    };

    /*
    	@method dateLong
    	@param str Date en formato mysql "y-m-d"
    	@return str Fecha larga
     */
    $W.Script.dateLong = function(date) {
      var NewDate, day, month;
      day = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"];
      month = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
      NewDate = date.split("-");
      return NewDate[2] + " " + month[NewDate[1] - 1] + " de " + NewDate[0];
    };

    /*
    	@method numberFormat
    	@param str Date en formato mysql "y-m-d"
    	@return str Fecha larga
     */
    $W.Script.numberFormat = function(number, decimals, dec_point, thousands_sep) {
      var c, d, i, j, n, s, t;
      n = number;
      c = isNaN(decimals = Math.abs(decimals)) ? 2 : decimals;
      d = dec_point === void 0 ? "," : dec_point;
      t = thousands_sep === void 0 ? "." : thousands_sep;
      s = n < 0 ? "-" : "";
      i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "";
      j = (j = i.length) > 3 ? j % 3 : 0;
      return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
    };
    return $W.Script.isJSON = function(text) {
      var error, error1;
      try {
        JSON.parse(text);
        return true;
      } catch (error1) {
        error = error1;
        return false;
      }
    };
  })(Win);

}).call(this);
