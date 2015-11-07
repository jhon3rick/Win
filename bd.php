<?php
	error_reporting(E_ALL ^ E_NOTICE);
	$opc = $_GET['opc'];
	switch ($opc) {
		case 'prueba_ajax':
			prueba_ajax();
			break;

		default:
			default_function();
			break;
	}

	function prueba_ajax(){
		echo "true";
	}

	function default_function()
	{
		for ($i=0; $i < 100; $i++) {
			echo 'gtgjjg <br>';
		}
	}


?>