<?php
	error_reporting(E_ALL ^ E_NOTICE);
	$opc = $_GET['opc'];
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

		default:
			default_function();
			break;
	}

	function prueba_ajax(){ echo'Mi primera ventana'; }

	function prueba_ajax_load(){
		echo "<style>
					.MySelect{
						width : 100px;
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

	function prueba_ajax_request(){
		echo '<div><input type="text" id="input_calendar"></div>
				<script>
					$W.form.dateField({
						applyTo   : "input_calendar",
						format    : "y-m-d",
						listeners : { select: function() { alert("Haz seleccionado la fecha "+this.value) } }
					});
				</script>';
	}

	function default_function() { for ($i=0; $i < 100; $i++) { echo 'contenido renderizado <br>'; } }


?>