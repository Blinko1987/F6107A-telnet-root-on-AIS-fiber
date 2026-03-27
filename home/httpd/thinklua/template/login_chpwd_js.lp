$(document).ready(function(){
var cver = "<% =env.getenv("CountryCode")%>";
{
new CheckPwdStrengthClass("Password", "Username", "template_loginWrapper");
}
$("#fLogin").validate({
rules: {
"Password" : {
"required":true,
<%
if _G.commConf.ChgpwdStrong then
%>
"ChkPass": true,
<%
end
%>
"ASCII": true
},
"NewPassword": {
"required":true,
"ASCII": true,
"equalTo": "#Password"
}
}
});
var dispErr = function(data){
$("#login_error_span").text(data.loginErrMsg);
$("#login_error").show();
};
$("#Password").val("").focus();
function doChgpwd(){
$.post( "/?_type=loginData&_tag=login_changepwd", $("#fLogin").serialize(), undefined, "json" )
.done(function( data ) {
if ( data.login_need_refresh )
{
top.location.href = top.location.href;
}
else
{
dispErr(data);
}
});
}
$("#Btn_apply").bind("click", function(){
if ( true == $("#fLogin").validate().form() )
{
$("#action").val("changepwd");
doChgpwd();
}
});
$("#Btn_cancel").bind("click", function(){
$("#action").val("changepwd_cancel");
doChgpwd();
});
showWaitTip(false);
});
