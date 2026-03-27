<%
cgilua_lp.include("../../webmodules/modules/qos_speed_js.lp", getfenv(1))
%>
<div id="QosSpeed" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=qos_speed_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="QosSpeedBar">&?QosSpeed_001;</h1>
<div id="QosSpeed_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?QosSpeed_024;</a></div>
<div class="sceneTip_container">
<p>
<span>&?QosSpeed_025;</span><br />
<span>&?QosSpeed_026;</span>
</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_QosSpeed" style="display:none;">
<input type="hidden" id="ConformingAction" value="0">
<input type="hidden" id="PartialConformingAction" class="PostIgnore" value="0">
<input type="hidden" id="NonConformingAction" value="0">
<form class="form_content">
<div id="topLine_QosSpeed" class="formTblCtrlBar">
<span id="instName_QosSpeed" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0" checked="checked"/><label for="Enable0" >&?public_034;</label>
</div>
</span>
<span id="instDelete_QosSpeed" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_QosSpeed" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="Alias" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" class="inputLong" id="Alias" name="Alias" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073; 1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="MeterType" class="left w150">&?QosSpeed_003;</label>
<div class="right">
<select class="selectLong" id="MeterType" name="MeterType">
<option value="SimpleTokenBucket" title='&?QosSpeed_016;'>&?QosSpeed_016;</option>
<option value="SingleRateThreeColor" title='&?QosSpeed_017;'>&?QosSpeed_017;</option>
<option value="TwoRateThreeColor" title='&?QosSpeed_018;'>&?QosSpeed_018;</option>
</select>
</div>
</div>
<div class="row">
<label for="CommittedRate" class="left w150">&?QosSpeed_004;</label>
<div class="right">
<input type="text" class="inputLong" id="CommittedRate" name="CommittedRate" value=""/>&?public_081;
<span class="dTip" style="display: none;">&?public_072;<span id="QPP_MIN">8192</span> ~ <span id="QPP_MAX">100000000</span></span>
</div>
</div>
<div class="row">
<label for="CommittedBurstSize" class="left w150">&?QosSpeed_005;</label>
<div class="right">
<input type="text" class="inputLong" id="CommittedBurstSize" name="CommittedBurstSize" value=""/>&?public_082;
<span class="dTip" style="display: none;">&?public_072;1500 ~ 12 500 000</span>
</div>
</div>
<div class="row" style="display: none;">
<label for="ExcessBurstSize" class="left w150">&?QosSpeed_006;</label>
<div class="right">
<input type="text" class="inputLong PostIgnore" id="ExcessBurstSize" name="ExcessBurstSize" value=""/>&?public_082;
<span class="dTip" style="display: none;">&?public_072;1500 ~ 12 500 000</span>
</div>
</div>
<div class="row" style="display: none;">
<label for="PeakRate" class="left w150">&?QosSpeed_007;</label>
<div class="right">
<input type="text" class="inputLong PostIgnore" id="PeakRate" name="PeakRate" value=""/>&?public_081;
<span class="dTip" style="display: none;">&?public_072;<span id="QPPR_MIN">8192</span> ~ <span id="QPPR_MAX">100000000</span></span>
</div>
</div>
<div class="row" style="display: none;">
<label for="PeakBurstSize" class="left w150">&?QosSpeed_008;</label>
<div class="right">
<input type="text" class="inputLong PostIgnore" id="PeakBurstSize" name="PeakBurstSize" value=""/>&?public_082;
<span class="dTip" style="display: none;">&?public_072;1500 ~ 12 500 000</span>
</div>
</div>
<div class="segmentRow"></div>
<div class="row">
<label for="ConformingAction_S" class="left w150">&?QosSpeed_009;</label>
<div class="right">
<select class="selectLong PostIgnore" id="ConformingAction_S" name="ConformingAction_S">
<option value="Null" title='&?QosSpeed_019;'>&?QosSpeed_019;</option>
<option value="Drop" title='&?QosSpeed_020;'>&?QosSpeed_020;</option>
<option value="DSCPMark" title='&?QosSpeed_021;'>&?QosSpeed_021;</option>
<option value="802.1pMark" title='&?QosSpeed_022;'>&?QosSpeed_022;</option>
<option value="DSCPMark&802.1pMark" title='&?QosSpeed_023;'>&?QosSpeed_023;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="ConformingAction_DSCPMark" class="left w150">&?QosSpeed_010;</label>
<div class="right">
<select class="selectLong PostIgnore" id="ConformingAction_DSCPMark" name="ConformingAction_DSCPMark">
<option value="0" title='&?QosBasic_010;' selected="selected">&?QosBasic_010;</option>
<option value="14" title='&?QosBasic_011;'>&?QosBasic_011;</option>
<option value="12" title='&?QosBasic_012;'>&?QosBasic_012;</option>
<option value="10" title='&?QosBasic_013;'>&?QosBasic_013;</option>
<option value="8" title='&?QosBasic_014;'>&?QosBasic_014;</option>
<option value="22" title='&?QosBasic_015;'>&?QosBasic_015;</option>
<option value="20" title='&?QosBasic_016;'>&?QosBasic_016;</option>
<option value="18" title='&?QosBasic_017;'>&?QosBasic_017;</option>
<option value="16" title='&?QosBasic_018;'>&?QosBasic_018;</option>
<option value="30" title='&?QosBasic_019;'>&?QosBasic_019;</option>
<option value="28" title='&?QosBasic_020;'>&?QosBasic_020;</option>
<option value="26" title='&?QosBasic_021;'>&?QosBasic_021;</option>
<option value="24" title='&?QosBasic_022;'>&?QosBasic_022;</option>
<option value="38" title='&?QosBasic_023;'>&?QosBasic_023;</option>
<option value="36" title='&?QosBasic_024;'>&?QosBasic_024;</option>
<option value="34" title='&?QosBasic_025;'>&?QosBasic_025;</option>
<option value="32" title='&?QosBasic_026;'>&?QosBasic_026;</option>
<option value="46" title='&?QosBasic_027;'>&?QosBasic_027;</option>
<option value="40" title='&?QosBasic_028;'>&?QosBasic_028;</option>
<option value="48" title='&?QosBasic_029;'>&?QosBasic_029;</option>
<option value="56" title='&?QosBasic_030;'>&?QosBasic_030;</option>
<option value="other" title='&?QosBasic_031;'>&?QosBasic_031;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="other_ConformingAction_DSCPMark" class="left w150">&nbsp;</label>
<div class="right">
<input type="text" id="other_ConformingAction_DSCPMark" name="other_ConformingAction_DSCPMark" value="" class="inputLong PostIgnore"/>
<span style="display:none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="row" style="display:none;">
<label for="ConformingAction_802Mark" class="left w150">&?QosType_020;</label>
<div class="right">
<select class="selectLong PostIgnore" id="ConformingAction_802Mark" name="ConformingAction_802Mark">
<option value="0" title='0' selected="selected">0</option>
<option value="1" title='1'>1</option>
<option value="2" title='2'>2</option>
<option value="3" title='3'>3</option>
<option value="4" title='4'>4</option>
<option value="5" title='5'>5</option>
<option value="6" title='6'>6</option>
<option value="7" title='7'>7</option>
</select>
</div>
</div>
<div class="segmentRow"></div>
<div class="row" style="display:none;">
<label for="PartialConformingAction_S" class="left w150 ">&?QosSpeed_012;</label>
<div class="right">
<select class="selectLong PostIgnore" id="PartialConformingAction_S" name="PartialConformingAction_S">
<option value="Null" title='&?QosSpeed_019;'>&?QosSpeed_019;</option>
<option value="Drop" title='&?QosSpeed_020;'>&?QosSpeed_020;</option>
<option value="DSCPMark" title='&?QosSpeed_021;'>&?QosSpeed_021;</option>
<option value="802.1pMark" title='&?QosSpeed_022;'>&?QosSpeed_022;</option>
<option value="DSCPMark&802.1pMark" title='&?QosSpeed_023;'>&?QosSpeed_023;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="PartialConformingAction_DSCPMark" class="left w150">&?QosSpeed_010;</label>
<div class="right">
<select class="selectLong PostIgnore" id="PartialConformingAction_DSCPMark" name="PartialConformingAction_DSCPMark">
<option value="0" title='&?QosBasic_010;' selected="selected">&?QosBasic_010;</option>
<option value="14" title='&?QosBasic_011;'>&?QosBasic_011;</option>
<option value="12" title='&?QosBasic_012;'>&?QosBasic_012;</option>
<option value="10" title='&?QosBasic_013;'>&?QosBasic_013;</option>
<option value="8" title='&?QosBasic_014;'>&?QosBasic_014;</option>
<option value="22" title='&?QosBasic_015;'>&?QosBasic_015;</option>
<option value="20" title='&?QosBasic_016;'>&?QosBasic_016;</option>
<option value="18" title='&?QosBasic_017;'>&?QosBasic_017;</option>
<option value="16" title='&?QosBasic_018;'>&?QosBasic_018;</option>
<option value="30" title='&?QosBasic_019;'>&?QosBasic_019;</option>
<option value="28" title='&?QosBasic_020;'>&?QosBasic_020;</option>
<option value="26" title='&?QosBasic_021;'>&?QosBasic_021;</option>
<option value="24" title='&?QosBasic_022;'>&?QosBasic_022;</option>
<option value="38" title='&?QosBasic_023;'>&?QosBasic_023;</option>
<option value="36" title='&?QosBasic_024;'>&?QosBasic_024;</option>
<option value="34" title='&?QosBasic_025;'>&?QosBasic_025;</option>
<option value="32" title='&?QosBasic_026;'>&?QosBasic_026;</option>
<option value="46" title='&?QosBasic_027;'>&?QosBasic_027;</option>
<option value="40" title='&?QosBasic_028;'>&?QosBasic_028;</option>
<option value="48" title='&?QosBasic_029;'>&?QosBasic_029;</option>
<option value="56" title='&?QosBasic_030;'>&?QosBasic_030;</option>
<option value="other" title='&?QosBasic_031;'>&?QosBasic_031;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="other_PartialConformingAction_DSCPMark" class="left w150">&nbsp;</label>
<div class="right">
<input type="text" id="other_PartialConformingAction_DSCPMark" name="other_PartialConformingAction_DSCPMark" value="" class="inputLong PostIgnore"/>
<span style="display:none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="row" style="display:none;">
<label for="PartialConformingAction_802Mark" class="left w150">&?QosType_020;</label>
<div class="right">
<select class="selectLong PostIgnore" id="PartialConformingAction_802Mark" name="PartialConformingAction_802Mark">
<option value="0" title='0' selected="selected">0</option>
<option value="1" title='1'>1</option>
<option value="2" title='2'>2</option>
<option value="3" title='3'>3</option>
<option value="4" title='4'>4</option>
<option value="5" title='5'>5</option>
<option value="6" title='6'>6</option>
<option value="7" title='7'>7</option>
</select>
</div>
</div>
<div class="segmentRow"></div>
<div class="row">
<label for="NonConformingAction_S" class="left w150">&?QosSpeed_013;</label>
<div class="right">
<select class="selectLong PostIgnore" id="NonConformingAction_S" name="NonConformingAction_S">
<option value="Null" title='&?QosSpeed_019;'>&?QosSpeed_019;</option>
<option value="Drop" title='&?QosSpeed_020;'>&?QosSpeed_020;</option>
<option value="DSCPMark" title='&?QosSpeed_021;'>&?QosSpeed_021;</option>
<option value="802.1pMark" title='&?QosSpeed_022;'>&?QosSpeed_022;</option>
<option value="DSCPMark&802.1pMark" title='&?QosSpeed_023;'>&?QosSpeed_023;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="NonConformingAction_DSCPMark" class="left w150">&?QosSpeed_010;</label>
<div class="right">
<select class="selectLong PostIgnore" id="NonConformingAction_DSCPMark" name="NonConformingAction_DSCPMark">
<option value="0" title='&?QosBasic_010;' selected="selected">&?QosBasic_010;</option>
<option value="14" title='&?QosBasic_011;'>&?QosBasic_011;</option>
<option value="12" title='&?QosBasic_012;'>&?QosBasic_012;</option>
<option value="10" title='&?QosBasic_013;'>&?QosBasic_013;</option>
<option value="8" title='&?QosBasic_014;'>&?QosBasic_014;</option>
<option value="22" title='&?QosBasic_015;'>&?QosBasic_015;</option>
<option value="20" title='&?QosBasic_016;'>&?QosBasic_016;</option>
<option value="18" title='&?QosBasic_017;'>&?QosBasic_017;</option>
<option value="16" title='&?QosBasic_018;'>&?QosBasic_018;</option>
<option value="30" title='&?QosBasic_019;'>&?QosBasic_019;</option>
<option value="28" title='&?QosBasic_020;'>&?QosBasic_020;</option>
<option value="26" title='&?QosBasic_021;'>&?QosBasic_021;</option>
<option value="24" title='&?QosBasic_022;'>&?QosBasic_022;</option>
<option value="38" title='&?QosBasic_023;'>&?QosBasic_023;</option>
<option value="36" title='&?QosBasic_024;'>&?QosBasic_024;</option>
<option value="34" title='&?QosBasic_025;'>&?QosBasic_025;</option>
<option value="32" title='&?QosBasic_026;'>&?QosBasic_026;</option>
<option value="46" title='&?QosBasic_027;'>&?QosBasic_027;</option>
<option value="40" title='&?QosBasic_028;'>&?QosBasic_028;</option>
<option value="48" title='&?QosBasic_029;'>&?QosBasic_029;</option>
<option value="56" title='&?QosBasic_030;'>&?QosBasic_030;</option>
<option value="other" title='&?QosBasic_031;'>&?QosBasic_031;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="other_NonConformingAction_DSCPMark" class="left w150">&nbsp;</label>
<div class="right">
<input type="text" id="other_NonConformingAction_DSCPMark" name="other_NonConformingAction_DSCPMark" value="" class="inputLong PostIgnore"/>
<span style="display:none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="row" style="display:none;">
<label for="NonConformingAction_802Mark" class="left w150">&?QosType_020;</label>
<div class="right">
<select class="selectLong PostIgnore" id="NonConformingAction_802Mark" name="NonConformingAction_802Mark">
<option value="0" title='0' selected="selected">0</option>
<option value="1" title='1'>1</option>
<option value="2" title='2'>2</option>
<option value="3" title='3'>3</option>
<option value="4" title='4'>4</option>
<option value="5" title='5'>5</option>
<option value="6" title='6'>6</option>
<option value="7" title='7'>7</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_QosSpeed" name="Btn_cancel_QosSpeed" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_QosSpeed" name="Btn_apply_QosSpeed" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_QosSpeed" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
