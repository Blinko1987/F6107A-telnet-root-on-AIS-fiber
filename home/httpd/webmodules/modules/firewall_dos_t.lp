<%
cgilua_lp.include("../../webmodules/modules/firewall_dos_js.lp", getfenv(1))
%>
<div id="FirewallDos" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_dos_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="FirewallConfBar">&?Security_003;</h1>
<div id="FirewallDos_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_FirewallDos" style="display:none;">
<div id="topLine_FirewallDos" class="formTblCtrlBar">
<span id="instName_FirewallDos" class="instName collapsibleInst" title="&?Security_003;">&?Security_069;</span>
</div>
<div id="changeArea_FirewallDos" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<div class="staticInfoHint"><p>&?Security_071;</p></div>
<div class="row">
<label for="Enable" class="cfgLabel w130">&?Pinpublic_013;</label>
<div class="right">
<input type="checkbox" id="Enable" name="Enable" value=""/>
</div>
</div>
<div class="row">
<label for="Threshold" class="cfgLabel w130">&?Security_068;</label>
<div class="right">
<input class="inputNorm" type="text" id="Threshold" name="Threshold" value=""/>
<span style="display:none;">&?public_072;1 ~ 65535</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_FirewallConf" name="Btn_cancel_FirewallConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_FirewallConf" name="Btn_apply_FirewallConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
