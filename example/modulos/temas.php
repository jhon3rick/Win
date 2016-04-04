<div class="subtitle">Temas</div>
<div class="parrafo">
	<div>Insertar el CSS del tema deseado</div>
	<div>
		<pre><code class="html">
			<?php
$c ='
<link rel="stylesheet" href="css/Win-theme-dark.css" />
<link rel="stylesheet" href="css/Win-theme-light.css" />
<link rel="stylesheet" href="css/Win-theme-blue.css" />
<link rel="stylesheet" href="css/Win-theme-dark-blue.css" />
<link rel="stylesheet" href="css/Win-theme-green.css" />
<link rel="stylesheet" href="css/Win-theme-red.css" />';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>hljs.highlightBlock(document.querySelector('pre code'));</script>