<%
cgilua_lp.include("../../webmodules/modules/firewall_ipv6service_js.lp", getfenv(1))
%>
<div id="IPv6serviceCtl" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_ipv6service_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IPv6serviceCtlBar">&?Security_072;</h1>
<div id="IPv6serviceCtl_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_IPv6serviceCtl" style="display:none;">
<form class="form_content">
<div id="topLine_IPv6serviceCtl" class="formTblCtrlBar">
<span id="instName_IPv6serviceCtl" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable:IPv6serviceCtl">
<input type="radio" id="Enable1:IPv6serviceCtl" name="Enable:IPv6serviceCtl" value="1"/><label for="Enable1:IPv6serviceCtl">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0:IPv6serviceCtl" name="Enable:IPv6serviceCtl" value="0" checked="checked"/><label for="Enable0:IPv6serviceCtl">&?public_034;</label>
</div>
</span>
<span id="instDelete_IPv6serviceCtl" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_IPv6serviceCtl" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="INCName" value="">
<input type="hidden" id="ServiceList" value="">
<input type="hidden" id="IPMode" value="2">
<input type="hidden" id="PrefixLen" value="">
<input type="hidden" id="Prefix" value="">
<div class="row">
<label for="Name:IPv6serviceCtl" class="cfgLabel w150">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Name:IPv6serviceCtl" name="Name:IPv6serviceCtl" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w150">&?Security_031;</label>
<div id="FilterTarget:IPv6serviceCtl" class="right">
<input type="radio" id="FilterTarget1:IPv6serviceCtl" name="FilterTarget:IPv6serviceCtl" value="1" checked="checked"/><label for="FilterTarget1:IPv6serviceCtl">&?Security_032;</label>&nbsp;&nbsp;
<input type="radio" id="FilterTarget0:IPv6serviceCtl" name="FilterTarget:IPv6serviceCtl" value="0"/><label for="FilterTarget0:IPv6serviceCtl">&?Security_033;</label>
</div>
</div>
<div class="row">
<label for="INCViewName:IPv6serviceCtl" class="cfgLabel w150">&?Security_029;</label>
<div class="right">
<select class="selectNorm" id="INCViewName:IPv6serviceCtl" name="INCViewName:IPv6serviceCtl" >
<option value="IGD.WANIF" title='&?public_128;'>&?public_128;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv6ServCtl",nil,{"WANServlist"}))
%>
</select>
</div>
</div>
<div class="row">
<label class="left w150" for="Prefix">&?Security_073;</label>
<div class="right">
<input id="ShowPrefix" class="inputNorm" type="text" value="" name="ShowPrefix">
/
<input id="ShowPrefixLen" class="w37" type="text" value="" name="ShowPrefixLen">
<span style="display:none;">&?public_072;1 ~ 128</span>
</div>
</div>
<div class="row">
<label for="ServiceList" class="cfgLabel w150">&?Security_054;</label>
<div class="right" id="ServiceControlList6">
<%
local fwCommFunc = require "modules.firewall_common_func"
cgilua.put(fwCommFunc.CreateFwSCChkBoxGroup("IPv6"))
%>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_IPv6serviceCtl" name="Btn_cancel_IPv6serviceCtl" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_IPv6serviceCtl" name="Btn_apply_IPv6serviceCtl" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_IPv6serviceCtl" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
