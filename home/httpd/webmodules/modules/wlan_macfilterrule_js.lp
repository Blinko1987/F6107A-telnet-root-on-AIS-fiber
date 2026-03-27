<script type="text/javascript">
(function () {
function MacReadyCtl(headObj){
var ruleStr = "<%=_G.ssidConf["MACFilterRule"]%>";
if(ruleStr == ""){
return;
}
var ruleList = ruleStr.split("+");
for(i in ruleList) {
var rule = ruleList[i].split(":");
if(checkRight(rule[1]) == false){
continue;
}
if(rule[0] == "all"){
$("div.row",headObj).find("input,select").attr("disabled", true);
headObj.find(".Btn_cancel,.Btn_apply").disableButton(true);
if(rule[2] == "hideBtn"){
headObj.find(".Btn_cancel,.Btn_apply").showIt(false);
}
if(rule[2] == "enableBtn"){
headObj.find(".Btn_cancel,.Btn_apply").disableButton(false);
}
}
else{
var elementRow = $("div.row:has(#"+rule[0]+")",headObj);
var elementDiv = ($("#"+rule[0], headObj).length>0)?$("#"+rule[0], headObj):$("."+rule[0], headObj);
if(rule[2] == ""){
elementRow.find("input,select").disableIt(true);
}
else if(rule[2] == "hide"){
elementRow.find("input,select").disableIt(true);
elementDiv.showIt(false);
}
else if(rule[2] == "show"){
elementDiv.find("input,select").disableIt(false);
elementDiv.showIt(true);
}
}
}
}
function Customize_MACFilterRule(paramsOBJ)
{
var TemplateOBJ = paramsOBJ["TemplateOBJ"];
TemplateOBJ.collapsibleInstTitleChange("Name");
$("[id^='Btn_apply']", TemplateOBJ).addClass("disableBtn").unbind("click");
}
function initial_template_MACFilterRule(templateID)
{
var template = $("#"+templateID);
var macSegmentCheck = {
"required": true,
"HEX": true,
"fixedlength": 2
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
MACAddress: "sub_MACAddress0 sub_MACAddress1 sub_MACAddress2 sub_MACAddress3 sub_MACAddress4 sub_MACAddress5"
},
"rules": {
"Name": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,32]
},
"sub_MACAddress0": macSegmentCheck,
"sub_MACAddress1": macSegmentCheck,
"sub_MACAddress2": macSegmentCheck,
"sub_MACAddress3": macSegmentCheck,
"sub_MACAddress4": macSegmentCheck,
"sub_MACAddress5": macSegmentCheck
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if ( ActionByApplyResult(xml, template, "Name") == 0 )
{
$("[id^='Btn_apply']", template).addClass("disableBtn").unbind("click");
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_ACLCFG_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"TemplateOBJ":ContainerOBJ
};
Customize_MACFilterRule(CustomizeParams);
});
}
$(document).ready(function(){
var HeadID = "MACFilterRule";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_MACFilterRule(templateID);
MacReadyCtl(Head);
$.publish("/some/selectSSIDModify", [Head]);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var MACFilterRuleOBJ = $(xml).find("OBJ_ACLCFG_ID");
var RuleNum = $("Instance", MACFilterRuleOBJ).length;
var OBJID = ["OBJ_ACLCFG_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
$.publish("/some/SSIDFiltrerModify", [Head]);
};
wlanDisableControl(HeadID);
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
