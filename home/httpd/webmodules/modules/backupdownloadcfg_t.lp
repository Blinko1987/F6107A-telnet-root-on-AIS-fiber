<%
cgilua_lp.include("../../webmodules/modules/backupdownloadcfg_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="AISUserConfDownload" class="HeadDIV">
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_AISUserConfDownload">
<h1 class="collapsibleBar" id="AISUserConfDownloadBar">&?pro_standard_005;</h1>
<div id="AISUserConfDownload_container">
<input type="hidden" id="DataHasBeenGot" value="1">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form name="userConf_fDownload" id="userConf_fDownload" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="downloadAISconfig" id="downloadAISconfig">
<div class="unfloatBtnGroup">
<input type="button" class="longBtn" id="Btn_AISDownload" name="Btn_AISDownload" value="&?pro_standard_005;"/>
</div>
<input type="hidden" id="TOKEN_DOWNLOAD" name="TOKEN_DOWNLOAD" value="<%=sessToken%>"/>
</form>
</div>
</div>
</div>
</div>
</div>
