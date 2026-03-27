<script>
<%
if CountryCode == "163" and "2" == Right then
%>
(function(){
$(document).ready(function(){
$("[id^='div_DSCP']").hide();
});
})();
<%
end
%>
<%
if CountryCode == "163" then
%>
(function(){
$(document).ready(function(){
$("#INCViewName option[value='DEV.IP.IF3']").remove();
$("#INCViewName option[value='DEV.IP.IF5']").remove();
$("#INCViewName option[value='DEV.IP.IF6']").remove();
$("#INCViewName option[value='DEV.IP.IF7']").remove();
$("#OUTCViewName option[value='DEV.IP.IF3']").remove();
$("#OUTCViewName option[value='DEV.IP.IF5']").remove();
$("#OUTCViewName option[value='DEV.IP.IF6']").remove();
$("#OUTCViewName option[value='DEV.IP.IF7']").remove();
$("#INCViewName").children().eq(0).remove();
$("#OUTCViewName").children().eq(0).remove();
});
})();
<%
end
%>
</script>
