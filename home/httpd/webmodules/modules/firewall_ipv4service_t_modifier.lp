<script type="text/javascript">
<% if env.getenv("CountryCode") == "1" then %>
$(document).ready(function(){
$("[servicename^='TELNET']",$("#serviceCtl_container")).remove();
$("[for^='Servise_TELNET']",$("#serviceCtl_container")).remove();
});
<%end%>
</script><script type="text/javascript">
<% if CountryCode == "138" then %>
$(document).ready(function(){
$("#serviceCtlBar").text("&?SN_Orang_006;");
$("#ServiceControlList").parent().after("<div class='row'>&?SN_Orang_010;<%=_G.encodeHTML(env.getenv("WEBTitle"))%>&?SN_Orang_009;</div>");
});
<%end%>
</script><script>
<%
if env.getenv("CountryCode") == "48" then
local uRight = session_get(sess_id, "Right")
if uRight == "2" then
%>
(function(){
$(document).ready(function(){
$("input,select").attr("disabled",true);
$('.buttongroup').remove();
$('.addInstBar').remove();
$("[id^='instDelete_']").remove();
});
})();
<%
end
end
%>
</script><script type="text/javascript">
<%
if CountryCode == "124" then
%>
$(document).ready(function(){
var containerObj = $("#serviceCtl_container");
$("#serviceCtlBar").text("&?SN_Orang_006;");
$("[id^='addInstBar_serviceCtl'],[id^='instDelete_serviceCtl'],[class^='addInstBar']",containerObj).remove();
$("#ServiceControlList").parent().after("<div class='row'>&?SN_Orang_008;<%=_G.encodeHTML(env.getenv("WEBTitle"))%>&?SN_Orang_009;</div>");
<% if Right == "2" then %>
$("[id^='FilterTarget'],[id^='Name:serviceCtl'],[id^='sub_MinSrcIp'],[id^='sub_MaxSrcIp'],[id^='Servise'],[id^='INCViewName:serviceCtl']", containerObj).prop("disabled",true).addClass("PostIgnore");
<% end %>
});
<%end%>
</script>
