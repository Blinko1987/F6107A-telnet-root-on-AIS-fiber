<%
cgilua_lp.include("../../webmodules/modules/qos_queue_js.lp", getfenv(1))
%>
<div id="QoSQueueCongestionCfg" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=qos_queue_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="QoSQueueCongestionCfgBar">&?QosCongestion_001;</h1>
<div id="QoSQueueCongestionCfg_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?QosCongestion_003;</a></div>
<div class="sceneTip_container">
<p>&?QosCongestion_004;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div class ="outRow">
<label class="left w80" for="InterfaceFilter">&?QosCongestion_005;</label>
<div class="">
<select class="selectNorm" name="InterfaceFilter" id="InterfaceFilter">
<option value="WAN" title='&?public_128;'>&?public_128;</option>
<%cgilua.put(_G.CreateIFOpStr("QoSCongestion"))%>
</select>
</div>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_QoSQueueCongestionCfg" style="display:none;">
<form class="form_content">
<div id="topLine_QoSQueueCongestionCfg" class="formTblCtrlBar">
<span id="instName" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0" checked="checked"/><label for="Enable0" >&?public_034;</label>
</div>
</span>
<span id="instDelete_QoSQueueCongestionCfg" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_QoSQueueCfg" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="DroppedPackets" value="0">
<input type="hidden" id="OutputPackets" value="0">
<input type="hidden" id="DroppedBytes" value="0">
<input type="hidden" id="OutputBytes" value="0">
<input type="hidden" id="_Refresh" value="N">
<input type="hidden" id="_Reset" value="N">
<input type="hidden" id="QueueInterface" value="WAN">
<div class="row">
<label for="Alias" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Alias" name="Alias" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073; 1~64</span>
</div>
</div>
<div class="row">
<label class="left w150" for="QueueNum">&?QosCongestion_006;</label>
<div class="right">
<select class="selectNorm" name="QueueNum" id="QueueNum">
<option value="1" title='1' selected="selected">1</option>
<option value="2" title='2'>2</option>
<option value="3" title='3'>3</option>
<option value="4" title='4'>4</option>
<option value="5" title='5'>5</option>
<option value="6" title='6'>6</option>
<option value="7" title='7'>7</option>
<option value="8" title='8'>8</option>
</select>
</div>
</div>
<div class="row">
<label class="left w150" for="SchedulerAlgorithm">&?QosCongestion_007;</label>
<div class="right">
<select class="selectNorm" name="SchedulerAlgorithm" id="SchedulerAlgorithm">
<option value="SP" title='&?QosCongestion_022;' selected="selected">&?QosCongestion_022;</option>
<option value="WFQ" title='&?QosCongestion_028;'>&?QosCongestion_028;</option>
<option value="WRR" title='&?QosCongestion_027;'>&?QosCongestion_027;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label class="left w150" for="Weight">&?QosCongestion_008;</label>
<div class="right">
<input class="inputNorm PostIgnore" type="text" id="Weight" name="Weight" value=""/>
<span style="display:none;">&?public_072;1 ~ 100</span>
<span id="percent">%</span>
</div>
</div>
<div class="row">
<label for="ShapingRate" class="left w150">&?QosShaper_004;</label>
<div class="right">
<input type="text" class="inputNorm" id="ShapingRate" name="ShapingRate" value=""/>&?public_081;
<span class="dTip" style="display: none;">&?public_072;0, <span id="QBW_MIN">8192</span> ~ <span id="QBW_MAX">100000000</span></span>
</div>
</div>
<div class="row">
<label class="left w150" for="TrafficClasses">&?QosCongestion_020;</label>
<div class="right">
<input class="inputNorm" type="text" id="TrafficClasses" name="TrafficClasses" value=""/>
</div>
</div>
<div class="row">
<label class="left w150">&?QosCongestion_024;</label>
<div id="DefaultQueue" class="right">
<input type="radio" value="1" name="DefaultQueue" id="DefaultQueue1"><label for="DefaultQueue1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="DefaultQueue" id="DefaultQueue0" checked="checked"><label for="DefaultQueue0" >&?public_034;</label>
</div>
</div>
<div class="row">
<label class="left w150">&?QosCongestion_025;</label>
<div id="NeedStats" class="right">
<input type="radio" value="1" name="NeedStats" id="NeedStats1" checked="checked"><label for="NeedStats1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="NeedStats" id="NeedStats0"><label for="NeedStats0" >&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_QoSQueueCongestionCfg" name="Btn_cancel_QoSQueueCongestionCfg" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_QoSQueueCongestionCfg" name="Btn_apply_QoSQueueCongestionCfg" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_QoSQueueCongestionCfg" class="instNew addInst">&?public_098;</span>
</div>
<div class="outRow">
<a class="emColor" href="javascript:void(0)" onclick="QoSStatistics(); return false;">&?QosCongestion_010;</a>
</div>
</div>
</div>
