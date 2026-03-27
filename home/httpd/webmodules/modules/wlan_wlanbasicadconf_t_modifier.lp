<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
<%
local AirMode = env.getenv("AirMode")
%>
var AirMode = "<%=AirMode%>";
(function(){
$(document).ready(function(){
$("[id^='div_CountryCode']").hide();
});
function disWlanModeOption(e,subTemplate,b,c)
{
if ("1" == AirMode)
{
$("[id^='UI_Standard:0'] option", subTemplate).each(function(){
if( $(this).val() == "b,g,n,ax")
{
$(this).hide();
}
});
$("[id^='UI_Standard:1'] option", subTemplate).each(function(){
if( $(this).val() == "a,n,ac,ax")
{
$(this).hide();
}
});
}
else if ("2" == AirMode)
{
$("[id^='UI_Standard:0'] option", subTemplate).each(function(){
if( $(this).val() == "b" || $(this).val() == "g" || $(this).val() == "b,g")
{
$(this).show();
}
else
{
$(this).hide();
}
});
$("[id^='template_WlanBasicAdConf_1']").find("*").hide();
}
else if ("3" == AirMode)
{
$("[id^='template_WlanBasicAdConf_']").find("*").hide();
}
}
$.subscribe("/some/disWlanModeOption", disWlanModeOption);
})();
<% end %>
</script>
<script type="text/javascript">
<% if "139" == CountryCode then %>
$("[id^='div_TxPower']>label").text("&?multilaser_wlan_001;");
<% end %>
</script>
