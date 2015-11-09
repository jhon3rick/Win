// var classImage = function(){
// 	return function(style){
// 		style.define('loadImages', function(a, b) {
// 			// return a.operate('+', b);
// 			return ['user_black_36', 'user_black_36'];
// 		});
// 	};
// };
// module.exports = classImage;

var fs   = require('fs');
var path = require('path');

var classImage = function(){
	return function(style){
		style.define('loadImages', function() {

			var nameDir    = 'C:\\PROYECTOS\\WWW\\Win\\build\\img\\icons';
			var loadDir    = fs.readdirSync(nameDir);
			var arrayImage = [];

			// DIRECTORIO DE IMAGENES
			loadDir.forEach(function(dir){
				var dirImages  = nameDir+'\\'+dir;
				var loadImages = fs.readdirSync(dirImages);

				// IMAGENES
				loadImages.forEach(function(image){

			    	image = image.replace('.png', '');
					arrayImage.push(image);
				});

			});
			// return ['user_black_36', 'user_black_36'];

			return arrayImage;

		});
	};
};

module.exports = classImage;