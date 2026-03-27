<%
local getfenv,ipairs,require,session_get,encodeHTML = _G.getfenv,_G.ipairs,_G.require,_G.session_get,_G.encodeHTML
%>
<script type="text/javascript">
<%
cgilua_lp.include("../template/login_preempt_js.lp", getfenv(1))
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
<div id="loginWrapper">
<div class="logoBg"></div>
<div id="loginContainer" class="loginContainer">
<div class="warnHint" style="margin-top: 120px;">
<span id="login_warn_span">&?login_018;</span>
</div>
<div class="loginInstCfgArea" style="padding-top:1%">
<div id="Level">
<%
local usermgrLogicImpl = require("user_mgr.usermgr_logic_impl")
local users = usermgrLogicImpl:getUserMgrAttr("loginPolicy","opts","beKickedUsers")
local sess_id = cgilua.getCurrentSessID()
for i, v in ipairs(users) do
if sess_id ~= v then
local preempt_ip = session_get(v, "client_ip")
%>
<p class="row"><input type="radio" id="radio<%=i%>" name="preempt_sessid" value=<%cgilua.put(v)%> checked/>&nbsp;&nbsp;
<label for="radio<%=i%>"><%cgilua.put(_G.encodeHTML(preempt_ip))%>(<%cgilua.put(encodeHTML(session_get(v,"login_name")))%>)</label>
</p>
<%
end
end
%>
</div>
<input type="hidden" name="action" id="action" value="preempt"/>
</div>
<div id="loginBtn" class="">
<input type="button" class="Button login" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button login" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
