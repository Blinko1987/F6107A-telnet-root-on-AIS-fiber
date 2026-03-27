<%
cgilua_lp.include("../../webmodules/modules/firewall_parentctrl_js.lp", getfenv(1))
%>
<div id="ParentCtrl" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_parentctrl_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ParentCtrlBar">&?ParentCtrl_001;</h1>
<div id="ParentCtrl_container">
<input type="hidden" id="_InstNum" value="0">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_ParentCtrl" style="display:none;">
<form class="form_content">
<div id="topLine_ParentCtrl" class="formTblCtrlBar">
<span id="instName_ParentCtrl" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable:ParentCtrl">
<input type="radio" id="Enable1:ParentCtrl" name="Enable:ParentCtrl" value="1"/><label for="Enable1:ParentCtrl">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0:ParentCtrl" name="Enable:ParentCtrl" value="0" checked="checked"/><label for="Enable0:ParentCtrl" >&?public_034;</label>
</div>
</span>
<span id="instDelete_ParentCtrl" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_MACFilter" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="ChildId" _LuQUID_splitMACID="sub_ChildId" value="">
<input type="hidden" class="PostIgnore" id="IPAddress" _LuQUID_splitIPID="sub_IPAddress" value="">
<input type="hidden" id="Week" value="">
<div class="row">
<label for="Name:ParentCtrl" class="cfgLabel w180">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Name:ParentCtrl" name="Name:ParentCtrl" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row" id="div_Child">
<label for="sub_ChildId0" class="cfgLabel w180">&?ParentCtrl_003;</label>
<div class="right">
<input class="mac" name="sub_ChildId0" type="text" maxlength="2" id="sub_ChildId0" value=""/>:
<input class="mac" name="sub_ChildId1" type="text" maxlength="2" id="sub_ChildId1" value=""/>:
<input class="mac" name="sub_ChildId2" type="text" maxlength="2" id="sub_ChildId2" value=""/>:
<input class="mac" name="sub_ChildId3" type="text" maxlength="2" id="sub_ChildId3" value=""/>:
<input class="mac" name="sub_ChildId4" type="text" maxlength="2" id="sub_ChildId4" value=""/>:
<input class="mac" name="sub_ChildId5" type="text" maxlength="2" id="sub_ChildId5" value=""/>
<a class="_LuQUID_SelAccessDevice" _LuQUID_Access_Mode="ALL">&?public_143;</a>
</div>
</div>
<div class="bgColorRow" id="TR_TimeCfg">
<div class="row">
<label class="left w180"><strong>&?ParentCtrl_006;</strong></label>
</div>
<div class="row">
<label class="left w180">&?ParentCtrl_007;</label>
<div class="right">
<input name="EveryDay" id="EveryDay" class="PostIgnore" type="checkbox" value=""/><label for="EveryDay">&?ParentCtrl_008;</label>
</div>
</div>
<div class="row">
<label for="Time_Day_Su" class="left w180">&nbsp;</label>
<div class="right">
<input name="Time_Day_Su" id="Time_Day_Su" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_Su"><font style="color:rgb(200,0,0)">&?ParentCtrl_015;</font>&nbsp;&nbsp;</label>
<input name="Time_Day_M" id="Time_Day_M" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_M">&?ParentCtrl_009;&nbsp;&nbsp;</label>
<input name="Time_Day_T" id="Time_Day_T" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_T">&?ParentCtrl_010;&nbsp;&nbsp;</label>
<input name="Time_Day_We" id="Time_Day_We" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_We">&?ParentCtrl_011;&nbsp;&nbsp;</label>
<input name="Time_Day_Th" id="Time_Day_Th" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_Th">&?ParentCtrl_012;&nbsp;&nbsp;</label>
<input name="Time_Day_Fri" id="Time_Day_Fri" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_Fri">&?ParentCtrl_013;&nbsp;&nbsp;</label>
<input name="Time_Day_Sa" id="Time_Day_Sa" class="PostIgnore" type="checkbox" value="" /><label for="Time_Day_Sa"><font style="color:rgb(200,0,0)">&?ParentCtrl_014;</font></label>
</div>
</div>
<div class="row">
<label for="StartHour" class="left w180">&?ParentCtrl_016;</label>
<div class="right _LuQUID_TimeCtl">
<select name="StartHour" id="StartHour" class="w45 group_HourStart">
</select>&?public_011;&nbsp;
<select name="StartMin" id="StartMin" class="w45 group_MinuteStart">
</select>&?public_012;&nbsp;~&nbsp;
<select name="EndHour" id="EndHour" class="w45 group_HourEnd">
</select>&?public_011;&nbsp;
<select name="EndMin" id="EndMin" class="w45 group_MinuteEnd">
</select>&?public_012;&nbsp;
<a class="emColor ctrlFont" id="a_allday" name="a_allday">&?public_147;</a>
</div>
</div>
</div>
<div class="segmentRow"></div>
<div class="row">
<label for="FilterMode" class="cfgLabel w180">&?ParentCtrl_004;</label>
<div class="right">
<select class="selectLong" id="FilterMode" name="FilterMode">
<option value="NotAllowed" title='&?ParentCtrl_005;' selected="selected">&?ParentCtrl_005;</option>
<option value="BlackList" title='&?ParentCtrl_018;'>&?ParentCtrl_018;</option>
<option value="WhiteList" title='&?ParentCtrl_019;'>&?ParentCtrl_019;</option>
</select>
</div>
</div>
<div id="div_URLCfgArea" style="display:none">
<input type="hidden" id="URLCnt" value="">
<%
local iMax = 5;
local iIdx = 0;
for iIdx=0,(iMax-1) do
%>
<input type="hidden" id="URL<%=iIdx%>" value="">
<%
end
%>
<div class="row">
<label for="URL_0" class="cfgLabel w180">&?ParentCtrl_017;</label>
<div class="right">
<input type="text" class="inputLong PostIgnore" id="URL_0" name="URL_0" value=""/>
<span style="display: none;">&?public_073;1 ~ 128</span>
<img src="img/add.png" class="AddIconControl" alt="add" />
</div>
</div>
<div class="row" id="URLCtrlTemplate" style="display:none">
<label class="cfgLabel w180">&nbsp;</label>
<div class="right">
<input type="text" class="inputLong PostIgnore" id="URL" name="URL" value=""/>
<span style="display:none;">&?public_073;1 ~ 128</span>
<img src="img/delete.png" class="DelIconControl" alt="delete" />
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_ParentCtrl" name="Btn_cancel_ParentCtrl" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_ParentCtrl" name="Btn_apply_ParentCtrl" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_ParentCtrl" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
