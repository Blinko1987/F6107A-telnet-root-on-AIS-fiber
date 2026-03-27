<script type="text/javascript">
<%
if env.getenv("CountryCode") == "1" then
%>
(function(){
$(document).ready(function(){
$("#ProcFlag3").hide();
$("label[for=ProcFlag3]").hide();
});
})();
<%
end
%>
</script>
<script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "163" and "2" == session_get(sess_id, "Right") then %>
$("#div_LanDevDHCPSourceRule_6",subTemplate).hide();
$("#div_LanDevDHCPSourceRule_7",subTemplate).hide();
$("#div_LanDevDHCPSourceRule_10",subTemplate).hide();
$("#div_LanDevDHCPSourceRule_11",subTemplate).hide();
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
var template = $("#LanDevDHCPSource");
template.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
