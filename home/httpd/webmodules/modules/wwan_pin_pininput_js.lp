<script type="text/javascript">
var check_status_handle = function (Head_ID, func_handle) {
var HeadID = Head_ID;
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr, "GET", func_handle,
g_cycle_fail_handle, false);
}
function customize_warn_div_pin(templeteOBJ)
{
var div_warn = $("[id^='pin_warn2']", templeteOBJ);
var remain_num = $("[id^='PinRemain']", templeteOBJ).html();
var div_chk = $(" '[id^='SimPin']', '[id^='RemPin']', '#Btn_apply_PinInput' ", templeteOBJ);
var btn_change = $("#Btn_apply_PinInput", templeteOBJ);
PINWarnChangeByRemainTime(div_warn, remain_num, btn_change, div_chk);
}
function customize_check_reload_pin(tDongleStatus)
{
if ( "INPUT_PIN" == tDongleStatus )
{
consoleLog("not to do anything");
}
else
{
top.location.href = top.location.href;
}
}
var succ_func = function(xml) {
var Head = $("PinInput");
if (Head.hasError(xml) == 0)
{
var tDongleStatus = $("DongleStatus", $(xml)).text();
customize_check_reload_pin(tDongleStatus);
}
}
var succ_lastTime_func = function(xml){
succ_func(xml);
var Head = $("#PinInput");
var template = $("[id^='template_']",Head);
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_WWANPINCFG_ID"];
Head.fillDataByOBJID(xml ,OBJID, template, 0);
showWaitTip(false);
PINRemainTimeBlink("refresh_pin", template);
customize_warn_div_pin(template);
}
}
function initial_PinInput_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"SimPin" : {
"required": true,
"digits":true,
"rangelength" : [4, 8]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
if ( 0 == ActionByApplyResult(xml, template) )
{
var HeadID = "PinInput";
setTimeout(function() {
check_status_handle(HeadID, succ_func);
}, 4000);
setTimeout(function() {
check_status_handle(HeadID, succ_func);
}, 8000);
setTimeout(function() {
check_status_handle(HeadID, succ_lastTime_func);
}, 12000);
}
else
{
showWaitTip(false);
}
});
template.bind("fillDataByCancelResult", function(event, xml, template) {
var OBJID = ["OBJ_WWANPINCFG_ID"];
ActionByCancelResult(xml, template, OBJID);
var tDongleStatus = $("DongleStatus", $(xml)).text();
customize_check_reload_pin(tDongleStatus)
setTimeout(function() {
PINRemainTimeBlink("refresh_pin", template);
customize_warn_div_pin(template);
}, 500);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ) {
var HeadID = "PinInput";
var Head = $("#"+HeadID);
callback_check = function(tDongleStatus) {
customize_check_reload_pin(tDongleStatus)
}
var RemPin = $("#RemPin",ContainerOBJ);
if( RemPin.is(':checked'))
{
setTimeout(function() {
check_status_handle(HeadID, succ_func);
}, 4000);
setTimeout(function() {
check_status_handle(HeadID, succ_func);
}, 8000);
setTimeout(function() {
check_status_handle(HeadID, succ_lastTime_func);
}, 12000);
}
else
{
showWaitTip(false);
PINRemainTimeBlink("refresh_pin", ContainerOBJ);
customize_warn_div_pin(ContainerOBJ);
}
});
template.bind("hiddenValueChangeByCustom", function(event, template) {
$("[id^='SimPinOP']", template).val(2);
});
}
$(document).ready(function(){
var HeadID = "PinInput";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_PinInput_template(templateID);
$(".Btn_apply", Head).unbind("click");
initial_button("Apply", Head, false);
$(".Btn_apply", Head).click(function(event){
var template = $("#template_PinInput");
var formOBJ = $(".form_content", template);
if ( formOBJ.length > 0 && false == formOBJ.valid() )
{
return;
}
else
{
showWaitTip(true);
}
});
Head.succfunction = function(xml) {
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_WWANPINCFG_ID"];
Head.fillDataByOBJID(xml ,OBJID, template, 0);
showWaitTip(true, "&?Pinpublic_010;", false);
template.trigger("fillDataByCustom",[0, template]);
};
showWaitTip(true);
Head.dataTransfer(ServerAddr,"GET", Head.succfunction,undefined, false);
$(".collapsibleBar",Head).click();
});
</script>
