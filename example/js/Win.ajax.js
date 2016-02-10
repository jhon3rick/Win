/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * Request XHR
 */

(function() {
  (function($W) {
    var _loadScript;
    $W.Ajax = function(obj) {
      var bodyXhr, method, param, value, xhr;
      param = '';
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          param += param === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      xhr = new XMLHttpRequest;
      bodyXhr = obj.url;
      method = obj.method || 'POST';
      xhr.open(method, bodyXhr, true);
      if (method === 'POST') {
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded", true);
      }
      xhr.onreadystatechange = function() {
        var response;
        if (xhr.readyState === 4) {
          response = xhr;
          return obj.success(response, xhr);
        } else {
          if (obj.failure) {
            return obj.failure(xhr);
          }
        }
      };
      return xhr.send(param);
    };
    $W.Load = function(obj) {
      var bodyXhr, method, param, text, value, xhr;
      if (!obj.idApply) {
        alert('idApply Obligatorio');
        return;
      } else if (typeof document.getElementById(obj.idApply) === 'null') {
        alert('No se encontro elemento en el arbol Dom');
        return;
      }
      param = '';
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          param += param === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      text = obj.text || 'cargando...';
      document.getElementById(obj.idApply).innerHTML = "<div class=\"win-content-min-load\" > <div class=\"win-content-min-load-img\"> <div class=\"win-min-load-ajax\"></div> </div> <div class=\"win-content-min-load-label\">" + text + "</div> </div>";
      xhr = new XMLHttpRequest;
      bodyXhr = obj.url + '?';
      method = obj.method || 'POST';
      xhr.open(method, bodyXhr, true);
      if (method === 'POST') {
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded", true);
      }
      xhr.onreadystatechange = function() {
        var divScript;
        if (xhr.readyState === 4) {
          divScript = document.getElementById(obj.idApply);
          if (xhr.status === 404) {
            return divScript.innerHTML = 'Not found';
          } else {
            divScript.innerHTML = xhr.responseText;
            return _loadScript(divScript);
          }
        }
      };
      return xhr.send(param);
    };

    /*
    	@method _loadScript
    	@param  obj objectDom load script
     */
    return _loadScript = function(obj) {
      var i, j, len, results, tagScript, tagsScript;
      tagsScript = obj.getElementsByTagName('script');
      results = [];
      for (j = 0, len = tagsScript.length; j < len; j++) {
        i = tagsScript[j];
        tagScript = document.createElement('script');
        i.parentNode.replaceChild(tagScript, i);
        results.push(tagScript.innerHTML = i.innerHTML);
      }
      return results;
    };
  })(Win);

}).call(this);
