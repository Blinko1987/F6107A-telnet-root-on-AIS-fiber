<%
cgilua_lp.include("../../webmodules/modules/ctc_wan_config_js.lp", getfenv(1))
%>
<div id="Internet" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wan_internet_lua.lua&TypeUplink=2&pageType=0</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="InternetBar">&?InternetDE_116;</h1>
<div id="Internet_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="ipmtumax" value="1500">
<div id="template_Internet" style="display:none;">
<div id="topLine_Internet" class="formTblCtrlBar">
<span id="instName_Internet" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
</span>
</div>
<div id="changeArea_Internet" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="uplink" value="2">
<input type="hidden" id="InstHasGot" value="0">
<input type="hidden" id="ControlType" value="1">
<div class="row" style="display:none;">
<label for="WANCName" class="cfgLabel w150">&?InternetDE_005;</label>
<div class="right">
<input class="inputNorm" type="text" id="WANCName" name="WANCName" value=""/>
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 256</span>
</div>
</div>
<div class="row" id="Prefix_mode" style="display:none;">
<label for="mode" class="cfgLabel w150">&?InternetDE_011;</label>
<div class="right">
<select id="mode" name="mode" class="selectNorm">
<option value="route" title="&?public_049;" select>&?public_049;</option>
<% if "1"==env.getenv("Bridge") then %>
<option value="bridge" title="&?InternetDE_032;">&?InternetDE_032;</option>
<%end%>
</select>
</div>
</div>
<div class="row" id="Prefix_ServList" style="display:none;">
<label for="ServList" class="cfgLabel w150">&?InternetDE_007;</label>
<div class="right">
<select class="selectNorm" id="ServList" name="ServList">
<option value="1" title="&?InternetDE_086;">&?InternetDE_086;</option>
<option value="2" title="&?InternetDE_087;">&?InternetDE_087;</option>
<option value="3" title="&?InternetDE_088;">&?InternetDE_088;</option>
<% if "0" ~= env.getenv("voipSupport") then %>
<option value="4" title="&?InternetDE_089;">&?InternetDE_089;</option>
<option value="5" title="&?InternetDE_090;">&?InternetDE_090;</option>
<option value="6" title="&?InternetDE_091;">&?InternetDE_091;</option>
<option value="7" title="&?InternetDE_092;">&?InternetDE_092;</option>
<%end%>
<option value="8" title="&?InternetDE_093;">&?InternetDE_093;</option>
</select>
</div>
</div>
<div class="row" id="Prefix_MTU" style="display:none;">
<label for="MTU" class="cfgLabel w150">&?public_104;</label>
<div class="right">
<input type="text" class="inputNorm" id="MTU" name="MTU" value="1492"/>
</div>
</div>
<div class="row" id="Prefix_linkMode" style="display:none;">
<label for="linkMode" class="cfgLabel w150">&?InternetDE_013;</label>
<div class="right">
<select id="linkMode" name="linkMode" class="selectNorm">
<option value="PPP" title="&?public_102;">&?public_102;</option>
<option value="IP" title="&?public_044;">&?public_044;</option>
</select>
</div>
</div>
<div class="row" id="Prefix_TransType" style="display:none;">
<label for="TransType" class="cfgLabel w150">&?InternetDE_020;</label>
<div class="right">
<select id="TransType" name="TransType" class="selectNorm">
<option value="PPPoE" title="&?public_047;">&?public_047;</option>
</select>
</div>
</div>
<div id="forPpp" class="bgColorRow">
<div class="row"><b>PPP</b></div>
<div class="row" id="Prefix_UserName">
<label for="UserName" class="cfgLabel w150">&?public_026;</label>
<div class="right">
<input class="inputNorm" type="text" id="UserName" name="UserName" value=""/>
<span style="display:none;">&?public_073;1 ~ 128</span>
</div>
</div>
<div class="row" id="Prefix_Password">
<label for="Password" class="cfgLabel w150">&?public_027;</label>
<div class="right">
<input type="password" class="w150" id="Password" name="Password" autocomplete="new-password"/>
<span style="display:none;">&?public_073;1 ~ 128</span>
</div>
</div>
<div class="row" id="Prefix_AuthType">
<label for="AuthType" class="cfgLabel w150">&?InternetDE_016;</label>
<div class="right">
<select id="AuthType" name="AuthType" class="selectNorm">
<option value="PAP,CHAP,MS-CHAP" title="&?public_071;">&?public_071;</option>
<option value="PAP" title="&?public_124;">&?public_124;</option>
<option value="CHAP" title="&?public_125;">&?public_125;</option>
</select>
</div>
</div>
<div class="row" id="Prefix_ConnTrigger">
<label for="ConnTrigger" class="cfgLabel w150">&?InternetDE_017;</label>
<div class="right">
<select id="ConnTrigger" name="ConnTrigger" class="selectNorm">
<option value="AlwaysOn" title="&?InternetDE_034;">&?InternetDE_034;</option>
<option value="OnDemand" title="&?InternetDE_035;">&?InternetDE_035;</option>
</select>
</div>
</div>
<div class="row" id="Prefix_IdleTime" style="display:none">
<label for="IdleTime0" class="cfgLabel w150">&?InternetDE_018;</label>
<div class="right">
<input type="text" class="w80" id="IdleTime0" name="IdleTime0" value="20"/>&?public_012;
<span style="display:none;">&?public_072;0 ~ 1092</span>
<input type="text" class="w40" id="IdleTime1" name="IdleTime1" value="0"/>&?public_013;
<span style="display:none;">&?public_072;0 ~ 59</span>
</div>
</div>
<div class="segmentRow"></div>
</div>
<div class="row" id="Prefix_IpMode" style="display:none;">
<label for="IpMode" class="cfgLabel w150 ">&?InternetDE_019;</label>
<div class="right">
<select id="IpMode" name="IpMode" class="selectNorm">
<option value="IPv4" title="&?public_100;">&?public_100;</option>
<option value="IPv6" title="&?public_101;">&?public_101;</option>
<option value="Both" title="&?public_126;">&?public_126;</option>
</select>
</div>
</div>
<div id="foripvfback" class="bgColorRow">
<div class="row PostIgnore" id="Prefix_IPv4Label" style="display:none"><b>&?public_100;</b></div>
<div class="row PostIgnore" id="Prefix_Addressingtype" style="display:none">
<label for="Addressingtype" class="cfgLabel w150">&?InternetDE_021;</label>
<div class="right">
<select id="Addressingtype" name="Addressingtype" class="selectNorm">
<option value="DHCP" title="&?InternetDE_062;">&?InternetDE_062;</option>
<option value="Static" title="&?InternetDE_061;">&?InternetDE_061;</option>
</select>
</div>
</div>
<div id="forIpvf">
<div class="row" id="Prefix_sub_IPAddress0" style="display:none;">
<label for="IPAddress0" class="cfgLabel w150">&?public_007;</label>
<div class="right">
<input class="ip" name="IPAddress0" type="text" maxlength="3" id="IPAddress0" />.
<input class="ip" name="IPAddress1" type="text" maxlength="3" id="IPAddress1" />.
<input class="ip" name="IPAddress2" type="text" maxlength="3" id="IPAddress2" />.
<input class="ip" name="IPAddress3" type="text" maxlength="3" id="IPAddress3" />
</div>
</div>
<div class="row" id="Prefix_sub_SubnetMask0" style="display:none;">
<label for="SubnetMask0" class="cfgLabel w150">&?InternetDE_024;</label>
<div class="right">
<input class="ip" name="SubnetMask0" type="text" maxlength="3" id="SubnetMask0" />.
<input class="ip" name="SubnetMask1" type="text" maxlength="3" id="SubnetMask1" />.
<input class="ip" name="SubnetMask2" type="text" maxlength="3" id="SubnetMask2" />.
<input class="ip" name="SubnetMask3" type="text" maxlength="3" id="SubnetMask3" />
</div>
</div>
<div class="row" id="Prefix_sub_GateWay0" style="display:none;">
<label for="GateWay0" class="cfgLabel w150">&?public_031;</label>
<div class="right">
<input class="ip" name="GateWay0" type="text" maxlength="3" id="GateWay0" />.
<input class="ip" name="GateWay1" type="text" maxlength="3" id="GateWay1" />.
<input class="ip" name="GateWay2" type="text" maxlength="3" id="GateWay2" />.
<input class="ip" name="GateWay3" type="text" maxlength="3" id="GateWay3" />
</div>
</div>
<div class="row" id="Prefix_sub_DNS10" style="display:none;">
<label for="DNS10" class="cfgLabel w150">&?public_107;1</label>
<div class="right">
<input class="ip" name="DNS10" type="text" maxlength="3" id="DNS10" value="0" />.
<input class="ip" name="DNS11" type="text" maxlength="3" id="DNS11" value="0" />.
<input class="ip" name="DNS12" type="text" maxlength="3" id="DNS12" value="0" />.
<input class="ip" name="DNS13" type="text" maxlength="3" id="DNS13" value="0" />
</div>
</div>
<div class="row" id="Prefix_sub_DNS20" style="display:none;">
<label for="DNS20" class="cfgLabel w150">&?public_107;2</label>
<div class="right">
<input class="ip" name="DNS20" type="text" maxlength="3" id="DNS20" value="0" />.
<input class="ip" name="DNS21" type="text" maxlength="3" id="DNS21" value="0" />.
<input class="ip" name="DNS22" type="text" maxlength="3" id="DNS22" value="0" />.
<input class="ip" name="DNS23" type="text" maxlength="3" id="DNS23" value="0" />
</div>
</div>
<div class="row" id="Prefix_sub_DNS30" style="display:none;">
<label for="DNS30" class="cfgLabel w150">&?public_107;3</label>
<div class="right">
<input class="ip" name="DNS30" type="text" maxlength="3" id="DNS30" value="0" />.
<input class="ip" name="DNS31" type="text" maxlength="3" id="DNS31" value="0" />.
<input class="ip" name="DNS32" type="text" maxlength="3" id="DNS32" value="0" />.
<input class="ip" name="DNS33" type="text" maxlength="3" id="DNS33" value="0" />
</div>
</div>
</div>
<div id="IsNAT" class="row" style="display:none;">
<label class="cfgLabel w150">&?InternetDE_022;</label>
<input id="IsNAT1" type="radio" value="1" name="IsNAT" checked="checked">
<label for="IsNAT1">&?public_033;</label>&nbsp;&nbsp;
<input id="IsNAT0" type="radio" value="0" name="IsNAT" >
<label for="IsNAT0">&?public_034;</label>
</div>
<div class="segmentRow PostIgnore" id="Prefix_segment" style="display:none"></div>
</div>
<div id="foripvS" class="bgColorRow" style="display:none">
<div class="row"><b>IPv6</b></div>
<div class="row" id="Prefix_IPv6AcquireMode">
<label for="IPv6AcquireMode" class="cfgLabel w150">&?InternetDE_026;</label>
<div class="right">
<select id="IPv6AcquireMode" name="IPv6AcquireMode" class="w150">
<option value="Auto" title="&?InternetDE_039;">&?InternetDE_039;</option>
<option value="Manual" title="&?InternetDE_038;">&?InternetDE_038;</option>
<option value="IPv6CPExtension" title="&?InternetDE_040;">&?InternetDE_040;</option>
</select>
</div>
</div>
<div class="row" id="Prefix_Gua1">
<label for="Gua1" class="cfgLabel w150">&?InternetDE_027;</label>
<div class="right">
<input type="text" id="Gua1" name="Gua1" class="inputNorm" value=""/>
/<input type="text" id="Gua1PrefixLen" class="w37 readonlyInputBg" name="Gua1PrefixLen" value="128" readonly="readonly"/>
</div>
</div>
<div class="row" id="Prefix_Gateway6">
<label for="Gateway6" class="cfgLabel w150">&?InternetDE_028;</label>
<div class="right">
<input type="text" class="inputNorm" id="Gateway6" name="Gateway6" value=""/>
</div>
</div>
<div class="row" id="Prefix_Pd">
<label for="Pd" class="cfgLabel w150">&?InternetDE_030;</label>
<div class="right">
<input type="text" id="Pd" name="Pd" class="w150" value=""/>
/<input type="text" id="PdLen" class="w37" name="PdLen" value=""/>
<span style="display:none;">&?public_072;1 ~ 64</span>
</div>
</div>
<div class="row" id="Prefix_Dns1v6">
<label for="Dns1v6" class="cfgLabel w150">&?public_107;1</label>
<div class="right">
<input type="text" class="inputNorm" id="Dns1v6" name="Dns1v6" value=""/>
</div>
</div>
<div class="row" id="Prefix_Dns2v6">
<label for="Dns2v6" class="cfgLabel w150">&?public_107;2</label>
<div class="right">
<input type="text" class="inputNorm" id="Dns2v6" name="Dns2v6" value=""/>
</div>
</div>
<div class="row" id="Prefix_Dns3v6">
<label for="Dns3v6" class="cfgLabel w150">&?public_107;3</label>
<div class="right">
<input type="text" class="inputNorm" id="Dns3v6" name="Dns3v6" value=""/>
</div>
</div>
<div id="forSwitcher">
<div id="IsPD" class="row radiobutton">
<label class="cfgLabel w150">&?InternetDE_108;</label>
<input id="IsPD1" type="radio" value="1" name="IsPD" checked="checked">
<label for="IsPD1">&?public_033;</label>&nbsp;&nbsp;
<input id="IsPD0" type="radio" value="0" name="IsPD">
<label for="IsPD0">&?public_034;</label>
</div>
<div id="Unnumbered" class="row radiobutton">
<label class="cfgLabel w150">&?InternetDE_128;</label>
<input id="Unnumbered1" type="radio" value="1" name="Unnumbered">
<label for="Unnumbered1">&?public_033;</label>&nbsp;&nbsp;
<input id="Unnumbered0" type="radio" value="0" name="Unnumbered" checked="checked">
<label for="Unnumbered0">&?public_034;</label>
</div>
<div id="div_IsSLAAC" class="row">
<label class="cfgLabel w150">&?InternetDE_129;</label>
<div>
<input type="checkbox" value="" name="IsSLAAC" id="IsSLAAC" checked="checked">
<label for="IsSLAAC">&?InternetDE_105;</label>
</div>
</div>
<div id="div_IsGUA" class="row">
<label class="cfgLabel w150">&nbsp;</label>
<div>
<input type="checkbox" value="" name="IsGUA" id="IsGUA" checked="checked">
<label for="IsGUA">&?InternetDE_106;</label>
</div>
</div>
<div id="div_IsPdAddr" class="row">
<label class="cfgLabel w150">&nbsp;</label>
<div>
<input type="checkbox" value="" name="IsPdAddr" id="IsPdAddr" checked="checked">
<label for="IsPdAddr">&?InternetDE_031;</label>
</div>
</div>
</div>
<div class="segmentRow"></div>
</div>
<div id="forVlan" style="display:none;">
<div id="VlanEnable" class="row radiobutton">
<label class="cfgLabel w150">&?public_136;</label>
<input id="VlanEnable1" type="radio" value="1" name="VlanEnable" >
<label for="VlanEnable1">&?public_033;</label>&nbsp;&nbsp;
<input id="VlanEnable0" type="radio" value="0" name="VlanEnable" checked="checked">
<label for="VlanEnable0">&?public_034;</label>
</div>
<div class="bgColorRow">
<div class="row" id="Prefix_VLANID" style="display:none">
<label for="VLANID" class="cfgLabel w150">&?public_137;</label>
<div class="right">
<input class="inputNorm" type="text" id="VLANID" name="VLANID" value=""/>
<span style="display:none;">&?public_072;0 ~ 4094</span>
</div>
</div>
<div class="row" id="Prefix_Priority" style="display:none">
<label for="Priority" class="cfgLabel w150">&?public_103;</label>
<div class="right">
<select id="Priority" name="Priority" class="selectNorm">
<option value="0" title="0">0</option>
<option value="1" title="1">1</option>
<option value="2" title="2">2</option>
<option value="3" title="3">3</option>
<option value="4" title="4">4</option>
<option value="5" title="5">5</option>
<option value="6" title="6">6</option>
<option value="7" title="7">7</option>
</select>
</div>
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_internet" name="Btn_cancel_IPFilter" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_internet" name="Btn_apply_IPFilter" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
