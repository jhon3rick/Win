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
Win.ini = (function(obj) {
  if (obj == null) {
    obj = {};
  }
  window.addEventListener('keydown', function(e) {});
  console.log(e.keyIdentifier);
  if (e.keyIdentifier === 'F12' || e.keyCode === 74 && e.metaKey && e.altKey) {
    return console.log(e.keyIdentifier);
  }
});
