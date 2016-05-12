<div class="subtitle">Validacion Feld</div>
<div class="parrafo">
	<div>Field Text</div>
	<input type="text" id="inputInteger" class="inputForm" placeholder="inputInteger" data-icon="add" />
	<div>
		<pre><code class="html" id="fieldText">
			<?php
$c ='
<input type="text" id="inputInteger"/>
<script>
	$W.Form.field({
		idApply : "inputInteger",
		type    : "integer"		// integer, double, email, mayuscula, minuscula
	});
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">Field Date</div>
	<input type="text" id="inputDate" class="inputForm" placeholder="inputDate"/>
	<div>
		<pre><code class="html" id="fieldDate">
			<?php
$c ='
<input type="text" id="inputDate"/>
<script>
	$W.Form.field({
		idApply   : "inputDate",
		format    : "y-m-d",
		type      : "date",
		listeners : { select: function(j) { alert(j) } }
	});
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<!-- =================================================================================== -->

<div class="subtitle">Validacion Field Parent</div>
<div class="parrafo" id="form-validate">
	<input type="text" placeholder="inputInteger" data-icon="add" data-validate="uppercase"/>
	<input type="text" placeholder="inputInteger" data-icon="add" data-validate="integer"/>
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

	// $W.Form.field({
	// 	idApply : "inputInteger",
	// 	type    : "integer"		// integer, double, email, text, upercase, lowercase
	// });

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