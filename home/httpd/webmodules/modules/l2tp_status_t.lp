<%
cgilua_lp.include("../../webmodules/modules/l2tp_status_js.lp", getfenv(1))
%>
<div id="L2tpStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=l2tp_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="L2tpStatusBar">&?L2tpStatus_003;</h1>
<div id="L2tpStatus_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_L2tpStatus" style="display:none;">
<form class="colorTbl form_content">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="DNS1" value="" class="PostIgnore">
<input type="hidden" id="DNS2" value="" class="PostIgnore">
<input type="hidden" id="DNS3" value="" class="PostIgnore">
<input type="hidden" id="SubnetMask" value="" class="PostIgnore">
<input type="hidden" id="ConnTrigger" value="" class="PostIgnore">
<div id="L2tpStatus_title" class="colorTblRow emFont titleRow">
<span class="w250 emFont" title="&?L2tpStatus_004;">&?L2tpStatus_004;</span>
<span class="w400" id="SessionName" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?L2TP_003;">&?L2TP_003;</span>
<span class="w400" id="Enable" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?InternetAIS_032;">&?InternetAIS_032;</span>
<span class="w400" id="IpMode" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?L2TP_009;">&?L2TP_009;</span>
<span class="w400" id="NATEnable" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?public_007;">&?public_007;</span>
<span class="w400" id="IPAddress" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?public_031;">&?public_031;</span>
<span class="w400" id="GateWay" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?public_107;">&?public_107;</span>
<span class="w400" id="allDNS" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?L2tpStatus_007;">&?L2tpStatus_007;</span>
<span class="w280" id="ConnSatus" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?L2tpStatus_005;">&?L2tpStatus_005;</span>
<span class="w400" id="UpTime" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh PostIgnore" id="L2tpStatus_Btn_refresh" name="L2tpStatus_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
