<%
cgilua_lp.include("../../webmodules/modules/dhcp6s_hostinfo_js.lp", getfenv(1))
%>
<div id="IPv6DHCPHostInfo" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=dhcp6s_hostinfo_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IPv6DHCPHostInfoBar">&?LanMgrIpv6_029;</h1>
<div id="IPv6DHCPHostInfo_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<div>&?public_023;</div>
</div>
<div class="colorTbl form_content">
<div id="IPv6DHCPHostInfo_title" class="colorTblRow emFont titleRow">
<span class="w250" title="&?LanMgrIpv6_030;">&?LanMgrIpv6_030;</span>
<span class="w280" title="&?public_007;">&?public_007;</span>
<span class="w130" title="&?LanMgrIpv6_032;">&?LanMgrIpv6_032;</span>
</div>
<div id="template_IPv6DHCPHostInfo" class="colorTblRow" style="display:none;" >
<span class="w250" id="Duid" title=""></span>
<span class="w280" id="IpAddr" title=""></span>
<span class="w130" id="ExpiredTime" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_IPv6DHCPHostInfo" name="Btn_refresh_IPv6DHCPHostInfo" value="&?public_003;" />
</div>
</div>
</div>
