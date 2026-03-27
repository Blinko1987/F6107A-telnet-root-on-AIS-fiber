<script>
<%
if "156" == env.getenv("CountryCode") then
%>
function restartMsg(e,Msg,b,c){
$("#Msg").val("&?ctcpdt_001;" + "&?DeviceManag_010;");
}
$.subscribe("/some/ctcchangeMsg", restartMsg);
<%
end
%>
</script>
