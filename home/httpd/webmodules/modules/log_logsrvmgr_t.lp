<%
cgilua_lp.include("../../webmodules/modules/log_logsrvmgr_js.lp", getfenv(1))
local sess_id = cgilua.getCurrentSessID()
local sessToken = _G.encodeHTML(session_get(sess_id, "sess_token"))
%>
<div id="SrvLogManagerConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=log_logsrvmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SrvLogManagerConfBar">&?LogManag_020;</h1>
<div id="SrvLogManagerConf_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_SrvLogManagerConf" class="formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<div class="row">
<label class="cfgLabel w130" for="ServiceEnable">&?LogManag_006;</label>
<div class="right" id="ServiceEnable">
<input type="radio" value="1" name="ServiceEnable" id="ServiceEnable1"><label for="ServiceEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" value="0" name="ServiceEnable" id="ServiceEnable0"><label for="ServiceEnable0">&?public_034;</label>
</div>
</div>
<div class="row" id="div_ServiceIp" style="display:none;">
<input id="ServiceIp" type="hidden" value="0">
<label class="cfgLabel w130" for="sub_ServiceIp0">&?LogManag_007;</label>
<div class="right">
<input class="ip" name="sub_ServiceIp0" type="text" maxlength="3" id="sub_ServiceIp0" value=""/>.
<input class="ip" name="sub_ServiceIp1" type="text" maxlength="3" id="sub_ServiceIp1" value=""/>.
<input class="ip" name="sub_ServiceIp2" type="text" maxlength="3" id="sub_ServiceIp2" value=""/>.
<input class="ip" name="sub_ServiceIp3" type="text" maxlength="3" id="sub_ServiceIp3" value=""/>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_SrvLogManagerConf" name="Btn_cancel_SrvLogManagerConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_SrvLogManagerConf" name="Btn_apply_SrvLogManagerConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
