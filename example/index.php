<html>
	<head>
		<title>Win Js</title>

		<meta content="no-cache" http-equiv="Pragma"></meta>
		<meta content="no-cache, no-store, must-revalidate" http-equiv="Cache-Control"></meta>
		<meta content="0" http-equiv="Expires"></meta>

		<link rel="stylesheet" href="css/normalize.css" />
		<link rel="stylesheet" href="../dist/css/Win.min.css" />
		<link rel="stylesheet" href="../dist/css/Win-theme-blue.min.css" />
		<link rel="stylesheet" href="css/Win-loaders.css" />
		<link rel="stylesheet" href="css/icon.css" />


		<script src="../dist/js/Win.min.js"></script>
		<!-- <script src="js/Win.js"></script>
		// <script src="js/Win.element.js"></script>
		// <script src="js/Win.css.js"></script>
		// <script src="js/Win.events.js"></script>
		// <script src="js/Win.query.js"></script>
		// <script src="js/Win.output.js"></script>


		// <script src="js/Win.form.js"></script>
		// <script src="js/Win.widget.js"></script>
		// <script src="js/Win.ajax.js"></script>
		// <script src="js/Win.ini.js"></script>
		// <script src="js/Win.desktop.js"></script> -->

		<link rel="stylesheet" href="js/highlight/styles/androidstudio.css">
		<script src="js/highlight/highlight.pack.js"></script>
		<script>hljs.initHighlightingOnLoad();</script>

		<style type="text/css">

			#parent .head{
				color   : #FFF;
				height  : 50px;
				width   : 100%;
				display : table;
				text-align : center;
				/*background-color : #333;*/

				background: -webkit-gradient(radial, center center, 0, center center, 460, from(#111), to(#000));
				background: -webkit-radial-gradient(circle, #111, #000);
				background: -moz-radial-gradient(circle, #111, #000);
				background: -o-radial-gradient(circle, #111, #000);
				background: -ms-radial-gradient(circle, #111, #000);
				background: radial-gradient(circle, #111, #000);
			}

			#parent .body{
				width    : 100%;
				height   : calc(100% - 50px);
				overflow : hidden;
			}

			#parent #menu-left{
				float  : left;
				width  : 150px;
				height : 100%;
				background-color : #000;
			}

			#parent #menu-left > div{
				color     : #fff;
				cursor    : pointer;
				padding   : 5px;
				font-size : 15px;

				border-bottom: 1px solid #666;
				background: -webkit-gradient(radial, center center, 0, center center, 460, from(#111), to(#000));
				background: -webkit-radial-gradient(circle, #111, #000);
				background: -moz-radial-gradient(circle, #111, #000);
				background: -o-radial-gradient(circle, #111, #000);
				background: -ms-radial-gradient(circle, #111, #000);
				background: radial-gradient(circle, #111, #000);
				background-color: #000;
			}

			#parent #menu-right{
				float    : left;
				height   : 100%;
				width    : calc(100% - 150px);
				overflow : auto;
				padding  : 0 10px;
				background-color :#282b2e;
			}

			#parent .subtitle, #parent .subtitle2{
				color   : #FFF;
				padding : 5px;
				background-color : #282b2e;
			}

			#parent .subtitle{ font-size: 20px; }
			#parent .subtitle2{ font-size: 17px; }
			#parent .parrafo > div{
				color   : #fff;
				margin  : 0;
				padding : 0 5px;
			}

			pre{ margin: -20px 0 0 20px; }
		</style>

	</head>
	<body>
		<div id="parent">
			<div class="head">
				<div style="display:table-cell; vertical-align:middle;">
					<span style="font-size:30px;">Win Js</span><span style="font-size:12px;">($W)</span>
				</div>
			</div>
			<div class="body">
				<div id="menu-left">
					<div onclick="load_file('instalacion')">Instalacion</div>
					<div onclick="load_file('temas')">Temas</div>
					<div onclick="load_file('api')">Api</div>
					<div onclick="load_file('core')">Core</div>
					<div onclick="load_file('form')">Formulario</div>
					<div onclick="load_file('ajax')">Ajax</div>
					<div onclick="load_file('elements')">Elements</div>
					<div onclick="load_file('tbar')">Tbar</div>
					<div onclick="load_file('ventana')">Ventana</div>
					<div onclick="load_file('add')">Add</div>
					<div onclick="load_file('icons')">Icons</div>
				</div>
				<div id="menu-right"></div>
			</div>
		</div>

		<script type="text/javascript">

			load_file = function (file){
				$W.Load({
					idApply : "menu-right",
					url     : "modulos/"+file+".php",
					params  : {}
				})
			}
		</script>

	</body>
</html>