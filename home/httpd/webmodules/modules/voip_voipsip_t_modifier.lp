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
</script><script>
<%
if "140" == CountryCode then
%>
$(document).ready(function(){
$("[id^='VoIPSIP_container'] *").attr("disabled",true)
$("[id^='Btn_apply'],[id^='Btn_cancel']",$("#VoIPSIP_container")).remove()
})
<%
end
%>
</script><script>
<%
if "138" == env.getenv("CountryCode") then
%>
$(document).ready(function(){
$("[id^='ProxyServerPort1'], [id^='UserAgentPort']").attr("disabled",true).addClass("PostIgnore");
});
<%
end
%>
</script>
