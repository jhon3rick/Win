<?php
	error_reporting(E_ALL ^ E_NOTICE);
	$opc = $_POST['opc'];

	switch ($opc) {
		case 'prueba_ajax':
			prueba_ajax();
			break;

		case 'prueba_ajax_load':
			prueba_ajax_load();
			break;

		case 'prueba_ajax_request':
			prueba_ajax_request();
			break;


		case 'code_tab_panel':
			code_tab_panel();
			break;

		case 'default1':
			default1();
			break;

		case 'default2':
			default2();
			break;

		default:
			default3();
			break;
	}

	function prueba_ajax_request(){
		echo"<div>Hello World!</div>";
	}

	function prueba_ajax_load(){
		echo "<style>
					.MySelect{
						width   : 100px;
						padding : 0;
					}
				</style>
				<select class='MySelect' id='MySelect'>
					<option>Datos</option>
					<option>Datos</option>
					<option>Datos</option>
					<option>Datos</option>
				</select>";
	}

	function prueba_ajax(){
		echo '<div><input type="text" id="input_calendar"></div>
				<script>
					$W.Form.field({
						idApply : "input_calendar",
						format  : "y-m-d",
						type    : "date"
					});
				</script>';
	}

	function code_tab_panel(){ ?>

		<div>
			<pre><code class="html" id="tabpanelColor">
				<?php $c ='
<div id="tab-win"></div>
<script>
	$W.Add({
		idApply : "tab-win",
		items :
		[
			{
				xtype : "tabpanel",
				height : 30,
				items :
				[
					{
						xtype    : "tab",
						title    : "Codigo",
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "code_tab_panel" }
						}
					},
					{
						xtype    : "tab",
						title    : "Tab 1",
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "default1" }
						}
					},
					{
						xtype    : "tab",
						title    : "Tab 2",
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "default2" }
						}
					},
				]
			}
		]
	})
</script>';
					echo htmlentities($c);
				?>
			</code></pre>
		</div>
		<script type="text/javascript">hljs.highlightBlock(document.querySelector('#tabpanelColor'));</script>

	<?php }

	function default1(){
		echo '<div>';
		for ($i=0; $i < 100; $i++) { echo 'yyyyyyyyy '.$i.'<br>'; }
		echo '</div>';
	}

	function default2(){
		echo '<div>';
		for ($i=0; $i < 100; $i++) { echo 'zzzzzzzzz '.$i.'<br>'; }
		echo '</div>';
	}

	function default3(){
		echo '<div>';
		for ($i=0; $i < 100; $i++) { echo 'contenido renderizado '.$i.'<br>'; }
		echo '</div>';
	}
?>