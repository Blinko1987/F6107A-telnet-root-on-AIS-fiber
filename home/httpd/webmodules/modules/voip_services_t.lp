<%
cgilua.lp.include("../../webmodules/modules/voip_services_js.lp", getfenv(1))
local contrlStr = ""
if _G.voipConf["VOIPSipService"] ~= nil then
contrlStr = _G.voipConf["VOIPSipService"]
end
%>
<div id="VOIPSipService" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Voip_SipService_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_VOIPSipService" style="display:none;">
<h1 class="collapsibleBar" id="VOIPRegStatusBar">&?VoipBasic_002;</h1>
<div id="VOIPSipService_container" style="display:none;">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="staticInfoHint">
<p>&?SipServices_003;</p>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="ThreeWayTalkingBySS" value="">
<div class="row">
<label for="AuthUserName" class="cfgLabel w200">&?VoipBasic_005;</label>
<div class="right">
<input type="text" id="AuthUserName" name="AuthUserName" value="" class="inputNorm PostIgnore" disabled/>
</div>
</div>
<div class="row">
<label for="CallForwardUnconditionalEnable" class="left w200">&?SipServices_004;</label>
<div id="CallForwardUnconditionalEnable" class="right">
<input type="radio" id="CallForwardUnconditionalEnable1" name="CallForwardUnconditionalEnable" value="1"/>
<label for="CallForwardUnconditionalEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallForwardUnconditionalEnable0" name="CallForwardUnconditionalEnable" value="0"/>
<label for="CallForwardUnconditionalEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_CallForwardUnconditionalNumber">
<label for="CallForwardUnconditionalNumber" class="cfgLabel w200">&?SipServices_005;</label>
<div class="right">
<input type="text" id="CallForwardUnconditionalNumber" name="CallForwardUnconditionalNumber" value=""/>
<span style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="CallForwardOnBusyEnable" class="left w200">&?SipServices_006;</label>
<div id="CallForwardOnBusyEnable" class="right">
<input type="radio" id="CallForwardOnBusyEnable1" name="CallForwardOnBusyEnable" value="1"/>
<label for="CallForwardOnBusyEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallForwardOnBusyEnable0" name="CallForwardOnBusyEnable" value="0"/>
<label for="CallForwardOnBusyEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_CallForwardOnBusyNumber">
<label for="CallForwardOnBusyNumber" class="cfgLabel w200">&?SipServices_005;</label>
<div class="right">
<input type="text" id="CallForwardOnBusyNumber" name="CallForwardOnBusyNumber" value=""/>
<span style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="CallForwardOnNoAnswerEnable" class="left w200">&?SipServices_007;</label>
<div id="CallForwardOnNoAnswerEnable" class="right">
<input type="radio" id="CallForwardOnNoAnswerEnable1" name="CallForwardOnNoAnswerEnable" value="1"/>
<label for="CallForwardOnNoAnswerEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallForwardOnNoAnswerEnable0" name="CallForwardOnNoAnswerEnable" value="0"/>
<label for="CallForwardOnNoAnswerEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_CallForwardOnNoAnswerNumber">
<label for="CallForwardOnNoAnswerNumber" class="cfgLabel w200">&?SipServices_005;</label>
<div class="right">
<input type="text" id="CallForwardOnNoAnswerNumber" name="CallForwardOnNoAnswerNumber" value=""/>
<span style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row" id="div_CfnrTimer">
<label for="CfnrTimer" class="cfgLabel w200">&?SipServices_008;</label>
<div class="right">
<input type="text" id="CfnrTimer" name="CfnrTimer" value=""/>
<label>&?SipServices_009;</label>
<span style="display: none;">&?public_072;500 ~ 6000</span>
</div>
</div>
<div class="row">
<label for="CallWaitingEnable" class="left w200">&?SipServices_010;</label>
<div id="CallWaitingEnable" class="right">
<input type="radio" id="CallWaitingEnable1" name="CallWaitingEnable" value="1"/>
<label for="CallWaitingEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallWaitingEnable0" name="CallWaitingEnable" value="0"/>
<label for="CallWaitingEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="CallTransfer" class="left w200">&?SipServices_011;</label>
<div id="CallTransfer" class="right">
<input type="radio" id="CallTransfer1" name="CallTransfer" value="1"/>
<label for="CallTransfer1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallTransfer0" name="CallTransfer" value="0"/>
<label for="CallTransfer0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="CallHoldFlag" class="left w200">&?SipServices_012;</label>
<div id="CallHoldFlag" class="right">
<input type="radio" id="CallHoldFlag1" name="CallHoldFlag" value="1"/>
<label for="CallHoldFlag1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallHoldFlag0" name="CallHoldFlag" value="0"/>
<label for="CallHoldFlag0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="MCIDEnable" class="left w200">&?SipServices_026;</label>
<div id="MCIDEnable" class="right">
<input type="radio" id="MCIDEnable1" name="MCIDEnable" value="1"/>
<label for="MCIDEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="MCIDEnable0" name="MCIDEnable" value="0"/>
<label for="MCIDEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="SipDelayHookonFlag" class="left w200">&?SipServices_013;</label>
<div id="SipDelayHookonFlag" class="right">
<input type="radio" id="SipDelayHookonFlag1" name="SipDelayHookonFlag" value="1"/>
<label for="SipDelayHookonFlag1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="SipDelayHookonFlag0" name="SipDelayHookonFlag" value="0"/>
<label for="SipDelayHookonFlag0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="ServInfoReport" class="left w200">&?SipServices_014;</label>
<div id="ServInfoReport" class="right">
<input type="radio" id="ServInfoReport1" name="ServInfoReport" value="1"/>
<label for="ServInfoReport1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="ServInfoReport0" name="ServInfoReport" value="0"/>
<label for="ServInfoReport0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="ThreeWayTalkingBySelf" class="left w200">&?SipServices_015;</label>
<div id="ThreeWayTalkingBySelf" class="right">
<input type="radio" id="ThreeWayTalkingBySelf1" name="ThreeWayTalkingBySelf" value="1"/>
<label for="ThreeWayTalkingBySelf1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="ThreeWayTalkingBySelf0" name="ThreeWayTalkingBySelf" value="0"/>
<label for="ThreeWayTalkingBySelf0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_ConfUri">
<label for="ConfUri" class="cfgLabel w200">&?SipServices_017;</label>
<div class="right">
<input type="text" id="ConfUri" name="ConfUri" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;0 ~ 31</span>
</div>
</div>
<div class="row">
<label for="HotLine" class="left w200">&?SipServices_018;</label>
<div class="right">
<select name="HotLine" id="HotLine" class="selectNorm">
<option value="0" title='&?SipServices_019;'>&?SipServices_019;</option>
<option value="1" title='&?SipServices_020;'>&?SipServices_020;</option>
<option value="2" title='&?SipServices_021;'>&?SipServices_021;</option>
</select>
</div>
</div>
<div class="row" id="div_HLNumber">
<label for="HLNumber" class="cfgLabel w200">&?SipServices_022;</label>
<div class="right">
<%
if("1" == env.getenv("HotType")) then
%>
<input type="text" id="HLNumber" name="HLNumber" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;1 ~ 63</span>
<%
else
%>
<input type="text" id="HLNumber" name="HLNumber" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;1 ~ 32</span>
<%end%>
</div>
</div>
<div class="row" id="div_DhlTimer">
<label for="DhlTimer" class="cfgLabel w200">&?SipServices_023;</label>
<div class="right">
<input type="text" id="DhlTimer" name="DhlTimer" value="" class="inputNorm"/>
<label>&?SipServices_009;</label>
</div>
</div>
<div class="row">
<label for="AntiPole" class="left w200">&?SipServices_024;</label>
<div id="AntiPole" class="right">
<input type="radio" id="AntiPole1" name="AntiPole" value="1"/>
<label for="AntiPole1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="AntiPole0" name="AntiPole" value="0"/>
<label for="AntiPole0">&?public_034;</label>
</div>
</div>
<%if string.find(contrlStr,"ReAccessIfPeerHookedOn") ~= nil then%>
<div class="row">
<label for="ReAccessIfPeerHookedOn" class="left w200">&?SipServices_025;</label>
<div id="ReAccessIfPeerHookedOn" class="right">
<input type="radio" id="ReAccessIfPeerHookedOn1" name="ReAccessIfPeerHookedOn" value="1"/>
<label for="ReAccessIfPeerHookedOn1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="ReAccessIfPeerHookedOn0" name="ReAccessIfPeerHookedOn" value="0"/>
<label for="ReAccessIfPeerHookedOn0">&?public_034;</label>
</div>
</div>
<%end%>
<%if string.find(contrlStr,"AlertingTimer") ~= nil then%>
<div class="row" id="div_AlertingTimer">
<label for="AlertingTimer" class="cfgLabel w200">&?SipServices_008;</label>
<div class="right">
<input type="text" id="AlertingTimer" name="AlertingTimer" value=""/>
<label>&?SipServices_009;</label>
<span style="display: none;">&?public_072;3000 ~ 12000</span>
</div>
</div>
<%end%>
<%if string.find(contrlStr,"CallerIDEnable") ~= nil then%>
<div class="row">
<label for="CallerIDEnable" class="left w200">&?SipServices_101;</label>
<div id="CallerIDEnable" class="right">
<input type="radio" id="CallerIDEnable1" name="CallerIDEnable" value="1"/>
<label for="CallerIDEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CallerIDEnable0" name="CallerIDEnable" value="0"/>
<label for="CallerIDEnable0">&?public_034;</label>
</div>
</div>
<% end %>
<%if string.find(contrlStr,"CidDisplayEnable") ~= nil then%>
<div class="row">
<label for="CidDisplayEnable" class="left w200">&?SipServices_102;</label>
<div id="CidDisplayEnable" class="right">
<input type="radio" id="CidDisplayEnable1" name="CidDisplayEnable" value="1"/>
<label for="CidDisplayEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="CidDisplayEnable0" name="CidDisplayEnable" value="0"/>
<label for="CidDisplayEnable0">&?public_034;</label>
</div>
</div>
<% end %>
<div class="segmentRow"></div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_VOIPSipService" name="Btn_cancel_VOIPSipService" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_VOIPSipService" name="Btn_apply_VOIPSipService" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
