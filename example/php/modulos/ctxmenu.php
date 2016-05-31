<div class="parrafo">
	<div id="div1">PROBAR CLICK DERECHO AQUI!</div>
	<div>
		<pre><code class="html" id="tbarColor">
			<?php
$c ='
<div id="div1"></div>
<script>
	$W.CtxMenu({
		idApply : "title_win",
		items   :
		[
			{
				text    : "Pintar en Rojo",
				cls     : "delete",
				handler : function(){ document.getElementById("div1").style.color="red" }
			},
			{
				text    : "Pintar en azul",
				cls     : "delete1",
				handler : function(){ document.getElementById("div1").style.color="blue" }
			},
			{
				text    : "Opcion 3",
				cls     : "delete3",
				handler : function(){ alert("Opcion 3"); }
			}
		]
	})
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<style type="text/css">pre{margin: 5px 20px;}</style>
<script>
	hljs.highlightBlock(document.querySelector('#tbarColor'));

	$W.CtxMenu({
		idApply : "div1",
		items   :
		[
			{
				text    : "Pintar en Rojo",
				cls     : "delete",
				handler : function(){ document.getElementById("div1").style.color="red" }
			},
			{
				text    : "Pntar en azul",
				cls     : "delete1",
				handler : function(){  document.getElementById("div1").style.color="blue" }
			},
			{
				text    : "Opcion 3",
				cls     : "delete3",
				handler : function(){ alert("Opcion 3"); }
			}
		]
	})
</script>