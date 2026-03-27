<%
cgilua_lp.include("../../webmodules/modules/voip_diag_js.lp", getfenv(1))
%>
<div id="VoipDiag" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_diag_lua.lua</span>
</address>
<h1 id="VoipDiagBar" class="collapBarWithDataTrans">&?voipdiag_04;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VoipDiag_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VoipDiag" style="display:none;">
<div id="topLine_VoipDiag" class="formTblCtrlBar">
<span id="instName_VoipDiag" class="instName collapsibleInst">&?public_041;</span>
</div>
<div id="changeArea_VoipDiag" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_VoipDiag" name="Btn_cancel_VoipDiag" value="&?DiagnosisManag_050;" />
</div>
<div class="row">
<label class="cfgLabel w150">&?voipdiag_01;</label>
</div>
<div class="textareaRow">
<textarea id="RegStatus" value="" readonly="readonly"></textarea>
</div>
<div class="segmentRow"></div>
</form>
</div>
</div>
</div>
</div>
