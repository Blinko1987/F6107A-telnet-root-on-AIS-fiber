<script type="text/javascript">
(function(){
function Customize_MACFilter(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Name");
}
function setWeekToDayEle(template)
{
var EveryDay = $("[id^='EveryDay:']", template);
var Week = $("[id^='Week:']", template);
var De_WeekVal = Week.val();
var WeekVal = parseInt(De_WeekVal,10).toString(2);
while (WeekVal.length < 7)
{
WeekVal = "0" + WeekVal;
}
if( WeekVal == "1111111" )
{
EveryDay.prop("checked", true);
}
else
{
EveryDay.prop("checked", false);
var temp = $("[id^='Time_Day']", template);
for( var i=0; i < WeekVal.length; i++ )
{
if(WeekVal.charAt(i) == '1')
{
$(temp[i]).prop("checked",true);
}
else
{
$(temp[i]).prop("checked",false);
}
}
}
EveryDay.change();
}
function setDayEleToWeek(template)
{
var EveryDay = $("[id^='EveryDay:']", template);
var Week = $("[id^='Week:']", template);
var B_WeekVal = "";
if( EveryDay.is(":checked") )
{
B_WeekVal = "1111111";
}
else
{
var temp = $("[id^='Time_Day']", template);
for( var i=0; i< temp.length;i++ )
{
if($(temp[i]).is(":checked"))
{
B_WeekVal += "1";
}
else
{
B_WeekVal += "0";
}
}
}
Week.val(parseInt(B_WeekVal, 2));
var data = {};
data.template = template;
$.callModifier("ParentCtrl/changeTime",data);
}
function CtrlURLAreaDispAttr(template)
{
var filterModeObj = $("#FilterMode", template);
filterModeObj.change(function(){
var filterMode = $(this).val();
var template = $(this).parents("[id^='template_']");
if ( "NotAllowed" == filterMode )
{
$("[id^='div_URLCfgArea']", template).hide();
}
else
{
$("[id^='div_URLCfgArea']", template).show();
}
});
}
function AddEvent2URLOpBtn(template)
{
$(".AddIconControl", template).click(function(){
var template = $(this).parents("[id^='template_']");
var VisibleURLCtrls = $("[id^='URLCtrlTemplate_']:visible", template);
var VisibleURLCnt = VisibleURLCtrls.length;
var iMax = 5;
if ( VisibleURLCnt >= iMax )
{
return false;
}
var HiddenURLCtrls = $("[id^='URLCtrlTemplate_']:hidden", template);
HiddenURLCtrls.eq(0).show();
if ( 1 == HiddenURLCtrls.length )
{
$(this).attr("src", "img/add_disable.png");
}
});
$(".DelIconControl", template).click(function(){
var template = $(this).parents("[id^='template_']");
var VisibleURLs = $("[id^='URL_']:visible", template);
var VisibleURLCnt = VisibleURLs.length;
var iMax = 5;
if ( VisibleURLCnt == iMax )
{
$(".AddIconControl", template).attr("src", "img/add.png");
}
var URLCtrl = $(this).parents("[id^='URLCtrlTemplate_']");
var URLObj = $("[id^='URL_']", URLCtrl);
URLObj.val("");
$(".errorLabelWraper>.error", URLCtrl).hide();
URLCtrl.hide();
});
}
function MakeDynamicURLCtrl(template)
{
var iMax = 5;
var URLCtrlTemplate = $("#URLCtrlTemplate", template);
for ( var suffix=1; suffix<iMax; suffix++ )
{
var clone = URLCtrlTemplate.cloneWithSuffix(suffix, "_");
URLCtrlTemplate.before(clone);
}
}
function FillAndDispURLCtrl(template)
{
var URLCnt = $("[id^='URLCnt:']", template).val();
URLCnt = parseInt(URLCnt, 10);
var iMax = 5;
for ( var suffix=0; suffix<iMax; suffix++ )
{
var URLCtrl = $("[id^='URLCtrlTemplate_"+suffix+":']", template);
$("[id^='URL_"+suffix+":']", URLCtrl).val("");
$(".errorLabelWraper>.error", URLCtrl).hide();
URLCtrl.hide();
}
for ( var suffix=0; suffix<URLCnt; suffix++ )
{
var urlval = $("[id^='URL"+suffix+":']", template).val();
$("[id^='URL_"+suffix+":']", template).val(urlval);
$("[id^='URLCtrlTemplate_"+suffix+":']", template).show();
}
if ( URLCnt == iMax )
{
$(".AddIconControl", template).attr("src", "img/add_disable.png");
}
else
{
$(".AddIconControl", template).attr("src", "img/add.png");
}
var filterModeObj = $("[id^='FilterMode']", template);
filterModeObj.change();
}
function SetURLHideVal(template)
{
var iMax = 5;
var filterModeObj = $("[id^='FilterMode']", template);
var filterMode = filterModeObj.val();
if ( "NotAllowed" == filterMode )
{
$("[id^='URLCnt:']", template).addClass("PostIgnore");
for ( var i=0; i<iMax; i++ )
{
$("[id^='URL"+i+":']", template).addClass("PostIgnore");
}
return ;
}
else
{
$("[id^='URLCnt:']", template).removeClass("PostIgnore");
for ( var i=0; i<iMax; i++ )
{
$("[id^='URL"+i+":']", template).removeClass("PostIgnore");
}
}
for ( var i=0; i<iMax; i++ )
{
$("[id^='URL"+i+":']", template).val("NULL");
}
var URLHidenIdx = 0;
for ( var i=0; i<iMax; i++ )
{
var URLCtrl = $("[id^='URL_"+i+":']", template);
if ( URLCtrl.is(":visible") )
{
var urlval = URLCtrl.val();
var URLHidenCtrl = $("[id^='URL"+URLHidenIdx+":']", template);
URLHidenCtrl.val(urlval);
URLHidenIdx++;
}
}
$("[id^='URLCnt:']", template).val(URLHidenIdx);
}
function initial_template_ParentCtrl(templateID)
{
var template = $("#"+templateID);
CtrlURLAreaDispAttr(template);
AddEvent2URLOpBtn(template);
MakeDynamicURLCtrl(template);
$("[id^='a_allday']", template).click(function(event){
event.preventDefault();
var TimeCtl = $(this).parents("._LuQUID_TimeCtl");
var allday = {
"group_HourStart" : "0",
"group_MinuteStart" : "0",
"group_HourEnd" : "23",
"group_MinuteEnd" : "59"
}
for (var i in allday)
{
var timeEle = $("."+i,TimeCtl);
$("option[value='"+ allday[i] + "']",timeEle).prop("selected",
"selected");
}
});
var MACCheckRules = {
"required": true,
"HEX": true,
"fixedlength": 2
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
ChildIdGroup: "sub_ChildId0 sub_ChildId1 sub_ChildId2 sub_ChildId3 sub_ChildId4 sub_ChildId5"
},
"rules": {
"Name:ParentCtrl": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,32]
},
"sub_ChildId0": MACCheckRules,
"sub_ChildId1": MACCheckRules,
"sub_ChildId2": MACCheckRules,
"sub_ChildId3": MACCheckRules,
"sub_ChildId4": MACCheckRules,
"sub_ChildId5": MACCheckRules
},
"messages": {
}
};
var iMax = 5;
for ( var suffix=0; suffix<iMax; suffix++ )
{
var urlID = "URL_"+suffix;
checkJSONTempObj.rules[urlID] = {
"required": true,
"rangelength":[1,128],
"url": true
};
}
template.setPromptCheckJSON(checkJSONTempObj, template);
});
$("[id^='EveryDay']",template).bind("change", function () {
var EveryDayOBJ = $(this);
var subTemplate = EveryDayOBJ.parents("[id^='template_']");
$("[id^='Time_Day']", subTemplate).each(function () {
if(EveryDayOBJ.is(":checked"))
{
$(this).prop("checked", false);
$(this).attr("disabled",true);
}
else
{
$(this).prop("disabled",false);
}
});
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Name");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_PARENT_CONTROL_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_MACFilter(CustomizeParams);
setWeekToDayEle(ContainerOBJ);
FillAndDispURLCtrl(ContainerOBJ);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
setDayEleToWeek(template);
SetURLHideVal(template);
});
}
$(document).ready(function(){
var HeadID = "ParentCtrl";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_ParentCtrl(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var MACFILTEROBJ = $(xml).find("OBJ_PARENT_CONTROL_ID");
var RuleNum = $("Instance", MACFILTEROBJ).length;
var OBJID = ["OBJ_PARENT_CONTROL_ID"];
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
