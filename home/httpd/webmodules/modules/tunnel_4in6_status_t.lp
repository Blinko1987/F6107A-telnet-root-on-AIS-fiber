<%
cgilua_lp.include("../../webmodules/modules/tunnel_4in6_status_js.lp", getfenv(1))
%>
<div id="Tnl4in6Status" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=tunnel_4in6_status_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="Tnl4in6StatusBar">&?Tnl4in6Status_003;</h1>
<div id="Tnl4in6Status_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_Tnl4in6Status" style="display:none;">
<form class="colorTbl form_content">
<div id="Tnl4in6Status_title" class="colorTblRow emFont titleRow">
<span class="w250 emFont" title="&?Internet4in6_004;">&?Internet4in6_004;</span>
<span class="w400" id="Tunnel46name" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?public_015;">&?public_015;</span>
<span class="w400" id="TUN46WANName" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?Internet4in6_007;">&?Internet4in6_007;</span>
<span class="w400" id="TUN46Localv4Addr" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?Internet4in6_009;">&?Internet4in6_009;</span>
<span class="w400" id="AFTRAddr" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?Tnl6in4Status_003;">&?Tnl6in4Status_003;</span>
<span class="w400" id="ConnStatus" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Tnl4in6Status_Btn_refresh" name="Tnl4in6Status_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
