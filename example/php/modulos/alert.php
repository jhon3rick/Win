<div class="subtitle">LOADING</div>
<div class="parrafo">
	<div>
		<pre><code class="html" id="loading">
			<?php
$c ='
<script>
	$W.Alert("Este es un alert")					// Open method message
	$W.Alert()					// Close method

	$W.Alert({timeout:3000})		// Close timeout

	$W.Alert({					// Default open params
		text     : \'\',
		title    : \'Aviso!\',
		timeout  : \'\',
		closable : true
	})
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<script>
	hljs.highlightBlock(document.querySelector('#loading'));

	$W.Alert("Este es un alert");
</script>