<%
cgilua_lp.include("../../webmodules/modules/voip_sipslc_js.lp", getfenv(1))
%>
<div id="VOICESIPSLC" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_sipslc_lua.lua</span>
</address>
<h1 id="VOICESIPSLCBar" class="collapBarWithDataTrans">&?proc_sipslc_009;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VOICESIPSLC_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VOICESIPSLC" style="display:none;">
<div id="topLine_VOICESIPSLC" class="formTblCtrlBar">
<span id="instName_VOICESIPSLC" class="instName collapsibleInst">&?public_041;</span>
</div>
<div id="changeArea_VOICESIPSLC" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="RingVoltage" class="left w200">&?proc_sipslc_001;</label>
<div class="right">
<select name="RingVoltage" id="RingVoltage" class="selectNorm">
<option value="50">50</option>
<option value="55">55</option>
<option value="65">65</option>
<option value="70">70</option>
<option value="75">75</option>
<option value="85">85</option>
</select>&nbsp;&?proc_sipslc_005;
</div>
</div>
<div class="row">
<label for="PortCurrent" class="left w200">&?proc_sipslc_002;</label>
<div class="right">
<select name="PortCurrent" id="PortCurrent" class="selectNorm">
<option value="20">20</option>
<option value="24">24</option>
<option value="28">28</option>
<option value="32">32</option>
</select>&nbsp;&?proc_sipslc_006;
</div>
</div>
<div class="row">
<label for="PortVoltage" class="left w200">&?proc_sipslc_003;</label>
<div class="right">
<select name="PortVoltage" id="PortVoltage" class="selectNorm">
<option value="48">48</option>
<option value="52">52</option>
</select>&nbsp;&?proc_sipslc_007;
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_VOICESIPSLC" name="Btn_cancel_VOICESIPSLC" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_VOICESIPSLC" name="Btn_apply_VOICESIPSLC" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
