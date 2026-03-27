<%
cgilua_lp.include("../../webmodules/modules/wlan_wlanstatus_js.lp", getfenv(1))
%>
<div id="WLANStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_wlanstatus_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WLANStatusBar">&?LocalnetStatus_002;</h1>
<div id="WLANStatus_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="colorTbl">
<div class="colorTblRow emFont titleRow">
<span class="w200 emFont" title="&?LocalnetStatusAd_006;">&?LocalnetStatusAd_006;</span>
</div>
<div id="div_WLANRadioSta" class="colorTblRow" style="display:none;">
<span class="w130 emFont" id="titleRealRF" title="&?WlanBasicAd_077;">&?WlanBasicAd_077;</span>
<span class="w180" id="RealRF" title=""></span>
<span class="w200 emFont" id="titleChannelInUsed" title="&?LocalnetStatus_004;">&?LocalnetStatus_004;</span>
<input type="hidden" id="Band" class="PostIgnore" value="">
<input type="hidden" id="_InstID" class="PostIgnore" value="">
<span class="w150" id="ChannelInUsed" title=""></span>
</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_WLANStatus" style="display:none;">
<form class="colorTbl form_content">
<input type="hidden" id="TotalPacketsReceived" value="">
<input type="hidden" id="TotalPacketsSent" value="">
<input type="hidden" id="TotalBytesReceived" value="">
<input type="hidden" id="TotalBytesSent" value="">
<input type="hidden" id="Alias" value="" class="PostIgnore">
<input type="hidden" id="WLANViewName" class="PostIgnore" value="">
<input type="hidden" id="WPAAuthMode" class="PostIgnore" value="">
<input type="hidden" id="WPA3AuthMode" class="PostIgnore" value="">
<input type="hidden" id="11iAuthMode" class="PostIgnore" value="">
<input type="hidden" id="WPAEncryptType" class="PostIgnore" value="">
<input type="hidden" id="11iEncryptType" class="PostIgnore" value="">
<input type="hidden" id="WEPAuthMode" class="PostIgnore" value="">
<div id="WLANStatus_title" class="colorTblRow emFont titleRow">
<span class="w100 emFont" id="_InstID" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?WlanBasic_011;">&?WlanBasic_011;</span>
<span class="w180" id="ESSID" title=""></span>
<span class="w200 emFont" title="&?public_010;">&?public_010;</span>
<span class="w150" id="Bssid" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?LocalnetStatusAd_004;">&?LocalnetStatusAd_004;</span>
<span class="w180" id="Enable"></span>
<span class="w200 emFont" title="&?LocalnetStatusAd_005;">&?LocalnetStatusAd_005;</span>
<span class="w150" id="TotalPacketsCount" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?LocalnetStatus_005;">&?LocalnetStatus_005;</span>
<span class="w180" id="BeaconType" title=""></span>
<span class="w200 emFont" title="&?LocalnetStatusAd_003;">&?LocalnetStatusAd_003;</span>
<span class="w150" id="TotalBytesCount" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="WLANStatus_Btn_refresh" name="WLANStatus_Btn_refresh" value="&?public_003;" />
<input type="button" class="Button" id="WLANStatus_Btn_clear" name="WLANStatus_Btn_clear" value="&?LogManag_010;" style="display:none"/>
</div>
</div>
</div>
