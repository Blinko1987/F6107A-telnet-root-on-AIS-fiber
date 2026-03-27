<%
cgilua_lp.include("../../webmodules/modules/log_seclogmgr_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="SecLogManagerConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=log_seclogmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SecLogManagerConfBar">&?LogManag_019;</h1>
<div id="SecLogManagerConf_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_SecLogManagerConf" class="formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<div class="row">
<label class="cfgLabel w130" for="SecLogEnable">&?LogManag_004;</label>
<div class="right" id="SecLogEnable">
<input type="radio" value="1" name="SecLogEnable" id="SecLogEnable1"><label for="SecLogEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="SecLogEnable" id="SecLogEnable0"><label for="SecLogEnable0">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_SecLogManagerConf" name="Btn_cancel_SecLogManagerConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_SecLogManagerConf" name="Btn_apply_SecLogManagerConf" value="&?public_018;" />
</div>
</form>
<form name="fDownload_SecLog" id="fDownload_SecLog" class="formTbl" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="downloadseclog" id="downloadseclog" value="">
<div class="row">
<label class="cfgLabel w130">&?LogManag_008;</label>
</div>
<div class="textareaRow">
<textarea id="logStr" value=""></textarea>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_SecLogManagerConf" name="Btn_refresh_SecLogManagerConf" value="&?public_003;" />
</div>
<input type="hidden" id="TOKEN_SECLOG_DOWNLOAD" name="TOKEN_SECLOG_DOWNLOAD" value="<%=sessToken%>"/>
</form>
</div>
</div>
</div>
