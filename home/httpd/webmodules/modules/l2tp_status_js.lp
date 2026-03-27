<script type="text/javascript">
(function(){
function initial_L2tpStatus(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByCustom", function(event, suffix, template){
var dns1 = $("[id^='DNS1']", template).val();
var dns2 = $("[id^='DNS2']", template).val();
var dns3 = $("[id^='DNS3']", template).val();
var allDns = dns1 + "/" + dns2 + "/" + dns3;
var allDnsObj = $("[id^='allDNS']", template);
allDnsObj.text(allDns);
allDnsObj.attr("title", allDns);
var upTimeObj = $("[id^='UpTime']", template);
var upTime = upTimeObj.text();
upTimeObj.text(sec2HrMinSec(upTime));
upTimeObj.attr("title", upTimeObj.text());
var ipObj = $("[id^='IPAddress']", template);
var ip = ipObj.text();
var mask = $("[id^='SubnetMask']", template).val();
ipObj.text(ip + "/" + mask);
ipObj.attr("title", ipObj.text());
var ipModeObj = $("[id^='IpMode']", template);
var ipModeStatus = {
"1": "&?public_100;",
"2": "&?public_101;",
"3": "&?public_126;"
};
ipModeObj.text(ipModeStatus[ipModeObj.text()]);
ipModeObj.attr("title", ipModeObj.text());
var connStatusObj = $("[id^='ConnSatus']", template);
var connStatus = {
"0": "&?L2tpStatus_008;",
"1": "&?L2tpStatus_009;",
"2": "&?L2tpStatus_010;"
};
connStatusObj.text(connStatus[connStatusObj.text()]);
connStatusObj.attr("title", connStatusObj.text());
var natObj = $("[id^='NATEnable']", template);
var natStatus = {
"0": "&?public_034;",
"1": "&?public_033;"
};
natObj.text(natStatus[natObj.text()]);
natObj.attr("title", natObj.text());
var enableObj = $("[id^='Enable']", template);
var enableStatus = {
"0": "&?public_034;",
"1": "&?public_033;"
};
enableObj.text(enableStatus[enableObj.text()]);
enableObj.attr("title", enableObj.text());
});
}
$(document).ready(function(){
var L2tpStatusHeadID = "L2tpStatus";
var L2tpStatusHead = $("#"+L2tpStatusHeadID);
var templateID = "template_"+ L2tpStatusHeadID;
var template = $("#"+templateID);
var L2tpStatusServerAddr = $("address span", L2tpStatusHead).text();
RefreshClickHandle(L2tpStatusHead);
initial_L2tpStatus(templateID);
L2tpStatusHead.succfunction = function(xml){
L2tpStatusHead.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_L2TP_ID");
var RuleNum = $("Instance", OBJ).length;
if (RuleNum == 0)
{
$(".noDataHint", L2tpStatusHead).showIt(true);
}
else
{
$(".noDataHint", L2tpStatusHead).showIt(false);
var OBJID = ["OBJ_L2TP_ID"];
L2tpStatusHead.createPageDataByClone(RuleNum,OBJID,xml);
colorTblRow(".colorTbl", "even", L2tpStatusHead);
}
};
if ( $(".collapBarWithDataTrans",L2tpStatusHead).length <= 0 )
{
L2tpStatusHead.dataTransfer(L2tpStatusServerAddr, "GET", L2tpStatusHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(L2tpStatusHead);
}
});
})();
</script>
