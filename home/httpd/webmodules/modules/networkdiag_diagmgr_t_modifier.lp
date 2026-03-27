<script>
<%
if "154" == CountryCode then
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if uRight == "2" then
%>
hideSVCSimulation()
function hideSVCSimulation(e,subTemplate,b,c){
$("#SvcSimulation").hide();
return;
}
$.subscribe("/some/SVCSimulationHide", hideSVCSimulation);
<%
end
end
%>
</script>
<script type="text/javascript">
<%
if "63" == env.getenv("CountryCode") then
%>
$.unsubscribe("/some/networkdiag_ping");
$.unsubscribe("/some/networkdiag_traceroute");
$.unsubscribe("/some/networkdiag_nslookup");
function filldata(e,container)
{
$("[id^='Host:PingDiagnosis']", container).val("ais.co.th");
$("[id^='Host:TraceRouteDiagnosis']", container).val("ais.co.th");
$("[id^='HostName:NsLookupDiagnosis']", container).val("ais.co.th");
}
$.subscribe("/some/networkdiag_ping", filldata);
$.subscribe("/some/networkdiag_traceroute", filldata);
$.subscribe("/some/networkdiag_nslookup", filldata);
(function(){
$(document).ready(function(){
var template = $("#template_TraceRouteDiagnosis");
var IPVersionObj = $("[id^='IPVersion']", template);
var optionObj = $("option[value='Any']", IPVersionObj);
if ( IPVersionObj.length>0 && optionObj.length==0)
{
IPVersionObj.prepend("<option value='Any' title='&?public_126;' selected >&?public_126;</option>");
}
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<%
if "156" == env.getenv("CountryCode") then
%>
function ctcchangeWANOptions(e,subTemplate,b,c){
$("[id^='Interface:PingDiagnosis'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
$("[id^='Interface:TraceRouteDiagnosis'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
}
$.subscribe("/some/CTCWANOptionsChange", ctcchangeWANOptions);
<%
end
%>
</script>
<script type="text/javascript">
<%
if CountryCode == "131" then
%>
(function(){
$(document).ready(function(){
var template = $("#template_TraceRouteDiagnosis");
var ProtocolObj = $("[id^='Protocol']", template);
var proptionObj = $("option[value='ICMP']", ProtocolObj);
proptionObj.attr("selected","selected");
});
})();
<%
end
%>
</script>
