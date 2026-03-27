<%
cgilua_lp.include("../../webmodules/modules/wlan_wps_btn_js.lp", getfenv(1))
%>
<div id="WPSBtn" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_wps_btn_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WPSBtnBar">&?wpsbtn_001;</h1>
<div id="WPSBtn_container" class="formTblWrap">
<input type="hidden" id="DataHasBeenGot" value="1">
<input type="hidden" id="Msg">
<div id="template_WPSBtn" class="formTbl">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="Button longBtn" id="Btn_WPSBtn" name="Btn_WPSBtn" value="&?wpsbtn_001;" />
</div>
</div>
</div>
</div>
