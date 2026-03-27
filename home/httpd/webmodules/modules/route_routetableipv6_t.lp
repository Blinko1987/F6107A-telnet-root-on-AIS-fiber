<%
cgilua_lp.include("../../webmodules/modules/route_routetableipv6_js.lp", getfenv(1))
%>
<div id="RouteTable" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routetableipv6_lua.lua</span>
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
<span class="w250" title="&?RouteIpv6_003;">&?RouteIpv6_003;</span>
<span class="w200" title="&?public_031;">&?public_031;</span>
<span class="w200" title="&?public_056;">&?public_056;</span>
</div>
<div id="template_RouteTable" class="colorTblRow" style="display:none;">
<input type="hidden" id="PrefixLen" name="PrefixLen" value=""/>
<span class="w250" id="DestIP" title=""></span>
<span class="w200" id="GWIP" title=""></span>
<span class="w200" id="Interface" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="RouteTable_Btn_refresh" name="RouteTable_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
