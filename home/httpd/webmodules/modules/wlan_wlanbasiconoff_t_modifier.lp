<script>
<%
if env.getenv("CountryCode") == "163" then
%>
(function(){
$(document).ready(function(){
$("#div_TimerEnable").hide();
});
})();
<%
end
%>
</script><script>
<% if "39" == CountryCode then %>
$(document).ready(function(){
$("[id='CountryCode']").attr("disabled","disabled");
});
<% end %>
</script><script type="text/javascript">
<%
local AirMode = env.getenv("AirMode")
%>
function disWlanOption(e,subTemplate,b,c){
<% if env.getenv("CountryCode") == "156" then %>
var onbutton = $("[id^='RadioStatus0']", subTemplate);
var offbutton = $("[id^='RadioStatus1']", subTemplate);
var onbuttonfor2g = $("[id^='RadioStatus0_0']", subTemplate);
var offbuttonfor2g = $("[id^='RadioStatus1_0']", subTemplate);
var onbuttonfor5g = $("[id^='RadioStatus0_1']", subTemplate);
var offbuttonfor5g = $("[id^='RadioStatus1_1']", subTemplate);
<%
local retTable = nil
local xmlStr = ""
local RouterStatus
retTable = cmapi.getinst("OBJ_DISWLANSTATUS_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
end
if retTable.IF_ERRORID == 0 then
RouterStatus = retTable["RouterStatus"]
end
if RouterStatus == "OFF" or AirMode == "3" then
%>
$(onbutton).prop("disabled",true);
$(offbutton).prop("disabled",true);
$("[id^='TimerEnable0']", subTemplate).hide()
$("[for^='TimerEnable0']", subTemplate).hide()
<%
elseif AirMode == "2" then
%>
onbuttonfor2g.prop("disabled",false);
offbuttonfor2g.prop("disabled",false);
onbuttonfor5g.prop("disabled",true);
offbuttonfor5g.prop("disabled",true);
$("[id^='TimerEnable0']", subTemplate).hide()
$("[for^='TimerEnable0']", subTemplate).hide()
<%
else
%>
$(onbutton).prop("disabled",false);
$(offbutton).prop("disabled",false);
<% end %>
<%
end
%>
}
$.subscribe("/some/disWlanOption", disWlanOption);
</script>
<script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if env.getenv("CountryCode") == "131" and uRight == "2" then
%>
(function(){
$(document).ready(function(){
var template = $("#WlanBasicAdOnOff");
template.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
