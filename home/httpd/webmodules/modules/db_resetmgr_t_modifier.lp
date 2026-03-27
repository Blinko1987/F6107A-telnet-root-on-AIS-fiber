<script>
<%
if "156" == env.getenv("CountryCode") then
%>
function resetMsg(e,Msg,b,c){
$("#Msg").val("&?ctcpdt_001;" + "&?DeviceManag_012;");
}
$.subscribe("/some/changeMsg", resetMsg);
<%
end
%>
</script>
