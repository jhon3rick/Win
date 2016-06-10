<div class="subtitle">VENTANA</div>
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
			title       : "Ventana 1",
			scrollY 	: true,
			modal       : true,
			closable    : true,
			autoLoad    :
			{
				url     : "php/bd.php",
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
							xtype    : "panel",
							width    : 110,
							height   : 56,
							title    : "Opciones",
							style    : "text-align:center;",
							html     : "<div>contenido por parametro</div>",
							autoLoad :
							{
								url		: "php/bd.php",
								params	:
								{
									opc : "prueba_ajax_load",
								}
							}
						},"-",
						{
							xtype : "button",
							cls   : "add",
							width : 65,
							text  : "Nueva ventana",
							handler : function(){ ventana2(); }
						},
						{
							xtype : "button",
							width : 65,
							cls   : "load",
							text  : "ajax load",
							handler: function () { alert("Ajax Load"); }
						},
						{
							xtype : "button",
							width : 65,
							cls   : "load",
							text  : "ajax request",
							handler: function () { alert("Ajax Request"); }
						}
						,"->","-",
						{
							xtype : "button",
							cls   : "exit",
							text  : "Salir",
							handler : function(){ Win_ventana_1.close() }
						},"--",
						{
							xtype : "tbtext",
							text  : "<div style=\"padding:5px;\">una demostracion de un texto largo<br>con salto de linea</div>",
						}
					]
				}
			]
		});
	}

	function ventana2(){
		Win_ventana_2 = new $W.Window({
			id          : "Win_ventana_2",
			title       : "Ventana 2",
			width       : 500,
			height      : 400,
			scrollY 	: true,
			modal       : true,
			closable    : true,
			autoLoad    :
			{
				url     : "php/bd.php",
				params  : { }
			},
			items :
			[
				{
					xtype : "tbar",
					items :
					[

						{
							xtype   : "button",
							text    : "Salir",
							cls     : "exit",
							handler : function(){ Win_ventana_2.close(); }
						},"-","->","--",
						{
							xtype : "tbtext",
							style : "text-align:center;",
							text  : "Hello World!",
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

		Win_ventana_1 = new $W.Window({
			width       : width,
			height      : height,
			id          : "Win_ventana_1",
			title       : "Ventana 1",
			scrollY 	: true,
			modal       : true,
			closable    : true,
			autoLoad    :
			{
				url     : "php/bd.php",
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
							xtype    : "panel",
							width    : 110,
							height   : 56,
							title    : "Opciones",
							style    : "text-align:center;",
							html     : "<div>contenido por parametro</div>",
							autoLoad :
							{
								url		: "php/bd.php",
								params	:
								{
									opc : "prueba_ajax_load",
								}
							}
						},'-',
						{
							xtype : "button",
							cls   : "add",
							width : 65,
							text  : "Nueva ventana",
							handler : function(){ ventana2(); }
						},
						{
							xtype : "button",
							width : 65,
							cls   : "load",
							text  : "ajax load",
							handler: function () { alert("Ajax Load"); }
						},
						{
							xtype : "button",
							width : 65,
							cls   : "load",
							text  : "ajax request",
							handler: function () { alert("Ajax Request"); }
						}
						,"->","-",
						{
							xtype : "button",
							cls   : "exit",
							text  : "Salir",
							handler : function(){ Win_ventana_1.close() }
						},"--",
						{
							xtype : "tbtext",
							text  : "<div style=\"padding:5px;\">una demostracion de un texto largo<br>con salto de linea</div>",
						}
					]
				}
			]
		});
	}

	function ventana2(){
		Win_ventana_2 = new $W.Window({
			id          : "Win_ventana_2",
			title       : "Ventana 2",
			width       : 500,
			height      : 400,
			scrollY 	: true,
			modal       : true,
			closable    : true,
			autoLoad    :
			{
				url     : "php/bd.php",
				params  : { }
			},
			items :
			[
				{
					xtype : "tbar",
					items :
					[

						{
							xtype   : "button",
							text    : "Salir",
							cls     : "exit",
							handler : function(){ Win_ventana_2.close(); }
						},"-","->","--",
						{
							xtype : "tbtext",
							style : "text-align:center;",
							text  : "Hello World!",
						}
					]
				}
			]
		});
	}
</script>