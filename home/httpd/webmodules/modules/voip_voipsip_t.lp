<%
cgilua_lp.include("../../webmodules/modules/voip_voipsip_js.lp", getfenv(1))
local contrlStr = ""
if _G.voipConf["VoIPSIP"] ~= nil then
contrlStr = _G.voipConf["VoIPSIP"]
end
%>
<div id="VoIPSIP" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_voipsip_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="VoIPSIPBar">&?VoipSip_001;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VoIPSIP_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VoIPSIP" class="formTblWrap" style="display:none;">
<div id="topLine_VoIPSIP" class="formTblCtrlBar">
<span id="instName_VoIPSIP" class="instName collapsibleInst instNameExp">&?public_041;</span>
</div>
<div id="changeArea_VoIPSIP" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="_InstIDTIMER" value="-1">
<input type="hidden" id="_InstIDBEARINFO" value="-1">
<input type="hidden" id="CodecList" value="-1">
<%if string.find(contrlStr,"DNSMode") ~= nil then%>
<div class="row">
<label for="DNSMode" class="cfgLabel w250">&?DNSMode_001;</label>
<div class="right">
<select class="selectNorm" id="DNSMode" name="DNSMode">
<option value="0" title='&?public_107;'>&?public_107;</option>
<option value="1" title='&?DNSMode_002;'>&?DNSMode_002;</option>
<option value="2" title='&?DNSMode_003;'>&?DNSMode_003;</option>
</select>
</div>
</div>
<%
end
if string.find(contrlStr,"Opt120FlagControl") ~= nil then
%>
<div class="row" id="div_Opt120FlagControl">
<label for="Opt120FlagControl" class="cfgLabel w250">&?InternetDE_135;</label>
<div class="right" id="Opt120FlagControl">
<input type="radio" id="Opt120FlagControl1" name="Opt120FlagControl" value="1"/><label for="Opt120FlagControl1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Opt120FlagControl0" name="Opt120FlagControl" value="0"/><label for="Opt120FlagControl0">&?public_034;</label>
</div>
</div>
<%
end
if string.find(contrlStr,"UserAgentDomain") ~= nil then
%>
<div class="row">
<label for="UserAgentDoimain" class="cfgLabel w250">&?voipvsp_001;</label>
<div class="right">
<input type="text" id="UserAgentDoimain" name="UserAgentDoimain" value="" class="inputNorm">
</div>
</div>
<%end%>
<div class="row">
<label for="UserAgentPort" class="cfgLabel w250">&?VoipSip_002;</label>
<div class="right">
<input type="text" id="UserAgentPort" name="UserAgentPort" value="" class="inputNorm">
<span style="display: none;">&?public_072;1024 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="RegistrarServer1" class="cfgLabel w250">&?VoipSip_016;</label>
<div class="right">
<input type="text" id="RegistrarServer1" name="RegistrarServer1" value="" class="inputNorm"/>
</div>
</div>
<div class="row">
<label for="ProxyServer1" class="cfgLabel w250">&?VoipSip_003;</label>
<div class="right">
<input type="text" id="ProxyServer1" name="ProxyServer1" value="" class="inputNorm"/>
</div>
</div>
<div class="row">
<label for="OutboundProxy1" class="cfgLabel w250">&?VoipSip_004;</label>
<div class="right">
<input type="text" id="OutboundProxy1" name="OutboundProxy1" value="" class="inputNorm"/>
</div>
</div>
<div class="row">
<label for="ProxyServerPort1" class="cfgLabel w250">&?VoipSip_005;</label>
<div class="right">
<input type="text" id="ProxyServerPort1" name="ProxyServerPort1" value="" class="inputNorm"/>
<span style="display: none;">&?public_072;1024 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="RegistrarServer2" class="cfgLabel w250">&?VoipSip_017;</label>
<div class="right">
<input type="text" id="RegistrarServer2" name="RegistrarServer2" value="" class="inputNorm"/>
</div>
</div>
<div class="row">
<label for="ProxyServer2" class="cfgLabel w250">&?VoipSip_006;</label>
<div class="right">
<input type="text" id="ProxyServer2" name="ProxyServer2" value="" class="inputNorm"/>
</div>
</div>
<div class="row">
<label for="OutboundProxy2" class="cfgLabel w250">&?VoipSip_007;</label>
<div class="right">
<input type="text" id="OutboundProxy2" name="OutboundProxy2" value="" class="inputNorm"/>
</div>
</div>
<div class="row">
<label for="ProxyServerPort2" class="cfgLabel w250">&?VoipSip_008;</label>
<div class="right">
<input type="text" id="ProxyServerPort2" name="ProxyServerPort2" value="" class="inputNorm"/>
<span style="display: none;">&?public_072;1024 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="RegisterExpires" class="cfgLabel w250">&?VoipSip_009;</label>
<div class="right">
<input type="text" id="RegisterExpires" name="RegisterExpires" value="" class="inputNorm"/>&?public_013;
<span style="display: none;">&?public_072;1 ~ 4 294 967 295</span>
</div>
</div>
<div class="row">
<label for="DeRegister" class="cfgLabel w250">&?VoipSip_015;</label>
<div class="right" id="DeRegister">
<input type="radio" id="DeRegister1" name="DeRegister" value="1"/><label for="DeRegister1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="DeRegister0" name="DeRegister" value="0"/><label for="DeRegister0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="LinkTest" class="cfgLabel w250">&?VoipSip_010;</label>
<div class="right" id="LinkTest">
<input type="radio" id="LinkTest1" name="LinkTest" value="2"/><label for="LinkTest1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="LinkTest0" name="LinkTest" value="0"/><label for="LinkTest0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="LinkTestInterval" class="cfgLabel w250">&?VoipSip_011;</label>
<div class="right">
<input type="text" id="LinkTestInterval" name="LinkTestInterval" value="" class="inputNorm"/>&?public_013;
<span style="display: none;">&?public_072;1 ~ 4 294 967 295</span>
</div>
</div>
<%if string.find(contrlStr,"StartTimer") ~= nil then%>
<div class="row">
<label for="StartTimer" class="cfgLabel w250">&?VoipSip_018;</label>
<div class="right">
<input type="text" id="StartTimer" name="StartTimer" value="" class="inputNorm"/>&?SipAdvanced_029;
<span style="display: none;">&?public_072;1500 ~ 6000</span>
</div>
</div>
<%
end
if env.getenv("VoIPTR104V2") == "1" then
%>
<div class="row">
<label for="CodecList" class="cfgLabel w250">&?SIPMedia_007;</label>
<div class="right">
<input type="text" id="CodecList_" name="CodecList_" value="" class="inputNorm"/>
<span style="display: none;">&?Tr104v2_005;</span>
</div>
</div>
<%
end
%>
<div class="row" id="div_EventSubscription" style="display: none;">
<label for="EventSubscription" class="cfgLabel w250">&?VoipSip_019;</label>
<div class="right PostIgnore" id="EventSubscription">
<input type="radio" id="EventSubscription1" name="EventSubscription" value="1"/><label for="EventSubscription1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="EventSubscription0" name="EventSubscription" value="0"/><label for="EventSubscription0">&?public_034;</label>
</div>
</div>
<%if string.find(contrlStr,"UPDATE") ~= nil then%>
<div class="row" id="div_UPDATE">
<label for="Timer" class="cfgLabel w250">&?VoipSip_020;</label>
<div class="right" id="Timer">
<input type="radio" id="Timer1" name="Timer" value="1"/><label for="Timer1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Timer0" name="Timer" value="0"/><label for="Timer0">&?public_034;</label>
</div>
</div>
<%
end
if string.find(contrlStr,"InviteExpires") ~= nil then
%>
<div class="row" id="div_InviteExpires">
<label for="InviteExpires" class="cfgLabel w250">&?VoipSip_021;</label>
<div class="right">
<input type="text" id="InviteExpires" name="InviteExpires" value="" class="inputNorm"/>&?public_013;
<span style="display: none;">&?public_072;1 ~ 4 294 967 295</span>
</div>
</div>
<%
end
if string.find(contrlStr,"PRACK") ~= nil then
%>
<div class="row" id="div_PRACK">
<label for="V100rel" class="cfgLabel w250">&?VoipSip_022;</label>
<div class="right" id="V100rel">
<input type="radio" id="V100rel1" name="V100rel" value="1"/><label for="V100rel1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="V100rel0" name="V100rel" value="0"/><label for="V100rel0">&?public_034;</label>
</div>
</div>
<%end%>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
