<html>
	<head>
		<title>Win Js</title>

		<meta content="no-cache" http-equiv="Pragma"></meta>
		<meta content="no-cache, no-store, must-revalidate" http-equiv="Cache-Control"></meta>
		<meta content="0" http-equiv="Expires"></meta>

		<!--<link rel="stylesheet" href="js/winJs/css/Win.min.css" />
		<link rel="stylesheet" href="js/winJs/css/Win-theme-blue.min.css" />
		<script src="js/winJs/js/Win.min.js"></script>-->

		<link rel="stylesheet" href="../dist/css/Win.min.css" />
		<link rel="stylesheet" href="../dist/css/Win-theme-blue.min.css" />
		<script src="../dist/js/Win.min.js"></script>


		<link rel="stylesheet" href="css/icon.css" />
		<link rel="stylesheet" href="js/highlight/styles/github.css">
		<script src="js/highlight/highlight.pack.js"></script>
		<script>hljs.initHighlightingOnLoad();</script>

		<style type="text/css">

			#body-win{ padding: 10px; }

			#body-win .subtitle, #body-win .subtitle2{
				color            : #FFF;
				padding          : 5px;
				margin           : 0 0 15px 0;
				font-size        : 12px;
				font-weight      : bolder;
				background-color : #282b2e;
			}

			#load-win{ height: calc(100% - 30px); }

			.footer{
				height           : 30px;
				padding          : 8px 5px 2px 5px;
				text-align       : center;
				background-color : #CCC;
			}

		</style>

	</head>
	<body>
		<div id="load-win"></div>
		<div class="footer">
			Power by
			<span style="color:red;">WinJs</span> &copy; LogicalSoft sas - Jhon Erick Marroquin Cardenas Licencia
			<span style="color:blue;"> MIT </span>2016
		</div>

		<script type="text/javascript">

			$W.Add({
				idApply : "load-win",
				items   :
				[
					{
						xtype : "tbar",
						items :
						[
							{
								xtype : 'tbtext',
								text  : '<div><span style="color:red; font-size:40px;">$</span><span style="color:red; font-size:40px;">W</span><span style="font-size:30px;">in JS </span>v0.3</div>',
								width : 400
							},'->','-',
							{
								xtype    : 'panel',
								title    : 'Componentes',
								autoLoad :
								{
									url    : "php/modulos/componentes.php",
									params : {}
								}
							}

						]
					},
					{
						xtype : 'body',
						id    : 'body-win',
					}
				]

			})

		</script>

	</body>
</html>