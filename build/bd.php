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
		// for ($i=0; $i < 50000000; $i++) {
		// 	$temp++;
		// }
		echo'<input type="text" id="inputText" placeholder="inputText"/><br><br>
			<input type="text" id="inputNumber" placeholder="inputNumber"/><br><br>
			<input type="text" id="inputDouble" placeholder="inputDouble"/><br><br>
			<input type="text" id="inputEmail" placeholder="inputEmail"/><br><br>
			<input type="button" onclick="Win.Alert({title:\'title de alert\', text:\'Mensaje de alerta\'})" value="Alert Win">

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
				<div class='win-content-min-load' ><div class='win-content-min-load-img'><div class='win-min-load-ajax'></div></div><div class='win-content-min-load-label'>loading style</div></div>
				<script>
					console.log('ajax load!!!!');
					var style = document.getElementById('MySelect').parentNode.getAttribute('style');
					document.getElementById('MySelect').parentNode.setAttribute('style','text-align:center;padding-top:5px;'+style);
				</script>";
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