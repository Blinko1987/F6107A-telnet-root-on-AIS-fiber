<script type="text/javascript">
<%
if CountryCode == "39" then
%>
$.addModifier("PortLocate/ChangePLFRules",function(data){
delete data.checkJson.rules.PortLocateFormat["PLFormat"];
});
(function(){
$(document).ready(function(){
$("[id^='PortLocateFormat']").next().remove();
});
})();
<%
end
%>
</script><script>
<%
if env.getenv("CountryCode") == "48" then
%>
(function(){
$(document).ready(function(){
$("#PortLocateFormat").attr("disabled","disabled");
$("#DHCPv6Enable").parent().parent().remove();
});
})();
<%
end
%>
</script>
