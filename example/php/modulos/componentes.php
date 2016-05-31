<div style="padding: 0 5px;">
	<select onchange="load_file(this.value);" style="width:100%;">
		<option value="blank">Seleccione...</option>
		<option value="instalacion">Instalacion</option>
		<option value="temas">Temas</option>
		<option value="api">Api</option>
		<option value="core">Core</option>
		<option value="form">Formulario</option>
		<option value="ajax">Ajax</option>
		<option value="elements">Elements</option>
		<option value="tbar">Tbar</option>
		<option value="ventana">Ventana</option>
		<option value="add">Add</option>
		<option value="ctxmenu">Menu click derecho</option>
	</select>
</div>
<script type="text/javascript">
	load_file = function (file){
		$W.Load({
			idApply : "body-win",
			url     : "php/modulos/"+file+".php",
			params  : {}
		})
	}
</script>