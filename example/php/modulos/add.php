<div class="subtitle">ADD BOTON</div>
<div class="parrafo">
	<div id="addBtn"></div>
	<div>
		<pre><code class="html" id="add1">
			<?php
$c ='
<div id="addBtn"></div>
<script>
	$W.Add({
		idApply : "addBtn",
		items   :
		[
			{
				xtype     : "button",
				text      : "New",
				scale     : "large",
				cls       : "add",
				iconAlign : "top",
				handler   : function(){ alert(1) }
			}
		]
	})
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="subtitle">ADD TBAR Y ADD BOTON AL TBAR</div>
<div class="parrafo">
	<div id="addTbar"></div>
	<div>
		<pre><code class="html" id="add2">
			<?php
$c ='
<div id="addTbar"></div>
<script>
	$W.Add({
		idApply : "addTbar",
		items   :
		[
			{
				xtype : "tbar",
				id    : "tbar_btn",
				items :
				[
					{
						xtype     : "button",
						text      : "New",
						scale     : "large",
						cls       : "add",
						iconAlign : "top",
						handler   : function(){ alert(1) }
					}
				]

			}
		]
	})

	$W.Add({
		idApply : "tbar_btn",
		items   :
		[
			{
				xtype     : "button",
				text      : "Update",
				scale     : "large",
				cls       : "load",
				iconAlign : "top",
				handler   : function(){ alert(2) }
			}
		]
	})
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>
<style type="text/css">pre{margin: 5px 20px;}</style>
<script>
	hljs.highlightBlock(document.querySelector('#add1'));
	hljs.highlightBlock(document.querySelector('#add2'));

	$W.Add({
		idApply : "addBtn",
		items   :
		[
			{
				xtype     : "button",
				text      : "New",
				scale     : "large",
				cls       : "add",
				iconAlign : "top",
				handler   : function(){ alert(1) }
			}
		]
	})

	$W.Add({
		idApply : "addTbar",
		items   :
		[
			{
				xtype : "tbar",
				id    : "tbar_btn",
				items :
				[
					{
						xtype     : "button",
						text      : "New",
						scale     : "large",
						cls       : "add",
						iconAlign : "top",
						handler   : function(){ alert(1) }
					}
				]

			}
		]
	})

	$W.Add({
		idApply : "tbar_btn",
		items   :
		[
			{
				xtype     : "button",
				text      : "Update",
				scale     : "large",
				cls       : "load",
				iconAlign : "top",
				handler   : function(){ alert(2) }
			}
		]
	})
</script>