<html>
	<head>
		<title>Win Js</title>

		<link rel="stylesheet" href="css/normalize.css" />
		<link rel="stylesheet" href="css/Win.css" />
		<link rel="stylesheet" href="css/Win-loaders.css" />
		<link rel="stylesheet" href="css/icon.css" />

		<link rel="stylesheet" href="css/Win-theme-dark.css" />
		<!-- <link rel="stylesheet" href="css/Win-theme-light.css" /> -->

		<script src="../dist/js/Win.min.js"></script>

		<link rel="stylesheet" href="js/highlight/styles/androidstudio.css">
		<script src="js/highlight/highlight.pack.js"></script>
		<script>hljs.initHighlightingOnLoad();</script>

		<style type="text/css">
			#contenedor .subtitle, #contenedor .subtitle2{
				color            : #FFF;
				background-color : #282b2e;
				margin-top       : 20px;
				padding          : 5px;
			}

			#contenedor .subtitle{ font-size: 20px; }
			#contenedor .subtitle2{ font-size: 17px; }

			#contenedor .head{
				color            : #FFF;
				height           : 70px;
				text-align       : center;
				display          : table;
				width            : 100%;
				background-color : #333;
			}

			#contenedor .parrafo{
				font-size        : 15px;
				color            : #FFF;
				background-color : #282b2e;
				margin           : 0;
				padding          : 5px;
			}
			body{ background-color: #282b2e; }
			pre{ margin: -30px 0 0 20px; }

			input, select, textarea{ color: #282b2e; }

			.textForm{
				width: 100px;
				float: left;
			}
			.inputForm{
				width: 200px;
				float: left;
			}

			#contenedor .body{
				/*overflow : auto;*/
				height   : calc(100% - 70px);
			}

		</style>

	</head>
	<body>
		<div id="contenedor">
			<div class="head">
				<div style="display:table-cell; vertical-align:middle;">
					<span style="font-size:30px;">Win Js</span><span style="font-size:12px;">($W)</span>
				</div>
			</div>
			<div class="body">

<!-- ===================== INSTALACION ===================== -->
				<div class="subtitle">INSTALACION</div>
				<div class="parrafo">
					<div>Insertar en el archivo index</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<script src="dist/js/Win.min.js"></script>
<link rel="stylesheet" href="css/normalize.css" />
<link rel="stylesheet" href="css/Win.css" />
<link rel="stylesheet" href="css/Win-loaders.css" />
<link rel="stylesheet" href="css/icon.css" />';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>
				</div>

<!-- ===================== TEMAS ===================== -->
				<div class="subtitle">TEMAS</div>
				<div class="parrafo">
					<div>Insertar el CSS del tema deseado</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<link rel="stylesheet" href="css/Win-theme-dark.css" />
<link rel="stylesheet" href="css/Win-theme-light.css" />';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>
				</div>

				<div class="subtitle">API</div>

<!-- ===================== API VERSION ===================== -->
				<div class="subtitle2">API VERSION</div>
				<div class="parrafo">
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<script>
    console.log($W.version);
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>
				</div>

<!-- ===================== OBJECT DOM ===================== -->
				<div class="subtitle2">OBJECT DOM</div>
				<div class="parrafo">
					<div>Acceder a los elementos del DOM</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<div id="contenedor">
  <p class="parrafo">Lorem insu...</p>
</div>
<script>
    $W("#contenedor").style.backgroundColor = "red";
    $W("p","#contenedor")
    $W(".parrafo").innerHTML="true";
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>
				</div>

<!-- ===================== OBJECT FORM ===================== -->
				<div class="subtitle2">FORM</div>
				<div class="parrafo">

					<div style="overflow:hidden; margin: 10px 0;">
						<div class="textForm">Input Integer</div>
						<input type="text" id="inputInteger" class="inputForm" placeholder="inputInteger"/>
					</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<input type="text" id="inputInteger"/>
<script>
    $W.form.intField({
		applyTo : "inputInteger"
	});
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>

					<div style="overflow:hidden; margin: 10px 0;">
						<div class="textForm">Input Double</div>
						<input type="text" id="inputDouble" class="inputForm" placeholder="inputDouble"/>
					</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<input type="text" id="inputDouble"/>
<script>
    $W.form.doubleField({
		applyTo : "inputDouble"
	});
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>

					<div style="overflow:hidden; margin: 10px 0;">
						<div class="textForm">Input Email</div>
						<input type="text" id="inputEmail" class="inputForm" placeholder="inputEmail"/>
					</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<input type="text" id="inputEmail"/>
<script>
    $W.form.emailField({
		applyTo : "inputEmail"
	});
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>

					<div style="overflow:hidden; margin: 10px 0;">
						<div class="textForm">Input Text</div>
						<input type="text" id="inputText" class="inputForm" placeholder="inputText" data-icon="date"/>
					</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<input type="text" id="inputText"/>
<script>
    $W.form.textField({
		applyTo : "inputText",
		type    : "uppercase"
		// type    : "lowercase"
	});
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>

					<div style="overflow:hidden; margin: 10px 0;">
						<div class="textForm">Input Date</div>
						<input type="text" id="inputDate" class="inputForm" placeholder="inputDate"/>
					</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<input type="text" id="inputDate"/>
<script>
    $W.form.dateField({
		applyTo   : "inputDate",
		format    : "y-m-d",
		listeners : { select: function() { console.log(this); alert("prueba input date") } }
	});
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>
				</div>

<!-- ===================== WIDGET ===================== -->
				<div class="subtitle2">WIDGET</div>
				<div class="parrafo">

					<div style="overflow:hidden; margin: 10px 0;">
						<div class="textForm">Elemento Windows</div>
						<input type="button" onclick="ventana1()" value="Nueva Ventana" data-icon="date"/>
					</div>
					<div>
						<pre><code class="html">
							<?php
$contenido ='
<input type="button" onclick="ventana1()" />
<script>
	function ventana1(){
		Win_ventana_1 = new $W.Window({
			bodyStyle   : "",
			width       : 800,
			height      : 700,
			id          : "Win_ventana_1",
			title       : "VENTANA 1",
			titleStyle  : "",
			modal       : true,
			closable    : true,
			drag        : true,
			resize      : true,
			autoLoad    :
			{
		        url     : "bd.php",
		        params  :
		        {
		            opc : "prueba_ajax",
		            var2 : "var2",
		        }
		    },
			tbar        :
			[
				{
					xtype : "button",
					id    : "btn_1",
					cls   : "user_black_36",
					text  : "Nueva ventana",
					handler : function(){ ventana2(); }
				},"-",
				{
					items	:
					[
						{
							xtype     : "panel",
							width     : 160,
							height    : 56,
							bodyStyle : "background-color:rgb(208, 205, 205)",
							bodyStyle : "border:1px solid #2a80b9;",
							html      : "<div>contenido por parametro</div>",
							autoLoad  :
							{
								url		: "bd.php",
								params	:
								{
									opc    : "prueba_ajax_load",
									prueba : 1
								}
							}
						}
					]
				},
				{
					xtype : "button",
					id    : "btn_2",
					handler: function () { ajax_load();	},
					cls   : "ic_autorenew_black_36dp",
					text  : "ajax load"
				},
				{
					xtype : "button",
					id    : "btn_2",
					handler: function () { ajax_request();	},
					cls   : "ic_autorenew_black_36dp",
					text  : "ajax request"
				}
				,"->","-",
				{
					xtype : "button",
					id    : "btn_1",
					cls   : "icon-action-black-ic_perm_identity_black_24dp",
					text  : "Salir",
					handler : function(){ alert(4); ventana2(); }
				},"-",
				{
					xtype : "tbtext",
					id    : "btn_1",
					text  : "una demostracion de un texto largo<br>con salto de linea",
				}
			]
		});
	}

	function ventana2(){
		Win_ventana_2 = new Win.Window({
			apply       : "prueba",
			bodyStyle   : "",
			width       : 600,
			height      : 500,
			id          : "Win_ventana_2",
			title       : "VENTANA 2",
			modal       : true,
			autoScroll  : true,
			closable    : true,
			autoDestroy : true,
			tbar        :
			[
				{
					xtype : "button",
					id    : "btn_1",
					cls   : "prueba",
					text  : "Nueva<br>Ventana",
					handler : function(){ ventana3(); }
				},
				{
					xtype : "button",
					id    : "btn_2",
					cls   : "prueba",
					// text  : "guardar"
					handler: function () { ajax_load_2();	}
				},
			]
		});
	}

	function ventana3(){
		Win_ventana_3 = new Win.Window({
			apply       : "prueba",
			bodyStyle   : "",
			width       : 400,
			height      : 300,
			id          : "Win_ventana_3",
			title       : "VENTANA 3",
			modal       : true,
			autoScroll  : true,
			closable    : true,
			autoDestroy : true,
			autoLoad    :
			{
		        url     : ".php",
		        params  :
		        {
		            var1 : "var1",
		            var2 : "var2",
		        }
		    },
			drag        : true,
			resize      : true,
			tbar        :
			[
				{
					xtype : "button",
					id    : "btn_2",
					cls   : "prueba",
					// text  : "guardar"
				},
			]
		});
	}
</script>';
								echo htmlentities($contenido);
							?>
						</code></pre>
					</div>
				</div>





			</div>
		</div>

		<script type="text/javascript">
			console.log($W.version);

			$W.form.intField({
				applyTo : "inputInteger"
			});

			$W.form.doubleField({
				applyTo : "inputDouble"
			});

			$W.form.emailField({
				applyTo : "inputEmail"
			});

			$W.form.textField({
				applyTo : "inputText",
				type    : "uppercase"
			});

			$W.form.dateField({
				applyTo   : "inputDate",
				format    : "y-m-d",
				listeners : { select: function() { console.log(this); alert("prueba input 1") } }
			});

			function ventana1(){
				Win_ventana_1 = new $W.Window({
					bodyStyle   : "",
					width       : 800,
					height      : 700,
					id          : "Win_ventana_1",
					title       : "VENTANA 1",
					titleStyle  : "",
					modal       : true,
					closable    : true,
					drag        : true,
					resize      : true,
					autoLoad    :
					{
				        url     : "bd.php",
				        params  :
				        {
				            opc : "prueba_ajax",
				            var2 : "var2",
				        }
				    },
					tbar        :
					[
						{
							xtype : "button",
							id    : "btn_1",
							cls   : "user_black_36",
							text  : "Nueva Ventana",
							handler : function(){ ventana2(); }
						},"-",
						{
							items	:
							[
								{
									xtype     : "panel",
									width     : 160,
									height    : 56,
									bodyStyle : "background-color:rgb(208, 205, 205)",
									bodyStyle : "border:1px solid #2a80b9;",
									html      : "<div>contenido por parametro</div>",
									autoLoad  :
									{
										url		: "bd.php",
										params	:
										{
											opc    : "prueba_ajax_load",
											prueba : 1
										}
									}
								}
							]
						},
						{
							xtype : "button",
							id    : "btn_2",
							handler: function () { ajax_load();	},
							cls   : "ic_autorenew_black_36dp",
							text  : "ajax load"
						},
						{
							xtype : "button",
							id    : "btn_2",
							handler: function () { ajax_request();	},
							cls   : "ic_autorenew_black_36dp",
							text  : "ajax request"
						}
						,"->","-",
						{
							xtype : "button",
							id    : "btn_1",
							cls   : "icon-action-black-ic_perm_identity_black_24dp",
							text  : "Salir",
							handler : function(){ alert(4); ventana2(); }
						},"-",
						{
							xtype : "tbtext",
							id    : "btn_1",
							text  : "una demostracion de un texto largo<br>con salto de linea",
						}
					]
				});
			}

			function ventana2(){

				Win_ventana_2 = new Win.Window({
					apply       : "prueba",
					bodyStyle   : "",
					width       : 600,
					height      : 500,
					id          : "Win_ventana_2",
					title       : "VENTANA 2",
					modal       : true,
					autoScroll  : true,
					closable    : true,
					autoDestroy : true,
					tabPanel    :
					[
						{
					        xtype     : "",
					        scripts : true,
					        nocache : true,
					        params  :
					        {
					            var1 : "var1",
					            var2 : "var2",
					        }
					    },
					],
					tbar        :
					[
						{
							xtype : "button",
							id    : "btn_1",
							cls   : "prueba",
							text  : "Nueva<br>Ventana",
							handler : function(){ ventana3(); }
						},
						{
							xtype : "button",
							id    : "btn_2",
							cls   : "prueba",
							// text  : "guardar"
							handler: function () { ajax_load_2();	}
						},
					]
				});
			}

			function ventana3(){
				Win_ventana_3 = new Win.Window({
					apply       : "prueba",
					bodyStyle   : "",
					width       : 400,
					height      : 300,
					id          : "Win_ventana_3",
					title       : "VENTANA 3",
					modal       : true,
					autoScroll  : true,
					closable    : true,
					autoDestroy : true,
					drag        : true,
					resize      : true,
					autoLoad    :
					{
				        url     : ".php",
				        params  :
				        {
				            var1 : "var1",
				            var2 : "var2",
				        }
				    },
				});
			}

			// Win.getButton('btn_1').hiden;
			// prueba = new Win.getButton('btn_1').hiden
			// console.log(prueba)
			// console.log(Win.getButton('btn_1'))


			// array.forEach(function(value,index,element){
			//     console.log(value+'-'+index);
			// });

			// return;
			// AJAX REQUEST
			// Win.Ajax.request({
			// 	url: 'bd.php',
			// 	params: {
			// 		opc: 'prueba_ajax',
			// 		prueba: 1
			// 	},
			// 	success :function (result,xhr){

			//                 if(result == 'true'){ console.log("true"); }
			//                 else{ console.log("false"); }
			//             },
			//           failure : function(xhr){ console.log("fail"); }
			// })


			// text = TEXTO DEL LOADING

			// LOADING DISPONIBLES ELEMENTO loader
			// default
			// loader1
			// loader2
			// loader3

			// duracion : segundos o infinito

			function ajax_load () {
				Win.get('win_window_Win_ventana_1').load({
					url        : 'bd.php',
					text       : 'ajax load text',
					modal      : true,
					params: {
						opc    : 'prueba_ajax_load',
						prueba : 1
					}
				})
			}

			function ajax_request() {
				Win.Ajax.request({
					url            : 'bd.php',
					modal          : true,
					id_ventana     : 'Win_ventana_1',
					text           : 'ajax request text',
					loader         : 'default',
					autoClose      : true,
					textFinish     : 'ajax finalizado',
					iconFinish     : 'warn',
					duracionFinish : '2000',
					params: {
						opc    : 'prueba_ajax_request',
						prueba : 1
					},
					success : function (result,xhr){
				                if(result == 'true'){ console.log("true"); }
				                else{ console.log("false"); }
				            },
				    failure : function(xhr){ console.log("fail"); }
				})
			}

			function ajax_load_2 () {
				Win.get('win_window_Win_ventana_1').load({
					url        : 'bd.php',
					id_ventana : 'Win_ventana_2',
					params: {
						opc    : 'prueba_ajax_load',
						prueba : 1
					}
				})
			}

			function confirm_win() {
				Win.Confirm({title:'title de Confirm', text:'Mensaje de Confirm',functionOK : 'Win.Alert({title:\'Success\', text:\'Ha clickeado en ok buttom\'})'})
			}

		</script>
	</body>
</html>