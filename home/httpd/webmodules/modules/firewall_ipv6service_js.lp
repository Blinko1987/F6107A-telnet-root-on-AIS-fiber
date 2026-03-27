<script type="text/javascript">
(function(){
function SeviceValueCombineOrSplit(ipmode,action,template)
{
var attrValue = "";
var serviceOption = {
};
if ( ipmode == "IPv4" )
{
$("input[type='checkbox']", "#ServiceControlList").each(function(){
attrValue = $(this).attr("serviceName");
serviceOption["Servise_"+attrValue] = attrValue;
});
}
else if ( ipmode == "IPv6" )
{
$("input[type='checkbox']", "#ServiceControlList6").each(function(){
attrValue = $(this).attr("serviceName");
serviceOption["Servise_"+attrValue] = attrValue;
});
}
if ( action == "Combine" )
{
var combinValue = "";
for ( var servTmp in serviceOption )
{
var servTmpOBJ = $("[id^='"+servTmp+":']",template);
servTmpOBJ.addClass("PostIgnore");
if ( servTmpOBJ && (servTmpOBJ.is(':checked')))
{
if(combinValue.length > 0)
{
combinValue = combinValue+",";
}
combinValue = combinValue + serviceOption[servTmp];
}
}
$("[id^='ServiceList:']",template).val(combinValue);
}
else if ( action == "Split" )
{
var cmpStr = $("[id^='ServiceList:']",template).val().split(",");
for ( var servTmp in serviceOption )
{
var splitValue = serviceOption[servTmp];
var IsMatch = false;
var servTmpOBJ = $("[id^='"+servTmp+"']",template);
for (var i in cmpStr)
{
if (cmpStr[i] == splitValue)
{
IsMatch = true;
break;
}
}
if (IsMatch )
{
servTmpOBJ.prop("checked", true);
}
else
{
servTmpOBJ.prop("checked", false);
}
}
}
else
{
}
}
function initial_template_IPv6serviceCtl(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
PrefixVal: "ShowPrefix ShowPrefixLen"
},
"rules": {
"Name:IPv6serviceCtl": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,32]
},
"ShowPrefixLen": {
"integer": true,
"range":[1,128],
"concurrence":["ShowPrefix"]
},
"ShowPrefix": {
"banValue": ["::"],
"IPv6Addr": true,
"concurrence":["ShowPrefixLen"]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Name");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_FWSCv6_ID"];
ActionByCancelResult(xml, template, OBJID, "Name");
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var WanOptionJSON = {
"INCName":"INCViewName"
};
for ( var WanOptionTmp in WanOptionJSON )
{
var WanOption = $("[id^='"+WanOptionJSON[WanOptionTmp]+"']",template);
var valueTmp = $("option:selected",WanOption).text();
$("[id^='"+WanOptionTmp+"']",template).val(valueTmp);
}
SeviceValueCombineOrSplit("IPv6","Combine",template);
var ShowPrefixVal = $("[id^='ShowPrefix:']",template).val();
if (ShowPrefixVal == "")
{
ShowPrefixVal = "::";
}
$("[id^='Prefix:']",template).val(ShowPrefixVal);
var ShowPrefixLenVal = $("[id^='ShowPrefixLen:']",template).val();
if (ShowPrefixLenVal == "")
{
ShowPrefixLenVal = 0;
}
$("[id^='PrefixLen:']",template).val(ShowPrefixLenVal);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
ContainerOBJ.collapsibleInstTitleChange("Name");
SeviceValueCombineOrSplit("IPv6","Split",ContainerOBJ);
var PrefixVal = $("[id^='Prefix:']",ContainerOBJ).val()
if (PrefixVal == "::")
{
PrefixVal = "";
}
$("[id^='ShowPrefix:']",ContainerOBJ).val(PrefixVal);
var PrefixLenVal = $("[id^='PrefixLen:']",ContainerOBJ).val();
if (PrefixLenVal == "0")
{
PrefixLenVal = "";
}
$("[id^='ShowPrefixLen:']",ContainerOBJ).val(PrefixLenVal);
});
}
$(document).ready(function(){
var HeadID = "IPv6serviceCtl";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_IPv6serviceCtl(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var FWIPOBJ = $(xml).find("OBJ_FWSCv6_ID");
var RuleNum = $("Instance", FWIPOBJ).length;
var OBJID = ["OBJ_FWSCv6_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
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
