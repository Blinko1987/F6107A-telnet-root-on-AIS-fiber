<%
cgilua_lp.include("../../webmodules/modules/wlan_macfilterrule_js.lp", getfenv(1))
%>
<div id="MACFilterRule" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_macfilterrule_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MACFilterRuleBar">&?WlanAdvanced_002;-&?WlanAdvanced_004;</h1>
<div id="MACFilterRule_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_MACFilterRule" style="display:none;">
<form class="form_content">
<div id="topLine_MACFilterRule" class="formTblCtrlBar">
<span id="instName_MACFilterRule" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_MACFilterRule" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_MACFilterRule" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="MACAddress" _LuQUID_splitMACID="sub_MACAddress" value="">
<div class="row">
<label for="Name" class="cfgLabel w150">&?public_016;</label>
<div class="right">
<input type="text" id="Name" name="Name" class="inputNorm"/>
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="Interface" class="cfgLabel w150">&?public_117;</label>
<div class="right">
<select id="Interface" name="Interface" class="selectNorm">
<%
local claro_wlanCommFunc = require "modules.claro_wlan_common_func"
cgilua.put(claro_wlanCommFunc.CLAROQuerySSIDOutputOption())
%>
</select>
</div>
</div>
<div class="row">
<label for="sub_MACAddress0" class="cfgLabel w150">&?public_010;</label>
<div class="right">
<input class="mac" name="sub_MACAddress0" type="text" maxlength="2" id="sub_MACAddress0" value="" />:
<input class="mac" name="sub_MACAddress1" type="text" maxlength="2" id="sub_MACAddress1" value="" />:
<input class="mac" name="sub_MACAddress2" type="text" maxlength="2" id="sub_MACAddress2" value="" />:
<input class="mac" name="sub_MACAddress3" type="text" maxlength="2" id="sub_MACAddress3" value="" />:
<input class="mac" name="sub_MACAddress4" type="text" maxlength="2" id="sub_MACAddress4" value="" />:
<input class="mac" name="sub_MACAddress5" type="text" maxlength="2" id="sub_MACAddress5" value="" />
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MACFilterRule" name="Btn_cancel_MACFilterRule" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MACFilterRule" name="Btn_apply_MACFilterRule" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_MACFilterRule" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
