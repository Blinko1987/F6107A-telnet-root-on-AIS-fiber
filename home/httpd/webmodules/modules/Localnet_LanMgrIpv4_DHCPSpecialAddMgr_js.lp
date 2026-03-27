<script type="text/javascript">
function Customize_DHCPSpecialAddMgr(paramsOBJ)
{
var TemplateOBJ = paramsOBJ["TemplateOBJ"];
TemplateOBJ.collapsibleInstTitleChange("PoolName");
var IPJSON = {
"MinAddress":"sub_SpecialMinAddress",
"MaxAddress":"sub_SpecialMaxAddress"
};
for (var IPTmp in IPJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']", TemplateOBJ);
ipHiddenObj.FillIPorMacDataBySplit(IPJSON[IPTmp], ".", 4);
}
var MinAddress = $("[id^='MinAddress']", TemplateOBJ).val();
$("[id^='Text_MinAddress']", TemplateOBJ).text(MinAddress);
var MaxAddress = $("[id^='MaxAddress']", TemplateOBJ).val();
$("[id^='Text_MaxAddress']", TemplateOBJ).text(MaxAddress);
}
function initial_template_DHCPSpecialAddMgr(templateID)
{
var template = $("#"+templateID);
var IPCheckRules = {
"integer": true,
"range":[0,255]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
MinAddress: "sub_SpecialMinAddress0 sub_SpecialMinAddress1 sub_SpecialMinAddress2 sub_SpecialMinAddress3",
MaxAddress: "sub_SpecialMaxAddress0 sub_SpecialMaxAddress1 sub_SpecialMaxAddress2 sub_SpecialMaxAddress3"
},
"rules": {
"sub_SpecialMinAddress0": IPCheckRules,
"sub_SpecialMinAddress1": IPCheckRules,
"sub_SpecialMinAddress2": IPCheckRules,
"sub_SpecialMinAddress3": IPCheckRules,
"sub_SpecialMaxAddress0": IPCheckRules,
"sub_SpecialMaxAddress1": IPCheckRules,
"sub_SpecialMaxAddress2": IPCheckRules,
"sub_SpecialMaxAddress3": IPCheckRules
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
var OBJID = ["OBJ_DHCPPOOL_ID"];
if (template.hasError(xml) == 0)
{
succHintShow(template);
template.fillDataByOBJID(xml, OBJID, template, 0);
}
var CustomizeParams = {
"TemplateOBJ":template
};
Customize_DHCPSpecialAddMgr(CustomizeParams);
});
<%
if "0" == env.getenv("DHCPConfigurable") then
%>
chanegeButtonByCustom("Btn_apply_DHCPSpecialAddMgr", template)
<%
end
%>
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DHCPPOOL_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"TemplateOBJ":template
};
Customize_DHCPSpecialAddMgr(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var IPJSON = {
"MinAddress":"sub_SpecialMinAddress",
"MaxAddress":"sub_SpecialMaxAddress"
};
for (var IPTmp in IPJSON)
{
var ipHiddenObj = $("[id^='"+IPTmp+"']", template);
ipHiddenObj.FillIPorMacDataCombination(IPJSON[IPTmp], ".", 4);
}
});
}
$(document).ready(function(){
var HeadID = "DHCPSpecialAddMgr";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_DHCPSpecialAddMgr(templateID);
Head.fillDataByCustom = function(suffix,TemplateOBJ){
var CustomizeParams = {
"TemplateOBJ":TemplateOBJ
};
Customize_DHCPSpecialAddMgr(CustomizeParams);
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var DHCPSpecialAddMgrOBJ = $(xml).find("OBJ_DHCPPOOL_ID");
var RuleNum = $("Instance", DHCPSpecialAddMgrOBJ).length;
var OBJID = ["OBJ_DHCPPOOL_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,
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
var Btn_DHCPSpecialAddMgr_Refresh= $("#DHCPSpecialAddMgr_Refresh_button", Head);
Btn_DHCPSpecialAddMgr_Refresh.unbind("click");
Btn_DHCPSpecialAddMgr_Refresh.click(function(){
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
