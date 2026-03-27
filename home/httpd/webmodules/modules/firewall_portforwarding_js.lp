<script type="text/javascript">
(function () {
function pf_templateElementCtrl(templateOBJ)
{
var Head = templateOBJ.parents(".HeadDIV");
var ruleStr = commConf.PortForwarding["elementControl"];
if(ruleStr == undefined){
return;
}
var ruleList = ruleStr.split("+");
for(i in ruleList) {
var rule = ruleList[i].split(":");
if(checkRight(rule[1]) == false){
continue;
}
if(rule[0] == "all"){
$(".addInstBar", Head).remove();
var barObj = $(".formTblCtrlBar", templateOBJ);
barObj.find("input").disableIt(true);
barObj.find(".instDelete").remove();
}
else{
singleElementCtrl4Multi(rule, templateOBJ);
}
}
}
function pf_HeadDIVElementCtrl(HeadID)
{
var Head = $("#"+HeadID);
var templateOBJ = $("#template_"+ HeadID);
var ruleStr = commConf.PortForwarding["elementControl"];
if(ruleStr == undefined){
return;
}
var ruleList = ruleStr.split("+");
for(i in ruleList) {
var rule = ruleList[i].split(":");
if(checkRight(rule[1]) == false){
continue;
}
if(rule[0] == "all"){
disable_all_templte(Head);
if(rule[2] == "hideBtn"){
$("div.buttongroup",Head).find(":button").showIt(false);
}
var barObj = $(".formTblCtrlBar", templateOBJ);
barObj.find("input").disableIt(true);
}
}
}
function initial_template_PortForwarding(templateID)
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
RemoteHost: "sub_RemoteHost0 sub_RemoteHost1 sub_RemoteHost2 sub_RemoteHost3 sub_RemoteHostEndRange0 sub_RemoteHostEndRange1 sub_RemoteHostEndRange2 sub_RemoteHostEndRange3",
ExternalPort: "ExternalPort ExternalPortEndRange",
InternalPort: "InternalPort InternalPortEndRange"
},
"rules": {
"Alias": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,192]
},
"Description": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,765]
},
"ExternalPort": {
"required": true,
"integer": true,
"range":[1,65535],
"extremumRange":["lessThan","ExternalPortEndRange",{"equal" :true}]
},
"ExternalPortEndRange": {
"required": true,
"integer": true,
"range":[1,65535],
"extremumRange":["greatThan","ExternalPort",{"equal" :true}]
},
"InternalPort": {
"required": true,
"integer": true,
"range":[1,65535],
"extremumRange":["lessThan","InternalPortEndRange",{"equal" :true}]
},
"InternalPortEndRange": {
"required": true,
"integer": true,
"range":[1,65535],
"extremumRange":["greatThan","InternalPort",{"equal" :true}]
},
"InternalClient": {
"required": true,
"ASCII": true
},
"sub_RemoteHost0": IPCheckRules,
"sub_RemoteHost1": IPCheckRules,
"sub_RemoteHost2": IPCheckRules,
"sub_RemoteHost3": IPCheckRules,
"sub_RemoteHostEndRange0": IPCheckRules,
"sub_RemoteHostEndRange1": IPCheckRules,
"sub_RemoteHostEndRange2": IPCheckRules,
"sub_RemoteHostEndRange3": IPCheckRules
},
"messages": {
}
};
$.publish("/some/ChekIpAddr", [checkJSONTempObj]);
var data={};
data.checkJson = checkJSONTempObj;
data.template=template;
$.callModifier("portForward/ChangeRules", data);
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Alias");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_FWPM_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByCustom",function(event, suffix,ContainerOBJ){
ContainerOBJ.collapsibleInstTitleChange("Alias");
var AllInterface = $("[id^='AllInterface']",ContainerOBJ).val();
var Interface = $("[id^='Interface']",ContainerOBJ).val();
var InterfaceOBJ = $("[id^='S_Interface']",ContainerOBJ);
if ( AllInterface == "1" )
{
InterfaceOBJ.val("WANAll");
}
else
{
InterfaceOBJ.val(Interface);
}
pf_templateElementCtrl(ContainerOBJ);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var InterfaceOBJ = $("[id^='Interface']",template);
var AllInterfaceOBJ = $("[id^='AllInterface']",template);
var S_InterfaceOBJ = $("[id^='S_Interface']",template);
var InterfaceSelected = S_InterfaceOBJ.find("option:selected").val();
if ( InterfaceSelected == "WANAll" )
{
AllInterfaceOBJ.val("1");
InterfaceOBJ.addClass("PostIgnore");
}
else
{
AllInterfaceOBJ.val("0");
InterfaceOBJ.val(InterfaceSelected);
InterfaceOBJ.removeClass("PostIgnore");
}
});
}
$(document).ready(function(){
var HeadID = "PortForwarding";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_PortForwarding(templateID);
pf_HeadDIVElementCtrl(HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var MACFILTEROBJ = $(xml).find("OBJ_FWPM_ID");
var RuleNum = $("Instance", MACFILTEROBJ).length;
$.publish("/some/softVersionModify", [$("#template_PortForwarding")]);
var OBJID = ["OBJ_FWPM_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
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
