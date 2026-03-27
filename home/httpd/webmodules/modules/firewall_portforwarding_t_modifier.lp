<script>
<%
if CountryCode == "163" and "2" == Right then
%>
function hideWanName(e,subTemplate,b,c)
{
$("[id^='S_Interface']",subTemplate).find("option[title='COMMUNITY WIFI']").remove();
$("[id^='S_Interface']",subTemplate).find("option[title='Internet']").attr("selected",true);
$("[id^='S_Interface']",subTemplate).find("option[value='WANAll']").remove();
$("[id^='S_Interface']",subTemplate).attr("disabled","disabled");
$("[id^='sub_RemoteHost0'],[id^='sub_RemoteHost1'],[id^='sub_RemoteHost2'],[id^='sub_RemoteHost3']",subTemplate).attr("disabled","disabled");
$("[id^='sub_RemoteHostEndRange0'],[id^='sub_RemoteHostEndRange1'],[id^='sub_RemoteHostEndRange2'],[id^='sub_RemoteHostEndRange3']",subTemplate).attr("disabled","disabled");
}
$.unsubscribe("/some/softVersionModify");
$.subscribe("/some/softVersionModify", hideWanName);
<%
end
%>
</script>
<script>
<%
if env.getenv("CountryCode") == "156" then
%>
function ctcModifyPort(e,subTemplate,b,c)
{
$("[id^='InternalPort']",subTemplate).val($("[id^='ExternalPort']",subTemplate).val());
$("[id^='InternalPortEndRange']",subTemplate).val($("[id^='ExternalPortEndRange']",subTemplate).val());
$("[id^='ExternalPort']",subTemplate).removeClass("PostIgnore");
$("[id^='ExternalPortEndRange']",subTemplate).removeClass("PostIgnore");
}
function ctcModify(e,subTemplate,b,c)
{
$("[id^='S_Interface']",subTemplate).find("option[value!='DEV.IP.IF4']").remove();
$("[id^='div_wan_port']",subTemplate).hide();
$("[id^='div_Interface']",subTemplate).hide();
$("[for^='ExternalPort']",subTemplate).html("&?ctc_firewall_001;");
$(".sceneTip").remove();
}
$.subscribe("/some/softVersionModify", ctcModify);
$.subscribe("/some/portModify", ctcModifyPort);
<%
end
%>
</script>
<script type="text/javascript">
(function(){
$(document).ready(function(){
<% if CountryCode == "186" then %>
$("#PortForwardingBar").html("&?ChileWOM_pf_001;");
$(".sceneTipLink>a").html("&?ChileWOM_pf_003;");
$(".sceneTip_container").html("&?ChileWOM_pf_004;");
<%end%>
});
})();
</script>
