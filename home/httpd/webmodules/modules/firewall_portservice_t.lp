<%
cgilua_lp.include("../../webmodules/modules/firewall_portservice_js.lp", getfenv(1))
%>
<div id="ServPortCfg" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_portservice_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ServPortCfgBar">&?Security_060;</h1>
<div id="ServPortCfg_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_ServPortCfg" class="formTblWrap">
<form class="form_content">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstNum">
<div id="div_ServPortRule" style="display:none;">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="ServPort" class="cfgLabel w100"><span id="ServName" name="ServName"></span></label>
<div class="right">
<input type="text" class="inputNorm" id="ServPort" name="ServPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_ServPortCfg" name="Btn_cancel_ServPortCfg" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_ServPortCfg" name="Btn_apply_ServPortCfg" value="&?public_018;" />
</div>
</div>
</form>
</div>
</div>
</div>
