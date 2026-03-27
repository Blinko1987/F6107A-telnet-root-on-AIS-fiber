<script type="text/javascript">
<%
if env.getenv("CountryCode") == "156" then
local AirMode = env.getenv("AirMode")
%>
var AirMode = "<%=AirMode%>";
function ctcWPSModify(e,subTemplate,b,c){
if ("2" == AirMode)
{
$("[id^='template_WPS_1']",subTemplate).hide()
}
}
$.subscribe("/some/softVersionModify", ctcWPSModify);
<%
end
%>
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if env.getenv("CountryCode") == "131" and uRight == "2" then
%>
(function(){
$(document).ready(function(){
var template = $("#WPS");
template.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
