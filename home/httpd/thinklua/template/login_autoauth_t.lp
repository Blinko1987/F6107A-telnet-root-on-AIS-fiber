<%
local usermgrLogicImpl = require("user_mgr.usermgr_logic_impl")
local user,pass = usermgrLogicImpl:getAutoAuthAccount()
%>
<form name="fLogin" id="fLogin" method="POST" onsubmit="return false;" action="">
<input type="hidden" name="Username" id="Username" value="<%=user%>"/>
<input type="hidden" name="Password" id="Password" value="<%=pass%>"/>
<input type="hidden" name="action" id="action" value="login"/>
</form>
<script type="text/javascript">
<%
cgilua_lp.include("../template/commpage_status_comm.lp", getfenv(1))
%>
function g_loginToken(xml)
{
var xmlObj = $(xml).text();
var Password =$("#Password").val();
var SHA256Password =sha256(Password+xmlObj);
$("#Password").val(SHA256Password);
Password = undefined;
SHA256Password = undefined;
$.post( "/?_type=loginData&_tag=login_entry", $("#fLogin").serialize(), undefined, "json" )
.done(function( data ) {
if ( data.login_need_refresh )
{
top.location.href = top.location.href;
}
else
{
alert("Auto Login Failed! Please check config para: needAuth ");
}
});
}
$(document).ready(function() {
var tokenRqst = "/?_type=loginData&_tag=login_token";
$("#fLogin").dataTransfer(tokenRqst, "GET", g_loginToken, undefined, false);
});
</script>
