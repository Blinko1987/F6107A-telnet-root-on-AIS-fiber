<%
cgilua_lp.include("../../webmodules/modules/voip_slctime_js.lp", getfenv(1))
%>
<div id="SLCTIME" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_slctime_lua.lua</span>
</address>
<h1 id="SLCTIMEBar" class="collapBarWithDataTrans">&?sipslic_001;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="SLCTIME_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_SLCTIME" style="display:none;">
<div id="topLine_SLCTIME" class="formTblCtrlBar">
<span id="instName_SLCTIME" class="instName collapsibleInst">&?public_041;</span>
</div>
<div id="changeArea_SLCTIME" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<div class="row" id="Row_FlashLowMin" style="display:none">
<label for="FlashLowMin" class="left w160">&?sipslic_002;</label>
<div class="right">
<input type="text" id="FlashLowMin" name="FlashLowMin" value="" class="inputNorm"/>&?SipAdvanced_029;
<span style="display:none;">&?public_072;5 ~ 10</span>
</div>
</div>
<div class="row" id="Row_HookLow" style="display:">
<label for="HookLow" class="left w160">&?SipAdvanced_027;</label>
<div class="right">
<input type="text" id="HookLow" name="HookLow" value="" class="inputNorm"/>&?SipAdvanced_029;
<span style="display:none;">&?public_072;30 ~ 150</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_SLCTIME" name="Btn_cancel_SLCTIME" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_SLCTIME" name="Btn_apply_SLCTIME" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
