<%
cgilua_lp.include("../../webmodules/modules/qos_statistics_js.lp", getfenv(1))
%>
<div id="QoSStatisticsDiv" class="white_content_Qos">
<div id="QoSStatisticsCfg" class="HeadDIV divQoSStatisticsCfg">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=qos_statistics_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="fakeBar" id="QoSStatisticsCfgBar">&?QosCongestion_012;</h1>
<div id="QoSStatistics_container">
<span id="instDelete_QoSStatistics" class="closePopLayer">
<img src="img/close.png" alt="close" />
</span>
<div class="outRow">
<label class="left w80" for="InterfaceFilter2">&?QosCongestion_005;</label>
<div class="right">
<select class="selectNorm" name="InterfaceFilter2" id="InterfaceFilter2">
<option value="WAN" title='&?public_128;'>&?public_128;</option>
<%cgilua.put(_G.CreateIFOpStr("QoSCongestion"))%>
</select>
</div>
<div id="QoSStatistics_trans" class="inlineTip" style="display:none">
<span>&?public_087;</span>
<span class="picQoSTrans">&nbsp;&nbsp;&nbsp;&nbsp;</span>
</div>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<div class="colorTbl form_content alignCenter" id="template_QoSStatisticsCfg">
<div id="Statistics_title" class="colorTblRow emFont titleRow">
<span class="w150" title="&?public_016;">&?public_016;</span>
<span class="w120" title="&?QosCongestion_014;">&?QosCongestion_014;</span>
<span class="w120" title="&?QosCongestion_015;">&?QosCongestion_015;</span>
<span class="w120" title="&?QosCongestion_016;">&?QosCongestion_016;</span>
<span class="w120" title="&?QosCongestion_017;">&?QosCongestion_017;</span>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="QueueInterface" value="WAN">
<form class="colorRowforQos">
<div class="colorTblRow" id="data_QoSStatisticsCfg" style="display:none;">
<input id="_InstID" type="hidden" value="">
<span class="w150" id="Alias" title=""></span>
<span class="w120" id="OutputPackets" title=""></span>
<span class="w120" id="DroppedPackets" title=""></span>
<span class="w120" id="OutputBytes" title=""></span>
<span class="w120" id="DroppedBytes" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button" id="Statistics_Btn_reset" name="Statistics_Btn_reset" value="&?public_063;" />
<input type="button" class="Button Btn_refresh" id="Statistics_Btn_refresh" name="Statistics_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
</div>
