<%
cgilua_lp.include("../../webmodules/modules/firewall_ipv4service_js.lp", getfenv(1))
%>
<div id="serviceCtl" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_ipv4service_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="serviceCtlBar">&?Security_048;</h1>
<div id="serviceCtl_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_serviceCtl" style="display:none;">
<form class="form_content">
<div id="topLine_serviceCtl" class="formTblCtrlBar">
<span id="instName_serviceCtl" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable:serviceCtl">
<input type="radio" id="Enable1:serviceCtl" name="Enable:serviceCtl" value="1"/><label for="Enable1:serviceCtl">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0:serviceCtl" name="Enable:serviceCtl" value="0" checked="checked"/><label for="Enable0:serviceCtl" >&?public_034;</label>
</div>
</span>
<span id="instDelete_serviceCtl" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_serviceCtl" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="INCName" value="">
<input type="hidden" id="MinSrcIp" _LuQUID_splitIPID="sub_MinSrcIp" value="">
<input type="hidden" id="MaxSrcIp" _LuQUID_splitIPID="sub_MaxSrcIp" value="">
<input type="hidden" id="ServiceList" value="">
<input type="hidden" id="IPMode" value="1">
<div class="row">
<label for="Name:serviceCtl" class="cfgLabel w150">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Name:serviceCtl" name="Name:serviceCtl" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w150">&?Security_031;</label>
<div id="FilterTarget:serviceCtl" class="right">
<input type="radio" id="FilterTarget1:serviceCtl" name="FilterTarget:serviceCtl" value="1" checked="checked"/><label for="FilterTarget1:serviceCtl">&?Security_032;</label>&nbsp;&nbsp;
<input type="radio" id="FilterTarget0:serviceCtl" name="FilterTarget:serviceCtl" value="0"/><label for="FilterTarget0:serviceCtl">&?Security_033;</label>
</div>
</div>
<div class="row">
<label for="INCViewName:serviceCtl" class="cfgLabel w150">&?Security_029;</label>
<div class="right">
<select class="selectNorm" id="INCViewName:serviceCtl" name="INCViewName:serviceCtl" >
<option value="IGD.WANIF" title='&?public_128;'>&?public_128;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv4ServCtl",nil,{"WANServlist"}))
%>
</select>
</div>
</div>
<div class="row">
<label for="sub_MinSrcIp0" class="cfgLabel w150">&?Security_052;</label>
<div class="right">
<input class="ip" name="sub_MinSrcIp0" type="text" maxlength="3" id="sub_MinSrcIp0" value="0"/>.
<input class="ip" name="sub_MinSrcIp1" type="text" maxlength="3" id="sub_MinSrcIp1" value="0"/>.
<input class="ip" name="sub_MinSrcIp2" type="text" maxlength="3" id="sub_MinSrcIp2" value="0"/>.
<input class="ip" name="sub_MinSrcIp3" type="text" maxlength="3" id="sub_MinSrcIp3" value="0"/>
~
<input class="ip" name="sub_MaxSrcIp0" type="text" maxlength="3" id="sub_MaxSrcIp0" value="0"/>.
<input class="ip" name="sub_MaxSrcIp1" type="text" maxlength="3" id="sub_MaxSrcIp1" value="0"/>.
<input class="ip" name="sub_MaxSrcIp2" type="text" maxlength="3" id="sub_MaxSrcIp2" value="0"/>.
<input class="ip" name="sub_MaxSrcIp3" type="text" maxlength="3" id="sub_MaxSrcIp3" value="0"/>
</div>
</div>
<div class="row">
<label for="ServiceList" class="cfgLabel w150">&?Security_054;</label>
<div class="right" id="ServiceControlList">
<%
local fwCommFunc = require "modules.firewall_common_func"
cgilua.put(fwCommFunc.CreateFwSCChkBoxGroup("IPv4"))
%>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_serviceCtl" name="Btn_cancel_serviceCtl" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_serviceCtl" name="Btn_apply_serviceCtl" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_serviceCtl" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
