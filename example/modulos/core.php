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
	$W(".parrafo > div").html("tapquo");						// Captura varios nodos que cumplen la condicion
	$W(".parrafo > div").html("tapquo").style("color", "red")	// Anidacion de funciones
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>hljs.highlightBlock(document.querySelector('pre code'));</script>