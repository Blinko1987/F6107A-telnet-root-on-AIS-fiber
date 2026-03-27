<%
cgilua_lp.include("../../webmodules/modules/firewall_config_js.lp", getfenv(1))
%>
<div id="FirewallConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_config_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="FirewallConfBar">&?Security_061;</h1>
<div id="FirewallConf_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?Security_004;</a></div>
<div class="sceneTip_container">
<p>
<span>&?Security_008;</span><br />
<span>&?Security_005;</span><br />
<span>&?Security_007;</span><br />
</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_FirewallConf">
<form class="form_content">
<div id="changeArea_FirewallConf" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="Enable" class="cfgLabel w130">&?Pinpublic_013;</label>
<div class="right">
<input type="checkbox" id="Enable" name="Enable" value=1/>
</div>
</div>
<div id="Level">
<p class="row"><label class="cfgLabel w130">&?Security_047;</label><input type="radio" id="Level3" name="Level" value="High" />&nbsp;&nbsp;<label for="Level3">&?Security_009;</label></p>
<p class="row"><label class="cfgLabel w130">&nbsp;</label><input type="radio" id="Level2" name="Level" value="Middle" />&nbsp;&nbsp;<label for="Level2">&?Security_010;</label></p>
<p class="row"><label class="cfgLabel w130">&nbsp;</label><input type="radio" id="Level1" name="Level" value="Low"/>&nbsp;&nbsp;<label for="Level1">&?Security_011;</label></p>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_FirewallConf" name="Btn_cancel_FirewallConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_FirewallConf" name="Btn_apply_FirewallConf" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
