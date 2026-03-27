<%
cgilua_lp.include("../../webmodules/modules/log_loglevelmgr_js.lp", getfenv(1))
%>
<div id="LvlLogManagerConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=log_loglevelmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LvlLogManagerConfBar">&?LogManag_021;</h1>
<div id="LvlLogManagerConf_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_LvlLogManagerConf" class="formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<div class="row" id="div_LogLevel">
<label class="cfgLabel w130" for="LogLevel">&?LogManag_005;</label>
<div class="right">
<select name="LogLevel" id="LogLevel" class="selectNorm">
<option value="0" title='&?LogManag_011;'>&?LogManag_011;</option>
<option value="1" title='&?LogManag_012;'>&?LogManag_012;</option>
<option value="2" title='&?LogManag_013;'>&?LogManag_013;</option>
<option value="3" title='&?LogManag_014;'>&?LogManag_014;</option>
<option value="4" title='&?LogManag_015;'>&?LogManag_015;</option>
<option value="5" title='&?LogManag_016;'>&?LogManag_016;</option>
<option value="6" title='&?LogManag_017;'>&?LogManag_017;</option>
<option value="7" title='&?LogManag_018;'>&?LogManag_018;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_LvlLogManagerConf" name="Btn_cancel_LvlLogManagerConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_LvlLogManagerConf" name="Btn_apply_LvlLogManagerConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
