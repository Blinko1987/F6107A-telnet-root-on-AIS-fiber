<script type="text/javascript">
(function(){
function Customize_PlcyRoute(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Alias");
var IpJSON = {
"SrcIP":"sub_SrcIP",
"SrcIPMask":"sub_SrcIPMask",
"DestIP":"sub_DestIP",
"DestIPMask":"sub_DestIPMask"
};
for (var IPTmp in IpJSON)
{
var IPOBJ = $("[id^='"+IPTmp+"']",ContainerOBJ);
if (IPOBJ.val() == "0.0.0.0")
{
IPOBJ.val("...")
}
IPOBJ.FillIPorMacDataBySplit(IpJSON[IPTmp], ".", 4);
}
var MacJSON = {
"SrcMAC":"sub_SrcMAC"
};
for (var MACTmp in MacJSON)
{
var MACOBJ = $("[id^='"+MACTmp+"']",ContainerOBJ);
if (MACOBJ.val() == "00:00:00:00:00:00")
{
MACOBJ.val(":::::")
}
MACOBJ.FillIPorMacDataBySplit(MacJSON[MACTmp], ":", 6);
}
var portOBJ = $("[id^='SrcPort'],[id^='DestPort']", ContainerOBJ);
portOBJ.each(function(){
if ($(this).val() == 0)
{
$(this).val("");
}
});
$("[id^='Protocol']",ContainerOBJ).change();
}
function initial_template_PlcyRoute(templateID)
{
var template = $("#"+templateID);
var ipCheckRules = {
"integer": true,
"range":[0,255]
};
var macSegmentCheck = {
"HEX": true,
"fixedlength": 2
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
SrcIP: "sub_SrcIP0 sub_SrcIP1 sub_SrcIP2 sub_SrcIP3",
DestIP: "sub_DestIP0 sub_DestIP1 sub_DestIP2 sub_DestIP3",
DestIPMask: "sub_DestIPMask0 sub_DestIPMask1 sub_DestIPMask2 sub_DestIPMask3",
SrcIPMask: "sub_SrcIPMask0 sub_SrcIPMask1 sub_SrcIPMask2 sub_SrcIPMask3",
SrcMAC: "sub_SrcMAC0 sub_SrcMAC1 sub_SrcMAC2 sub_SrcMAC3 sub_SrcMAC4 sub_SrcMAC5"
},
"rules": {
"DestInterface": {
"required": true
},
"Alias:PolicyRoute": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,64]
},
"SrcPort": {
"integer": true,
"range":[1,65535]
},
"DestPort": {
"integer": true,
"range":[1,65535]
},
"sub_SrcIP0": ipCheckRules,
"sub_SrcIP1": ipCheckRules,
"sub_SrcIP2": ipCheckRules,
"sub_SrcIP3": ipCheckRules,
"sub_SrcIPMask0": ipCheckRules,
"sub_SrcIPMask1": ipCheckRules,
"sub_SrcIPMask2": ipCheckRules,
"sub_SrcIPMask3": ipCheckRules,
"sub_DestIP0": ipCheckRules,
"sub_DestIP1": ipCheckRules,
"sub_DestIP2": ipCheckRules,
"sub_DestIP3": ipCheckRules,
"sub_DestIPMask0": ipCheckRules,
"sub_DestIPMask1": ipCheckRules,
"sub_DestIPMask2": ipCheckRules,
"sub_DestIPMask3": ipCheckRules,
"sub_SrcMAC0": macSegmentCheck,
"sub_SrcMAC1": macSegmentCheck,
"sub_SrcMAC2": macSegmentCheck,
"sub_SrcMAC3": macSegmentCheck,
"sub_SrcMAC4": macSegmentCheck,
"sub_SrcMAC5": macSegmentCheck
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("wholeIPorMACCheck", function(event, template, IPMACCheckResult){
var checkIPorMACObj = {
"SrcIP": {
"eleType": "IP",
"labelId": "sub_SrcIP0",
"rules":{
"banValue": ["0.0.0.0"]
},
"messages": {
}
},
"SrcIPMask": {
"eleType": "IP",
"labelId": "sub_SrcIPMask0",
"rules": {
"banValue": ["0.0.0.0"]
},
"messages": {
}
},
"DestIP": {
"eleType": "IP",
"labelId": "sub_DestIP0",
"rules": {
"banValue": ["0.0.0.0"]
},
"messages": {
}
},
"DestIPMask": {
"eleType": "IP",
"labelId": "sub_DestIPMask0",
"rules": {
"banValue": ["0.0.0.0"]
},
"messages": {
}
},
"SrcMAC": {
"eleType": "MAC",
"labelId": "sub_SrcMAC0",
"rules":{
"banValue": ["00:00:00:00:00:00","ff:ff:ff:ff:ff:ff"]
},
"messages": {
}
}
};
template.checkIPorMACbyApply(checkIPorMACObj, template, IPMACCheckResult);
});
$("[id^='Protocol']",template).change(function(event){
var ProtocolOBJ = $(this);
var template = ProtocolOBJ.parents("[id^='template_']");
var protocol = ProtocolOBJ.val();
var controlledOBJ = $("[id^='SrcPort'],[id^='DestPort']", template);
if ( protocol == "ICMP" || protocol == "ANY" )
{
controlledOBJ.parent().parent().hide();
controlledOBJ.addClass("PostIgnore");
}
else
{
controlledOBJ.parent().parent().show();
controlledOBJ.removeClass("PostIgnore");
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Alias");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_ROUTETPOLICY_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_PlcyRoute(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var IpJSON = {
"SrcIP":"sub_SrcIP",
"SrcIPMask":"sub_SrcIPMask",
"DestIP":"sub_DestIP",
"DestIPMask":"sub_DestIPMask"
};
for (var IPTmp in IpJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']",template);
ipHiddenObj.FillIPorMacDataCombination(IpJSON[IPTmp], ".", 4);
if (ipHiddenObj.val() == "...")
{
ipHiddenObj.addClass("PostIgnore");
}
else
{
ipHiddenObj.removeClass("PostIgnore");
}
}
var MacJSON = {
"SrcMAC":"sub_SrcMAC"
};
for (var MACTmp in MacJSON)
{
var macHiddenObj = $("[id^='"+MACTmp+"']",template);
macHiddenObj.FillIPorMacDataCombination(MacJSON[MACTmp], ":", 6);
if (macHiddenObj.val() == ":::::")
{
macHiddenObj.addClass("PostIgnore");
}
else
{
macHiddenObj.removeClass("PostIgnore");
}
}
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
var portNameValue = {
"SrcPort" : "",
"DestPort" : ""
};
if ( portNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "0";
}
});
}
$(document).ready(function(){
var PlcyRouteHeadID = "PolicyRoute";
var PlcyRouteHead = $("#"+PlcyRouteHeadID);
var PlcyRouteTempalteID = "template_"+ PlcyRouteHeadID;
var PlcyRouteServerAddr = $("address span", PlcyRouteHead).text();
initial_template_PlcyRoute(PlcyRouteTempalteID);
PlcyRouteHead.succfunction = function(xml){
PlcyRouteHead.hasError(xml,"externErrorHint");
var PlcyRouteOBJ = $(xml).find("OBJ_ROUTETPOLICY_ID");
var PlcyRouteRuleNum = $("Instance", PlcyRouteOBJ).length;
var plcyOBJID = ["OBJ_ROUTETPOLICY_ID"];
PlcyRouteHead.createPageDataByClone(PlcyRouteRuleNum, plcyOBJID, xml);
};
if ( $(".collapBarWithDataTrans",PlcyRouteHead).length <= 0 )
{
PlcyRouteHead.dataTransfer(PlcyRouteServerAddr,
"GET",
PlcyRouteHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(PlcyRouteHead);
}
});
})();
</script>
