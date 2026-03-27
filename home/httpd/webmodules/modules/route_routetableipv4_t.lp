<%
cgilua_lp.include("../../webmodules/modules/route_routetableipv4_js.lp", getfenv(1))
%>
<div id="RouteTable" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routetableipv4_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="RouteTableBar">&?RouteIpv4_003;</h1>
<div id="RouteTable_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<div class="colorTbl">
<div id="colorTblHead" class="colorTblRow emFont titleRow">
<span class="w160" title="&?RouteIpv4_004;">&?RouteIpv4_004;</span>
<span class="w160" title="&?public_030;">&?public_030;</span>
<span class="w160" title="&?public_031;">&?public_031;</span>
<span class="w160" title="&?public_056;">&?public_056;</span>
</div>
<div id="template_RouteTable" class="colorTblRow" style="display:none;">
<span class="w160" id="DestIP" title=""></span>
<span class="w160" id="DestIPMask" title=""></span>
<span class="w160" id="GWIP" title=""></span>
<span class="w160" id="Interface" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="RouteTable_Btn_refresh" name="RouteTable_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
