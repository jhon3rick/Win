<div class="subtitle">VALIDACION FELD FORMULARIO</div>
<div class="parrafo">
	<div style="margin: 15px 5px;">Field Text</div>
	<input type="text" id="inputInteger" class="inputForm" placeholder="inputInteger" data-icon="add" />
	<div>
		<pre><code class="html" id="fieldText">
			<?php
$c ='
<input type="text" id="inputInteger"/>
<script>
	$W.Form.field({
		idApply : "inputInteger",
		type    : "integer"		// integer, double, email, uppercase, lowercase
	});
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin: 15px 5px;">Field Date</div>
	<input type="text" id="inputDate" class="inputForm" placeholder="inputDate" value="2016-11-21"/>
	<div>
		<pre><code class="html" id="fieldDate">
			<?php
$c ='
<input type="text" id="inputDate"/>
<script>
	$W.Form.field({
		idApply   : "inputDate",
		format    : "y-m-d",
		type      : "date"
	});
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<!-- =================================================================================== -->

<div class="parrafo" id="form-validate">
	<div style="margin: 15px 5px;">Validacion Field Parent</div>
	<input style="margin: 5px 0;" type="text" placeholder="uppercase" data-icon="add" data-validate="uppercase"/><br>
	<input style="margin: 5px 0;" type="text" placeholder="integer" data-icon="add" data-validate="integer"/>
	<div>
		<pre><code class="html" id="fieldParent">
			<?php
$c ='
<div id="form-validate">
    <input type="text" data-validate="uppercase"/>
    <input type="text" data-validate="integer"/>
</div>
<script>
	$W.Form.validate("form-validate");
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<script>
	$W.Form.validate("form-validate");

	$W.Form.field({
		idApply : "inputInteger",
		type    : "integer"		// integer, double, email, text, uppercase, lowercase
	});

	$W.Form.field({
		idApply   : "inputDate",
		format    : "y-m-d",
		type      : "date",
		listeners : { select: function(j) { alert(j) } }
	});

	hljs.highlightBlock(document.querySelector('#fieldText'));
	hljs.highlightBlock(document.querySelector('#fieldDate'));
	hljs.highlightBlock(document.querySelector('#fieldParent'));
</script>