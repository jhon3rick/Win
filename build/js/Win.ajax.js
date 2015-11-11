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
      var bodyXhr, method, obj_loading, parametros, value, xhr;
      parametros = '';
      if (typeof obj === 'undefined') {
        console.warn("Para hacer uso del ajax debe enviar el objeto con los paramteros Win.Ajax.request(obj) \nConsulte la documentacion del proyecto");
        return;
      }
      if (typeof obj.id_ventana === 'undefined') {
        console.warn("Debe enviar el paramtro id_ventana, para poder mostrar el loading");
        return;
      }
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      if (obj.modal === true || obj.modal === '') {
        obj_loading = {
          id_ventana: obj.id_ventana,
          text: obj.text,
          loader: obj.loader,
          icono: obj.iconFinish,
          icono: obj.iconFinish,
          texto: obj.textFinish,
          duracion: obj.duracionFinish,
          estado: 'on'
        };
        Win.loading(obj_loading);
      }
      xhr = new XMLHttpRequest;
      bodyXhr = obj.url + '?' + parametros;
      method = obj.method || 'POST';
      xhr.open(method, bodyXhr, true);
      xhr.onreadystatechange = function() {
        var response;
        if (xhr.readyState === 4) {
          response = xhr.responseText;
          if ((obj.modal === true || obj.modal === '') && (obj.autoClose === true || obj.autoClose === '')) {
            obj_loading.estado = 'off';
            Win.loading(obj_loading);
          }
          return obj.success(response, xhr);
        } else {
          if ((obj.modal === true || obj.modal === '') && (obj.autoClose === true || obj.autoClose === '')) {
            obj_loading.estado = 'off';
            Win.loading(obj_loading);
          }
          return obj.failure(xhr);
        }
      };
      return xhr.send(null);
    },
    load: function(dom_element, obj) {
      var bodyXhr, eval_script, extract_script, load_icon, method, parametros, tagScript, text, value, xhr;
      if (typeof obj === 'undefined') {
        console.warn("Para hacer uso del ajax load debe enviar el objeto con los paramteros Win.Ajax.load(DOM_ELEMENT,obj) \nConsulte la documentacion del proyecto");
        return;
      }
      parametros = '';
      tagScript = '(?:<script.*?>)((\n|\r|.)*?)(?:<\/script>)';
      if (typeof obj.params !== 'undefined') {
        for (value in obj.params) {
          parametros += parametros === '' ? value + "=" + obj.params[value] : "&" + value + "=" + obj.params[value];
        }
      }
      text = obj.text || 'cargando...';
      load_icon = 'data:image/gif;base64,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';
      dom_element.innerHTML = '<div class="win-content-min-load" ><div class="win-content-min-load-img"><img src="' + load_icon + '"></div><div class="win-content-min-load-label">' + text + '</div></div>';
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
