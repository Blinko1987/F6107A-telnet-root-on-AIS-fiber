<script>
<%
if CountryCode == "163" and "2" == Right then
%>
$.addModifier("Ipv4Dmz/WANCViewName/onlyInternet",function(){
$("[id^='WANCViewName']").find("option[title='COMMUNITY WIFI']").remove();
$("[id^='WANCViewName']").find("option[title='Internet']").attr("selected",true);
$("[id^='WANCViewName']").find("option[value='IGD.WANIF']").remove();
$("[id^='WANCViewName']").attr("disabled","disabled");
});
<%
end
%>
</script>
<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcWanssidModify(e,subTemplate,b,c)
{
$("#WANCViewName option").each(function(){
if( $(this).val() != "IGD.WANIF" && $(this).val() != "DEV.IP.IF4")
{
$(this).remove();
}
});
}
$.subscribe("/some/softVersionModify", ctcWanssidModify);
(function(){
$(document).ready(function(){
$("[class^='cfgLabel']").removeClass("w130").addClass("w170");
});
})();
<%end%>
</script>
