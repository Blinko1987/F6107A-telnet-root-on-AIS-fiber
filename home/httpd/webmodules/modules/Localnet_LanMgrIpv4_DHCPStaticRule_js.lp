<script type="text/javascript">
chanegeButtonByCustom = function(btn, ContainerOBJ){
var Obj = $("[id^='"+btn+"']",ContainerOBJ);
Obj.addClass("disableBtn");
};
function Customize_DHCPStaticRule(paramsOBJ)
{
var TemplateOBJ = paramsOBJ["TemplateOBJ"];
TemplateOBJ.collapsibleInstTitleChange("Name");
var MACJSON = {
"MACAddr":"sub_MACAddr"
};
for (var MACTmp in MACJSON)
{
var macHiddenObj = $("[id^='"+MACTmp+"']", TemplateOBJ);
macHiddenObj.FillIPorMacDataBySplit(MACJSON[MACTmp], ":", 6);
}
var IPJSON = {
"IPAddr":"sub_IPAddr"
};
for (var IPTmp in IPJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']", TemplateOBJ);
ipHiddenObj.FillIPorMacDataBySplit(IPJSON[IPTmp], ".", 4);
}
}
function initial_template_DHCPStaticRule(templateID)
{
var template = $("#"+templateID);
var macSegmentCheck = {
"required": true,
"HEX": true,
"fixedlength": 2
};
var ipSegmentCheck = {
"required": true,
"integer": true,
"range": [0, 255]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
MACAddr: "sub_MACAddr0 sub_MACAddr1 sub_MACAddr2 sub_MACAddr3 sub_MACAddr4 sub_MACAddr5",
IPAddr: "sub_IPAddr0 sub_IPAddr1 sub_IPAddr2 sub_IPAddr3"
},
"rules": {
"Name": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,32]
},
"sub_MACAddr0": macSegmentCheck,
"sub_MACAddr1": macSegmentCheck,
"sub_MACAddr2": macSegmentCheck,
"sub_MACAddr3": macSegmentCheck,
"sub_MACAddr4": macSegmentCheck,
"sub_MACAddr5": macSegmentCheck,
"sub_IPAddr0": ipSegmentCheck,
"sub_IPAddr1": ipSegmentCheck,
"sub_IPAddr2": ipSegmentCheck,
"sub_IPAddr3": ipSegmentCheck
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Name");
});
<%
if "0" == env.getenv("DHCPConfigurable") then
%>
chanegeButtonByCustom("Btn_apply_DHCPStaticRule", template)
<%
end
%>
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DHCPBIND_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var MACJSON = {
"MACAddr":"sub_MACAddr"
};
for (var MACTmp in MACJSON)
{
var macHiddenObj = $("[id^='"+MACTmp+"']",template);
macHiddenObj.FillIPorMacDataCombination(MACJSON[MACTmp], ":", 6);
}
var IPJSON = {
"IPAddr":"sub_IPAddr"
};
for (var IPTmp in IPJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']", template);
ipHiddenObj.FillIPorMacDataCombination(IPJSON[IPTmp], ".", 4);
}
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"TemplateOBJ":ContainerOBJ
};
Customize_DHCPStaticRule(CustomizeParams);
});
}
$(document).ready(function(){
var HeadID = "DHCPStaticRule";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_DHCPStaticRule(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var DHCPStaticRuleOBJ = $(xml).find("OBJ_DHCPBIND_ID");
var RuleNum = $("Instance", DHCPStaticRuleOBJ).length;
var OBJID = ["OBJ_DHCPBIND_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
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
var Btn_DHCPStaticRule_Refresh= $("#DHCPStaticRule_Refresh_button", Head);
Btn_DHCPStaticRule_Refresh.unbind("click");
Btn_DHCPStaticRule_Refresh.click(function(){
var HeadID = Head.attr("id");
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
false);
});
});
</script>
