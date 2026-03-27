<script type="text/javascript">
(function(){
var getXml = "";
var StartTimer = "";
jQuery.validator.addMethod("checkName", function(value, element) {
if(value=="")
return false;
else
return true;
}, $.validator.format("&?public_error001;"));
jQuery.validator.addMethod("PhoneNum", function(value, element) {
return Validation(value);
}, $.validator.format("&?SipServicesError_001;"));
function Validation(str)
{
var checkStr="0123456789";
checkStr+="#*";
for(var i=0;i < str.length; i++)
{
var c = str.charAt(i);
if(checkStr.indexOf(c) == -1)
{
return false;
}
}
return true;
}
function initial_template_VOIPSipService(templateID)
{
var template = $("#"+templateID);
template.succfunction = function(xml){
StartTimer = getParaValueInXML(xml, "OBJ_VOIPDMTIMER_ID", 0, "StartTimer");
StartTimer = parseInt(StartTimer);
};
template.dataTransfer("/?_type=menuData&_tag=voipDmtTimer_lua.lua",
"GET",
template.succfunction);
$("input:radio[name='CallForwardUnconditionalEnable']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='CallForwardUnconditionalEnable1']",subTemplate).is(':checked'))
{
$("[id^='div_CallForwardUnconditionalNumber']", subTemplate).show();
$("[id^='CallForwardUnconditionalNumber']", subTemplate).removeClass("PostIgnore");
$("input[name^='CallForwardOnBusyEnable'][value=0]",subTemplate).prop("checked",true);
$("input[name^='CallForwardOnNoAnswerEnable'][value=0]",subTemplate).prop("checked",true);
$("[id^='div_CallForwardOnBusyNumber'],[id^='div_CallForwardOnNoAnswerNumber'],[id^='div_CfnrTimer']", subTemplate).hide();
$("[id^='CallForwardOnBusyNumber'],[id^='CallForwardOnNoAnswerNumber'],[id^='CfnrTimer']", subTemplate).addClass("PostIgnore");
$("input[name^='CallWaitingEnable'][value=0]",subTemplate).prop("checked",true);
}
else
{
$("[id^='div_CallForwardUnconditionalNumber']", subTemplate).hide();
$("[id^='CallForwardUnconditionalNumber']", subTemplate).addClass("PostIgnore");
}
});
$("input:radio[name='CallForwardOnBusyEnable']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='CallForwardOnBusyEnable1']",subTemplate).is(':checked'))
{
$("[id^='div_CallForwardOnBusyNumber']", subTemplate).show();
$("[id^='CallForwardOnBusyNumber']", subTemplate).removeClass("PostIgnore");
$("input[name^='CallForwardUnconditionalEnable'][value=0]",subTemplate).prop("checked",true);
$("[id^='div_CallForwardUnconditionalNumber']", subTemplate).hide();
$("[id^='CallForwardUnconditionalNumber']", subTemplate).addClass("PostIgnore");
$("input[name^='CallWaitingEnable'][value=0]",subTemplate).prop("checked",true);
}
else
{
$("[id^='div_CallForwardOnBusyNumber']", subTemplate).hide();
$("[id^='CallForwardOnBusyNumber']", subTemplate).addClass("PostIgnore");
}
});
$("input:radio[name='CallForwardOnNoAnswerEnable']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='CallForwardOnNoAnswerEnable1']",subTemplate).is(':checked'))
{
$("[id^='div_CallForwardOnNoAnswerNumber'],[id^='div_CfnrTimer']", subTemplate).show();
$("[id^='CallForwardOnNoAnswerNumber'],[id^='CfnrTimer']", subTemplate).removeClass("PostIgnore");
$("input[name^='CallForwardUnconditionalEnable'][value=0]",subTemplate).prop("checked",true);
$("[id^='div_CallForwardUnconditionalNumber']", subTemplate).hide();
$("[id^='CallForwardUnconditionalNumber']", subTemplate).addClass("PostIgnore");
$("input[name^='CallWaitingEnable'][value=0]",subTemplate).prop("checked",true);
}
else
{
$("[id^='div_CallForwardOnNoAnswerNumber'],[id^='div_CfnrTimer']", subTemplate).hide();
$("[id^='CallForwardOnNoAnswerNumber'],[id^='CfnrTimer']", subTemplate).addClass("PostIgnore");
}
});
$("input:radio[name='CallWaitingEnable']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='CallWaitingEnable1']",subTemplate).is(':checked'))
{
$("input[name^='CallForwardUnconditionalEnable'][value=0]",subTemplate).prop("checked",true);
$("input[name^='CallForwardOnBusyEnable'][value=0]",subTemplate).prop("checked",true);
$("input[name^='CallForwardOnNoAnswerEnable'][value=0]",subTemplate).prop("checked",true);
$("input[name^='ServInfoReport'][value=0]",subTemplate).prop("checked",true);
$("[id^='div_CallForwardUnconditionalNumber'],[id^='div_CallForwardOnBusyNumber'],[id^='div_CallForwardOnNoAnswerNumber'],[id^='div_CfnrTimer']", subTemplate).hide();
$("[id^='CallForwardUnconditionalNumber'],[id^='CallForwardOnBusyNumber'],[id^='CallForwardOnNoAnswerNumber'],[id^='CfnrTimer']", subTemplate).addClass("PostIgnore");
}
else
{
}
});
$("input:radio[name='CallTransfer']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='CallTransfer1']",subTemplate).is(':checked'))
{
$("input[name^='ServInfoReport'][value=0]",subTemplate).prop("checked",true);
}
});
$("input:radio[name='CallHoldFlag']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='CallHoldFlag1']",subTemplate).is(':checked'))
{
$("input[name^='ServInfoReport'][value=0]",subTemplate).prop("checked",true);
}
});
$("input:radio[name='MCIDEnable']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='MCIDEnable1']",subTemplate).is(':checked'))
{
$("input[name^='ServInfoReport'][value=0]",subTemplate).prop("checked",true);
}
});
$("input:radio[name='ServInfoReport']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='ServInfoReport1']",subTemplate).is(':checked'))
{
$("input[name^='CallWaitingEnable'][value=0]",subTemplate).prop("checked",true);
$("input[name^='CallTransfer'][value=0]",subTemplate).prop("checked",true);
$("input[name^='CallHoldFlag'][value=0]",subTemplate).prop("checked",true);
$("input[name^='MCIDEnable'][value=0]",subTemplate).prop("checked",true);
$("[id^='ThreeWayTalkingBySS']", subTemplate).val("0");
$("input[name^='ThreeWayTalkingBySelf'][value=0]",subTemplate).prop("checked",true);
$("[id^='div_ConfUri']", subTemplate).hide();
$("[id^='ConfUri']", subTemplate).addClass("PostIgnore");
}
});
$("input:radio[name='ThreeWayTalkingBySelf']",template).change(function(){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
if ($("[id^='ThreeWayTalkingBySelf1']",subTemplate).is(':checked'))
{
$("[id^='ThreeWayTalkingBySS']", subTemplate).val("1");
$("[id^='div_ConfUri']", subTemplate).show();
$("[id^='ConfUri']", subTemplate).removeClass("PostIgnore");
$("input[name^='ServInfoReport'][value=0]",subTemplate).prop("checked",true);
}
else
{
$("[id^='ThreeWayTalkingBySS']", subTemplate).val("0");
$("[id^='div_ConfUri']", subTemplate).hide();
$("[id^='ConfUri']", subTemplate).addClass("PostIgnore");
}
});
$("[id='HotLine']").change(function(event){
var subTemplate = $(this).parents("[id^='template_VOIPSipService']");
var val = $(this).val();
if ( val == "1" )
{
$("[id^='div_HLNumber']", subTemplate).show();
$("[id^='div_DhlTimer']", subTemplate).hide();
$("[id^='HLNumber']", subTemplate).removeClass("PostIgnore");
$("[id^='DhlTimer']", subTemplate).addClass("PostIgnore");
}
else if(val == "2" )
{
$("[id^='div_HLNumber'],[id^='div_DhlTimer']", subTemplate).show();
$("[id^='HLNumber'],[id^='DhlTimer']", subTemplate).removeClass("PostIgnore");
}
else
{
$("[id^='div_HLNumber'],[id^='div_DhlTimer']", subTemplate).hide();
$("[id^='HLNumber'],[id^='DhlTimer']", subTemplate).addClass("PostIgnore");
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj;
var HotType = '<%=env.getenv("HotType")%>';
if("1" == HotType)
{
checkJSONTempObj = {
"rules": {
"CallForwardUnconditionalNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"CallForwardOnBusyNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"CallForwardOnNoAnswerNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"CfnrTimer": {
"required": true,
"integer":true,
"range":[500,6000]
},
"ConfUri": {
"rangelength":[0,31]
},
"HLNumber": {
"required": true,
"rangelength":[1,63],
"url":true
},
"DhlTimer": {
"required": true,
"range":[1,StartTimer],
},
"AlertingTimer": {
"required": true,
"range":[3000,12000],
}
},
"messages": {
}
};
}
else
{
checkJSONTempObj = {
"rules": {
"CallForwardUnconditionalNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"CallForwardOnBusyNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"CallForwardOnNoAnswerNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"CfnrTimer": {
"required": true,
"integer":true,
"range":[500,6000]
},
"ConfUri": {
"rangelength":[0,31]
},
"HLNumber": {
"required": true,
"rangelength":[1,32],
"PhoneNum":true
},
"DhlTimer": {
"required": true,
"range":[1,StartTimer],
},
"AlertingTimer": {
"required": true,
"range":[3000,12000],
}
},
"messages": {
}
};
}
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPVPCALLTIMER_ID", "OBJ_VOIPSIPLINE_ID", "OBJ_VOIPVPLINE_ID", "OBJ_VOIPVPCALLFEATURE_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
$("input:radio[name^='CallForwardUnconditionalEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallForwardOnBusyEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallForwardOnNoAnswerEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallWaitingEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallTransfer']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallHoldFlag']",ContainerOBJ).trigger("change");
$("input:radio[name^='MCIDEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='ServInfoReport']",ContainerOBJ).trigger("change");
$("input:radio[name^='ThreeWayTalkingBySelf']",ContainerOBJ).trigger("change");
$("[id='HotLine']",ContainerOBJ).trigger("change");
});
}
$(document).ready(function(){
var HeadID = "VOIPSipService";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_VOIPSipService("template_"+HeadID);
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var AuthUserNameObjs = ContainerOBJ.find("[id^='AuthUserName:']");
var UserNameValue = getParaValueInXML(getXml, "OBJ_VOIPSIPLINE_ID", suffix, "AuthUserName");
AuthUserNameObjs.val(UserNameValue);
var CfnrTimerObjs = ContainerOBJ.find("[id^='CfnrTimer:']");
var CfnrTimerValue = getParaValueInXML(getXml, "OBJ_VOIPVPCALLTIMER_ID", 0, "CfnrTimer");
var DhlTimerObjs = ContainerOBJ.find("[id^='DhlTimer:']");
var DhlTimerValue = getParaValueInXML(getXml, "OBJ_VOIPVPCALLTIMER_ID", 0, "DhlTimer");
DhlTimerObjs.val(DhlTimerValue);
CfnrTimerObjs.val(CfnrTimerValue);
var AlertingTimerObjs = ContainerOBJ.find("[id^='AlertingTimer:']");
var AlertingTimerValue = getParaValueInXML(getXml, "OBJ_VOIPVPCALLTIMER_ID", 0, "AlertingTimer");
AlertingTimerObjs.val(AlertingTimerValue);
var PhoneIndex = parseInt(suffix)+1;
var VOIPRegStatusBarOBJ = ContainerOBJ.find("[id^='VOIPRegStatusBar:']");
VOIPRegStatusBarOBJ.append(PhoneIndex);
$("input:radio[name^='CallForwardUnconditionalEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallForwardOnBusyEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallForwardOnNoAnswerEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallWaitingEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallTransfer']",ContainerOBJ).trigger("change");
$("input:radio[name^='MCIDEnable']",ContainerOBJ).trigger("change");
$("input:radio[name^='CallHoldFlag']",ContainerOBJ).trigger("change");
$("input:radio[name^='ServInfoReport']",ContainerOBJ).trigger("change");
$("input:radio[name^='ThreeWayTalkingBySelf']",ContainerOBJ).trigger("change");
$("[id^='HotLine']",ContainerOBJ).trigger("change");
var data = {};
data.template = ContainerOBJ;
$.callModifier("VOIPSipService/fillDataByCustom",data);
};
Head.chanegeDataByCustom =function(xml){
;
};
Head.succfunction = function(xml){
getXml = xml;
Head.hasError(xml,"externErrorHint");
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_VOIPVPCALLFEATURE_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPVPLINE_ID","OBJ_VOIPVPCALLFEATURE_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
var templateID = "template_" + Head.attr("id");
var template = $("[id^='"+templateID+"_']",Head).eq(0);
$(".collapsibleBar",template).eq(0).click();
$.publish("/some/antelVoipServModify", [Head]);
var data = {};
data.RuleNum = RuleNum;
$.callModifier("VOIPSipService/showPhone2",data);
};
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
});
})();
</script>
