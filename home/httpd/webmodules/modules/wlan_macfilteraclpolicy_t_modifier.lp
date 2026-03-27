<script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "163" and "2" == session_get(sess_id, "Right") then %>
$("#div_ACLPolicy_2",subTemplate).hide();
$("#div_ACLPolicy_3",subTemplate).hide();
$("#div_ACLPolicy_6",subTemplate).hide();
$("#div_ACLPolicy_7",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script>﻿<script type="text/javascript">
<%
if env.getenv("CountryCode") == "156" then
local AirMode = env.getenv("AirMode")
%>
var AirMode = "<%=AirMode%>";
function ctcWlanssidModify(e,subTemplate,b,c)
{
$("#div_ACLPolicy_3",subTemplate).hide();
$("#div_ACLPolicy_7",subTemplate).hide();
if ("2" == AirMode)
{
$("#div_ACLPolicy_4",subTemplate).hide();
$("#div_ACLPolicy_5",subTemplate).hide();
$("#div_ACLPolicy_6",subTemplate).hide();
}
else if ("3" == AirMode)
{
$("#MACFilterACLPolicy").hide();
}
}
$.subscribe("/some/softVersionModify", ctcWlanssidModify);
<%end%>
</script>
<script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "68" and "2" == session_get(sess_id, "Right") then %>
$("#div_ACLPolicy_5",subTemplate).hide();
$("#div_ACLPolicy_1",subTemplate).hide();
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
var template = $("#MACFilterACLPolicy");
template.find("*").attr("disabled",true);
return;
});
})();
<%
end
%>
</script>
