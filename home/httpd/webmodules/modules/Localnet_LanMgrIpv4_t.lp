<%
local t = cmapi.getinst("OBJ_DHCPHOST_ID", "")
if t.IF_ERRORID == 0 then
env.setenv("DHCPConfigurable", t.Configurable)
end
cgilua_lp.include("../../webmodules/modules/Localnet_LanMgrIpv4_DHCPHostInfo_js.lp", getfenv(1))
cgilua_lp.include("../../webmodules/modules/Localnet_LanMgrIpv4_DHCPBasicCfg_js.lp", getfenv(1))
local specailPool = cmapi.querylist("OBJ_DHCPPOOL_ID", "IGD");
local poolCount = 0
if specailPool.IF_ERRORID == 0 then
poolCount = specailPool.Count
end
if poolCount > 0 then
cgilua_lp.include("../../webmodules/modules/Localnet_LanMgrIpv4_DHCPSpecialAddMgr_js.lp", getfenv(1))
end
cgilua.lp.include("../../webmodules/modules/Localnet_LanMgrIpv4_SecondIP_js.lp", getfenv(1))
cgilua_lp.include("../../webmodules/modules/Localnet_LanMgrIpv4_DHCPStaticRule_js.lp", getfenv(1))
%>
<% if "108" ~= env.getenv("CountryCode") or "2" ~= env.getenv("OnuMode") then %>
<div id="DHCPHostInfo" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanMgrIpv4_DHCPHostInfo_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DHCPHostInfoBar">&?LanMgrIpv4_004;</h1>
<div id="DHCPHostInfo_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<form class="colorTbl form_content">
<div id="DHCPHostInfo_title" class="colorTblRow emFont titleRow">
<span class="w180" title="&?LanMgrIpv4_008;">&?LanMgrIpv4_008;</span>
<span class="w150" title="&?public_010;">&?public_010;</span>
<span class="w100" title="&?public_007;">&?public_007;</span>
<span class="w100" title="&?public_135;">&?public_135;</span>
<span class="w120" title="&?LanMgrIpv4_007;">&?LanMgrIpv4_007;</span>
</div>
<div id="template_DHCPHostInfo" class="colorTblRow" style="display:none;">
<span class="w180" id="HostName:DHCPHostInfo" title=""></span>
<span class="w150" id="MACAddr:DHCPHostInfo" title=""></span>
<span class="w100" id="IPAddr:DHCPHostInfo" title=""></span>
<span class="w100" id="PhyPortName:DHCPHostInfo" title=""></span>
<span class="w120" id="ExpiredTime:DHCPHostInfo" title=""></span>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="DHCPHostInfo_Btn_refresh" name="DHCPHostInfo_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
<% end %>
<div id="DHCPBasicCfg" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanMgrIpv4_DHCPBasicCfg_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DHCPBasicCfgBar">&?LanMgrIpv4_010;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="DHCPBasicCfg_container">
<div id="template_DHCPBasicCfg">
<div id="changeArea_DHCPBasicCfg" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="IF_URL_HOST">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="IPAddr:DHCPBasicCfg">
<input type="hidden" id="SubMask">
<input type="hidden" id="SubnetMask">
<% if "108" ~= env.getenv("CountryCode") or "2" ~= env.getenv("OnuMode") then %>
<input type="hidden" id="MinAddress:DHCPBasicCfg">
<input type="hidden" id="MaxAddress:DHCPBasicCfg">
<input type="hidden" id="IPRouters">
<input type="hidden" id="DNSServer1">
<input type="hidden" id="DNSServer2">
<input type="hidden" id="LeaseTime">
<% end %>
<% if "108" ~= env.getenv("CountryCode") or "2" ~= env.getenv("OnuMode") then %>
<div class="row" id="div_ServerEnable">
<label class="cfgLabel w200">&?LanMgrIpv4_011;</label>
<div id="ServerEnable" class="right w200">
<input type="radio" id="ServerEnable1" name="ServerEnable" value="1"/>
<label for="ServerEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="ServerEnable0" name="ServerEnable" value="0"/>
<label for="ServerEnable0">&?public_034;</label>
</div>
</div>
<% end %>
<div class="row">
<label for="sub_IPAddr0:DHCPBasicCfg" class="cfgLabel w200">&?LanMgrIpv4_012;</label>
<div class="right">
<input class="ip" name="sub_IPAddr0:DHCPBasicCfg" type="text" maxlength="3" id="sub_IPAddr0:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_IPAddr1:DHCPBasicCfg" type="text" maxlength="3" id="sub_IPAddr1:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_IPAddr2:DHCPBasicCfg" type="text" maxlength="3" id="sub_IPAddr2:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_IPAddr3:DHCPBasicCfg" type="text" maxlength="3" id="sub_IPAddr3:DHCPBasicCfg" value="" />
</div>
</div>
<div class="row">
<label for="sub_SubMask0" class="cfgLabel w200">&?public_030;</label>
<div class="right">
<input class="ip" name="sub_SubMask0" type="text" maxlength="3" id="sub_SubMask0" value="" />.
<input class="ip" name="sub_SubMask1" type="text" maxlength="3" id="sub_SubMask1" value="" />.
<input class="ip" name="sub_SubMask2" type="text" maxlength="3" id="sub_SubMask2" value="" />.
<input class="ip" name="sub_SubMask3" type="text" maxlength="3" id="sub_SubMask3" value="" />
</div>
</div>
<% if "108" ~= env.getenv("CountryCode") or "2" ~= env.getenv("OnuMode") then %>
<div class="row">
<label for="sub_MinAddress0:DHCPBasicCfg" class="cfgLabel w200">&?LanMgrIpv4_014;</label>
<div class="right">
<input class="ip" name="sub_MinAddress0:DHCPBasicCfg" type="text" maxlength="3" id="sub_MinAddress0:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_MinAddress1:DHCPBasicCfg" type="text" maxlength="3" id="sub_MinAddress1:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_MinAddress2:DHCPBasicCfg" type="text" maxlength="3" id="sub_MinAddress2:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_MinAddress3:DHCPBasicCfg" type="text" maxlength="3" id="sub_MinAddress3:DHCPBasicCfg" value="" />
</div>
</div>
<div class="row">
<label for="sub_MaxAddress0:DHCPBasicCfg" class="cfgLabel w200">&?LanMgrIpv4_015;</label>
<div class="right">
<input class="ip" name="sub_MaxAddress0:DHCPBasicCfg" type="text" maxlength="3" id="sub_MaxAddress0:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_MaxAddress1:DHCPBasicCfg" type="text" maxlength="3" id="sub_MaxAddress1:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_MaxAddress2:DHCPBasicCfg" type="text" maxlength="3" id="sub_MaxAddress2:DHCPBasicCfg" value="" />.
<input class="ip" name="sub_MaxAddress3:DHCPBasicCfg" type="text" maxlength="3" id="sub_MaxAddress3:DHCPBasicCfg" value="" />
</div>
</div>
<div class="row" id="div_DnsServerSource">
<label for="DnsServerSource" class="left w200">&?LanMgrIpv4_016;</label>
<div id="DnsServerSource" class="right">
<input type="radio" id="DnsServerSource1" name="DnsServerSource" value="1"/>
<label for="DnsServerSource1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="DnsServerSource0" name="DnsServerSource" value="0"/>
<label for="DnsServerSource0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_Ipv4DnsOrigin" style="display:none;">
<label for="Ipv4DnsOrigin" class="left w200">&nbsp;</label>
<div class="right">
<select id="Ipv4DnsOrigin" name="Ipv4DnsOrigin" class="PostIgnore selectNorm">
<option value="1" title='&?LanMgrIpv4_041;'>&?LanMgrIpv4_041;</option>
<option value="0" title='&?LanMgrIpv4_042;'>&?LanMgrIpv4_042;</option>
</select>
</div>
</div>
<div class="row" id="div_DNSServer1">
<label for="sub_DNSServer10" class="cfgLabel w200">&?LanMgrIpv4_017;</label>
<div class="right">
<input class="ip" name="sub_DNSServer10" type="text" maxlength="3" id="sub_DNSServer10" value="" />.
<input class="ip" name="sub_DNSServer11" type="text" maxlength="3" id="sub_DNSServer11" value="" />.
<input class="ip" name="sub_DNSServer12" type="text" maxlength="3" id="sub_DNSServer12" value="" />.
<input class="ip" name="sub_DNSServer13" type="text" maxlength="3" id="sub_DNSServer13" value="" />
</div>
</div>
<div class="row" id="div_DNSServer2">
<label for="sub_DNSServer20" class="cfgLabel w200">&?LanMgrIpv4_018;</label>
<div class="right">
<input class="ip" name="sub_DNSServer20" type="text" maxlength="3" id="sub_DNSServer20" value="" />.
<input class="ip" name="sub_DNSServer21" type="text" maxlength="3" id="sub_DNSServer21" value="" />.
<input class="ip" name="sub_DNSServer22" type="text" maxlength="3" id="sub_DNSServer22" value="" />.
<input class="ip" name="sub_DNSServer23" type="text" maxlength="3" id="sub_DNSServer23" value="" />
</div>
</div>
<div class="row">
<label for="LeaseTimeMode" class="left w200">&?LanMgrIpv4_019;</label>
<div class="right">
<select id="LeaseTimeMode" name="LeaseTimeMode" class="PostIgnore selectNorm">
<option value="selfDefine" title='&?LanMgrIpv4_020;'>&?LanMgrIpv4_020;</option>
<option value="Infinity" title='&?LanMgrIpv4_003;'>&?LanMgrIpv4_003;</option>
</select>
</div>
</div>
<div class="row" id="div_LeaseTimeSelfDefine">
<label for="LeaseTimeSelfDefine" class="cfgLabel w200">&?LanMgrIpv4_021;</label>
<div class="right">
<input type="text" id="LeaseTimeSelfDefine" name="LeaseTimeSelfDefine" class="PostIgnore inputNorm"/>&?public_013;
<span style="display:none;">&?public_072;60 ~ 157 680 000</span>
</div>
</div>
<% end %>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_DHCPBasicCfg" name="Btn_cancel_DHCPBasicCfg" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_DHCPBasicCfg" name="Btn_apply_DHCPBasicCfg" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
<% if "108" ~= env.getenv("CountryCode") or "2" ~= env.getenv("OnuMode") then %>
<%
if poolCount > 0 then
%>
<div id="DHCPSpecialAddMgr" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanMgrIpv4_DHCPSpecialAddMgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DHCPSpecialAddMgrBar">&?LanMgrIpv4_027;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="DHCPSpecialAddMgr_container">
<input type="hidden" id="_InstNum" value="0">
<div id="template_DHCPSpecialAddMgr" style="display:none">
<form class="form_content">
<div id="topLine_DHCPSpecialAddMgr" class="formTblCtrlBar">
<span id="instName_DHCPSpecialAddMgr" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
(<label id="Text_MinAddress"></label>~<label id="Text_MaxAddress"></label>)
</span>
</div>
<div id="changeArea_DHCPSpecialAddMgr" class="ChangeArea formTblWrap" style="display:none;">
<div class="formTbl">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="MinAddress">
<input type="hidden" id="MaxAddress">
<input type="hidden" id="PoolName">
<div class="row" id="div_Enable">
<label for="Enable" class="cfgLabel w200">&?Pinpublic_013;</label>
<div id="Enable" class="right w200">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0"/><label for="Enable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="sub_SpecialMinAddress0" class="cfgLabel w200">&?LanMgrIpv4_025;</label>
<div class="right">
<input class="ip" name="sub_SpecialMinAddress0" type="text" maxlength="3" id="sub_SpecialMinAddress0" value="" />.
<input class="ip" name="sub_SpecialMinAddress1" type="text" maxlength="3" id="sub_SpecialMinAddress1" value="" />.
<input class="ip" name="sub_SpecialMinAddress2" type="text" maxlength="3" id="sub_SpecialMinAddress2" value="" />.
<input class="ip" name="sub_SpecialMinAddress3" type="text" maxlength="3" id="sub_SpecialMinAddress3" value="" />
</div>
</div>
<div class="row">
<label for="sub_SpecialMaxAddress0" class="cfgLabel w200">&?LanMgrIpv4_026;</label>
<div class="right">
<input class="ip" name="sub_SpecialMaxAddress0" type="text" maxlength="3" id="sub_SpecialMaxAddress0" value="" />.
<input class="ip" name="sub_SpecialMaxAddress1" type="text" maxlength="3" id="sub_SpecialMaxAddress1" value="" />.
<input class="ip" name="sub_SpecialMaxAddress2" type="text" maxlength="3" id="sub_SpecialMaxAddress2" value="" />.
<input class="ip" name="sub_SpecialMaxAddress3" type="text" maxlength="3" id="sub_SpecialMaxAddress3" value="" />
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_DHCPSpecialAddMgr" name="Btn_cancel_DHCPSpecialAddMgr" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_DHCPSpecialAddMgr" name="Btn_apply_DHCPSpecialAddMgr" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
<div id="DHCPSpecialAddMgr_Refresh" style="display:none;">
<input type="hidden" id="DHCPSpecialAddMgr_Refresh_button">
</div>
</div>
<%
end
%>
<% if (_G.lanConf["v4secondip"] == true) then %>
<div id="SECONDIP" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanMgrIpv4_SecondIP_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SECONDIPBar">&?LanMgrIpv4_040;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="SECONDIP_container">
<div id="template_SECONDIP">
<div id="changeArea_SECONDIP" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="SecIPAddr">
<input type="hidden" id="SecNetMask">
<div class="row" id="div_SecEnable">
<label class="cfgLabel w200">&?LanMgrIpv4_040;</label>
<div id="SecEnable" class="right w200">
<input type="radio" id="SecEnable1" name="SecEnable" value="1"/>
<label for="SecEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="SecEnable0" name="SecEnable" value="0"/>
<label for="SecEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="sub_SecIPAddr0" class="cfgLabel w200">&?LanMgrIpv4_039;</label>
<div class="right">
<input class="ip" name="sub_SecIPAddr0" type="text" maxlength="3" id="sub_SecIPAddr0" value="" />.
<input class="ip" name="sub_SecIPAddr1" type="text" maxlength="3" id="sub_SecIPAddr1" value="" />.
<input class="ip" name="sub_SecIPAddr2" type="text" maxlength="3" id="sub_SecIPAddr2" value="" />.
<input class="ip" name="sub_SecIPAddr3" type="text" maxlength="3" id="sub_SecIPAddr3" value="" />
</div>
</div>
<div class="row">
<label for="sub_SecNetMask0" class="cfgLabel w200">&?public_030;</label>
<div class="right">
<input class="ip" name="sub_SecNetMask0" type="text" maxlength="3" id="sub_SecNetMask0" value="" />.
<input class="ip" name="sub_SecNetMask1" type="text" maxlength="3" id="sub_SecNetMask1" value="" />.
<input class="ip" name="sub_SecNetMask2" type="text" maxlength="3" id="sub_SecNetMask2" value="" />.
<input class="ip" name="sub_SecNetMask3" type="text" maxlength="3" id="sub_SecNetMask3" value="" />
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="SecondIP_Btn_refresh" name="SecondIP_Btn_refresh" value="&?public_003;" style="display:none;"/>
<input type="button" class="Button Btn_cancel" id="Btn_cancel_SECONDIP" name="Btn_cancel_SECONDIP" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_SECONDIP" name="Btn_apply_SECONDIP" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
<% end %>
<div id="DHCPStaticRule" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanMgrIpv4_DHCPStaticRule_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DHCPStaticRuleBar">&?LanMgrIpv4_022;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="DHCPStaticRule_container">
<input type="hidden" id="_InstNum" value="0">
<div id="template_DHCPStaticRule" style="display:none;">
<div id="topLine_DHCPStaticRule" class="formTblCtrlBar">
<span id="instName_DHCPStaticRule" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_DHCPStaticRule" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_DHCPStaticRule" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID:DHCPStaticRule" value="-1">
<input type="hidden" id="MACAddr" value="">
<input type="hidden" id="IPAddr" value="">
<div class="row">
<label for="Name" class="cfgLabel w200">&?public_016;</label>
<div class="right">
<input type="text" id="Name" name="Name" class="inputNorm"/>
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="sub_MACAddr0" class="cfgLabel w200">&?public_010;</label>
<div class="right">
<input class="mac" name="sub_MACAddr0" type="text" maxlength="2" id="sub_MACAddr0" value="" />:
<input class="mac" name="sub_MACAddr1" type="text" maxlength="2" id="sub_MACAddr1" value="" />:
<input class="mac" name="sub_MACAddr2" type="text" maxlength="2" id="sub_MACAddr2" value="" />:
<input class="mac" name="sub_MACAddr3" type="text" maxlength="2" id="sub_MACAddr3" value="" />:
<input class="mac" name="sub_MACAddr4" type="text" maxlength="2" id="sub_MACAddr4" value="" />:
<input class="mac" name="sub_MACAddr5" type="text" maxlength="2" id="sub_MACAddr5" value="" />
</div>
</div>
<div class="row">
<label for="sub_IPAddr0" class="cfgLabel w200">&?public_007;</label>
<div class="right">
<input class="ip" name="sub_IPAddr0" type="text" maxlength="3" id="sub_IPAddr0" value="" />.
<input class="ip" name="sub_IPAddr1" type="text" maxlength="3" id="sub_IPAddr1" value="" />.
<input class="ip" name="sub_IPAddr2" type="text" maxlength="3" id="sub_IPAddr2" value="" />.
<input class="ip" name="sub_IPAddr3" type="text" maxlength="3" id="sub_IPAddr3" value="" />
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_DHCPStaticRule" name="Btn_cancel_DHCPStaticRule" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_DHCPStaticRule" name="Btn_apply_DHCPStaticRule" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_DHCPStaticRule" class="instNew addInst">&?public_098;</span>
</div>
<div id="DHCPStaticRule_Refresh" style="display:none;">
<input type="hidden" id="DHCPStaticRule_Refresh_button">
</div>
</div>
</div>
<% end %>
