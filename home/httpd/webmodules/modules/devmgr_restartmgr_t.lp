<%
cgilua_lp.include("../../webmodules/modules/devmgr_restartmgr_js.lp", getfenv(1))
%>
<div id="RestartManag" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=devmgr_restartmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="RestartManagBar">&?DeviceManag_002;</h1>
<div id="RestartManag_container" class="formTblWrap">
<input type="hidden" id="DataHasBeenGot" value="1">
<input type="hidden" id="Msg">
<div id="template_RestartManag" class="formTbl">
<div class="OperationWarn">
<p class="row">&?DeviceManag_004;</p>
<p class="row">&?DeviceManag_005;</p>
</div>
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="Button Btn_restart" id="Btn_restart" name="Btn_restart" value="&?DeviceManag_006;" />
</div>
</div>
</div>
</div>
