<%
cgilua_lp.include("../../webmodules/modules/prefix_prefixpool_js.lp", getfenv(1))
%>
<div id="PrefixPool" class="HeadDIV" style="display:none;">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=prefix_prefixpool_lua.lua</span>
</address>
<input type="hidden" id="FullDelegationRelation" value="">
<div id="PrefixPool_container">
<div class="colorTbl" id="PrefixPool_container">
<div id="" class="colorTblRow emFont titleRow">
<span class="w180" title="&?LanMgrIpv6_008;">&?LanMgrIpv6_008;</span>
<span class="w150" title="&?LanMgrIpv6_065;">&?LanMgrIpv6_065;</span>
<span class="w180" title="&?LanMgrIpv6_039;">&?LanMgrIpv6_039;</span>
<span class="w100" title="&?LanMgrIpv6_040;">&?LanMgrIpv6_040;</span>
</div>
<div id="template_PrefixPool" class="colorTblRow" style="display:none;">
<input type="hidden" id="PrefixPoolInst" value="" class="PostIgnore">
<input type="hidden" id="PreferredLifetime" value="" class="PostIgnore">
<input type="hidden" id="ValidLifetime" value="" class="PostIgnore">
<input type="hidden" id="Prefix" value="" class="PostIgnore">
<input type="hidden" id="PrefixLen" value="" class="PostIgnore">
<span class="w180" id="RealPrefix" title="" ></span>
<span class="w150" id="IfName" title="" ></span>
<input type="hidden" id="isStaticPrefix" value="" class="PostIgnore"/>
<span class="w180" id="ValidPreferTime" title="" ></span>
<span class="w100"><input type="checkbox" id="IsDelegation" name="IsDelegation" value="" class="PostIgnore"/></span>
</div>
<div class="noDataRow" style="display:none;">
<span>&nbsp;</span>
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" id="Btn_PrefixPool" name="Btn_PrefixPool" value=""/>
</div>
</div>
