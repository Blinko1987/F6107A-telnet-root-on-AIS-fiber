<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_devidentying_js.lp", getfenv(1))
%>
<div id="DevIdentying" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DevIdentyingBar">&?Pinpublic_001;</h1>
<div id="DevIdentying_container" >
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_DevIdentying" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<input type="hidden" id="AutoRefreshTime" value="3000">
<form class="formTbl">
<div class="colorTblRow">
<span class="w400">
&?Pinpublic_014;
</span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh_pin" refreshTime="5000" id="Btn_refresh_DevIdentying" name="Btn_refresh_DevIdentying" value="&?public_003;" />
</div>
</div>
</div>
