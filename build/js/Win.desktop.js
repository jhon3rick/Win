/**
 * win - Libreria para web aplicaciones RIA
 * @version v0.0.1
 * @link    https://github.com/jhon3rick/Win.js#readme
 * @author  Jhon Marroquin (Twitter @jhon3rick || email jhon3rick@gmail.com)
 * @license (MIT)
 */

/*
 * Desktop
 */
Win.Desktop = function(obj) {
  var background, backgroundImage, heightIcon, widthIcon;
  widthIcon = obj.widthIcon || 20;
  heightIcon = obj.heightIcon || 20;
  background = obj.background ? 'background-color:' + obj.background + ';' : '';
  backgroundImage = obj.backgroundImage ? 'background-image:' + obj.background + ';' : '';
  this.modulos = function(obj) {
    var div;
    div = '<div style="height:100%"> <div class="desk-content-modulos">';
    obj.forEach(function(array, index, element) {
      return div += "<div class=\"desk-modulo\" style=\"width:" + widthIcon + "; height:" + heightIcon + ";\">\n	<div></div>\n	<div>" + obj.text + "</div>\n</div>";
    });
    div += '</div></div>';
    return document.querySelector('body').innerHTML = div;
  };
  if (typeof obj.modulos === 'object') {
    return this.modulos(obj.modulos);
  }
};
