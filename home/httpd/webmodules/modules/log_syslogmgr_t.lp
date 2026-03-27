<%
cgilua_lp.include("../../webmodules/modules/log_syslogmgr_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="LogManagerConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=log_syslogmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LogManagerConfBar">&?LogManag_003;</h1>
<div id="LogManagerConf_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_LogManagerConf" class="formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_BASICCONIG" value="Y">
<Input type="hidden" id="ServiceIp" value="">
<div class="row">
<label class="cfgLabel w130" for="LogEnable">&?LogManag_004;</label>
<div class="right" id="LogEnable">
<input type="radio" value="1" name="LogEnable" id="LogEnable1"><label for="LogEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="LogEnable" id="LogEnable0"><label for="LogEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_LogLevel" style="display:none;">
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
<%
if "108" ~= env.getenv("CountryCode") then
%>
<div class="row">
<label class="cfgLabel w130" for="ServiceEnable">&?LogManag_006;</label>
<div class="right" id="ServiceEnable">
<input type="radio" value="1" name="ServiceEnable" id="ServiceEnable1"><label for="ServiceEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="ServiceEnable" id="ServiceEnable0"><label for="ServiceEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_ServiceIp" style="display:none;">
<label class="cfgLabel w130" for="ServiceIp">&?LogManag_007;</label>
<div class="right">
<input class="ip" name="sub_ServiceIp0" type="text" maxlength="3" id="sub_ServiceIp0" value=""/>.
<input class="ip" name="sub_ServiceIp1" type="text" maxlength="3" id="sub_ServiceIp1" value=""/>.
<input class="ip" name="sub_ServiceIp2" type="text" maxlength="3" id="sub_ServiceIp2" value=""/>.
<input class="ip" name="sub_ServiceIp3" type="text" maxlength="3" id="sub_ServiceIp3" value=""/>
</div>
</div>
<%
end
%>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_LogManagerConf" name="Btn_cancel_LogManagerConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_LogManagerConf" name="Btn_apply_LogManagerConf" value="&?public_018;" />
</div>
</form>
<form name="fDownload" id="fDownload" class="formTbl" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="downloadlog" id="downloadlog" value="">
<div class="row">
<label class="cfgLabel w130">&?LogManag_008;</label>
</div>
<div class="textareaRow">
<textarea id="logStr" value=""></textarea>
</div>
<div class="buttongroup">
<input type="button" class="Button longBtn Btn_save" id="Btn_save_LogManagerConf" name="Btn_save_LogManagerConf" value="&?LogManag_009;" />
<input type="button" class="Button Btn_refresh" id="Btn_refresh_LogManagerConf" name="Btn_refresh_LogManagerConf" value="&?public_003;" />
</div>
<input type="hidden" id="TOKEN_DOWNLOAD" name="TOKEN_DOWNLOAD" value="<%=sessToken%>"/>
</form>
</div>
</div>
</div>
