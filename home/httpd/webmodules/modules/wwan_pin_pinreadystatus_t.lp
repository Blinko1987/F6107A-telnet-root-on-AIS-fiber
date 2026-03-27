<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_pinreadystatus_js.lp", getfenv(1))
%>
<div id="PinReadyStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PinReadyStatusBar">&?Pinpublic_001;</h1>
<div id="PinReadyStatus_container" >
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_PinReadyStatus" class="formTblWrap">
<input type="hidden" id="AutoRefreshTime" value="10000">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="formTbl">
<div class="colorTblRow">
<input type="hidden" id="PinStatus" value="">
<span class="200px">
<span>&?Pinpublic_011;</span>
<span id="C_PinStatus"></span>
<span id="C_error_PinStatus" style="display:none;">&?PinReadyStatus_005;</span>
</span>
</div>
<div class="colorTblRow">
<span class="w400">
&?PinReadyStatus_001;
</span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh_pin" id="Btn_refresh_PinReadyStatus" name="Btn_refresh_PinReadyStatus" value="&?public_003;" />
</div>
</div>
</div>
