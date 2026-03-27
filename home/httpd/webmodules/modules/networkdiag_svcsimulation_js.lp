<script type="text/javascript">
var g_svcSimulation_timer = null;
function SimulationReGetResult()
{
var HeadID = "SvcSimulation";
var Head = $("#"+HeadID);
var template = $("#template_SvcSimulation");
var ServerAddr = $("address span", Head).text();
var confirmLayerOBJ = $("#confirmLayer");
$("#confirmStop",confirmLayerOBJ).unbind("click");
$("#confirmStop",confirmLayerOBJ).bind("click", function(event){
var msg = "&?DiagnosisManag_038;";
IniConfirm(msg);
$("#confirmCancel",confirmLayerOBJ).unbind("click");
$("#confirmCancel",confirmLayerOBJ).bind("click", function(event){
showWaitTip(true,"&?cmret_004;",true);
});
$("#confirmOK",confirmLayerOBJ).unbind("click");
$("#confirmOK",confirmLayerOBJ).bind("click", {TEMPLATE: template, SERVERADDR:ServerAddr}, function(event){
clearTimeout(g_svcSimulation_timer);
showWaitTip(false);
var template = event.data.TEMPLATE;
var serverAddr = event.data.SERVERADDR;
var simuType = $("#SimulationType", template).val();
var simuAction = "";
if (simuType == "1")
{
simuAction = "PPPoE_DEL";
}
else if (simuType == "2")
{
simuAction = "DHCP_DEL";
}
dataPost(simuAction, "fillDataBySimuStopResult", serverAddr,
template, undefined, false);
});
});
dataPost("", "fillDataByRePostResult", ServerAddr, template, undefined, false);
}
function GetSimuResult(xml,simuType,OBJID)
{
var resultStr = "";
var template = $("#template_SvcSimulation");
var ControlParaArr = {
"Issucceed" : {ValueOrigin: ""},
"Opt60Mode" : {ValueOrigin: ""},
"PortViewName": {ValueOrigin: ""}
};
xmlParaInInstOperate(xml, OBJID, 0, ControlParaArr);
var issucceed = ControlParaArr.Issucceed.ValueOrigin;
var Opt60Mode = ControlParaArr.Opt60Mode.ValueOrigin;
var portView = ControlParaArr.PortViewName.ValueOrigin;
var portStr = "#PortViewName [value='" + portView + "']";
var portName = $(portStr,template).text();
resultStr += "Port: " + portName + "\r\n";
var ToBeChagParaArr = {
"PortState" : {
setAction: function(ParaNameSel, ParaValSel, SelfVal){
var portText = {
"0": "None",
"1": "Running",
"2": "Complete",
"3": "Complete"
};
if (portText[SelfVal] != undefined)
{
ParaValSel.text(portText[SelfVal]);
}
}
},
"AuthType" : {
setAction: function(ParaNameSel, ParaValSel, SelfVal){
var authTypeText = {
"0": "Auto",
"1": "PAP",
"2": "CHAP"
};
if (authTypeText[SelfVal] != undefined)
{
ParaValSel.text(authTypeText[SelfVal]);
}
}
},
"IPMode" : {
setAction: function(ParaNameSel, ParaValSel, SelfVal){
var IPModeText = {
"IPv4": "IPv4",
"IPv6": "IPv6",
"Both": "IPv4/v6"
};
if (IPModeText[SelfVal] != undefined)
{
ParaValSel.text(IPModeText[SelfVal]);
}
}
},
"Opt60Mode" : {
setAction: function(ParaNameSel, ParaValSel, SelfVal){
var opt60ModeText = {
"0": "Account mode",
"1": "MAC mode"
};
if (opt60ModeText[SelfVal] != undefined)
{
ParaValSel.text(opt60ModeText[SelfVal]);
}
}
}
};
xmlParaInInstOperate(xml, OBJID, 0, ToBeChagParaArr);
var PPPoEOrder = [
"PortState",
"SimuTypePPPoE",
"RetryTimes",
"AuthType",
"UserName",
"PassWord",
"SuccResult",
"SimuGateWay",
"SimuIp",
"FailResult",
"FailReason",
"IPMode",
"AuthCode",
"IPv6IPAddress",
"IPv6DNSAddress",
"DefaultIPv6Gateway",
"SessionID"
];
var PPPoEParaArr = {
"PortState" : {ValueOrigin: "", RelatedText: "Port State: "},
"SimuTypePPPoE" : {ValueOrigin: "PPPoE", RelatedText: "Simulation Type: "},
"RetryTimes" : {ValueOrigin: "", RelatedText: "Retry Times: "},
"AuthType" : {ValueOrigin: "", RelatedText: "Authentication Type: "},
"UserName" : {ValueOrigin: "", RelatedText: "Username: "},
"PassWord" : {ValueOrigin: "", RelatedText: "Password: "},
"SuccResult" : {ValueOrigin: "Succeeded", RelatedText: "Result: ", Condtion:(issucceed == "1")},
"SimuGateWay" : {ValueOrigin: "", RelatedText: "Simulation Gateway: ", Condtion:(issucceed == "1")},
"SimuIp" : {ValueOrigin: "", RelatedText: "IP Address: ", Condtion:(issucceed == "1")},
"FailResult" : {ValueOrigin: "Failed", RelatedText: "Result: ", Condtion:(issucceed != "1")},
"FailReason" : {ValueOrigin: "Failed", RelatedText: "Failed Reason: ", Condtion:(issucceed != "1")},
"IPMode" : {ValueOrigin: "", RelatedText: "IPMode: "},
"AuthCode" : {ValueOrigin: "", RelatedText: "AuthCode: "},
"IPv6IPAddress" : {ValueOrigin: "", RelatedText: "IPv6IPAddress: "},
"IPv6DNSAddress" : {ValueOrigin: "", RelatedText: "IPv6DNSAddress: "},
"DefaultIPv6Gateway" : {ValueOrigin: "", RelatedText: "DefaultIPv6Gateway: "},
"SessionID" : {ValueOrigin: "", RelatedText: "SessionID: "}
};
var ipmodeType = $("#IPMode", template).val();
if(ipmodeType == "IPv4")
{
PPPoEOrder = [
"PortState",
"SimuTypePPPoE",
"RetryTimes",
"AuthType",
"UserName",
"PassWord",
"SuccResult",
"SimuGateWay",
"SimuIp",
"FailResult",
"FailReason",
"IPMode",
"SessionID"
];
PPPoEParaArr = {
"PortState" : {ValueOrigin: "", RelatedText: "Port State: "},
"SimuTypePPPoE" : {ValueOrigin: "PPPoE", RelatedText: "Simulation Type: "},
"RetryTimes" : {ValueOrigin: "", RelatedText: "Retry Times: "},
"AuthType" : {ValueOrigin: "", RelatedText: "Authentication Type: "},
"UserName" : {ValueOrigin: "", RelatedText: "Username: "},
"PassWord" : {ValueOrigin: "", RelatedText: "Password: "},
"SuccResult" : {ValueOrigin: "Succeeded", RelatedText: "Result: ", Condtion:(issucceed == "1")},
"SimuGateWay" : {ValueOrigin: "", RelatedText: "Simulation Gateway: ", Condtion:(issucceed == "1")},
"SimuIp" : {ValueOrigin: "", RelatedText: "IP Address: ", Condtion:(issucceed == "1")},
"FailResult" : {ValueOrigin: "Failed", RelatedText: "Result: ", Condtion:(issucceed != "1")},
"FailReason" : {ValueOrigin: "Failed", RelatedText: "Failed Reason: ", Condtion:(issucceed != "1")},
"IPMode" : {ValueOrigin: "", RelatedText: "IPMode: "},
"SessionID" : {ValueOrigin: "", RelatedText: "SessionID: "}
};
}
xmlParaInInstOperate(xml, OBJID, 0, PPPoEParaArr);
var IPoEOrder = [
"PortState",
"SimuTypeIPoE",
"SimuMAC",
"Opt60Mode",
"UserName",
"PassWord",
"OptContent",
"SuccResult",
"SimuGateWay",
"SimuIp",
"FailResult",
"FailReason"
,
"PingDestIP",
"PingTimes",
"PingTimeOut",
"PingSuccessCount",
"PingFailCount",
"PingResTimeMax",
"PingResTimeMin",
"PingResTimeAver"
];
var IPoEParaArr = {
"PortState" : {ValueOrigin: "", RelatedText: "Port State: "},
"SimuTypeIPoE" : {ValueOrigin: "IPoE", RelatedText: "Simulation Type: "},
"SimuMAC" : {ValueOrigin: "", RelatedText: "Simulation MAC: "},
"Opt60Mode" : {ValueOrigin: "", RelatedText: "Option60 Mode: "},
"UserName" : {ValueOrigin: "", RelatedText: "Username: ", Condtion:(Opt60Mode == "0")},
"PassWord" : {ValueOrigin: "", RelatedText: "Password: ", Condtion:(Opt60Mode == "0")},
"OptContent" : {ValueOrigin: "", RelatedText: "Vendor Class ID: ", Condtion:(Opt60Mode != "0")},
"SuccResult" : {ValueOrigin: "Succeeded", RelatedText: "Result: ", Condtion:(issucceed == "1")},
"SimuGateWay" : {ValueOrigin: "", RelatedText: "Simulation Gateway: ", Condtion:(issucceed == "1")},
"SimuIp" : {ValueOrigin: "", RelatedText: "IP Address: ", Condtion:(issucceed == "1")},
"FailResult" : {ValueOrigin: "Failed", RelatedText: "Result: ", Condtion:(issucceed != "1")},
"FailReason" : {ValueOrigin: "Failed", RelatedText: "Failed Reason: ", Condtion:(issucceed != "1")},
"PingDestIP" : {ValueOrigin: "", RelatedText: "PING Destination IP Address: "},
"PingTimes" : {ValueOrigin: "", RelatedText: "PING Times: "},
"PingTimeOut" : {ValueOrigin: "", RelatedText: "PING Timeout: "},
"PingSuccessCount" : {ValueOrigin: "", RelatedText: "PING Success Count: "},
"PingFailCount" : {ValueOrigin: "", RelatedText: "PING Fail Count: "},
"PingResTimeMax" : {ValueOrigin: "", RelatedText: "Maximum Response Time: "},
"PingResTimeMin" : {ValueOrigin: "", RelatedText: "Minimum Response Time: "},
"PingResTimeAver" : {ValueOrigin: "", RelatedText: "Average Response Time: "}
};
xmlParaInInstOperate(xml, OBJID, 0, IPoEParaArr);
var tmpOrderArr;
var tmpDataArr;
if ( simuType == 1 )
{
tmpOrderArr = PPPoEOrder;
tmpDataArr = PPPoEParaArr;
}
else
{
tmpOrderArr = IPoEOrder;
tmpDataArr = IPoEParaArr;
}
for (var i=0; i<tmpOrderArr.length; i++)
{
var tmpID = tmpOrderArr[i];
if ( tmpDataArr[tmpID].Condtion != undefined && tmpDataArr[tmpID].Condtion == false )
{
continue;
}
var tmpStr = tmpDataArr[tmpID].RelatedText + tmpDataArr[tmpID].ValueOrigin;
resultStr += tmpStr + "\r\n";
}
return resultStr;
}
function ReGetSvcSimulation(xml)
{
var template = $("#template_SvcSimulation");
var TRResult = "";
var TRFlag = "";
var simuType = $("#SimulationType", template).val();
var OBJID = "";
if (simuType == "1")
{
OBJID = "OBJ_SIMULATION_PPPOE_GET_ID";
}
else if (simuType == "2")
{
OBJID = "OBJ_SIMULATION_DHCP_GET_ID";
}
var portState = "";
if (template.hasError(xml) == 0)
{
portState = getParaValueInXML(xml, OBJID, 0, "PortState");
if((portState == 0 || portState == 1))
{
g_svcSimulation_timer = setTimeout("SimulationReGetResult()", 3000);
}
else
{
showWaitTip(false);
var PortViewName = getParaValueInXML(xml, OBJID, 0, "PortViewName");
if (PortViewName == "")
{
return;
}
var simuResult = GetSimuResult(xml,simuType,OBJID);
template.find("textarea").val(simuResult);
}
}
}
function initial_template_SvcSimulation(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByRePostResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
ReGetSvcSimulation(xml);
}
});
template.bind("fillDataBySimuStopResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
showWaitTip(false);
}
});
template.bind("fillDataBySimulationResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
SimulationReGetResult();
}
else
{
showWaitTip(false);
}
});
var vlanRelvObjs = $(".vlanRelv", template);
$("input:radio[name='UseVlan']", template).change(function(){
var radioVal = $(this).val();
if (radioVal == 1)
{
vlanRelvObjs.showIt(true);
$("#VlanId", template).removeClass("PostIgnore");
$("#VlanPri", template).removeClass("PostIgnore");
}
else
{
vlanRelvObjs.showIt(false);
$("#VlanId", template).addClass("PostIgnore");
$("#VlanPri", template).addClass("PostIgnore");
}
});
var pppoeRelvRows = $(".forPPPoE", template);
var dhcpRelvRows = $(".forDHCP", template);
$("#S_SimulationType", template).change(function(){
var typeVal = $(this).val();
$("#SimulationType", template).val(typeVal);
if (typeVal == "1")
{
pppoeRelvRows.showIt(true);
dhcpRelvRows.showIt(false);
}
else if(typeVal == "2")
{
pppoeRelvRows.showIt(false);
dhcpRelvRows.showIt(true);
$("input:radio[name='Opt60Mode']", template).change();
}
else
{
}
});
var OptAccoutRows = $(".OptAccout", template);
var OptMacRows = $(".OptMac", template);
$("input:radio[name='Opt60Mode']", template).change(function(){
if ($("#Opt60Mode0",template).is(':checked'))
{
OptAccoutRows.showIt(true);
OptMacRows.showIt(false);
$("#UserNameOpt60", template).removeClass("PostIgnore");
$("#PassWordOpt60", template).removeClass("PostIgnore");
$("#OptLen", template).addClass("PostIgnore");
$("#OptContent", template).addClass("PostIgnore");
}
else
{
OptMacRows.showIt(true);
OptAccoutRows.showIt(false);
$("#UserNameOpt60", template).addClass("PostIgnore");
$("#PassWordOpt60", template).addClass("PostIgnore");
$("#OptLen", template).removeClass("PostIgnore");
$("#OptContent", template).removeClass("PostIgnore");
}
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var IpJSON = {
"PingDestIP":"sub_PingDestIP"
};
for (var IPTmp in IpJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']",template);
ipHiddenObj.FillIPorMacDataCombination(IpJSON[IPTmp], ".", 4);
}
var MacJSON = {
"SimuMAC":"sub_SimuMAC"
};
for (var MACTmp in MacJSON)
{
var macHiddenObj = $("[id^='"+MACTmp+"']",template);
macHiddenObj.FillIPorMacDataCombination(MacJSON[MACTmp], ":", 6);
}
$("#OptLen", template).val($("#OptContent", template).val().length);
});
var macSegmentCheck = {
"required": true,
"HEX": true,
"fixedlength": 2
};
var ipCheckRules = {
"required": true,
"integer": true,
"range":[0,255]
};
var instForm = template.find("form");
instForm.validate({
"groups": {
PingDestIP: "sub_PingDestIP0 sub_PingDestIP1 sub_PingDestIP2 sub_PingDestIP3",
SimuMAC: "sub_SimuMAC0 sub_SimuMAC1 sub_SimuMAC2 sub_SimuMAC3 sub_SimuMAC4 sub_SimuMAC5"
},
"rules": {
"VlanId": {
"required": true,
"integer": true,
"range":[1,4094]
},
"PppoeUserName": {
"required": true,
"ASCII": true,
"rangelength":[1,64]
},
"PppoePassWord": {
"ASCII": true,
"rangelength":[0,64]
},
"RetryTimes": {
"required": true,
"integer": true,
"range":[1,3]
},
"UserNameOpt60": {
"required": true,
"ASCII": true,
"rangelength":[1,64]
},
"PassWordOpt60": {
"required": true,
"ASCII": true,
"rangelength":[1,64]
},
"SimuTimeOut": {
"required": true,
"integer": true,
"range":[1,60]
},
"sub_PingDestIP0": ipCheckRules,
"sub_PingDestIP1": ipCheckRules,
"sub_PingDestIP2": ipCheckRules,
"sub_PingDestIP3": ipCheckRules,
"PingTimes": {
"required": true,
"integer": true,
"range":[1,20]
},
"PingTimeOut": {
"required": true,
"integer": true,
"range":[1,3000]
},
"sub_SimuMAC0": macSegmentCheck,
"sub_SimuMAC1": macSegmentCheck,
"sub_SimuMAC2": macSegmentCheck,
"sub_SimuMAC3": macSegmentCheck,
"sub_SimuMAC4": macSegmentCheck,
"sub_SimuMAC5": macSegmentCheck
},
"messages": {
}
});
}
$(document).ready(function(){
var TRHeadID = "SvcSimulation";
var TRHead = $("#"+TRHeadID);
var TRtemplateID = "template_"+ TRHeadID;
var TRServerAddr = $("address span", TRHead).text();
var template = $("#"+TRtemplateID);
$.publish("/some/SVCSimulationHide", [1]);
initial_template_SvcSimulation(TRtemplateID);
$(".Btn_SvcSimulation").bind("click", {templateOBJ:TRtemplateID}, function(event){
if ( false == $(".form_content", $("#"+TRtemplateID)).valid() )
{
return;
}
showWaitTip(false);
showWaitTip(true,"&?cmret_004;",true);
var TRtemplate = $(this).parents("[id^='template']");
TRHead.find("textarea").val("");
var simuType = $("#SimulationType", TRtemplate).val();
var simuAction = "";
if (simuType == "1")
{
simuAction = "PPPoE_APPLY";
}
else if (simuType == "2")
{
simuAction = "DHCP_APPLY";
}
dataPost(simuAction, "fillDataBySimulationResult",
TRServerAddr, TRtemplate, undefined, false);
});
TRHead.succfunction = function(xml){
TRHead.hasError(xml,"externErrorHint");
$("input:radio[name='UseVlan']", template).change();
$("#S_SimulationType", template).change();
};
TRHead.dataTransfer(TRServerAddr,
"GET",
TRHead.succfunction,
undefined,
true,
true);
});
</script>
