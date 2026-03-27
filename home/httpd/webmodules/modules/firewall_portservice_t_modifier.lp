<script type="text/javascript">
<% if env.getenv("CountryCode") == "77" then %>
$.addModifier("/ServName/displaytelnet",function(){
$("[id^='ServName']").each(function(){
if ( $(this).text() == "TELNET")
{
$(this).parents("[id^='div_ServPortRule']").find("*").hide().find("input").addClass("PostIgnore");
}
})
})
<% if Right ~= "1" then %>
$("[id='ServPortCfg_container'] *").disableIt(true);
$(".Btn_cancel,.Btn_apply", $("#ServPortCfg_container")).disableButton(true);
<%end%>
<%end%>
</script><script type="text/javascript">
<% if env.getenv("CountryCode") == "1" then %>
$.unsubscribe("/some/SerCtrModify");
function RemoteSerCtr(e,subTemplate,b,c)
{
$("[id^='ServName']").each(function(){
if ( $(this).text() == "TELNET")
{
$(this).parents("[id^='div_ServPortRule']").find("*").hide().find("input").addClass("PostIgnore");
}
})
}
$.subscribe("/some/SerCtrModify", RemoteSerCtr);
<%end%>
</script>
