<script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "1" then %>
$("#template_WLANSSIDConf_3",subTemplate).find("*").attr("disabled",true);;
$("#template_WLANSSIDConf_7",subTemplate).find("*").attr("disabled",true);;
$("[id='Btn_apply_WLANSSIDConf:3']").addClass("disableBtn");
$("[id='Btn_cancel_WLANSSIDConf:3']").addClass("disableBtn");
$("[id='Btn_apply_WLANSSIDConf:7']").addClass("disableBtn");
$("[id='Btn_cancel_WLANSSIDConf:7']").addClass("disableBtn");
<%end%>
}
$.unsubscribe("/some/softVersionModify");
$.subscribe("/some/softVersionModify", softModify);
</script><script type="text/javascript">
<% if env.getenv("CountryCode") == "79" then %>
$.unsubscribe("/some/softVersionModify", softModify);
function softModify(e,subTemplate,b,c)
{
$("#template_WLANSSIDConf_2",subTemplate).find(".div_GuestWifi").show();
}
$.subscribe("/some/softVersionModify", softModify);
<%end%>
</script>
<script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "163" and "2" == session_get(sess_id, "Right") then %>
$("#template_WLANSSIDConf_2",subTemplate).hide();
$("#template_WLANSSIDConf_3",subTemplate).hide();
$("#template_WLANSSIDConf_6",subTemplate).hide();
$("#template_WLANSSIDConf_7",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script><script>
<%
if "36" == env.getenv("CountryCode") then
%>
$.unsubscribe("/some/wlanLableModify");
function wlanLableModify(e,subTemplate,b,c)
{
$("label.w180", subTemplate).addClass("w220").removeClass("w180");
}
$.subscribe("/some/wlanLableModify", wlanLableModify);
<%
end
%>
</script>﻿<script type="text/javascript">
<%
if env.getenv("CountryCode") == "156" then
local AirMode = env.getenv("AirMode")
%>
var AirMode = "<%=AirMode%>";
function ctcWlanssidModify(e,subTemplate,b,c){
$("#template_WLANSSIDConf_3").hide();
$("#template_WLANSSIDConf_7").hide();
if ("2" == AirMode)
{
$("#template_WLANSSIDConf_4").hide();
$("#template_WLANSSIDConf_5").hide();
$("#template_WLANSSIDConf_6").hide();
}
else if ("3" == AirMode)
{
$("#WLANSSIDConf").hide();
}
}
$.subscribe("/some/softVersionModify", ctcWlanssidModify);
function ctcWlanssidClientModify(e,subTemplate,b,c){
subTemplate.rules.MaxUserNum ={
"required": true,
"integer": true,
"range": [1, 20]
}
$("[id^='MaxUserNum']").next().text("&?public_072;1 ~ 20");
}
$.subscribe("/some/ctcWlanssidClientModify", ctcWlanssidClientModify);
(function(){
$(document).ready(function(){
$("#EncryptionType option[value='WPA3-OWE']").remove();
});
})();
<% end %>
</script><script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "68" and "2" == session_get(sess_id, "Right") then %>
$("#template_WLANSSIDConf_1",subTemplate).hide();
$("#template_WLANSSIDConf_5",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if env.getenv("CountryCode") == "131" and uRight == "2" then
%>
(function(){
$(document).ready(function(){
var template = $("#WLANSSIDConf");
template.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<% if CountryCode == "125" and Right == "2" then %>
$.addModifier("wlanSSID/undisplaySSIDConf",function(){
$("#template_WLANSSIDConf_0").find("*").disableIt(true);
$("[id='Btn_apply_WLANSSIDConf:0']").addClass("disableBtn");
$("[id='Btn_cancel_WLANSSIDConf:0']").addClass("disableBtn");
var ESSIDHideEnable2Hide = $("[id^='div_ESSIDHideEnable']");
var EncryptionType2Hide = $("[id^='EncryptionType']").parent().parent();
showOrHideRowDiv("hide", ESSIDHideEnable2Hide, EncryptionType2Hide);
});
<%end%>
</script><script type="text/javascript">
<% if "139" == CountryCode then
%>
$(document).ready(function(){
$("[id^='MaxUserNum']").next().text("&?multilaser_wlan_003;1 ~ 32");
$("[id^='MaxUserNum']").parent().prev().text("&?multilaser_wlan_002;");
});
<% end %>
</script>
