<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_pinsimfail_js.lp", getfenv(1))
%>
<div id="PinSimFail" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PinSimFailBar">&?Pinpublic_001;</h1>
<div id="PinSimFail_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_PinSimFail" class="formTblWrap">
<input type="hidden" id="AutoRefreshTime" value="7000">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="formTbl">
<div class="colorTblRow">
<span class="w400">
&?PinSimFail_001;
</span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh_pin" refreshTime="1000" id="Btn_refresh_PinSimFail" name="Btn_refresh_PinSimFail" value="&?public_003;" />
</div>
</div>
</div>
