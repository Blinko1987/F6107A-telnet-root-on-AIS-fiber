<%
cgilua_lp.include("../../webmodules/modules/wlan_wps_js.lp", getfenv(1))
%>
<div class="instCfgArea">
<div id="WPS" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_wps_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WPSBar">&?WPS_001;</h1>
<div id="WPS_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?WPS_011;</a></div>
<div class="sceneTip_container">
<p>&?WPS_014;</p>
<%
if (_G.ssidConf.WpsPIN == true) then
%>
<%
end
%>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_WPS" style="display:none;">
<form class="form_content">
<div id="topLine_WPS" class="formTblCtrlBar">
<a id="instName_WPS" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);"></a>
</div>
<div id="changeArea_WPS" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="SSID_InstID" value="">
<input type="hidden" id="Band" class="PostIgnore" value="">
<input type="hidden" id="Enable" value="">
<input type="hidden" id="WPSMode" value="">
<input type="hidden" id="WpsPINShow" value="">
<input type="hidden" id="WpsPIN" value="" class="PostIgnore">
<div class="row">
<label for="WPSChoose" class="cfgLabel w150">&?WPS_016;</label>
<div class="right">
<select id="WPSChoose" name="WPSChoose" class="w210">
<option value="Disabled" title='&?public_133;'>&?WPS_005;</option>
<option value="PBC" title='&?WPS_006;'>&?WPS_006;</option>
<%
if (_G.ssidConf.WpsPIN == true) then
%>
<%
end
%>
</select>
</div>
</div>
<%
if (_G.ssidConf.WpsPIN == true) then
%>
<%
end
%>
<div class="buttongroup">
<input type="button" class="Button Btn_apply" id="Btn_apply_WPS" name="Btn_apply_WPS" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
</div>
