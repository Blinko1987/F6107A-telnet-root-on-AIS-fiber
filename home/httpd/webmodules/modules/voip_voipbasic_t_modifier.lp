<script>
<%
if "154" == env.getenv("CountryCode") and "3" == env.getenv("Right") then
%>
(function(){
$(document).ready(function(){
$("input,select").attr("disabled",true);
$(".Button").remove();
});
})();
<%
end
%>
</script><script type="text/javascript">
<%
if "77" == env.getenv("CountryCode") then
%>
(function(){
$(document).ready(function(){
$("[id^='div_Enable']").show();
$("[id^='AuthPassword']").removeClass("SpecialPassword");
return;
});
})();
<%
end
%>
</script><script type="text/javascript">
<%
if env.getenv("CountryCode") == "1" then
%>
(function(){
$(document).ready(function(){
$("#Lable_AuthUserName").text("URI");
$("#TR_DirectoryNumber").show();
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<%
if "79" == env.getenv("CountryCode") then
%>
(function(){
$(document).ready(function(){
$("[id^='div_Enable']").show();
return;
});
})();
<%
end
%>
</script><script>
<%
if "140" == CountryCode then
%>
$(document).ready(function(){
$("[id^='VOIPSipAccountConf_container'] *").attr("disabled",true)
$("[id^='Btn_apply_VOIPSipAccountConf'],[id^='Btn_cancel_VOIPSipAccountConf']").remove()
})
<%
end
%>
</script><script>
<% if "36" == CountryCode and "2" == Right then %>
$.addModifier("VOIPbasic/UserNameASCII", function(data){
$("[id^='DigestUserName']").each(function () {
data.rules.DigestUserName["PasswordASCII"]=true;
delete data.rules.DigestUserName["ASCII"];
})
});
$.addModifier("VOIPbasic/hideUserName", function(data){
$("[id^='DigestUserName']").each(function (data) {
$(this).prop("value","						");
$(this).attr("type","password");
})
$("[id^='AuthUserName']").each(function (data) {
$(this).attr("type","password");
})
});
<% end %>
</script><script type="text/javascript">
<%
if "138" == env.getenv("CountryCode") then
%>
$(document).ready(function(){
$("[id^='template_VOIPSipAccountConf']").find("*").attr("disabled",true).addClass("PostIgnore");
$("[class^='Button']").hide();
});
<%
end
%>
</script>
<script>
<%
if "131" == env.getenv("CountryCode") then
%>
(function(){
$(document).ready(function(){
$("[id^='div_Enable']").show();
$("[id^='DigestUserName']").hide();
$("[id^='Digesttmp']").show();
$("[id^='UserNameSuffix']").show();
$("[id^='UserNameSuffix']").attr("disabled", "disabled");
$("[id^='UserNameSuffix']").val("@ims.tm.com.my");
return;
});
})();
<%
end
%>
</script>
