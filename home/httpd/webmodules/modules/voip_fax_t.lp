<%
cgilua_lp.include("../../webmodules/modules/voip_fax_js.lp", getfenv(1))
%>
<div id="Fax" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_fax_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="FaxBar">&?Fax_003;</h1>
<div id="Fax_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_Fax" style="display:none;">
<div id="topLine_Fax" class="formTblCtrlBar">
<span id="instName_Fax" class="instName collapsibleInst instNameExp">&?public_041;</span>
</div>
<div id="changeArea_Fax" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="_InstID_V152" value="">
<input type="hidden" id="_InstID_mode" value="">
<div class="row">
<%
if env.getenv("VoIPTR104V2") ~= "1" then
%>
<%
if _G.commConf.voipFax == true then
%>
<div id="div_Enable" class="right">
<label for="Enable" class="cfgLabel w150">&?Fax_004;</label>
<select id="Enable" name="EncryptionType" class="w280">
<option value="1" title='&?voip_Fax001;'>&?voip_Fax001;</option>
<option value="0" title='&?voip_Fax002;'>&?voip_Fax002;</option>
</select>
</div>
<div id="div_MGInteract" class="right">
<label for="MGInteract" class="cfgLabel w150">Fax Switchmode</label>
<select id="MGInteract" name="EncryptionType" class="w280">
<option value="0" title='&?voip_Fax003;'>&?voip_Fax003;</option>
<option value="2" title='&?voip_Fax004;'>&?voip_Fax004;</option>
</select>
</div>
<% else %>
<label for="Enable" class="cfgLabel w150">&?Fax_004;</label>
<div id="Enable" class="right">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0"/><label for="Enable0">&?public_034;</label>
</div>
<% end %>
<%
else
%>
<label for="T38Enable" class="cfgLabel w150">&?Fax_004;</label>
<div id="T38Enable" class="right">
<input type="radio" id="T38Enable1" name="T38Enable" value="1"/><label for="T38Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="T38Enable0" name="T38Enable" value="0"/><label for="T38Enable0">&?public_034;</label>
</div>
<%
end
%>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_Fax" name="Btn_cancel_Fax" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_Fax" name="Btn_apply_Fax" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
