<%
cgilua_lp.include("../../webmodules/modules/voip_voiceproc_js.lp", getfenv(1))
%>
<div id="VOICEPROC" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_voiceproc_lua.lua</span>
</address>
<h1 id="VOICEPROCBar" class="collapBarWithDataTrans">&?SipAdvanced_016;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VOICEPROC_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VOICEPROC" style="display:none;">
<div id="topLine_VOICEPROC" class="formTblCtrlBar">
<span id="instName_VOICEPROC" class="instName collapsibleInst">&?public_041;</span>
</div>
<div id="changeArea_VOICEPROC" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="" class="left w160">&?SipAdvanced_004;</label>
<div id="EchoCancellationEnable" class="right">
<input type="radio" id="EchoCancellationEnable1" name="EchoCancellationEnable" value="1"/><label for="EchoCancellationEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="EchoCancellationEnable0" name="EchoCancellationEnable" value="0"/><label for="EchoCancellationEnable0">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_VOICEPROC" name="Btn_cancel_VOICEPROC" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_VOICEPROC" name="Btn_apply_VOICEPROC" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
