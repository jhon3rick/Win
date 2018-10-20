<div class="subtitle">TBAR</div>
<div class="parrafo">
	<div id="divTbar"></div>
	<div>
		<pre><code class="html" id="tbarColor">
			<?php
$c ='
<div id="divTbar"></div>
<script>
	$W.Tbar({
		idApply : "divTbar",
		items   :
		[
			{
				xtype    : "panel",
				title    : "Opciones",
				width    : 110,
				style    : "text-align:center;",
				html     : "<div>contenido por parametro</div>",
				autoLoad :
				{
					url		: "php/bd.php",
					params	:
					{
						opc    : "prueba_ajax_load",
						prueba : 1
					}
				}
			},"-",
			{
				xtype   : "button",
				width   : 65,
				cls     : "add",
				text    : "Nueva ventana",
				handler : function(){ alert("Nueva Ventana");  }
			},

			{
				xtype   : "button",
				width   : 65,
				cls     : "load",
				text    : "ajax load",
				handler : function () { ajax_load();	}
			},"--",
			{
				xtype   : "button",
				width   : 65,
				cls     : "load",
				text    : "ajax request",
				handler : function () { ajax_request();	}
			}
			,"->","-",
			{
				xtype : "tbtext",
				width : 160,
				text  : "una demostracion de un texto largo<br>con salto de linea",
				style : ""
			}
		]
	});

	ajax_load = function(){ alert("Ajax Load"); }
	ajax_request = function(){ alert("Ajax Request"); }
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<style type="text/css">pre{margin: 5px 20px;}</style>
<script>
	hljs.highlightBlock(document.querySelector('#tbarColor'));

	$W.Tbar({
		idApply : "divTbar",
		items   :
		[
			{
				xtype    : "panel",
				title    : "Opciones",
				width    : 110,
				style    : "text-align:center;",
				html     : "<div>contenido por parametro</div>",
				autoLoad :
				{
					url		: "php/bd.php",
					params	:
					{
						opc    : "prueba_ajax_load",
						prueba : 1
					}
				}
			},"-",
			{
				xtype   : "button",
				width   : 65,
				cls     : "add",
				text    : "Nueva ventana",
				handler : function(){ alert("Nueva Ventana");  }
			},

			{
				xtype   : "button",
				width   : 65,
				cls     : "load",
				text    : "ajax load",
				handler : function () { ajax_load();	}
			},"--",
			{
				xtype   : "button",
				width   : 65,
				cls     : "load",
				text    : "ajax request",
				handler : function () { ajax_request();	}
			}
			,"->","-",
			{
				xtype : "tbtext",
				width : 160,
				text  : "una demostracion de un texto largo<br>con salto de linea",
				style : ""
			}
		]
	});

	ajax_load = function(){ alert("Ajax Load"); }
	ajax_request = function(){ alert("Ajax Request"); }
</script>