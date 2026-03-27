<%
cgilua_lp.include("../../webmodules/modules/wlan_client_stat_js.lp", getfenv(1))
%>
<div id="Wlan_ClientStat" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_client_stat_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="Wlan_ClientStatBar">&?LocalnetStatus_006;</h1>
<div id="Wlan_ClientStat_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<form class="form_content">
<div id="template_Wlan_ClientStat" class="colorTbl" style="display:none;">
<div id="SSIDDev_title" class="colorTblRow emFont titleRow">
<span class="w100 emFont" id="WClientNum" title="&?LocalnetStatus_018;">&?LocalnetStatus_018;</span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" id= ssidAliasName title="&?public_117;">&?public_117;</span>
<span class="w180" id="AliasName"></span>
<span class="w130 emFont" title="&?LocalnetStatus_007;">&?LocalnetStatus_007;</span>
<span class="w200" id="HostName" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="SSID "+"&?public_117;">SSID &?LocalnetStatus_007;</span>
<span class="w180" id="ESSID" title=""></span>
<span class="w130 emFont" title="&?public_096;">&?public_096;</span>
<span class="w200" id="IPV6Address" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?public_095;">&?public_095;</span>
<span class="w180" id="IPAddress" title=""></span>
<span class="w130 emFont" title="&?public_010;">&?public_010;</span>
<span class="w200" id="MACAddress" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_177;">&?public_177;</span>
<span class="w180" id="MCS" title=""></span>
<span class="w130 emFont" title="&?public_175;">&?public_175;</span>
<span class="w200" id="RSSI" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?public_176;">&?public_176;</span>
<span class="w180" id="TxRate" title=""></span>
<span class="w130 emFont" title="&?public_178;">&?public_178;</span>
<span class="w200" id="RxRate" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?public_179;">&?public_179;</span>
<span class="w180" id="CurrentMode" title=""></span>
<span class="w130 emFont" title="&?WlanBasicAd_038;">&?WlanBasicAd_038;</span>
<span class="w200" id="BAND" title=""></span>
</div>
<div class="colorTblRow colorRow" id="NoiseSNR" style="display:none;">
<span class="w130 emFont" title="&?public_180;">&?public_180;</span>
<span class="w180" id="NOISE" title=""></span>
<span class="w130 emFont" title="&?public_181;">&?public_181;</span>
<span class="w200" id="SNR" title=""></span>
</div>
<div class="colorTblRow colorRow" id="ConnectionTime" style="display:none;">
<span class="w130 emFont" title="&?public_184;">&?public_184;</span>
<span class="w200" id="LinkTime" title=""></span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_Wlan_ClientStat" name="Btn_refresh_Wlan_ClientStat" value=&?public_003; />
</div>
</div>
</div>
