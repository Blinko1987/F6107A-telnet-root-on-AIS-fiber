<%
cgilua_lp.include("../../webmodules/modules/accessdev_landevs_js.lp", getfenv(1))
%>
<div id="LANDevs" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=accessdev_landevs_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LANDevsBar">&?LocalnetStatus_013;</h1>
<div id="LANDevs_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<form class="form_content">
<div id="template_LANDevs" class="colorTbl" style="display:none;">
<div id="LANDevs_title" class="colorTblRow emFont titleRow">
<span class="w100 emFont" id="ClientNum" title="&?LocalnetStatus_018;">&?LocalnetStatus_018;</span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_135;">&?public_135;</span>
<span class="w180" id="AliasName:LANDevs" title=""></span>
<span class="w130 emFont" title="&?LocalnetStatus_007;">&?LocalnetStatus_007;</span>
<span class="w200" id="HostName:LANDevs" title=""></span>
</div>
<div class="colorTblRow colorRow">
<span class="w130 emFont" title="&?public_095;">&?public_095;</span>
<span class="w180" id="IPAddress:LANDevs" title=""></span>
<span class="w130 emFont" title="&?public_010;">&?public_010;</span>
<span class="w200" id="MACAddress:LANDevs" title=""></span>
</div>
<div class="colorTblRow">
<span class="w130 emFont" title="&?public_096;">&?public_096;</span>
<span class="w400" id="IPV6Address:LANDevs" title=""></span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="LANDevs_Btn_refresh" name="LANDevs_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
