<%
cgilua_lp.include("../../webmodules/modules/db_defcfg_download_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="DefaultConfDownload" class="HeadDIV">
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_DefaultConfDownload">
<h1 class="collapsibleBar" id="DefaultConfDownloadBar">&?DefCfgMgr_003;</h1>
<div id="DefaultConfDownload_container">
<input type="hidden" id="DataHasBeenGot" value="1">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form name="fDownload" id="fDownload" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="defcfg" id="defcfg">
<div class="unfloatBtnGroup">
<input type="button" class="longBtn" id="Btn_Download" name="Btn_Download" value="&?UsrCfgMgr_004;"/>
</div>
<input type="hidden" id="TOKEN_DOWNLOAD" name="TOKEN_DOWNLOAD" value="<%=sessToken%>"/>
</form>
</div>
</div>
</div>
</div>
</div>
