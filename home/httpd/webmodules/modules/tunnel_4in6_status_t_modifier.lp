<script>
<%
if "154" == env.getenv("CountryCode") then
%>
function hideConnectionStatus(e,subTemplate,b,c)
{
subTemplate.each(function(){
$("[id^='ConnStatus']", $(this)).parent().hide();
});
}
$.subscribe("/some/connectionStatusHide", hideConnectionStatus);
<%
end
%>
</script>
