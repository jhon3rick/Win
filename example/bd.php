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
				</select>
				<div class='win-content-min-load'>
					<div class='win-content-min-load-img'></div>
					<div class='win-min-load-ajax'></div>
				</div>
				<div class='win-content-min-load-label'>loading style</div>";
	}

	function prueba_ajax_request(){ echo 'true'; }

	function default_function() { for ($i=0; $i < 100; $i++) { echo 'gtgjjg <br>'; } }


?>