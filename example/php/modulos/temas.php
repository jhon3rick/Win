<div class="subtitle">TEMAS</div>
<div class="parrafo">
	<div>Insertar el CSS del tema deseado</div>
	<div>
		<pre><code class="html">
			<?php
$c ='
<link rel="stylesheet" href="js/winJs/css/Win-theme-dark.min.css" />
<link rel="stylesheet" href="js/winJs/css/Win-theme-light.min.css" />
<link rel="stylesheet" href="js/winJs/css/Win-theme-blue.min.css" />
<link rel="stylesheet" href="js/winJs/css/Win-theme-dark-blue.min.css" />
<link rel="stylesheet" href="js/winJs/css/Win-theme-green.min.css" />
<link rel="stylesheet" href="js/winJs/css/Win-theme-red.min.css" />';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>hljs.highlightBlock(document.querySelector('pre code'));</script>