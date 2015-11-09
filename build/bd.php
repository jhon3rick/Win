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

		default:
			default_function();
			break;
	}

	function prueba_ajax(){
		echo "true";
	}

	function prueba_ajax_load(){
		echo "<script>alert('Load!!!');</script> Contenido Load <script>console.log('in');</script>";
	}

	function default_function()
	{
		for ($i=0; $i < 100; $i++) {
			echo 'gtgjjg <br>';
		}
	}


?>