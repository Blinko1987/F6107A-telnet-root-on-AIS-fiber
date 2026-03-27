<script type="text/javascript">
<%
if "63" == env.getenv("CountryCode") then
%>
$.unsubscribe("/some/selectModify");
function ddnsSelectModify(e,subTemplate,b,c)
{
var urlObj = $("#serviceUrl");
var provideTmpValue = $("#Provider").find("option:selected").val();
var divServerPortObj = $("#div_ServerPort");
if(provideTmpValue == "Other")
{
urlObj.removeClass("readonlyInputBg");
urlObj.removeAttr("readonly");
showOrHideRowDiv("show", divServerPortObj);
$("#div_Protocol").show();
}
else
{
urlObj.addClass("readonlyInputBg");
urlObj.attr("readonly","readonly");
showOrHideRowDiv("hide", divServerPortObj);
$("#div_Protocol").hide();
}
}
$.subscribe("/some/selectModify", ddnsSelectModify);
<%
end
%>
</script>
<script>
<%
if "36" == env.getenv("CountryCode") then
%>
function ddnsSelectModify(e,subTemplate,b,c)
{
var provideTmpValue = $("#Provider").find("option:selected").val();
if(provideTmpValue == "DynDNS" || provideTmpValue == "No-IP")
$("#div_Status").show();
else
$("#div_Status").hide();
}
$.subscribe("/some/selectModify", ddnsSelectModify);
<%
end
%>
</script>
