<%
%>
<div id="SvcSimulation" class="HeadDIV" style="padding-top:0">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=networkdiag_svcsimulation_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="SvcSimulation_container">
<div id="template_SvcSimulation">
<div id="topLine_SvcSimulation" class="formTblCtrlBar">
<span id="instName_SvcSimulation" class="instName collapsibleInst" title="&?SvcSimulation_001;">&?SvcSimulation_001;</span>
</div>
<div id="changeArea_SvcSimulation" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="OptCode" value="60">
<input type="hidden" id="OptLen" value="">
<input type="hidden" id="PortState" value="">
<input type="hidden" id="SimulationType" value="">
<input type="hidden" id="SimuMAC" value="">
<input type="hidden" id="PingDestIP" value="">
<input type="hidden" id="BNeedPing" value="1">
<input type="hidden" id="BNeedRelease" value="1">
<div class="row">
<label for="S_SimulationType" class="left w180">&?SvcSimulation_002;</label>
<div class="right">
<select id="S_SimulationType" name="S_SimulationType" class="selectNorm PostIgnore" >
<option value="1" title='&?public_047;' selected="selected">&?public_047;</option>
<option value="2" title="&?SvcSimulation_003;">&?SvcSimulation_003;</option>
</select>
</div>
</div>
<div class="row">
<label for="PortViewName" class="left w180">&?public_135;</label>
<div class="right">
<select id="PortViewName" name="PortViewName" class="selectNorm" >
<%
cgilua.put(_G.CreateIFOpStr("SvcSimulation"))
%>
</select>
</div>
</div>
<div class="row">
<label class="left w180">&?public_136;</label>
<div class="right" id="UseVlan">
<input type="radio" id="UseVlan1" name="UseVlan" value="1"/><label for="UseVlan1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="UseVlan0" name="UseVlan" value="0" checked="checked"/><label for="UseVlan0">&?public_034;</label>
</div>
</div>
<div class="row vlanRelv">
<label for="VlanId" class="left w180">&?public_137;</label>
<div class="right">
<input type="text" class="inputNorm" id="VlanId" name="VlanId" value=""/>
<span style="display:none;">&?public_072;1 ~ 4094</span>
</div>
</div>
<div class="row vlanRelv">
<label for="VlanPri" class="left w180">&?public_103;</label>
<div class="right">
<select id="VlanPri" name="VlanPri" class="selectNorm" >
<option value="0" selected="selected">0</option>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
</select>
</div>
</div>
<div class="row forPPPoE">
<label for="PppoeUserName" class="left w180">&?public_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="PppoeUserName" name="PppoeUserName" value=""/>
</div>
</div>
<div class="row forPPPoE">
<label for="PppoePassWord" class="left w180">&?public_027;</label>
<div class="right">
<input type="password" class="inputNorm SpecialPassword" id="PppoePassWord" name="PppoePassWord" value="" autocomplete="new-password" encode="1"/>
</div>
</div>
<div class="row forPPPoE">
<label for="AuthType" class="left w180">&?SvcSimulation_004;</label>
<div class="right">
<select id="AuthType" name="AuthType" class="selectNorm" >
<option value="0" title="&?public_071;" selected="selected">&?public_071;</option>
<option value="1" title="&?public_124;">&?public_124;</option>
<option value="2" title="&?public_125;">&?public_125;</option>
</select>
</div>
</div>
<div class="row forPPPoE">
<label for="IPMode" class="left w180">&?SvcSimulation_016;</label>
<div class="right">
<select id="IPMode" name="IPMode" class="selectNorm">
<option value="IPv4" title="&?public_100;" selected="selected">&?public_100;</option>
<option value="IPv6" title="&?public_101;">&?public_101;</option>
<option value="Both" title="&?public_126;">&?public_126;</option>
</select>
</div>
</div>
<div class="row forPPPoE">
<label for="RetryTimes" class="left w180">&?SvcSimulation_005;</label>
<div class="right">
<input type="text" class="inputNorm" id="RetryTimes" name="RetryTimes" value=""/>
<span style="display:none;">&?public_072;1 ~ 3</span>
</div>
</div>
<div class="row forDHCP">
<label for="sub_SimuMAC0" class="left w180">&?SvcSimulation_006;</label>
<div class="right">
<input name="sub_SimuMAC0" type="text" class="mac" maxlength="2" id="sub_SimuMAC0" value="" />:
<input name="sub_SimuMAC1" type="text" class="mac" maxlength="2" id="sub_SimuMAC1" value="" />:
<input name="sub_SimuMAC2" type="text" class="mac" maxlength="2" id="sub_SimuMAC2" value="" />:
<input name="sub_SimuMAC3" type="text" class="mac" maxlength="2" id="sub_SimuMAC3" value="" />:
<input name="sub_SimuMAC4" type="text" class="mac" maxlength="2" id="sub_SimuMAC4" value="" />:
<input name="sub_SimuMAC5" type="text" class="mac" maxlength="2" id="sub_SimuMAC5" value="" />
</div>
</div>
<div class="row forDHCP">
<label for="SimuTimeOut" class="left w180">&?SvcSimulation_007;</label>
<div class="right">
<input type="text" class="inputNorm" id="SimuTimeOut" name="SimuTimeOut" value=""/>&?public_013;
<span style="display:none;">&?public_072;1 ~ 60</span>
</div>
</div>
<div class="row forDHCP">
<label class="left w180">&?SvcSimulation_008;</label>
<div class="right" id="Opt60Mode">
<input type="radio" id="Opt60Mode0" name="Opt60Mode" value="0" checked="checked"/><label for="Opt60Mode0">&?SvcSimulation_009;</label>&nbsp;&nbsp;
<input type="radio" id="Opt60Mode1" name="Opt60Mode" value="1"/><label for="Opt60Mode1" >&?SvcSimulation_010;</label>
</div>
</div>
<div class="row forDHCP OptAccout">
<label for="UserNameOpt60" class="left w180">&?public_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="UserNameOpt60" name="UserNameOpt60" value=""/>
</div>
</div>
<div class="row forDHCP OptAccout">
<label for="PassWordOpt60" class="left w180">&?public_027;</label>
<div class="right">
<input type="password" class="inputNorm" id="PassWordOpt60" name="PassWordOpt60" value="" autocomplete="new-password"/>
</div>
</div>
<div class="row forDHCP OptMac">
<label for="OptContent" class="left w180">&?SvcSimulation_011;</label>
<div class="right">
<input type="text" class="inputNorm" id="OptContent" name="OptContent" value=""/>
</div>
</div>
<div class="row forDHCP">
<label for="sub_PingDestIP0" class="left w180">&?SvcSimulation_012;</label>
<div class="right">
<input name="sub_PingDestIP0" type="text" maxlength="3" id="sub_PingDestIP0" value="" class="ip" />.
<input name="sub_PingDestIP1" type="text" maxlength="3" id="sub_PingDestIP1" value="" class="ip" />.
<input name="sub_PingDestIP2" type="text" maxlength="3" id="sub_PingDestIP2" value="" class="ip" />.
<input name="sub_PingDestIP3" type="text" maxlength="3" id="sub_PingDestIP3" value="" class="ip" />
</div>
</div>
<div class="row forDHCP">
<label for="PingTimes" class="left w180">&?SvcSimulation_013;</label>
<div class="right">
<input type="text" class="inputNorm" id="PingTimes" name="PingTimes" value=""/>
<span style="display:none;">&?public_072;1 ~ 20</span>
</div>
</div>
<div class="row forDHCP">
<label for="PingTimeOut" class="left w180">&?SvcSimulation_014;</label>
<div class="right">
<input type="text" class="inputNorm" id="PingTimeOut" name="PingTimeOut" value=""/>&?public_052;
<span style="display:none;">&?public_072;1 ~ 3000</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_SvcSimulation PostIgnore" id="Btn_SvcSimulation" name="Btn_SvcSimulation" value="&?DiagnosisManag_001;" />
</div>
<div class="row">
<label class="left w180">&?SvcSimulation_015;</label>
</div>
<div class="textareaRow">
<textarea id="SvcSimuResult" value="" readonly="readonly"></textarea>
</div>
<div class="segmentRow"></div>
</form>
</div>
</div>
</div>
</div>
