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
  var background, backgroundImage;
  background = obj.background ? 'background-color:' + obj.background + ';' : '';
  backgroundImage = obj.backgroundImage ? 'background-image:' + obj.background + ';' : '';
  if (typeof obj.modulos === 'object') {
    this.modulos(obj);
  }
  return this.modulos = function(obj) {
    return obj.forEach(function(obj, index, element) {
      console.log(obj);
      console.log(index);
      return console.log(element);
    });
  };
};
