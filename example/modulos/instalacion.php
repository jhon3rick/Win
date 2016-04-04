<div class="subtitle">INSTALACION</div>
<div class="parrafo">
	<div>Insertar en el archivo index</div>
	<div>
		<pre><code class="html">
			<?php
$c ='
<script src="dist/js/Win.min.js"></script>
<link rel="stylesheet" href="css/normalize.css" />
<link rel="stylesheet" href="css/Win.css" />
<link rel="stylesheet" href="css/Win-loaders.css" />
<link rel="stylesheet" href="css/icon.css" />';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>hljs.highlightBlock(document.querySelector('pre code'));</script>