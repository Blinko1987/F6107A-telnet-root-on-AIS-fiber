<%
cgilua_lp.include("../../webmodules/modules/devmgr_ScheReboot_js.lp", getfenv(1))
%>
<div id="SchedReb" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=devmgr_ScheReboot_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SchedRebBar">&?SchedReb01;</h1>
<div id="SchedReb_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_SchedReb">
<form class="form_content">
<div id="changeArea_SchedReb" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="OperationWarn" id="RebootHint">
<p class="row">&?SchedReb02; </p>
<br>
</div>
<div class="row">
<label for="Enable" class="cfgLabel w130" id="label_Enable">&?Pinpublic_013;</label>
<div class="right">
<input type="checkbox" id="Enable" name="Enable" value="">
</div>
</div>
<input type="hidden" id="TimeWeek" value="">
<div class="row">
<label class="left w130">&?ParentCtrl_007;</label>
<div class="right">
<input name="EveryDay" id="EveryDay" class="PostIgnore" type="checkbox" value=""/><label for="EveryDay">&?ParentCtrl_008;</label>
</div>
</div>
<div class="row">
<label for="Time_Day_Su" class="left w130">&nbsp;</label>
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
<input type="hidden" id="TimeMin" value="">
<div class="row">
<label class="left w130">&?SchedReb03;</label>
<div class="right">
<input type="text" id="HourSrc" name="HourSrc" value="" class="inputNorm" style="width:50px;"/>&?public_011;&nbsp;
<span style="display:none;">&?public_072;0 ~ 23</span>
<input type="text" id="MinuteSrc" name="MinuteSrc" value="" class="inputNorm" style="width:50px;"/>&?public_012;
<span style="display:none;">&?public_072;0 ~ 59</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_instCfgArea" name="Btn_cancel_instCfgArea" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_instCfgArea" name="Btn_apply_instCfgArea" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
