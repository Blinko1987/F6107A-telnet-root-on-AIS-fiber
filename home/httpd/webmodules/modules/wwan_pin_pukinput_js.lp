<script type="text/javascript">
function g_LastChanceConfirm(template)
{
var msg = "&?PukInput_012;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", function(event) {
showWaitTip(false);
$("#Btn_apply_PukInput", template).click();
});
}
function customize_warn_div_puk(templeteOBJ)
{
var div_warn = $("[id^='puk_warn2']", templeteOBJ);
div_warn.hide();
var remain_num = $("[id^='PukRemain']", templeteOBJ).text();
var div_chk = $("'[id^='SimPuk']', '[id^='SimPin']', '[id^='SimNewPin']', '#Btn_apply_PukInput', '#Btn_apply_PukInput_Confirm' ", templeteOBJ);
var btn_change = $(" '#Btn_apply_PukInput', '#Btn_apply_PukInput_Confirm' ", templeteOBJ);
if(remain_num <= 5)
{
div_warn.html("&?PukInput_013;");
div_warn.show();
div_chk.attr("disabled",true);
btn_change.addClass("disableBtn");
}
else if (remain_num != 10)
{
div_warn.html("&?PukInput_014;");
div_warn.show();
div_chk.disableIt(false);
btn_change.disableButton(false);
}
else
{
div_chk.disableIt(false);
btn_change.disableButton(false);
}
}
function customize_check_reload_puk(tDongleStatus)
{
if ( tDongleStatus == "INPUT_PUK" )
{
consoleLog("not to do anything");
}
else
{
top.location.href = top.location.href;
}
}
function initial_PukInput_template(templateID)
{
var template = $("#"+templateID);
var NewID = "#SimPin";
var instForm = template.find("form");
instForm.validate({
"rules": {
"SimPuk" : {
"required": true,
"digits":true,
"fixedlength" : 8
},
"SimPin" : {
"required": true,
"digits":true,
"rangelength" : [4, 8]
},
"SimNewPin" : {
"required": true,
"digits":true,
"rangelength" : [4, 8],
"equalTo": NewID
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template) {
if ( 0 == ActionByApplyResult(xml, template) )
{
setTimeout(function() {
top.location.href = top.location.href;
}, 4000);
}
else
{
showWaitTip(false);
customize_warn_div_puk(template);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template) {
var OBJID = ["OBJ_WWANPINCFG_ID"];
ActionByCancelResult(xml, template, OBJID);
var tDongleStatus = $("DongleStatus", $(xml)).text();
customize_check_reload_puk(tDongleStatus);
setTimeout(function() {
template.trigger("fillDataByCustom",[0, template]);
}, 1000);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ) {
PINRemainTimeBlink("refresh_puk", ContainerOBJ);
customize_warn_div_puk(ContainerOBJ);
callback_check = function(tDongleStatus) {
customize_check_reload_puk(tDongleStatus);
}
});
template.bind("hiddenValueChangeByCustom", function(event, template) {
$("[id^='SimPinOP']", template).val(5);
});
$("#Btn_apply_PukInput_Confirm", template).click(function() {
var remain_num = $("[id^='PukRemain']", template).text();
if (remain_num == 6)
{
var formOBJ = $(".form_content", template);
if ( formOBJ.length > 0 && true == formOBJ.valid() )
{
g_LastChanceConfirm(template);
}
}
else
{
$("#Btn_apply_PukInput", template).click();
}
});
}
$(document).ready(function(){
var HeadID = "PukInput";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_PukInput_template(templateID);
$(".Btn_apply", Head).unbind("click");
initial_button("Apply", Head, false);
$(".Btn_apply", Head).click(function(event){
var template = $("#template_PukInput");
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
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_WWANPINCFG_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
template.trigger("fillDataByCustom",[0, template]);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,"GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
</script>
