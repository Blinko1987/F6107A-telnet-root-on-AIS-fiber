<script type="text/javascript">
function HeadID_OBJ()
{
var g_HeadID = null;
this.setHeadID = function(head_id)
{
g_HeadID = head_id;
}
this.getHeadID = function()
{
if(g_HeadID == null)
{
consoleLog("g_HeadID_OBJ error");
}
else
{
return g_HeadID;
}
}
}
var g_HeadID_OBJ = new HeadID_OBJ();
var callback_check = null;
var g_getSIMStatus_handle = function (xml) {
var HeadID = g_HeadID_OBJ.getHeadID();
var Head = $("#"+HeadID);
if (Head.hasError(xml) == 0)
{
var OBJID = "OBJ_WWANPINCFG_ID";
var tDongleStatus = $("DongleStatus", $(xml)).text();
var tPinStatus = getParaValueInXML(xml, OBJID, 0, "PinStatus");
if (callback_check == null)
{
consoleLog("callback_check error");
}
else
{
callback_check(tDongleStatus, tPinStatus);
}
var template = $("[id^='template_']",Head);
var OBJID = ["OBJ_WWANPINCFG_ID"];
Head.fillDataByOBJID(xml ,OBJID, template, 0);
}
showWaitTip(false);
}
var g_fail_handle = function() {
showWaitTip(false);
}
var g_cycle_fail_handle = function() {
;
}
var ajax_handle = function() {
var HeadID = g_HeadID_OBJ.getHeadID();
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr, "GET", g_getSIMStatus_handle,
g_fail_handle, false);
}
var ajax_handle_cycle_time = function() {
var HeadID = g_HeadID_OBJ.getHeadID();
var Head = $("#"+HeadID);
var ServerAddr = "/?_type=menuData&_tag=wwan_pin_lua.lua";
Head.dataTransfer(ServerAddr, "GET", g_cycle_time_handle,
g_cycle_fail_handle, false);
}
var g_cycle_time_handle = function (xml) {
var HeadID = g_HeadID_OBJ.getHeadID();
var Head = $("#"+HeadID);
if (Head.hasError(xml, "_NoExist") == 0)
{
var externErrorHint = $(".externErrorHint",Head);
if ( externErrorHint != undefined )
{
if ( externErrorHint.is(":visible") )
{
externErrorHint.showIt(false);
}
}
var OBJID = "OBJ_WWANPINCFG_ID";
var tDongleStatus = $("DongleStatus", $(xml)).text();
var tPinStatus = getParaValueInXML(xml, OBJID, 0, "PinStatus");
if (callback_check == null)
{
consoleLog("callback_check error");
}
else
{
callback_check(tDongleStatus, tPinStatus);
}
}
}
var Btn_refresh_handle = function() {
showWaitTip(true, "&?Pinpublic_010;", false);
var waitTime = $(".Btn_refresh_pin").attr("refreshTime");
if (waitTime)
{
window.setTimeout(function() {
ajax_handle();
}, waitTime);
}
else
{
ajax_handle();
}
}
var AutocycleTime;
function CycleIntervalHandle()
{
var AutoRefreshTimeOBJ = $("#AutoRefreshTime");
var autoRefreshTime = $("#AutoRefreshTime").val();
if ( !autoRefreshTime)
{
consoleLog("AutocycleTime should be closed now");
clearTimeout(AutocycleTime);
return;
}
ajax_handle_cycle_time();
AutocycleTime = setTimeout("CycleIntervalHandle()", autoRefreshTime);
}
function initCycleInterval()
{
if (AutocycleTime)
{
consoleLog("AutocycleTime exists already!!");
clearTimeout(AutocycleTime);
}
var AutoRefreshTimeOBJ = $("#AutoRefreshTime");
var autoRefreshTime = $("#AutoRefreshTime").val();
var CurrHeadID = AutoRefreshTimeOBJ.parents(".HeadDIV").attr("id");
g_HeadID_OBJ.setHeadID(CurrHeadID);
AutocycleTime = setTimeout("CycleIntervalHandle()", autoRefreshTime);
}
$(document).ready(function() {
var PinRefreshBtn = $(".Btn_refresh_pin");
PinRefreshBtn.unbind("click");
PinRefreshBtn.bind("click", Btn_refresh_handle);
var HeadDivID = $(".HeadDIV").attr("id");
switch (HeadDivID)
{
case "PinDevFail":
$("[id^='PinDevFailBar']").text("&?PinDevFail_001_LTE;");
$(".sceneTipLink a").text("&?PinDevFail_004_LTE;");
$(".formTbl span").text("&?PinDevFail_002_LTE;");
break;
case "DevIdentying":
$("[id^='DevIdentyingBar']").text("&?Pinpublic_001_LTE;");
$(".formTbl span").text("&?Pinpublic_014_LTE;");
break;
case "DevIdentyNok":
$("[id^='DevIdentyNokBar']").text("&?Pinpublic_001_LTE;");
$(".formTbl span").text("&?Pinpublic_015_LTE;");
break;
case "DevIdentyOkOnly" :
$("[id^='DevIdentyOkOnlyBar']").text("&?Pinpublic_001_LTE;");
$(".formTbl span").text("&?Pinpublic_016_LTE;");
break;
case "PinReadyStatus":
$("[id^='PinReadyStatusBar']").text("&?Pinpublic_001_LTE;");
$("span", $(".formTbl div").eq(1)).text("&?PinReadyStatus_001_LTE;");
break;
case "PinSimBusy":
$("[id^='PinSimBusyBar']").text("&?Pinpublic_001_LTE;");
break;
case "PinSimFail":
$("[id^='PinSimFailBar']").text("&?Pinpublic_001_LTE;");
break;
case "PinExcept":
$("[id^='PinExceptBar']").text("&?Pinpublic_001_LTE;");
break;
default:
}
initCycleInterval();
});
function PINRemainTimeBlink(PINRemainTimeID,templeteOBJ)
{
var span_refresh = $("[id^='"+PINRemainTimeID+"']", templeteOBJ);
span_refresh.fadeIn(1000, function() {
$(this).removeClass("pinspan");
});
span_refresh.fadeOut(1000, function() {
$(this).addClass("pinspan");
});
span_refresh.fadeIn(1000, function() {
$(this).removeClass("pinspan");
});
}
function PINWarnChangeByRemainTime(warnContainer, remain_num, buttonOBJ, ConfItems)
{
var OpByRemaintime = {
"0": {"WarnShow": true, "WarnHint": "&?PinInput_009;", "Disabled": true},
"1": {"WarnShow": true, "WarnHint": "&?PinInput_004;", "Disabled": false},
"2": {"WarnShow": true, "WarnHint": "&?PinInput_008;", "Disabled": false},
"default": {"WarnShow": false, "WarnHint": "", "Disabled": false}
};
if ( !OpByRemaintime[remain_num] )
{
remain_num = "default";
}
var Operation = OpByRemaintime[remain_num];
warnContainer.showIt(false);
warnContainer.html(Operation["WarnHint"]);
warnContainer.showIt(Operation["WarnShow"]);
if ( Operation["Disabled"] )
{
ConfItems.attr("disabled",true);
buttonOBJ.addClass("disableBtn");
}
else
{
ConfItems.disableIt(false);
buttonOBJ.disableButton(false);
}
}
</script>
