<div class="subtitle">ANIDACION DE FUNCIONES</div>
<div class="parrafo">
	<div>
		<pre><code class="html" id="fn">
			<?php
$c ='
<div class="parrafo">
    <div>Primer Div</div>
    <div>Segundo Div</div>
</div>
<script>
	$W(".parrafo > div").html("<div>text 1</div>");					  // Captura varios nodos que cumplen la condicion
	$W(".parrafo > div").html("<div>text 2</div>").style("color", "red");   // Anidacion de funciones
</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<div class="subtitle">CORE</div>
<div class="parrafo">
	<div>
		<pre><code class="html" id="core">
			<?php
$c ='
<script>

	$W("#id").html();							// Get html
	$W("#id").html("<div></div>");				// Set html

	$W("#id").append("<div></div>");			// Add child after to end
	$W("#id").prepend("<div></div>");			// Add child before to start
	$W("#id").text();							// Get Text in html
	$W("#id").text("text");						// Set Text in html
	$W("#id").remove("");						// Remove attribute

	$W("#id").attr("attribute","value");			// Set attribute
	$W("#id").attr("attribute");					// Get attribute
	$W("#id").removeAttr("attribute");			// Remove attribute

	$W("#id").data("attribute");					// Get attribute
	$W("#id").data("attribute", "value");			// Set attribute
	$W("#id").removeData("attribute");			// Set attribute

	$W("#id").val("Value input");					// Set attribute
	$W("#id").val();							// Get attribute

	// STYLE
	$W("#id").show();							// Display Block
	$W("#id").hide();							// Display None

	$W("#id").addClass("class");					// Add class
	$W("#id").removeClass("class");				// Remove class

	$W("#id").css("property", "value");			// Add css
	$W("#id").style("property", "value");			// Add css
	$W("#id").vendor("property", "value");			// Add css prefix

	// EVENTS
	$W("#id").on("click", function(){ alert("prueba"); }); // Add event click

</script>';
				echo htmlentities($c);
			?>
		</code></pre>
	</div>
</div>

<script>
	hljs.highlightBlock(document.querySelector('#fn'));
	hljs.highlightBlock(document.querySelector('#core'));
</script>