<div class="subtitle">LOADING</div>
<div class="parrafo">
	<div>
		<pre><code class="html" id="loading">
			<?php
$c ='
<script>
	$W.Loading()					// Open, close method

	$W.Loading({timeout:3000})		// Close timeout

	$W.Loading({					// Default open params
		icon     : "loader",
		text     : "Load...",
		loader   : "default",
		idApply  : "",
		timeout  : "",
		iconSize : 100,
		closable : false
	})
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<script>
	hljs.highlightBlock(document.querySelector('#loading'));
	$W.Loading({timeout:3000});
</script>