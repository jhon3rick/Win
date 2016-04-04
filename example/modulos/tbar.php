<div class="subtitle">Tbar</div>
<div class="parrafo">
	<div id="div1"></div>
	<div>
		<pre><code class="html" id="tbarColor">
			<?php
$c ='
<div id="div1"></div>
<script>
	$W.Tbar({
		idApply : "div1",
		items   :
		[
			{
				xtype   : "button",
				cls     : "user_black_36",
				text    : "Nueva ventana",
				handler : function(){ prueba(); }
			},
			{
				xtype    : "panel",
				title    : "prueba",
				width    : 160,
				html     : "<div>contenido por parametro</div>",
				autoLoad :
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
				cls   : "ic_autorenew_black_36dp",
				text  : "ajax load",
				handler: function () { ajax_load();	}
			},"--",
			{
				xtype : "button",
				cls   : "ic_autorenew_black_36dp",
				text  : "ajax request",
				handler: function () { ajax_request();	}
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
		idApply : "div1",
		items   :
		[
			{
				xtype   : "button",
				cls     : "user_black_36",
				text    : "Nueva ventana",
				handler : function(){ prueba(); }
			},
			{
				xtype    : "panel",
				title    : "prueba",
				width    : 160,
				html     : "<div>contenido por parametro</div>",
				autoLoad :
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
				cls   : "ic_autorenew_black_36dp",
				text  : "ajax load",
				handler: function () { ajax_load();	}
			},"--",
			{
				xtype : "button",
				cls   : "ic_autorenew_black_36dp",
				text  : "ajax request",
				handler: function () { ajax_request();	}
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
</script>