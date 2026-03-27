<%
cgilua_lp.include("../../webmodules/modules/voip_sipadvanced_js.lp", getfenv(1))
local contrlStr = ""
if _G.voipConf["VoIPSIPAdvConf"] ~= nil then
contrlStr = _G.voipConf["VoIPSIPAdvConf"]
end
%>
<div id="VoIPSIPAdvConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_sipadvanced_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="VoIPSIPAdvConfBar">&?SipAdvanced_003;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="VoIPSIPAdvConf_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_VoIPSIPAdvConf" style="display:none;">
<div id="topLine_VoIPSIPAdvConf" class="formTblCtrlBar">
<span id="instName_VoIPSIPAdvConf" class="instName collapsibleInst instNameExp">&?public_041;</span>
</div>
<div class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="DTMFMethod" class="left w160">&?SipAdvanced_005;</label>
<div class="right">
<select name="DTMFMethod" id="DTMFMethod" class="selectNorm">
<option value="1" title='&?SipAdvanced_023;'>&?SipAdvanced_023;</option>
<option value="2" title='&?SipAdvanced_024;'>&?SipAdvanced_024;</option>
<option value="4" title='&?SipAdvanced_025;'>&?SipAdvanced_025;</option>
</select>
</div>
</div>
<%if string.find(contrlStr,"RFC2833EncryptEnable") ~= nil then%>
<div class="row" id="div_RFC2833EncryptEnable">
<label for="RFC2833EncryptEnable" class="left w160">Enable 2833 Encryption</label>
<div class="right">
<input type="checkbox" id="RFC2833EncryptEnable">
</div>
</div>
<% end %>
<div class="row">
<label for="JitMode" class="left w160">&?SipAdvanced_006;</label>
<div class="right">
<select name="JitMode" id="JitMode" class="selectNorm">
<option value="0" title='&?SipAdvanced_007;'>&?SipAdvanced_007;</option>
<option value="1" title='&?SipAdvanced_008;'>&?SipAdvanced_008;</option>
</select>
</div>
</div>
<div class="row" id="Row_FixedJitLen" style="display:">
<label for="FixedJitLen" class="left w160">&?SipAdvanced_009;</label>
<div class="right">
<input type="text" id="FixedJitLen" name="FixedJitLen" value="" class="inputNorm"/>&?public_052;
<span style="display:none;">&?public_072;0 ~ 200</span>
</div>
</div>
<div class="row" id="Row_AdaptJitMin" style="display:">
<label for="AdaptJitMin" class="left w160">&?SipAdvanced_010;</label>
<div class="right">
<input type="text" id="AdaptJitMin" name="AdaptJitMin" value="" class="inputNorm"/>&?public_052;
<span style="display:none;">&?public_072;0 ~ 200</span>
</div>
</div>
<div class="row" id="Row_AdaptJitMax" style="display:">
<label for="AdaptJitMax" class="left w160">&?SipAdvanced_011;</label>
<div class="right">
<input type="text" id="AdaptJitMax" name="AdaptJitMax" value="" class="inputNorm"/>&?public_052;
<span style="display:none;">&?public_072;0 ~ 200</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_VoIPSIPAdvConf" name="Btn_cancel_VoIPSIPAdvConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_VoIPSIPAdvConf" name="Btn_apply_VoIPSIPAdvConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
