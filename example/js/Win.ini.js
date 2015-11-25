/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * CONFIG INI
 */

(function() {
  (function($W) {
    return $W.ini = function(obj) {
      var dir, i, j, len, link, theme;
      if (obj.theme) {
        link = $W('head > link');
        for (j = 0, len = link.length; j < len; j++) {
          i = link[j];
          if (/Win-theme/g.test(i.getAttribute('href'))) {
            dir = i.getAttribute('href').split('Win-theme', 1);
            i.setAttribute('href', dir + obj.theme);
            return;
          }
        }
        theme = document.createElement("link");
        theme.setAttribute("rel", "stylesheet");
        theme.setAttribute("href", obj.theme);
        return $W('head')[0].appendChild(theme);
      }
    };
  })(Win);

}).call(this);
