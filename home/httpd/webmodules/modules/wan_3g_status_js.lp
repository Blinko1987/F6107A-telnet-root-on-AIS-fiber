<script type="text/javascript">
(function(){
$(document).ready(function(){
var HeadID = "WAN3GStatus";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
$("#WAN3GStatusBar").text("&?Internet3G_040_LTE;");
$("#InsertCardBefore span").text("&?Pinpublic_018_LTE;");
RefreshClickHandle(Head);
Head.fillDataByCustom = function(suffix,ContainerOBJ) {
var PDPTypeValue = $("[id^='TtyPDPType']",ContainerOBJ).val();
var C_PDPTypeOBJ = ContainerOBJ.find("[id^='C_TtyPDPType']");
var PDPTypeTrans = {
"PDP_IP" : "&?public_044;",
"PDP_PPP": "&?public_102;",
"default": "&?public_118;"
};
if (!PDPTypeTrans[PDPTypeValue])
{
PDPTypeValue = "default";
}
C_PDPTypeOBJ.text(PDPTypeTrans[PDPTypeValue]);
C_PDPTypeOBJ.attr("title", PDPTypeTrans[PDPTypeValue]);
var EnabelNATValue = $("[id^='IsNAT']",ContainerOBJ).val();
var C_EnabelNATOBJ = ContainerOBJ.find("[id^='C_IsNAT']");
if (EnabelNATValue == 1)
{
C_EnabelNATOBJ.text("&?public_033;");
}
else
{
C_EnabelNATOBJ.text("&?public_034;");
}
C_EnabelNATOBJ.attr("title", C_EnabelNATOBJ.text());
var ConnStatusValue = $("[id^='ConnStatus']",ContainerOBJ).val();
var C_ConnStatusOBJ = ContainerOBJ.find("[id^='C_ConnStatus']");
var ConnStatusTrans = {
"Connected" : "&?InternetAIS_006;",
"Demand" : "&?InternetAIS_007;",
"Unconfigured" : "&?InternetAIS_008;",
"Connecting" : "&?InternetAIS_009;",
"Authenticating" : "&?InternetAIS_010;",
"PendingDisconnect": "&?InternetAIS_011;",
"Disconnecting" : "&?InternetAIS_072;",
"default" : "&?InternetAIS_012;"
};
if (!ConnStatusTrans[ConnStatusValue])
{
ConnStatusValue = "default";
}
C_ConnStatusOBJ.text(ConnStatusTrans[ConnStatusValue]);
C_ConnStatusOBJ.attr("title", ConnStatusTrans[ConnStatusValue]);
var ConnErrorValue = $("[id^='ConnError']",ContainerOBJ).val();
var C_ConnErrorOBJ = ContainerOBJ.find("[id^='C_ConnError']");
var ConnErrorTrans = {
"ERROR_NONE" : "&?public_074;",
"ERROR_ISP_TIME_OUT" : "&?InternetAIS_077;",
"ERROR_USER_DISCONNECT" : "&?InternetAIS_078;",
"ERROR_ISP_DISCONNECT" : "&?InternetAIS_079;",
"ERROR_IDLE_DISCONNECT" : "&?InternetAIS_080;",
"ERROR_FORCED_DISCONNECT" : "&?InternetAIS_081;",
"ERROR_AUTHENTICATION_FAILURE" : "&?InternetAIS_082;",
"ERROR_UNKNOWN" : "&?InternetAIS_083;",
"ERROR_IP_CONFIGURATION" : "&?InternetAIS_084;",
"ERROR_NOT_ENABLED_FOR_INTERNET": "&?InternetAIS_085;",
"ERROR_NO_CARRIER" : "&?InternetAIS_086;",
"default" : "&?InternetAIS_083;"
};
if ( ConnErrorTrans[ConnErrorValue] == undefined )
{
ConnErrorValue = "default";
}
C_ConnErrorOBJ.text(ConnErrorTrans[ConnErrorValue]);
C_ConnErrorOBJ.attr("title", ConnErrorTrans[ConnErrorValue]);
var UpTimeObj = $("[id^='UpTime']",ContainerOBJ);
var UpTimeValue = UpTimeObj.text();
UpTimeValue = sec2HrMinSec(UpTimeValue);
UpTimeObj.text(UpTimeValue);
UpTimeObj.attr("title", UpTimeValue);
var DNS1 = $("[id^='DNS1']",ContainerOBJ).val();
var DNS2 = $("[id^='DNS2']",ContainerOBJ).val();
var DNS3 = $("[id^='DNS3']",ContainerOBJ).val();
var DNS = DNS1 + "/" + DNS2 + "/" + DNS3;
var dnsObj = $("[id^='DNS:']",ContainerOBJ);
dnsObj.text(DNS);
dnsObj.attr("title", DNS);
var IPAddress = $("[id^='IPAddress']",ContainerOBJ).val();
var SubnetMask = $("[id^='SubnetMask']",ContainerOBJ).val();
var IPAndMask = IPAddress + "/" + SubnetMask;
var ipObj = $("[id^='IPAndMask']",ContainerOBJ);
ipObj.text(IPAndMask);
ipObj.attr("title", IPAndMask);
}
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var DongleStatus = $("DongleStatus", $(xml)).text();
var DongleType = $("DongleType", $(xml)).text();
$("#InsertCardBefore",Head).showIt(false);
$("#NoItem",Head).showIt(false);
$(".ModemSpecial",Head).showIt(false);
$(".RouterSpecial",Head).showIt(false);
if ( DongleStatus == "Dev_FAILURE" )
{
$("#InsertCardBefore",Head).showIt(true);
}
else
{
var WLAN3GStatusOBJ = $(xml).find("OBJ_TTYWANCPPP_ID");
var RuleNum = $("Instance", WLAN3GStatusOBJ).length;
var OBJID = ["OBJ_TTYWANCPPP_ID"];
if( DongleType == "2")
{
$(".RouterSpecial",Head).showIt(true);
WLAN3GStatusOBJ = $(xml).find("OBJ_TTYROUTERWAN_ID");
RuleNum = $("Instance", WLAN3GStatusOBJ).length;
OBJID = ["OBJ_TTYROUTERWAN_ID"];
}
else
{
$(".ModemSpecial",Head).showIt(true);
}
if (0 == RuleNum)
{
$("#NoItem",Head).showIt(true);
}
else
{
Head.createPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
}
colorTblRow(".colorTbl", "even", Head);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
