<div class="subtitle">INSTALACION</div>
<div class="parrafo">
	<div>INSERTAR EN EL ARCHIVO INDEX</div>
	<div>
		<pre><code class="html">
			<?php
$c ='
<link rel="stylesheet" href="js/winJs/css/Win.min.css" />
<link rel="stylesheet" href="js/winJs/css/Win-theme-blue.min.css" />
<link rel="stylesheet" href="css/icon.css" />

<script src="js/winJs/js/Win.min.js"></script>
';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>hljs.highlightBlock(document.querySelector('pre code'));</script>