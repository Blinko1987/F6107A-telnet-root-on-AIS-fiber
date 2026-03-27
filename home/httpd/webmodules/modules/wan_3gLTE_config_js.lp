<script type="text/javascript">
(function(){
jQuery.validator.addMethod(
"DialNumCheck",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
return /^[\d#\*]*$/.test(value);
},
"&?Internet3G_030;"
);
function Customize_IdleTime_get(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("WANCName");
var IdleTime_value = $("[id^='IdleTime']", ContainerOBJ).val();
IdleTime_value = parseInt(IdleTime_value, 10);
var tmp_min = parseInt( (IdleTime_value/60), 10);
var tmp_sec = parseInt( (IdleTime_value%60), 10);
$("[id^='C_IdleTime0']", ContainerOBJ).val(tmp_min);
$("[id^='C_IdleTime1']", ContainerOBJ).val(tmp_sec);
$("[id^='C_IdleTime0']",ContainerOBJ).change();
$("[id^='ConnTrigger']", ContainerOBJ).change();
}
function Customize_IdleTime_set(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
var tmp_min = $("[id^='C_IdleTime0']", ContainerOBJ).val();
tmp_min = parseInt(tmp_min, 10);
var tmp_sec = $("[id^='C_IdleTime1']", ContainerOBJ).val();
tmp_sec = parseInt(tmp_sec, 10);
var total_sec = parseInt( (tmp_min*60), 10) + parseInt(tmp_sec, 10);
var IdleTimeHidden = $("[id^='IdleTime']", ContainerOBJ);
if( !($("[id^='Prefix_IdleTime']", ContainerOBJ).is(":hidden")) )
{
IdleTimeHidden.val(total_sec);
IdleTimeHidden.removeClass("PostIgnore");
}
else
{
IdleTimeHidden.addClass("PostIgnore");
}
}
function initial_template_WAN3GDev(templateID)
{
var template = $("#"+templateID);
$("[id^='C_IdleTime0']",template).change(function(event){
var IdleMin = $(this);
var template = IdleMin.parents("[id^='template_']");
var IdleSec = $("[id^='C_IdleTime1']", template);
var IdleMinVal = parseInt(IdleMin.val());
if ( IdleMinVal == 1092 )
{
IdleSec.rules("remove", "range");
IdleSec.rules("add", {"range" : [0,15]});
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
IdleSec.next().text("&?public_072;0 ~ 15");
}
else
{
IdleSec.rules("remove", "range");
IdleSec.rules("add", {"range" : [0,59]});
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
IdleSec.next().text("&?public_072;0 ~ 59");
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
C_IdleTime: "C_IdleTime0 C_IdleTime1"
},
"rules": {
"WANCName": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,768]
},
"TtyAPN": {
"ASCII": true,
"rangelength":[0,31]
},
"TtyDialNum": {
"required": true,
"DialNumCheck": true,
"rangelength":[1,31]
},
"MTU": {
"required": true,
"integer": true,
"range":[128,1540]
},
"UserName": {
"ASCII": true,
"rangelength":[0,64]
},
"Password": {
"PasswordASCII": true,
"rangelength":[0,64]
},
"C_IdleTime0" : {
"required": true,
"integer": true,
"range":[0,1092]
},
"C_IdleTime1" : {
"required": true,
"integer": true,
"range":[0,59]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("hiddenValueChangeByCustom", function(event, template){
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_IdleTime_set(CustomizeParams);
});
$("[id^='ConnTrigger']", template).change(function(event){
var obj_option = $(this);
var template = obj_option.parents("[id^='template_']");
var ConnTrigger_option = obj_option.val();
var div_IdleTime = $("[id^='Prefix_IdleTime']",template);
if ( ConnTrigger_option == "OnDemand" )
{
div_IdleTime.show();
}
else
{
div_IdleTime.hide();
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
var Head = $(this).parents(".HeadDIV");
$("#DongleTypeSwitch",Head).trigger("DongleTypeSwitch",[xml]);
ActionByApplyResult(xml, template, "WANCName");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var Head = $(this).parents(".HeadDIV");
$("#DongleTypeSwitch",Head).trigger("DongleTypeSwitch",[xml]);
var DongleType = $("DongleType", $(xml)).text();
var OBJID = DongleType == 1 ? ["OBJ_DONGLE3G_ID"] : ["OBJ_DONGLELTE_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_IdleTime_get(CustomizeParams);
});
}
function DongleTypeChange(index){
if( index == 2 )
{
$(".3G").hide();
$(".3G").find("input, select").addClass("PostIgnore")
}
else if( index == 1 )
{
$(".3G").show();
$(".3G").find("input, select").removeClass("PostIgnore")
}
else {
console.log("No card insert!");
}
}
$(document).ready(function(){
var HeadID = "WAN3GDev";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_WAN3GDev(templateID);
$("#DongleTypeSwitch",Head).bind("DongleTypeSwitch", function(event, xml){
var Head = $(this).parents(".HeadDIV");
var DongleType = $("DongleType", $(xml)).text();
var DongleStatus = $("DongleStatus", $(xml)).text();
DongleTypeChange(DongleType);
$("#InsertCardBefore",Head).showIt(false);
$("#RouterOnly",Head).showIt(false);
$("#ModemOnly",Head).showIt(false);
if ( DongleStatus == "Dev_FAILURE" )
{
$("#InsertCardBefore",Head).showIt(true);
}
else
{
$("#ModemOnly",Head).showIt(true);
}
});
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
$("#DongleTypeSwitch",Head).trigger("DongleTypeSwitch",[xml]);
var DongleType = $("DongleType", $(xml)).text();
var OBJ, RuleNum;
if(DongleType == 1)
{
OBJ = $(xml).find("OBJ_DONGLE3G_ID");
RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_DONGLE3G_ID"];
}
else if(DongleType == 2)
{
OBJ = $(xml).find("OBJ_DONGLELTE_ID");
RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_DONGLELTE_ID"];
}
Head.createPageDataByClone(RuleNum,OBJID,xml);
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
})();
</script>
