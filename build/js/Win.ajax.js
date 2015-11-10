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
Win.Ajax = (function() {
  return {
    request: function(obj) {
      var bodyXhr, method, parametros, value, xhr;
      parametros = '';
      if (typeof obj === 'undefined') {
        console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.request(obj) \nConsulte la documentacion del proyecto");
      }
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      xhr = new XMLHttpRequest;
      bodyXhr = obj.url + '?' + parametros;
      method = obj.method || 'POST';
      xhr.open(method, bodyXhr, true);
      xhr.onreadystatechange = function() {
        var response;
        if (xhr.readyState === 4) {
          response = xhr.responseText;
          return obj.success(response, xhr);
        } else {
          return obj.failure(xhr);
        }
      };
      return xhr.send(null);
    },
    load: function(div, obj) {
      var bodyXhr, eval_script, extract_script, method, parametros, tagScript, value, xhr;
      parametros = '';
      tagScript = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)';
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      xhr = new XMLHttpRequest;
      bodyXhr = obj.url + '?' + parametros;
      method = obj.method || 'POST';
      xhr.open(method, bodyXhr, true);
      xhr.onreadystatechange = function() {
        var html, response;
        if (xhr.readyState === 4) {
          response = xhr.responseText;
          html = extract_script(response);
          div.innerHTML = html;
          return eval_script(response);
        }
      };
      xhr.send(null);
      extract_script = function(string) {
        var SearchExp;
        SearchExp = new RegExp(tagScript, 'img');
        return string.replace(SearchExp, '');
      };
      return eval_script = function(string) {
        var script, scripts;
        scripts = string.match(new RegExp(tagScript, 'img')) || [];
        script = '';
        scripts.map(function(script_map) {
          return script += (script_map.match(new RegExp(tagScript, 'im')) || ['', ''])[1];
        });
        return eval(script);
      };
    }
  };
})();
