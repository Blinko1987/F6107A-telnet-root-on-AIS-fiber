<script>
<%
if "154" == env.getenv("CountryCode") then
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if uRight == "2" then
%>
function hideSpecialWAN(e,subTemplate,b,c){
var instances = $("[id^='template_EthStateDev_']", subTemplate);
instances.each(function(){
var strServList = $("[id^='StrServList']", $(this)).val();
if(strServList != "INTERNET"){
$(this).hide();
}
});
}
$.subscribe("/some/specialWANHide", hideSpecialWAN);
<%
end
end
%>
</script>
<script>
<%
if CountryCode == "96" and Right == "2" then
%>
$.addModifier("EthStateDev/paramsCtr",function(data){
var temp = data.template;
var strServList = $("[id^='StrServList']", temp).val();
if(strServList == "VOIP"){
$("[id^='Prefix_sub_cIPAddress:']", temp).hide();
$("[id^='Prefix_sub_cDNS:']", temp).hide();
$("[id^='Prefix_sub_cGateWay:']", temp).hide();
$("[id^='Prefix_sub_cSubnetMask:']", temp).hide();
}
});
<%
end
%>
</script>
<script>
<%
if CountryCode == "163" and "2" == Right then
%>
function hideSpecialWAN(e,subTemplate,b,c){
var instances = $("[id^='template_EthStateDev_']", subTemplate);
instances.each(function(){
var strServList = $("[id^='StrServList']", $(this)).val();
var linkMode = $("[id^='linkMode']", $(this)).val();
var wancName = $("[id^='WANCName']", $(this)).attr('title');
var mode = $("[id^='mode']", $(this)).val();
if(strServList != "INTERNET" || linkMode != "IP" || wancName == "COMMUNITY WIFI"){
$(this).hide();
if(mode == "bridge")
{
$(this).show();
}
}
else
{
$("[id^='Prefix_sub_cIsNAT'],[id^='Prefix_sub_cGateWay']", subTemplate).hide();
$("[id^='Prefix_sub_cConnError'],[id^='Prefix_sub_cGateway6']", subTemplate).hide();
}
});
}
$.unsubscribe("/some/specialWANHide");
$.subscribe("/some/specialWANHide", hideSpecialWAN);
<%
end
%>
</script><script>
<% if "156" == env.getenv("CountryCode") then%>
var BtnString = "<span class='Btn_Connect emColor ctrlFont' id='ctc_connect'>&?ctc_WanStatus_001;</span>  |                  <span id='ctc_disconnect' class='Btn_Disconnect emColor ctrlFont'>&?ctc_WanStatus_002;</span>";
$.addModifier("/wanmanual/manualDial", function(data){
var index = data.index;
if( $("[id^='ConnTrigger:']").eq(index).val() == "OnDemand" ){
globalTmp = BtnString;
}
else{
globalTmp = '';
}
});
$.addModifier("/wanmanual/IPv6ConnectBtns", function(){
$("[id^='ConnTrigger:']").each(function(index){
var connectStatusRow = $("[id^='Prefix_sub_cConnStatus:']");
if(connectStatusRow.children().length == 2
&& $("[id^='ConnTrigger:']").val() == "OnDemand" ){
connectStatusRow.append(BtnString);}
})
});
<%
if "2" == session_get(sess_id, "Right") then
%>
$.unsubscribe("/some/specialWANHide");
function CTChideSpecialWAN(e,subTemplate,b,c)
{
var instances = $("[id^='template_EthStateDev_']", subTemplate);
instances.each(function(){
var InstVal = $("[id^='_InstID']", $(this)).val();
if( InstVal == "DEV.IP.IF3" || InstVal == "DEV.IP.IF5" || InstVal == "DEV.IP.IF6")
{
$(this).remove();
}
});
}
$.subscribe("/some/specialWANHide", CTChideSpecialWAN);
<% end %>
<% end %>
</script>
<script>
<%
if CountryCode == "68" and Right == "2" then
%>
$.addModifier("EthStateDev/paramsCtr",function(data){
var temp = data.template;
$("[id^='Prefix_sub_cWorkIFMac:']", temp).hide();
$("[id^='Prefix_sub_cDNS:']", temp).hide();
$("[id^='Prefix_sub_cDnsv6:']", temp).hide();
$("[id^='Prefix_sub_cIPAddress:']", temp).hide();
$("[id^='Prefix_sub_cGateWay:']", temp).hide();
$("[id^='Prefix_sub_cGateway6:']", temp).hide();
$("[id^='Prefix_sub_cGuaNum:']", temp).hide();
$("[id^='Prefix_sub_cLLA:']", temp).hide();
});
<%
end
%>
</script>
