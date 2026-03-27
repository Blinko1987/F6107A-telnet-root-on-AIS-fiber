<script type="text/javascript">
<%
cgilua_lp.include("../template/login_js.lp", getfenv(1))
cgilua_lp.include("../template/commpage_status_comm.lp", getfenv(1))
%>
</script>
<%
cgilua_lp.include("../template/common_eventtriggering.lp", _G.getfenv(1))
local usermgrLogicImpl = require("user_mgr.usermgr_logic_impl")
local username, disabled = usermgrLogicImpl:getAutofillUsername()
%>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<link rel="stylesheet" type="text/css" href="css/helvetica.css" />
<style>
<%
if require"common_lib.file_utils".isFileExist("../../public/css/pro_style.css") then
cgilua_lp.include("../../public/css/pro_style.css")
end
%>
</style>
<div id="loginWrapper">
<div class="loginLogo"><img src="img/aisfibre.png" style="width:200px"></div>
<div id="loginContainer" class="loginContainer">
<input type="hidden" name="_sessionTOKEN" id="_sessionTOKEN" value="<%=token%>"/>
<div class="loginInstCfgArea">
<div>
<h2>&?pro_LOGIN_001;</h2>
</div>
<div class="row group">
<label for="Frm_Username">&?public_026;</label>
<div class="right">
<input type="text" name="Frm_Username" id="Frm_Username" autocomplete="off" class="uName circle" placeholder="USERNAME" value="<% =_G.encodeHTML(username) %>" <%if disabled then cgilua.put("disabled") end%>/>
</div>
</div>
<div class="row group">
<label for="Frm_Password" >&?public_027;</label>
<div class="right">
<input type="password" name="Frm_Password" id="Frm_Password" autocomplete="off" class="pwdName circle" placeholder="PASSWORD"/>
<input type="password" id="FakePasPassword" name="FakePasPassword" autocomplete="off" tabindex="-1" style="position: absolute;z-index: -100;">
</div>
</div>
<div id="captchaArea" class="row group">
<label for="Frm_captchaCode" class="valid">&?public_170;</label>
<img id="captchaImg" src="img/transparent.gif" class="captchaImg" style="float:left"/>
<div class="right">
<input type="text" name="Frm_captchaCode" id="Frm_captchaCode" class="circle"/>
</div>
</div>
<div id="login_error" class="errorHint" style="display:none;">
<span id="login_error_span"></span>
<span id="login_error_waittime" value="0"></span>
</div>
</div>
<div id="loginBtn" class="loginBtn">
<input type="submit" id="LoginId" class="button btn w150" value="&?pro_LOGIN_001;"/>
</div>
</div>
</div>
