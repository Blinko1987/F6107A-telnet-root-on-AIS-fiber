<%
cgilua_lp.include("../../webmodules/modules/db_resetmgr_js.lp", getfenv(1))
%>
<div id="ResetManag" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=db_resetmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ResetManagBar">&?DeviceManag_003;</h1>
<div id="ResetManag_container" class="formTblWrap">
<input type="hidden" id="DataHasBeenGot" value="1">
<input type="hidden" id="Msg">
<div id="template_ResetManag" class="formTbl">
<div class="OperationWarn">
<p class="row">&?DeviceManag_007;</p>
<p class="row">&?DeviceManag_008;</p>
</div>
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="Button longBtn Btn_reset" id="Btn_reset" name="Btn_reset" value="&?DeviceManag_009;" />
</div>
</div>
</div>
</div>
