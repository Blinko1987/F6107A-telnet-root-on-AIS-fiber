<%
cgilua_lp.include("../../webmodules/modules/firewall_filterglobal_js.lp", getfenv(1))
%>
<div id="SecurityGlobalCtl" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_filterglobal_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SecurityGlobalCtlBar">&?Security_067;</h1>
<div id="SecurityGlobalCtl_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_SecurityGlobalCtl">
<form class="form_content">
<div id="changeArea_SecurityGlobalCtl" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div id="macfilter_div">
<div class="row">
<label class="cfgLabel w130">&?Security_042;</label>
<div class="right" id="MacFilterEnable">
<input type="radio" id="MacFilterEnable1" name="MacFilterEnable" value="1"/><label for="MacFilterEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="MacFilterEnable0" name="MacFilterEnable" value="0"/><label for="MacFilterEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label id="lab_Mac" class="cfgLabel w130">&nbsp;</label>
<div id="div_Mac" class="right">
&?public_068;&nbsp;&nbsp;
<select class="w100" id="MacFilterTarget" name="MacFilterTarget" class="w100">
<option value="Discard" title='&?Security_039;'>&?Security_039;</option>
<option value="Permit" title='&?Security_040;'>&?Security_040;</option>
</select>
</div>
</div>
<div class="segmentRow">
</div>
</div>
<div class="row" id="div_UrlFilterEnable">
<label class="cfgLabel w130">&?Security_043;</label>
<div class="right" id="UrlFilterEnable">
<input type="radio" id="UrlFilterEnable1" name="UrlFilterEnable" value="1"/><label for="UrlFilterEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="UrlFilterEnable0" name="UrlFilterEnable" value="0"/><label for="UrlFilterEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_UrlFilterTarget">
<label id="lab_Url" class="cfgLabel w130">&nbsp;</label>
<div id="div_Url" class="right">
&?public_068;&nbsp;&nbsp;
<select class="w100" id="UrlFilterTarget" name="UrlFilterTarget" class="w100">
<option value="0" title='&?Security_039;'>&?Security_039;</option>
<option value="1" title='&?Security_040;'>&?Security_040;</option>
</select>
</div>
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
