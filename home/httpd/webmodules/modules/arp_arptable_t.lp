<%
cgilua_lp.include("../../webmodules/modules/arp_arptable_js.lp", getfenv(1))
%>
<div class="instCfgArea">
<div id="ArpTable" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=arp_arptable_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapsibleBar" id="ArpTableBar">&?ArpTable_001;</h1>
<div id="ArpTable_container" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<div>&?public_023;</div>
</div>
<div class="colorTbl form_content">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="ArpTable_title" class="colorTblRow emFont titleRow">
<span class="w200" title="&?public_007;">&?public_007;</span>
<span class="w200" title="&?public_010;">&?public_010;</span>
<span class="w100" title="&?public_001;">&?public_001;</span>
<span class="w100" title="&?public_056;">&?public_056;</span>
</div>
<div id="template_ArpTable" class="colorTblRow" style="display:none;" >
<span class="w200" id="DestIP" title=""></span>
<span class="w200" id="MACAddr" title=""></span>
<span class="w100" id="Status" title=""></span>
<span class="w100" id="Interface" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_ArpTable" name="Btn_refresh_ArpTable" value="&?public_003;" />
</div>
</div>
</div>
</div>
