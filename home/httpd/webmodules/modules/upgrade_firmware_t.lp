<%
cgilua_lp.include("../../webmodules/modules/upgrade_firmware_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="FirmwareUpgr" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=upgrade_firmware_query_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="FirmwareUpgrBar">&?FirmwareUpgr_001;</h1>
<div id="FirmwareUpgr_container">
<input type="hidden" id="DataHasBeenGot" value="1">
<div id="template_FirmwareUpgr">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl" name="fUpload" id="fUpload" method="POST" enctype="multipart/form-data" onsubmit="return false;">
<div class="staticInfoHint">
<p>&?FirmwareUpgr_004;</p>
</div>
<div class="row">
<label for="VersionUpload">&?FirmwareUpgr_003;</label>
</div>
<div class="row">
<div class="left">
<input type="file" name="VersionUpload" size="54" id="VersionUpload" value="">
</div>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="longBtn" id="Btn_Upload" name="Btn_Upload" value="&?FirmwareUpgr_005;"/>
</div>
<input type="hidden" id="TOKEN_UPLOAD" name="TOKEN_UPLOAD" value="<%=sessToken%>"/>
</form>
</div>
</div>
</div>
</div>
