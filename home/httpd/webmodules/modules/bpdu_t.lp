<%
cgilua_lp.include("../../webmodules/modules/bpdu_js.lp", getfenv(1))
%>
<div id="LocalBPDU" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=bpdu_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalBPDUBar">&?BPDU_001;</h1>
<div id="LocalBPDU_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalBPDU">
<form class="form_content">
<div id="changeArea_LocalBPDU" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="BPDUEnable" class="cfgLabel w150">&?BPDU_003;</label>
<div class="right" id="BPDUEnable">
<input type="radio" id="BPDUEnable1" name="BPDUEnable" value="1"/><label for="BPDUEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="BPDUEnable0" name="BPDUEnable" value="0"/><label for="BPDUEnable0" >&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_instCfgArea" name="Btn_cancel_instCfgArea" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_instCfgArea" name="Btn_apply_instCfgArea" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
