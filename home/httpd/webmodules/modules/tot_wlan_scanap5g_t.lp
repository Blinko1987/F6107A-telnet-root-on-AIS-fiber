<%
cgilua_lp.include("../../webmodules/modules/tot_wlan_scanap5g_js.lp", getfenv(1))
%>
<div id="WLANScanAP5g" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=tot_wlan_wlan_profile_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WLAN5gScanAPBar">&?WlanScan_014;</h1>
<div id="WLANScanAP5g_container">
<input type="hidden" id="DataHasBeenGot5g" value="0">
<div class="outRow">
<div class="left">
<input type="button" class="Button longBtn" id="Btn_scanap5g" name="Btn_scanap" value="&?WlanScan_012;" />
</div>
<div id="div_Scanning_tip5g" class="inlineTip" style="display: none;">
<span>&?STA_008;</span>
</div>
</div>
<div class="colorTbl" style="overflow-x:scroll;width:99%;margin-left: 2px;">
<div id="colorTblHead5g" class="colorTblRow emFont titleRow" style="width: 950px;">
<span class="w120" title="&?WlanScan_003;">&?WlanScan_003;</span>
<span class="w120" title="&?public_010;">&?public_010;</span>
<span class="w100" title="&?Wlan_ap001;">&?Wlan_ap001;</span>
<span class="w50" title="&?WlanScan_005;">&?WlanScan_005;</span>
<span class="w80" title="&?WlanScan_006;">&?WlanScan_006;</span>
<span class="w80" title="&?WlanScan_007;">&?WlanScan_007;</span>
<span class="w100" title="&?Wlan_ap002;">&?Wlan_ap002;</span>
<span class="w130" title="&?WlanScan_009;">&?WlanScan_009;</span>
<span class="w100" title="&?WlanScan_010;">&?WlanScan_010;</span>
</div>
<div id="template_WLANScanAP5g" class="colorTblRow" style="display:none; width: 950px;">
<span class="w120" id="Essid" title=""></span>
<span class="w120" id="MacAddr" title=""></span>
<span class="w100" id="NETWORK" title=""></span>
<span class="w50" id="Channel" title=""></span>
<span class="w80" id="Signal" title=""></span>
<span class="w80" id="Noise" title=""></span>
<span class="w100" id="DTIM" title=""></span>
<span class="w130" id="BeaconIntervel" title=""></span>
<span class="w100" id="AuthMode" title=""></span>
</div>
</div>
</div>
</div>
