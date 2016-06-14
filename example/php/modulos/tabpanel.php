<div class="subtitle">Tab Panel</div>
<div class="parrafo" style="height: calc(100% - 44px);">
	<div id="tab-win"></div>
</div>
<style type="text/css">pre{margin: 5px 20px;}</style>
<script>
	$W.Add({
		idApply : "tab-win",
		items :
		[
			{
				xtype : "tabpanel",
				id    : "idTabPanel",
				items :
				[
					{
						xtype    : "tab",
						title    : "Codigo",
						scrollY  : true,
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "code_tab_panel" }
						}
					},
					{
						xtype    : "tab",
						title    : "Selected and State",
						selected : true,
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "state_tab_panel" }
						}
					},
					{
						xtype    : "tab",
						title    : "Tab 2",
						scrollY  : true,
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "default1" }
						}
					},
					{
						xtype    : "tab",
						id       : "idTab",
						title    : "Tab disable Json",
						state    : "disable",
						autoLoad :
						{
							url    : "php/bd.php",
							params : { opc : "default2" }
						}
					}
				]
			}
		]
	})
</script>