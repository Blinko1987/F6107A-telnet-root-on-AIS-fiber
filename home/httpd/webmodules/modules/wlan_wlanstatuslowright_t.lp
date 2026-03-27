<%
cgilua_lp.include("../../webmodules/modules/wlan_wlanstatuslowright_js.lp", getfenv(1))
%>
<div id="WLANStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_wlanstatuslowright_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="WLANStatusBar">&?LocalnetStatus_002;</h1>
<div id="WLANStatus_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_WLANStatus" style="display:none;">
<form class="colorTbl form_content">
<input type="hidden" id="_InstID" value="" class="PostIgnore">
<input type="hidden" id="ChannelInUsed" value="" class="PostIgnore">
<input type="hidden" id="BeaconType" value="" class="PostIgnore">
<div id="WLANStatus_title" class="colorTblRow emFont titleRow">
<span class="w100 emFont" id="Band" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w250 emFont" title="&?LocalnetStatus_003;">&?LocalnetStatus_003;</span>
<span class="w250" id="ESSID" title=""></span>
</div>
<div id="" class="colorTblRow colorRow">
<span class="w250 emFont" title="&?LocalnetStatus_004;">&?LocalnetStatus_004;</span>
<span class="w250" id="S_ChannelInUsed" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w250 emFont" title="&?LocalnetStatus_005;">&?LocalnetStatus_005;</span>
<span class="w250" id="S_BeaconType" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="WLANStatus_Btn_refresh" name="WLANStatus_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
