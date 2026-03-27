<%
cgilua_lp.include("../../webmodules/modules/Voip_phoneStatus_js.lp", getfenv(1))
%>
<div id="VOIPPhoneStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voipVpPhyinterface_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="VOIPPhoneStatusBar">&?VoipStatus_038;</h1>
<div id="VOIPPhoneStatus_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<div>&?public_023;</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="colorTbl form_content">
<div id="VOIPPhoneStatus_title" class="colorTblRow emFont titleRow">
<span class="w100">&nbsp;</span>
<span class="w180" title="&?VoipStatus_019;">&?VoipStatus_019;</span>
<span class="w180" title="&?public_001;">&?public_001;</span>
</div>
<div id="template_VOIPPhoneStatus" class="colorTblRow" style="display:none;" >
<span class="w100"><img src="img/phone.png" alt="&?VoipStatus_016;" style="width:20px"/></span>
<span class="w180" id="phoneName" title=""></span>
<span class="w180" id="LanPortStatus" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_VOIPPhoneStatus" name="Btn_refresh_VOIPPhoneStatus" value="&?public_003;" />
</div>
</div>
</div>
