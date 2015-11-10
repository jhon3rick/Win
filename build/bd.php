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

	function prueba_ajax(){
		for ($i=0; $i < 50000000; $i++) {
			$temp++;
		}
		echo'<input type="text" id="inputText" placeholder="inputText"/><br><br>
			<input type="text" id="inputNumber" placeholder="inputNumber"/><br><br>
			<input type="text" id="inputDouble" placeholder="inputDouble"/><br><br>
			<input type="text" id="inputEmail" placeholder="inputEmail"/><br><br>
			<script>

				new Win.form.intField({
					applyTo : \'inputNumber\'
				});

				new Win.form.textField({
					applyTo : \'inputText\',
					type: \'lowercase\'
				});

				new Win.form.emailField({
					applyTo : \'inputEmail\'
				});

				new Win.form.doubleField({
					applyTo : \'inputDouble\'
				});
			</script>';
	}

	function prueba_ajax_load(){
		for ($i=0; $i < 50000000; $i++) {
			$temp++;
		}
		echo "<script>alert('Load!!!');</script> Contenido Load <script>console.log('in');</script>";
	}

	function prueba_ajax_request(){
		for ($i=0; $i < 50000000; $i++) {
			$temp++;
		}
		echo 'true';
	}

	function default_function()
	{
		for ($i=0; $i < 100; $i++) {
			echo 'gtgjjg <br>';
		}
	}


?>