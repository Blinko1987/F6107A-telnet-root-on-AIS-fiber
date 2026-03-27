<%
cgilua_lp.include("../../webmodules/modules/firewall_portforwarding_js.lp", getfenv(1))
%>
<div class="instCfgArea">
<div id="PortForwarding" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_portforwarding_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PortForwardingBar">&?PortForwarding_001;</h1>
<div id="PortForwarding_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?PortForwarding_004;</a></div>
<div class="sceneTip_container">
<p>&?PortForwarding_006;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_PortForwarding" style="display:none;">
<form class="form_content">
<div id="topLine_PortForwarding" class="formTblCtrlBar">
<span id="instName_PortForwarding" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1" checked="checked"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0" /><label for="Enable0" >&?public_034;</label>
</div>
</span>
<span id="instDelete_PortForwarding" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_PortForwarding" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="RemoteHost" _LuQUID_splitIPID="sub_RemoteHost" value="">
<input type="hidden" id="RemoteHostEndRange" _LuQUID_splitIPID="sub_RemoteHostEndRange" value="">
<input type="hidden" id="AllInterface" value="">
<input type="hidden" id="Interface" value="">
<div class="row" id="div_Alias">
<label for="Alias" class="cfgLabel w250">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Alias" name="Alias" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 192</span>
</div>
</div>
<div class="row" id="div_Description" style="display: none;">
<label for="Description" class="cfgLabel w250">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm postIgnore" id="Description" name="Description" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 765</span>
</div>
</div>
<div class="row">
<label for="Protocol" class="cfgLabel w250">&?public_053;</label>
<div class="right">
<select class="selectNorm" id="Protocol" name="Protocol">
<option value="TCP" title='&?public_036;'>&?public_036;</option>
<option value="UDP" title='&?public_037;'>&?public_037;</option>
<option value="BOTH" title='&?public_040;'>&?public_040;</option>
</select>
</div>
</div>
<div class="row">
<label for="S_Interface" class="cfgLabel w250">&?public_015;</label>
<div class="right">
<select class="selectNorm PostIgnore" id="S_Interface" name="S_Interface">
<option value="WANAll" title='&?public_094;'>&?public_094;</option>
<%
cgilua.put(_G.CreateIFOpStr("PortForward",nill,{"WANServlist"}))
%>
</select>
</div>
</div>
<div class="row">
<label for="sub_RemoteHost0" class="cfgLabel w250">&?PortForwarding_003;</label>
<div class="right">
<input class="ip" name="sub_RemoteHost0" type="text" maxlength="3" id="sub_RemoteHost0" value="0"/>.
<input class="ip" name="sub_RemoteHost1" type="text" maxlength="3" id="sub_RemoteHost1" value="0"/>.
<input class="ip" name="sub_RemoteHost2" type="text" maxlength="3" id="sub_RemoteHost2" value="0"/>.
<input class="ip" name="sub_RemoteHost3" type="text" maxlength="3" id="sub_RemoteHost3" value="0"/>
~
<input class="ip" name="sub_RemoteHostEndRange0" type="text" maxlength="3" id="sub_RemoteHostEndRange0" value="0"/>.
<input class="ip" name="sub_RemoteHostEndRange1" type="text" maxlength="3" id="sub_RemoteHostEndRange1" value="0"/>.
<input class="ip" name="sub_RemoteHostEndRange2" type="text" maxlength="3" id="sub_RemoteHostEndRange2" value="0"/>.
<input class="ip" name="sub_RemoteHostEndRange3" type="text" maxlength="3" id="sub_RemoteHostEndRange3" value="0"/>
</div>
</div>
<div class="row">
<label for="InternalClient" class="cfgLabel w250">&?PortForwarding_008;</label>
<div class="right">
<input type="text" class="inputNorm" id="InternalClient" name="InternalClient" value=""/>
<span class="dTip" style="display: none;">&?PortForwarding_013;</span>
</div>
</div>
<div class="row">
<label for="ExternalPort" class="cfgLabel w250">&?PortForwarding_005;</label>
<div class="right">
<input type="text" class="port" id="ExternalPort" name="ExternalPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
~
<input type="text" class="port" id="ExternalPortEndRange" name="ExternalPortEndRange" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="InternalPort" class="cfgLabel w250">&?PortForwarding_009;</label>
<div class="right">
<input type="text" class="port" id="InternalPort" name="InternalPort" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
~
<input type="text" class="port" id="InternalPortEndRange" name="InternalPortEndRange" value=""/>
<span class="dTip" style="display: none;">&?public_072;1 ~ 65535</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_PortForwarding" name="Btn_cancel_PortForwarding" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_PortForwarding" name="Btn_apply_PortForwarding" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_PortForwarding" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
</div>
