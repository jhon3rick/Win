<div class="subtitle">Ventana</div>
<div class="parrafo">
	<div>Elemento Windows</div>
	<input type="button" onclick="ventana1('auto')" value="AutoResize" data-icon="date"/>
	<input type="button" onclick="ventana1('fijo')" value="Fixed" data-icon="date"/>
	<div>
		<pre><code class="html">
			<?php
$c ='
<input type="button" onclick="ventana1(\'auto\')" value="AutoResize" data-icon="date"/>
<input type="button" onclick="ventana1(\'fijo\')" value="Fixed" data-icon="date"/>
<script>
	function ventana1(size){
		var width = 800
		,	height = 500;

		if(size == "auto"){
			width = "calc(100% - 20px)";
			height = "calc(100% - 20px)";
		}

		Win_ventana_1 = new $W.Window({
			width       : width,
			height      : height,
			id          : "Win_ventana_1",
			title       : "VENTANA 1",
			titleStyle  : "",
			scrollY 	: true,
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
			items :
			[
				{
					xtype : "tbar",
					items :
					[
						{
							xtype : "button",
							id    : "btn_1",
							cls   : "user_black_36",
							text  : "Nueva ventana",
							handler : function(){ ventana2(); }
						},
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
						},"--",
						{
							xtype : "tbtext",
							id    : "btn_1",
							text  : "una demostracion de un texto largo<br>con salto de linea",
						}
					]
				}
			]
		});
	}
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>
	hljs.highlightBlock(document.querySelector('pre code'));

	function ventana1(size){
		var width = 800
		,	height = 500;

		if(size == "auto"){
			width = "calc(100% - 20px)";
			height = "calc(100% - 20px)";
		}

		var ajax_request = function(){
			console.log('btn ajax request');
		}

		Win_ventana_1 = new $W.Window({
			width       : width,
			height      : height,
			id          : "Win_ventana_1",
			title       : "VENTANA 1",
			titleStyle  : "",
			scrollY 	: true,
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
			items :
			[
				{
					xtype : "tbar",
					items :
					[
						{
							xtype : "button",
							id    : "btn_1",
							cls   : "user_black_36",
							text  : "Nueva ventana",
							handler : function(){ ventana2(); }
						},
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
						},
						{
							xtype : "button",
							id    : "btn_2",
							width : 60,
							cls   : "ic_autorenew_black_36dp",
							text  : "ajax load",
							handler: function () { ajax_load();	}
						},
						{
							xtype : "button",
							id    : "btn_2",
							width : 60,
							cls   : "ic_autorenew_black_36dp",
							text  : "ajax request",
							handler: function () { ajax_request();	}
						}
						,"->","-",
						{
							xtype : "button",
							id    : "btn_1",
							cls   : "icon-action-black-ic_perm_identity_black_24dp",
							text  : "Salir",
							handler : function(){ alert(4); ventana2(); }
						},"--",
						{
							xtype : "tbtext",
							id    : "btn_1",
							text  : "<div style=\"padding:5px;\">una demostracion de un texto largo<br>con salto de linea</div>",
						}
					]
				}
			]
		});
	}
</script>