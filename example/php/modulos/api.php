<div class="subtitle">API</div>
<div class="parrafo">
	<div>VERSION</div>
	<div>
		<pre><code class="html" id="api1">
			<?php
$c ='
<script>
	console.log($W.version);
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">CAMBIAR TEMA</div>
	<div>
		<pre><code class="html" id="api2">
			<?php
$c ='
<script>
	$W.ini({theme:"light"})	// change theme
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>
	hljs.highlightBlock(document.querySelector('#api1'));
	hljs.highlightBlock(document.querySelector('#api2'));
</script>