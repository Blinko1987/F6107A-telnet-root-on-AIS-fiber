<%
cgilua_lp.include("../../webmodules/modules/db_usrcfg_upload_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="UserConfUpload" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=db_usrcfg_upgrade_query_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="UserConfUploadBar">&?UsrCfgMgr_005;</h1>
<div id="UserConfUpload_container">
<input type="hidden" id="DataHasBeenGot" value="1">
<div id="template_UserConfUpload">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl" name="fUpload" id="fUpload" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<div class="row">
<label for="ConfigUpload">&?UsrCfgMgr_007;</label>
</div>
<div class="row">
<div class="left">
<input type="file" name="ConfigUpload" size="54" id="ConfigUpload">
</div>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="longBtn" id="Btn_Upload" name="Btn_Upload" value="&?UsrCfgMgr_006;"/>
</div>
<input type="hidden" id="TOKEN_UPLOAD" name="TOKEN_UPLOAD" value="<%=sessToken%>"/>
</form>
</div>
</div>
</div>
</div>
