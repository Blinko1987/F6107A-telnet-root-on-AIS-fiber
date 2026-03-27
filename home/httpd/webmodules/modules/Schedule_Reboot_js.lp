<script type="text/javascript">
(function(){
function parseTime(RelTime)
{
var ret;
RelTime = parseInt(RelTime, 10);
ret = RelTime.toString(10);
if (ret.length == 1)
{
ret = "0" + ret;
}
return ret;
}
function SetTime(template)
{
var HourSrc = $("[id^='HourSrc']", template).val();
var MinuteSrc = $("[id^='MinuteSrc']", template).val();
var TimeMin = parseInt(HourSrc)*60 + parseInt(MinuteSrc);
$("[id^='TimeMin']",template).val(TimeMin);
$("[id^='HourSrc']", template).val(parseTime(HourSrc));
$("[id^='MinuteSrc']", template).val(parseTime(MinuteSrc));
}
function GetTime(template)
{
var TimeMin = $("[id^='TimeMin']", template).val();
var HourSrc = $("[id^='HourSrc']", template);
var MinuteSrc = $("[id^='MinuteSrc']", template);
if (TimeMin ==0 || TimeMin =="")
{
HourSrc.val("00");
MinuteSrc.val("00");
}
else
{
var hour = parseInt(TimeMin/60);
HourSrc.val(parseTime(hour));
var minute = TimeMin- HourSrc.val()*60;
MinuteSrc.val(parseTime(minute));
}
}
function setWeekToDayEle(template)
{
var EveryDay = $("[id^='EveryDay']", template);
var TimeWeek = $("[id^='TimeWeek']", template);
var De_WeekVal = TimeWeek.val();
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
$(temp[6-i]).prop("checked",true);
}
else
{
$(temp[6-i]).prop("checked",false);
}
}
}
EveryDay.change();
}
function setDayEleToWeek(template)
{
var EveryDay = $("[id^='EveryDay']", template);
var TimeWeek = $("[id^='TimeWeek']", template);
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
B_WeekVal = "1" + B_WeekVal;
}
else
{
B_WeekVal = "0" + B_WeekVal;
}
}
}
TimeWeek.val(parseInt(B_WeekVal, 2));
var Enable = $("[id^='Enable']",template);
if(Enable.is(":checked") && TimeWeek.val()==0)
{
TimeWeek.val("you need to set days");
}
}
function initial_template_SchedReb(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"HourSrc": {
"required": true,
"integer": true,
"range":[0,23]
},
"MinuteSrc": {
"required": true,
"integer": true,
"range":[0,59]
}
},
"messages": {
}
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
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_SRCFG_ID","OBJ_SRINFO_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
setWeekToDayEle(ContainerOBJ);
GetTime(ContainerOBJ);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
setDayEleToWeek(template);
SetTime(template);
});
}
$(document).ready(function(){
var HeadID = "SchedReb";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_SchedReb("template_"+HeadID);
Head.succfunction = function(xml){
if (Head.hasError(xml,"externErrorHint") == 0)
{
var tempobj = $("#template_SchedReb");
var OBJID = ["OBJ_SRCFG_ID","OBJ_SRINFO_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
tempobj.trigger("fillDataByCustom",[0, tempobj, xml]);
}
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
