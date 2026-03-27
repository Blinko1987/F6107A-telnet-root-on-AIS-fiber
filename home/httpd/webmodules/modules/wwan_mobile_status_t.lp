<%
cgilua_lp.include("../../webmodules/modules/wwan_mobile_status_js.lp", getfenv(1))
%>
<div id="Mobile3GStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_mobile_status_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="Mobile3GStatusBar">&?Internet3GStatus_001;</h1>
<div id="Mobile3GStatus_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="noDataHint" id="InsertCardBefore" style="display:none;">
<span>&?Pinpublic_018;</span>
</div>
<div class="noDataHint" id="NotSupport" style="display:none;">
<span>&?Pinpublic_017;</span>
</div>
<div id="template_Mobile3GStatus" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="colorTbl form_content">
<input type="hidden" id="MobileAlarm" value="">
<input type="hidden" id="SignalStrength" value="">
<div class="colorTblRow">
<span class="w250 emFont" title="&?Internet3GStatus_004;">&?Internet3GStatus_004;</span>
<span class="w250" id="C_SignalStrength" valign="bottom">
<table>
<tr>
<td valign="bottom">
<div>&nbsp;</div>
</td>
</tr>
</table>
</span>
</div>
<div class="colorTblRow CustomCard">
<span class="w250 emFont" title="&?Internet3GStatus_002;">&?Internet3GStatus_002;</span>
<span class="w250" id="MobileName" title=""></span>
</div>
<div class="colorTblRow CustomCard">
<span class="w250 emFont" title="&?Internet3GStatus_003;">&?Internet3GStatus_003;</span>
<span class="w250" id="NetWorkMode" title=""></span>
</div>
<div class="colorTblRow CustomCard">
<span class="w250 emFont" title="&?Internet3GStatus_014;">&?Internet3GStatus_014;</span>
<span class="w250" id="IMEI" title=""></span>
</div>
<div class="colorTblRow" id="div_MobileAlarm" style="display:none;">
<span class="w250 emFont" title="&?Internet3GStatus_005;">&?Internet3GStatus_005;</span>
<span class="w250" id="C_MobileAlarm"></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Mobile3GStatus_Btn_refresh" name="Mobile3GStatus_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
