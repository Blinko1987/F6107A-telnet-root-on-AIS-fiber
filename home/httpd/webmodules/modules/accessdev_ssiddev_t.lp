<%
cgilua_lp.include("../../webmodules/modules/accessdev_ssiddev_js.lp", getfenv(1))
%>
<div id="SSIDDev" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=accessdev_ssiddev_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SSIDDevBar">&?LocalnetStatus_006;</h1>
<div id="SSIDDev_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<form class="form_content">
<div id="template_SSIDDev" class="colorTbl" style="display:none;">
<div id="SSIDDev_title" class="colorTblRow emFont titleRow">
<span class="w100 emFont" id="WClientNum" title="&?LocalnetStatus_018;">&?LocalnetStatus_018;</span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_117;">&?public_117;</span>
<span class="w180" id="AliasName:SSIDDev"></span>
<span class="w130 emFont" title="&?LocalnetStatus_007;">&?LocalnetStatus_007;</span>
<span class="w200" id="HostName:SSIDDev" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?public_095;">&?public_095;</span>
<span class="w180" id="IPAddress:SSIDDev" title=""></span>
<span class="w130 emFont" title="&?public_010;">&?public_010;</span>
<span class="w200" id="MACAddress:SSIDDev" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_096;">&?public_096;</span>
<span class="w400" id="IPV6Address:SSIDDev" title=""></span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="SSIDDev_Btn_refresh" name="SSIDDev_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
