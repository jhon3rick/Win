// Generated by CoffeeScript 1.10.0

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
        return;
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
    load: function(dom_element, obj) {
      var bodyXhr, eval_script, extract_script, method, obj_loading, parametros, tagScript, value, xhr;
      if (typeof obj === 'undefined') {
        console.warn("Para hacer uso del ajax load debe enviar el objeto con los paramteros Win.Ajax.load(DOM_ELEMENT,obj) \nConsulte la documentacion del proyecto");
        return;
      }
      if (typeof obj.id_ventana === 'undefined') {
        console.warn("Debe enviar el paramtro id_ventana, para poder mostrar el loading");
        return;
      }
      parametros = '';
      tagScript = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)';
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      obj_loading = {
        id_ventana: obj.id_ventana,
        estado: 'on'
      };
      Win.loading(obj_loading);
      xhr = new XMLHttpRequest;
      bodyXhr = obj.url + '?' + parametros;
      method = obj.method || 'POST';
      xhr.open(method, bodyXhr, true);
      xhr.onreadystatechange = function() {
        var html, response;
        if (xhr.readyState === 4) {
          response = xhr.responseText;
          html = extract_script(response);
          dom_element.innerHTML = html;
          eval_script(response);
          obj_loading.estado = 'off';
          return Win.loading(obj_loading);
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
