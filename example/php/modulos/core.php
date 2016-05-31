<div class="subtitle">CORE</div>
<div class="parrafo">
	<div>
		<pre><code class="html" id="api1">
			<?php
$c ='
<div class="parrafo">
    <div>Primer Div</div>
    <div>Segundo Div</div>
</div>
<script>
	$W(".parrafo > div").html("<div>text 1</div>");					  // Captura varios nodos que cumplen la condicion
	$W(".parrafo > div").html("<div>text 2</div>").style("color", "red");   // Anidacion de funciones
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>hljs.highlightBlock(document.querySelector('pre code'));</script>