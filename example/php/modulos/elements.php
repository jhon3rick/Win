<div class="subtitle">ELEMENTS</div>
<div class="parrafo">
	<div>Hidden</div>
	<div>
		<pre><code class="html" id="ocultar">
			<?php
$c ='
<script>
	$W.Element("id").hidden();
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">Show</div>
	<div>
		<pre><code class="html" id="mostrar">
			<?php
$c ='
<script>
	$W.Element("id").show();
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">Disable</div>
	<div>
		<pre><code class="html" id="disable">
			<?php
$c ='
<script>
	$W.Element("id").disable();
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">Enable</div>
	<div>
		<pre><code class="html" id="enable">
			<?php
$c ='
<script>
	$W.Element("id").enable();
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">Bloquea Boton</div>
	<div>
		<pre><code class="html" id="boton">
			<?php
$c ='
<script>
	$W.BlockBtn("id");
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<script>
	hljs.highlightBlock(document.querySelector('#ocultar'));
	hljs.highlightBlock(document.querySelector('#mostrar'));
	hljs.highlightBlock(document.querySelector('#enable'));
	hljs.highlightBlock(document.querySelector('#disable'));
	hljs.highlightBlock(document.querySelector('#boton'));
</script>