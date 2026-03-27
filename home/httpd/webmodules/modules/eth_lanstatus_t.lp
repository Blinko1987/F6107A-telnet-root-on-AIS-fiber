<%
cgilua_lp.include("../../webmodules/modules/eth_lanstatus_js.lp", getfenv(1))
%>
<div id="LANStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=eth_lanstatus_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LANStatusBar">&?LocalnetStatusAd_002;</h1>
<div id="LANStatus_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<form class="form_content">
<div id="template_LANStatus" class="colorTbl" style="display:none;">
<input type="hidden" id="BytesReceived" value="">
<input type="hidden" id="BytesSent" value="">
<div id="LANStatus_title" class="colorTblRow emFont titleRow">
<span class="w180" id="AliasName" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_010;">&?public_010;</span>
<span class="w180" id="MACAddress" title=""></span>
<span class="w200 emFont" title="&?public_001;">&?public_001;</span>
<span class="w150" id="Status" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?public_095;">&?public_095;</span>
<span class="w180" id="IPAddress" title=""></span>
<span class="w200 emFont" title="&?LocalnetStatusAd_003;">&?LocalnetStatusAd_003;</span>
<span class="w150" id="BytesCount" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_096;">&?public_096;</span>
<span class="w400" id="IPv6Addr" title=""></span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="LANStatus_Btn_refresh" name="LANStatus_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
