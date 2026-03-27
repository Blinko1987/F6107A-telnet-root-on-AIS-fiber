<script type="text/javascript">
(function () {
function Customize_PlcyRoute(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Alias");
var MacJSON = {
"SrcMAC":"sub_SrcMAC"
};
for (var MACTmp in MacJSON)
{
var MACOBJ = $("[id^='"+MACTmp+"']",ContainerOBJ);
if (MACOBJ.val()=="00:00:00:00:00:00")
{
MACOBJ.val(":::::");
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
var prefixOBJ = $("[id^='SrcPrefixIP'],[id^='DestPrefixIP']", ContainerOBJ);
prefixOBJ.each(function(){
if ($(this).val() == "::")
{
$(this).val("");
}
});
$("[id^='Protocol']",ContainerOBJ).change();
}
function initial_template_PlcyRoute(templateID)
{
var template = $("#"+templateID);
var IPCheckRules = {
"required": true,
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
"SrcPrefixIP": {
"IPv6Addr": true,
"banValue": ["::"]
},
"DestPrefixIP": {
"IPv6Addr": true,
"banValue": ["::"]
},
"SrcPort": {
"integer": true,
"range":[1,65535]
},
"DestPort": {
"integer": true,
"range":[1,65535]
},
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
var OBJID = ["OBJ_ROUTETPOLICY6_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_PlcyRoute(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
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
$("[id^='SrcPrefixIP'],[id^='DestPrefixIP']",template).each(function(){
var thisPrefixObj = $(this);
if (thisPrefixObj.val() == "")
{
thisPrefixObj.addClass("PostIgnore");
}
else
{
thisPrefixObj.removeClass("PostIgnore");
}
});
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
PlcyRouteHead.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_PlcyRoute(CustomizeParams);
};
PlcyRouteHead.succfunction = function(xml){
PlcyRouteHead.hasError(xml,"externErrorHint");
var PlcyRouteOBJ = $(xml).find("OBJ_ROUTETPOLICY6_ID");
var PlcyRouteRuleNum = $("Instance", PlcyRouteOBJ).length;
var plcyOBJID = ["OBJ_ROUTETPOLICY6_ID"];
PlcyRouteHead.createPageDataByClone(PlcyRouteRuleNum, plcyOBJID, xml,
PlcyRouteHead.fillDataByCustom);
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
