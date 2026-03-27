<script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "163" and "2" == session_get(sess_id, "Right") then %>
$("#template_WLANStatus_2",subTemplate).hide();
$("#template_WLANStatus_3",subTemplate).hide();
$("#template_WLANStatus_6",subTemplate).hide();
$("#template_WLANStatus_7",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script><script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcWlanssidModify(e,subTemplate,b,c)
{
$("#template_WLANStatus_3",subTemplate).hide();
$("#template_WLANStatus_7",subTemplate).hide();
}
$.subscribe("/some/softVersionModify", ctcWlanssidModify);
$(document).ready(function(){
$("[id^='WLANStatus_title']").find("span").eq(0).removeClass("w100");
});
<%end%>
</script><script type="text/javascript">
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "68" and "2" == session_get(sess_id, "Right") then %>
$("#template_WLANStatus_1",subTemplate).hide();
$("#template_WLANStatus_5",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script>
