<script>
<%
if "77" == CountryCode then
%>
$.unsubscribe("/some/refreshPage");
function refresh(e,subTemplate,b,c)
{
top.location.href = top.location.href;
}
$.subscribe("/some/refreshPage", refresh);
<%
end
%>
</script>
