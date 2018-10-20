<div class="subtitle">AJAX</div>
<div class="parrafo">
	<div>AJAX LOAD</div>
	<div>
		<pre><code class="html" id="api1">
			<?php
$c ='
<div id="div-load"></div>
<script>
	$W.Load({
		idApply : "div-load",
		url     : "php/modulos/file.php",
		params  : {}
	})
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="parrafo">
	<div style="margin-top: 15px;">AJAX REQUEST</div>
	<div id="addTbar"></div>
	<div>
		<pre><code class="html" id="api2">
			<?php
$c ='
$W.Add({
	idApply : "addTbar",
	tbar    :
	[
		{
			xtype     : "button",
			text      : "Ajax success",
			scale     : "large",
			cls       : "add",
			iconAlign : "top",
			handler   : function(){ ajax("success") }
		},
		{
			xtype     : "button",
			text      : "Ajax failure",
			scale     : "large",
			cls       : "add",
			iconAlign : "top",
			handler   : function(){ ajax("failure") }
		}
	]
})

function ajax(opc){
	$W.Loading();
	var opc = opc=="success"? "method_ajax": "method_ajax_failure";
	$W.Ajax({
		url    : "php/bd.php",
		params :  { opc : opc },
		timeout : 2000,
		success : function(result,xhr){
			alert(result.responseText)
			$W.Loading();
		},
		failure : function(xhr){  
			console.log("fail"); 
			$W.Loading(); 
		}
	})
}';
			echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<script>
	hljs.highlightBlock(document.querySelector('#api1'));
	hljs.highlightBlock(document.querySelector('#api2'));

	$W.Add({
		idApply : "addTbar",
		tbar    :
		[
			{
				xtype     : "button",
				text      : "Ajax success",
				scale     : "large",
				cls       : "add",
				iconAlign : "top",
				handler   : function(){ ajax("success") }
			},
			{
				xtype     : "button",
				text      : "Ajax failure",
				scale     : "large",
				cls       : "add",
				iconAlign : "top",
				handler   : function(){ ajax("failure") }
			}
		]
	})

	function ajax(opc){
		$W.Loading();
		var opc = opc=="success"? "method_ajax": "method_ajax_failure";
		$W.Ajax({
			url    : "php/bd.php",
			params :  { opc : opc },
			timeout : 2000,
			success : function(result,xhr){
				alert(result.responseText)
				$W.Loading();
			},
			failure : function(xhr){  
				console.log("fail"); 
				$W.Loading(); 
			}
		})
	}
</script>