<script type="text/javascript">
(function(){
function Customize_StaticRoute(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Alias");
var gwOBJ = $("[id^='GWIP']", ContainerOBJ);
gwOBJ.each(function(){
if ($(this).val() == "::")
{
$(this).val("");
}
});
}
function initial_template_StaticRoute(templateID)
{
var template = $("#"+templateID);
var IPCheckRules = {
"required": true,
"integer": true,
"range":[0,255]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
IPv6Prefix: "DestIP:StaticRoute PrefixLen:StaticRoute"
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
"DestIP:StaticRoute": {
"required": true,
"IPv6Addr": true
},
"PrefixLen:StaticRoute": {
"required": true,
"integer": true,
"range":[0, 128]
},
"GWIP:StaticRoute": {
"IPv6Addr": true,
"banValue": ["::"]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Alias");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_ROUTESTATIC6_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_StaticRoute(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var prefixLen = $("[id^='PrefixLen']",template).val();
var typeOBJ = $("[id^='Type']",template);
if (prefixLen == "128")
{
typeOBJ.val("Host");
}
else if (prefixLen == "0")
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
"GWIP" : ""
};
if ( portNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "::";
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
var StaticRouteOBJ = $(xml).find("OBJ_ROUTESTATIC6_ID");
var StaticRouteRuleNum = $("Instance", StaticRouteOBJ).length;
var staticOBJID = ["OBJ_ROUTESTATIC6_ID"];
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
