<%
cgilua_lp.include("../../webmodules/modules/Voip_SipIf_js.lp", getfenv(1))
%>
<div id="SipIf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Voip_SipIf_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="SipIfBar">&?SipIf_005;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="SipIf_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_SipIf" class="formTblWrap" style="display:none;">
<div id="changeArea_SipIf" class="formTblWrap ChangeArea" style="">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="MediaWanConn" value="">
<div class="row">
<label for="WanConn" class="left w200">&?public_015;</label>
<div class="right">
<select name="WanConn" id="WanConn" class="selectLong">
<option value="" IPMode="0" title='&?public_039;' selected="selected">&?public_039;</option>
<%
local OptAttrTbl = {"IPMode"}
cgilua.put(_G.CreateIFOpStr("SIP",nil, OptAttrTbl))
%>
</select>
</div>
</div>
<div class="row">
<label for="S_MediaWanConn" class="left w200">&?SipIf_004;</label>
<div class="right">
<select name="S_MediaWanConn" id="S_MediaWanConn" class="selectLong">
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_SipIf" name="Btn_cancel_SipIf" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_SipIf" name="Btn_apply_SipIf" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
