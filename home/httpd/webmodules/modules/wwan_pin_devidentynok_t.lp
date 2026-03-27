<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_devidentynok_js.lp", getfenv(1))
%>
<div id="DevIdentyNok" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DevIdentyNokBar">&?Pinpublic_001;</h1>
<div id="DevIdentyNok_container" >
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_DevIdentyNok" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<input type="hidden" id="AutoRefreshTime" value="7000">
<form class="formTbl">
<div class="colorTblRow">
<span class="w400">
&?Pinpublic_015;
</span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh_pin" refreshTime="5000" id="Btn_refresh_DevIdentyNok" name="Btn_refresh_DevIdentyNok" value="&?public_003;" />
</div>
</div>
</div>
