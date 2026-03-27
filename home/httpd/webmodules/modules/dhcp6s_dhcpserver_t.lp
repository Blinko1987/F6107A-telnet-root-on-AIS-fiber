<%
cgilua_lp.include("../../webmodules/modules/dhcp6s_dhcpserver_js.lp", getfenv(1))
%>
<div id="IPv6DHCPServer" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=dhcp6s_dhcpserver_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IPv6DHCPServerBar">&?LanMgrIpv6_004;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="IPv6DHCPServer_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?LanMgrIpv6_043;</a></div>
<div class="sceneTip_container">
<p>
<span>&?LanMgrIpv6_044;</span><br/>
<span>&?LanMgrIpv6_045;</span><br/>
<span>&?LanMgrIpv6_046;</span><br/>
<span>&?LanMgrIpv6_047;</span><br/>
</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_IPv6DHCPServer">
<form class="form_content">
<div id="changeArea_IPv6DHCPServer" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="_InstID_DNS" value="">
<input type="hidden" id="IANAEnable" value="">
<input type="hidden" id="IsPrefixAutoMode" value="">
<input type="hidden" id="IANAManualPrefixes" value="">
<div class="row">
<label class="cfgLabel w200">&?LanMgrIpv6_005;</label>
<div id="Enable:IPv6DHCPServer" class="right">
<input type="radio" id="Enable1:IPv6DHCPServer" name="Enable:IPv6DHCPServer" value="1"/><label for="Enable1:IPv6DHCPServer">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Enable0:IPv6DHCPServer" name="Enable:IPv6DHCPServer" value="0"/><label for="Enable0:IPv6DHCPServer">&?public_034;</label>
</div>
</div>
<div class="row">
<label class="cfgLabel w200">&?LanMgrIpv6_064;</label>
<div id="ManualDNSEnable" class="right">
<input type="radio" id="ManualDNSEnable0" name="ManualDNSEnable" value="0"/><label for="ManualDNSEnable0">&?LanMgrIpv6_059;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="ManualDNSEnable1" name="ManualDNSEnable" value="1"/><label for="ManualDNSEnable1">&?LanMgrIpv6_060;</label>
</div>
</div>
<div id="div_dnsGroup" style="display:none;">
<div class="row">
<label for="DNSAddr1" class="cfgLabel w200">&?LanMgrIpv6_061;</label>
<div class="right">
<input type="text" class="w200" id="DNSAddr1" name="DNSAddr1" value=""/>
</div>
</div>
<div class="row">
<label for="DNSAddr2" class="cfgLabel w200">&?LanMgrIpv6_062;</label>
<div class="right">
<input type="text" class="w200" id="DNSAddr2" name="DNSAddr2" value=""/>
</div>
</div>
<div class="row">
<label for="DNSAddr3" class="cfgLabel w200">&?LanMgrIpv6_063;</label>
<div class="right">
<input type="text" class="w200" id="DNSAddr3" name="DNSAddr3" value=""/>
</div>
</div>
</div>
<div class="row" id="div_Ipv6DnsOrigin" style="display:none;">
<label for="Ipv6DnsOrigin" class="left w200">&nbsp;</label>
<div class="right">
<select id="Ipv6DnsOrigin" name="Ipv6DnsOrigin" class="w200 PostIgnore">
<option value="1" title='&?LanMgrIpv4_041;'>&?LanMgrIpv4_041;</option>
<option value="0" title='&?LanMgrIpv4_042;'>&?LanMgrIpv4_042;</option>
</select>
</div>
</div>
<div class="row">
<label for="DnsRefreshTime" class="cfgLabel w200">&?LanMgrIpv6_006;</label>
<div class="right">
<input type="text" class="w200" id="DnsRefreshTime" name="DnsRefreshTime" value=""/>&?public_013;
<span class="dTip" style="display: none;">&?public_072;600 ~ 4 294 967 295</span>
</div>
</div>
<div class="row" id="div_PrefixMode">
<label for="PrefixMode:IPv6DHCPServer" class="left w200">&?LanMgrIpv6_042;</label>
<div class="right">
<select name="PrefixMode:IPv6DHCPServer" id="PrefixMode:IPv6DHCPServer" class="w200 PostIgnore">
<option value="Auto" title='&?public_094;'>&?public_094;</option>
<option value="Manual" title='&?public_093;'>&?public_093;</option>
<option value="Disabled" title='&?LanMgrIpv6_041;'>&?LanMgrIpv6_041;</option>
</select>
</div>
</div>
<div id="DHCPPrefixZone" style="display:none;">
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_IPv6DHCPServer" name="Btn_cancel_IPv6DHCPServer" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_IPv6DHCPServer" name="Btn_apply_IPv6DHCPServer" value="&?public_018;" />
<input type="button" class="Button" id="Btn_PrefixUpd_IPv6DHCPServer" name="Btn_PrefixUpd_IPv6DHCPServer" style="display:none;" />
<input type="button" class="Button" id="Btn_SelfUpd_IPv6DHCPServer" name="Btn_SelfUpd_IPv6DHCPServer" style="display:none;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
