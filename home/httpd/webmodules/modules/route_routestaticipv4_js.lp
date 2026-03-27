<script type="text/javascript">
(function(){
function Customize_StaticRoute(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Alias");
var IpJSON = {
"GWIP":"sub_GWIP",
"DestIP":"sub_DestIP",
"DestIPMask":"sub_DestIPMask"
};
for (var IPTmp in IpJSON)
{
var IPOBJ = $("[id^='"+IPTmp+"']",ContainerOBJ);
if (IPOBJ.val() == "0.0.0.0" && IPTmp == "GWIP")
{
IPOBJ.val("...");
}
IPOBJ.FillIPorMacDataBySplit(IpJSON[IPTmp], ".", 4);
}
}
function initial_template_StaticRoute(templateID)
{
var template = $("#"+templateID);
var IPCheckRules = {
"required": true,
"integer": true,
"range":[0,255]
};
var IPCheckOptRules = {
"integer": true,
"range":[0,255]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
"DestIP": "sub_DestIP0:StaticRoute sub_DestIP1:StaticRoute sub_DestIP2:StaticRoute sub_DestIP3:StaticRoute",
"DestIPMask": "sub_DestIPMask0:StaticRoute sub_DestIPMask1:StaticRoute sub_DestIPMask2:StaticRoute sub_DestIPMask3:StaticRoute",
"GWIP": "sub_GWIP0 sub_GWIP1 sub_GWIP2 sub_GWIP3"
},
"rules": {
"Interface:StaticRoute": {
"required": true
},
"Alias:StaticRoute": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,64]
},
"sub_DestIP0:StaticRoute": IPCheckRules,
"sub_DestIP1:StaticRoute": IPCheckRules,
"sub_DestIP2:StaticRoute": IPCheckRules,
"sub_DestIP3:StaticRoute": IPCheckRules,
"sub_DestIPMask0:StaticRoute": IPCheckRules,
"sub_DestIPMask1:StaticRoute": IPCheckRules,
"sub_DestIPMask2:StaticRoute": IPCheckRules,
"sub_DestIPMask3:StaticRoute": IPCheckRules,
"sub_GWIP0": IPCheckOptRules,
"sub_GWIP1": IPCheckOptRules,
"sub_GWIP2": IPCheckOptRules,
"sub_GWIP3": IPCheckOptRules
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("wholeIPorMACCheck", function(event, template, IPMACCheckResult){
var checkIPorMACObj = {
"GWIP": {
"eleType": "IP",
"labelId": "sub_GWIP0",
"rules": {
"banValue": ["0.0.0.0"]
},
"messages": {
}
}
};
template.checkIPorMACbyApply(checkIPorMACObj, template, IPMACCheckResult);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Alias");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_ROUTESTATIC_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_StaticRoute(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var IpJSON = {
"GWIP":"sub_GWIP",
"DestIP":"sub_DestIP",
"DestIPMask":"sub_DestIPMask"
};
for (var IPTmp in IpJSON)
{
$("[id^='"+IPTmp+"']",template).FillIPorMacDataCombination(IpJSON[IPTmp], ".", 4);
}
var destIPMask = $("[id^='DestIPMask']",template).val();
var typeOBJ = $("[id^='Type']",template);
if (destIPMask == "255.255.255.255")
{
typeOBJ.val("Host");
}
else if (destIPMask == "0.0.0.0")
{
typeOBJ.val("Default");
}
else
{
typeOBJ.val("Network");
}
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
var portNameValue = {
"GWIP" : "..."
};
if ( portNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "0.0.0.0";
}
});
}
$(document).ready(function(){
var StaticRouteHeadID = "StaticRoute";
var StaticRouteHead = $("#"+StaticRouteHeadID);
var StaticRouteTempalteID = "template_"+ StaticRouteHeadID;
var StaticRouteServerAddr = $("address span", StaticRouteHead).text();
initial_template_StaticRoute(StaticRouteTempalteID);
StaticRouteHead.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_StaticRoute(CustomizeParams);
};
StaticRouteHead.succfunction = function(xml){
StaticRouteHead.hasError(xml,"externErrorHint");
var StaticRouteOBJ = $(xml).find("OBJ_ROUTESTATIC_ID");
var StaticRouteRuleNum = $("Instance", StaticRouteOBJ).length;
var staticOBJID = ["OBJ_ROUTESTATIC_ID"];
StaticRouteHead.createPageDataByClone(StaticRouteRuleNum, staticOBJID, xml,
StaticRouteHead.fillDataByCustom);
};
if ( $(".collapBarWithDataTrans",StaticRouteHead).length <= 0 )
{
StaticRouteHead.dataTransfer(StaticRouteServerAddr,
"GET",
StaticRouteHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(StaticRouteHead);
}
});
})();
</script>
