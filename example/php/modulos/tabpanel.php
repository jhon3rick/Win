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
					}
				]
			}
		]
	})
</script>