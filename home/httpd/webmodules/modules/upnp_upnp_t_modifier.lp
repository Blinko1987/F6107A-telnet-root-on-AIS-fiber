<script>
<%
if CountryCode == "128" and Right == "2" then
%>
(function(){
$(document).ready(function(){
$("#ADPeriod").parent().parent().remove();
$("#TTL").parent().parent().remove();
$("b").parent().remove();
});
})();
<%
end
%>
</script>
