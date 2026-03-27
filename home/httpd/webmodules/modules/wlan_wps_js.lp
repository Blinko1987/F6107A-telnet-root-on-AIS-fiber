<script type="text/javascript">
<%
local sess_id = cgilua.getCurrentSessID()
local initialWpsPIN = session_get(sess_id, "initialWpsPIN")
%>
(function () {
function initial_template_WPS(templateID)
{
var template = $("#"+templateID);
$("#WPSChoose", template).change(function(){
var WPSChooseOBJ = $(this);
var template = WPSChooseOBJ.parents("[id^='template_']");
var WPSChooseVal = WPSChooseOBJ.val();
var PINContentOBJ = $("[id^='div_PINContent']",template);
if ((WPSChooseVal == "Disabled")
|| (WPSChooseVal == "PBC"))
{
PINContentOBJ.showIt(false);
}
else
{
PINContentOBJ.showIt(true);
}
});
$("#PINMode", template).change(function(){
var PINModeOBJ = $(this);
var template = PINModeOBJ.parents("[id^='template_']");
var PINModeVal = PINModeOBJ.val();
var AutoPINOBJ = $("[id^='div_AutoPIN']",template);
var InputPINOBJ = $("[id^='div_InputPIN']",template);
if (PINModeVal == "AutoPIN")
{
AutoPINOBJ.showIt(true);
InputPINOBJ.showIt(false);
}
else if(PINModeVal == "InputPIN")
{
AutoPINOBJ.showIt(false);
InputPINOBJ.showIt(true);
}
else
{
consoleLog("PINModeVal is illegal!!");
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"InputPIN": {
"required": true,
"ASCII": true
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
template.fillDataByOBJID(xml ,["OBJ_WPS_ID"], template, 0);
FillPINtoText(template);
});
template.bind("fillDataByCustom", function(event, suffix, template){
template.collapsibleInstTitleChange("Band");
var EnableV = $("[id^='Enable']",template).val();
var WPSModeV = $("[id^='WPSMode']",template).val();
var WPSChooseObj = $("[id^='WPSChoose']",template);
if (EnableV == "0")
{
SetSelectValue(WPSChooseObj, "Disabled");
}
else
{
if (WPSModeV == "0")
{
SetSelectValue(WPSChooseObj, "PBC");
}
else
{
SetSelectValue(WPSChooseObj, "PIN");
}
}
$("[id^='WPSChoose']", template).change();
$("[id^='PINMode']", template).change();
FillPINtoText(template);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var WPSChooseV = $("[id^='WPSChoose']", template).val();
var PINMode = $("[id^='PINMode']", template).val();
var InputPINV = $("[id^='InputPIN']", template).val();
if (WPSChooseV == "Disabled")
{
$("[id^='Enable']", template).val("0");
$("[id^='WpsPIN']", template).addClass("PostIgnore");
$("[id^='PINMode']", template).addClass("PostIgnore");
}
else if (WPSChooseV == "PBC")
{
$("[id^='WPSMode']", template).val("0");
$("[id^='Enable']",template).val("1");
$("[id^='WpsPIN']",template).addClass("PostIgnore");
$("[id^='PINMode']",template).addClass("PostIgnore");
}
else if (WPSChooseV == "PIN")
{
$("[id^='WPSMode']", template).val("1");
$("[id^='Enable']",template).val("1");
$("[id^='PINMode']",template).removeClass("PostIgnore");
if (PINMode == "AutoPIN")
{
$("[id^='WpsPIN']",template).addClass("PostIgnore");
}
else
{
$("[id^='WpsPIN']",template).removeClass("PostIgnore");
$("[id^='WpsPIN']",template).val(InputPINV);
}
}
else
{
consoleLog("WPSModeVal is illegal!!");
}
});
template.bind("RefreshPINCode", function(event, xml,template){
if (template.hasError(xml) == 0)
{
var ToOperParaArr = {
"WpsPINShow" : { ValueOrigin: "" }
};
xmlParaInInstOperate(xml, "OBJ_WPS_ID", 0, ToOperParaArr);
var WpsPINVal = ToOperParaArr.WpsPINShow.ValueOrigin;
$("[id^='AutoPIN']", template).val(WpsPINVal);
}
});
var HeadID = "WPS";
var Head = $("#"+HeadID);
$("#Btn_AutoPIN", Head).bind("click", function(event){
var ServerAddr = $("address span", Head).text();
var template = $(this).parents("[id^='template']");
var _InstIDValue = $("[id^='SSID_InstID']", template).val();
var PostData = "IF_ACTION=Refresh"+"&"
+ "SSID_InstID=" + _InstIDValue;
dataPost("Refresh", "RefreshPINCode", ServerAddr, template, PostData);
});
}
function FillPINtoText(template)
{
var EnableV = $("[id^='Enable']", template).val();
var WPSModeV = $("[id^='WPSMode']", template).val();
var WpsPIN = $("[id^='WpsPINShow']", template).val();
var PINMode = $("[id^='PINMode']", template).val();
if ((EnableV == "0")
|| (EnableV == "1" && WPSModeV == "0"))
{
$("[id^='AutoPIN']", template).val("");
$("[id^='InputPIN']", template).val("");
}
else if (EnableV == "1" && WPSModeV == "1")
{
if (PINMode == "AutoPIN")
{
if (WpsPIN == "") {
$("[id^='AutoPIN']", template).val(<%=initialWpsPIN%>);
}
else{
$("[id^='AutoPIN']", template).val(WpsPIN);
}
$("[id^='InputPIN']", template).val("");
}
else
{
$("[id^='AutoPIN']", template).val("");
}
}
}
function g_ChanegeDataByCustom(xml)
{
var OBJ = $(xml).find("OBJ_WPS_ID");
var instances = $("Instance ", OBJ);
instances.each(function(){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("SSID_InstID");
}
});
});
}
$(document).ready(function(){
var HeadID = "WPS";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_WPS("template_"+HeadID);
RefreshClickHandle(Head);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var template = $("[id^='template_']",Head);
g_ChanegeDataByCustom(xml);
var CARDOBJ = $(xml).find("OBJ_WLANSETTING_ID");
var RuleNum = $("Instance", CARDOBJ).length;
var OBJID = ["OBJ_WPS_ID","OBJ_WLANSETTING_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
$.publish("/some/softVersionModify", [Head]);
$("[id^='template_']",Head).each(function(){
if($("[id^='instName_WPS']",this).text().indexOf("6G")>-1)
{
$(this).hide();
}
})
var firstTemp = $("#template_WPS_0");
$(".collapsibleInst", firstTemp).click();
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
