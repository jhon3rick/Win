<div class="subtitle">Tbar</div>
<div class="parrafo">
	<div id="div1">Probar Click derecho aqui!</div>
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
				text    : "Eliminar1",
				cls     : "delete",
				handler : function(a){ a.color="red" }
			},
			{
				text    : "Eliminar2",
				cls     : "delete1",
				handler : function(p){ console.log(p); }
			},
			{
				text    : "Eliminar3",
				cls     : "delete3",
				handler : function(t){ console.log(t); }
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
				text    : "Eliminar1",
				cls     : "delete",
				handler : function(div){ console.log(div); div.color="red" }
			},
			{
				text    : "Eliminar2",
				cls     : "delete1",
				handler : function(p){ console.log(p); }
			},
			{
				text    : "Eliminar3",
				cls     : "delete3",
				handler : function(t){ console.log(t); }
			}
		]
	})
</script>