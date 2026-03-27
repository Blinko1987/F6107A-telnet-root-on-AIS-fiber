<%
cgilua_lp.include("../../webmodules/modules/web_login_timeout_js.lp", getfenv(1))
%>
<div id="LoginTimeout" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=web_login_timeout_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LoginTimeoutBar">&?LoginTimeout_001;</h1>
<div id="LoginTimeout_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_LoginTimeout">
<div id="changeArea_LoginTimeout" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<div class="row">
<label for="Timeout" class="cfgLabel w80">&?LoginTimeout_002;</label>
<div class="right">
<input type="text" id="Timeout" name="Timeout" value="" class="inputNorm"/>&?public_012;
<span style="display:none;">&?public_072;1 ~ 30</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_LoginTimeout" name="Btn_cancel_LoginTimeout" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_LoginTimeout" name="Btn_apply_LoginTimeout" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
