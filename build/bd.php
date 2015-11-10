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
		echo "<script>alert('Load!!!');</script> Contenido Load <script>console.log('in');</script>";
	}

	function default_function()
	{
		for ($i=0; $i < 100; $i++) {
			echo 'gtgjjg <br>';
		}
	}


?>