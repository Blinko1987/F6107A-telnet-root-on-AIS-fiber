<%
cgilua_lp.include("../../webmodules/modules/loopback_enable_js.lp", getfenv(1))
%>
<div id="LoopbackEnable" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=loopback_enable_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LoopbackEnableBar">&?LoopbackEnable_004;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="LoopbackEnable_container">
<div id="template_LoopbackEnable" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstNum">
<div class="row" id="div_LoopbackEnableRule" style="display:none;">
<form>
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="IFID" value="">
<label id="PortName" for="PortName" class="cfgLabel w130"></label>
<div class="right">
<input id="PortLoopbackEnable" type="checkbox" name="PortLoopbackEnable"><label for="PortLoopbackEnable">&?LoopbackEnable_001;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input id="PortAlarmEnable" type="checkbox" name="PortAlarmEnable"><label for="PortAlarmEnable">&?LoopbackEnable_002;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input id="PortDisLoopedEnable" type="checkbox" name="PortDisLoopedEnable"><label for="PortDisLoopedEnable">&?LoopbackEnable_003;</label>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_LoopbackEnable" name="Btn_cancel_LoopbackEnable" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_LoopbackEnable" name="Btn_apply_LoopbackEnable" value="&?public_018;" />
<span class="AllOn emColor ctrlFont" id="allOn_LoopbackEnable1" name="allOn_LoopbackEnable">&?public_042;</span>
&nbsp;&nbsp;|&nbsp;&nbsp;
<span class="AllOff emColor ctrlFont" id="allOn_LoopbackEnable0" name="allOn_LoopbackEnable">&?public_043;</span>
</div>
</div>
</div>
</div>
</div>
