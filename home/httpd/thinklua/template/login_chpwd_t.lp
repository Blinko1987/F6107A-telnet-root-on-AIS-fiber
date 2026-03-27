<script type="text/javascript">
<%
local getfenv,require,encodeHTML = _G.getfenv,_G.require,_G.encodeHTML
local sessmgr = require("user_mgr.session_mgr")
local usermgr = require("user_mgr.usermgr_logic_impl")
local token = cmapi.nocsrf.tokenRandom()
sessmgr.SetCurrentSessAttr("sess_token", token)
cgilua_lp.include("../template/login_chpwd_js.lp", getfenv(1))
cgilua_lp.include("../template/commpage_status_comm.lp", getfenv(1))
%>
</script>
<%
cgilua_lp.include("../template/common_eventtriggering.lp", getfenv(1))
%>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<style>
<%
if require"common_lib.file_utils".isFileExist("../../public/css/pro_style.css") then
cgilua_lp.include("../../public/css/pro_style.css")
end
%>
</style>
<div id="loginWrapper" class="HeadDIV" style="padding-top: 0">
<div class="emFont loginTitle">&?login_001;<%=_G.encodeHTML(env.getenv("WEBTitle"))%></div>
<form name="fLogin" id="fLogin" method="POST" onsubmit="return false;" action="">
<div id="loginContainer" class="loginContainer">
<div class="warnHint" style="margin: 10px 0;">
<span id="login_warn_span">&?login_021;</span>
</div>
<div class="loginInstCfgArea formTbl" id="template_loginWrapper">
<input type="hidden" name="action" id="action" value=""/>
<input type="hidden" name="_sessionTOKEN" id="_sessionTOKEN" value="<%=token%>"/>
<div class="row">
<label for="Username" class="left w130">&?public_026;</label>
<div class="right">
<input type="text" name="Username" id="Username" _Username='Username' class="w180 readonlyInputBg" readonly="readonly" value="<%cgilua.put(_G.encodeHTML(sessmgr.GetCurrentSessAttr('login_name')))%>"/>
</div>
</div>
<div class="row">
<label for="Password" class="left w130">&?AccountManag_005;</label>
<div class="right">
<input type="password" name="Password" id="Password" _passStrength="StrengthComm" autocomplete="new-password" class="w180"/>
</div>
</div>
<div class="row">
<label for="NewPassword" class="left w130">&?AccountManag_006;</label>
<div class="right">
<input type="password" name="NewPassword" id="NewPassword" autocomplete="new-password" class="w180"/>
</div>
</div>
<div id="login_error" class="errorHint" style="display:none;">
<span id="login_error_span"></span><br/>
</div>
</div>
</div>
</form>
<div id="loginBtn" class="">
<% if usermgr:getUserMgrAttrValue("chpwdMode") ~= "required" then %>
<input type="button" class="Button login" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<% end %>
<input type="button" class="Button login" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
