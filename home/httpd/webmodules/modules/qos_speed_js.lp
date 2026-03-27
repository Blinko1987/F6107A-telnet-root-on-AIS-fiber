<script type="text/javascript">
(function(){
function isDSCPMarkOption(v)
{
if (v == "0" || v == "14" || v == "12" ||
v == "10" || v == "8" || v == "22" || v == "20" || v == "18" ||
v == "16" || v == "30" || v == "28" || v == "26" || v == "24" ||
v == "38" || v == "36" || v == "34" || v == "32" || v == "46" ||
v == "40" || v == "48" || v == "56")
{
return true;
}
return false;
}
function dealDscpGet(selectObj, inputObj, v)
{
if (isDSCPMarkOption(v))
{
selectObj.val(v);
}
else
{
selectObj.val("other");
inputObj.val(v);
}
}
function Customize_QosSpeed(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Alias");
var actionHiddenObjs = $("[id^='ConformingAction\\:'],[id^='PartialConformingAction\\:'],[id^='NonConformingAction\\:']", ContainerOBJ);
actionHiddenObjs.each(function(){
var actionHiddenOBJ = $(this);
var subTemplate = actionHiddenOBJ.parents("[id^='template_']");
var idKeyword = actionHiddenOBJ.attr("id").split(":");
idKeyword = idKeyword[0];
var dscpObj = $("[id^='"+idKeyword+"_DSCPMark']", subTemplate);
var dscpInputObj = $("[id^='other_"+idKeyword+"_DSCPMark']", subTemplate);
var m802Obj = $("[id^='"+idKeyword+"_802Mark']", subTemplate);
var actionObj = $("[id^='"+idKeyword+"_S']", subTemplate);
var actionVal = actionHiddenOBJ.val();
if (actionVal == "Null" || actionVal == "Drop")
{
actionObj.val(actionVal);
}
else
{
if (null == actionVal.match(":"))
{
actionVal += ":";
}
var actionValArr = actionVal.split(":");
var vdscp = actionValArr[0];
var v8021p = actionValArr[1];
if ( "" != vdscp && "" != v8021p )
{
dealDscpGet(dscpObj, dscpInputObj, vdscp);
m802Obj.val(v8021p);
actionObj.val("DSCPMark&802.1pMark");
}
else if ( "" == vdscp && "" != v8021p )
{
m802Obj.val(v8021p);
actionObj.val("802.1pMark");
}
else if ( "" != vdscp && "" == v8021p )
{
dealDscpGet(dscpObj, dscpInputObj, vdscp);
actionObj.val("DSCPMark");
}
else
{
}
}
actionObj.change();
});
$("[id^='MeterType']", ContainerOBJ).change();
}
function initial_template_QosSpeed(templateID)
{
var template = $("#"+templateID);
var qppMin = $("[id^='QPP_MIN']",template);
var qppMax = $("[id^='QPP_MAX']",template);
var qpprMin = $("[id^='QPPR_MIN']",template);
var qpprMax = $("[id^='QPPR_MAX']",template);
qppMin.text(reformString(qppMin.text(), 3));
qppMax.text(reformString(qppMax.text(), 3));
qpprMin.text(reformString(qpprMin.text(), 3));
qpprMax.text(reformString(qpprMax.text(), 3));
$("[id^='MeterType']",template).change(function(){
var meterTypeOBJ = $(this);
var subTemplate = meterTypeOBJ.parents("[id^='template_']");
var meterType = meterTypeOBJ.val();
var hideObjs = "";
var objIdStr = "";
var showObjs = "";
if (meterType == "SimpleTokenBucket")
{
objIdStr = "[id^='ExcessBurstSize'],[id^='PeakRate'],"
+ "[id^='PeakBurstSize'],[id^='PartialConformingAction_S'],"
+ "[id^='PartialConformingAction_DSCPMark'],"
+ "[id^='other_PartialConformingAction_DSCPMark'],"
+ "[id^='PartialConformingAction_802Mark']";
hideObjs = $(objIdStr, subTemplate);
}
else if (meterType == "SingleRateThreeColor")
{
hideObjs = $("[id^='PeakRate'],[id^='PeakBurstSize']", subTemplate);
showObjs = $("[id^='ExcessBurstSize'],[id^='PartialConformingAction_S']", subTemplate);
}
else if (meterType == "TwoRateThreeColor")
{
hideObjs = $("[id^='ExcessBurstSize']", subTemplate);
objIdStr = "[id^='PeakRate'],[id^='PeakBurstSize'],"
+ "[id^='PartialConformingAction_S']";
showObjs = $(objIdStr, subTemplate);
}
else
{
}
if (hideObjs.length > 0)
{
hideObjs.parent().parent().hide();
hideObjs.addClass("PostIgnore");
}
if (showObjs.length > 0)
{
showObjs.parent().parent().show();
showObjs.removeClass("PostIgnore");
}
if ($("[id^='PartialConformingAction_S']", subTemplate).hasClass("PostIgnore"))
{
$("[id^='PartialConformingAction:']", subTemplate).addClass("PostIgnore")
}
else
{
$("[id^='PartialConformingAction:']", subTemplate).removeClass("PostIgnore")
$("[id^='PartialConformingAction_S']", subTemplate).change();
}
});
$("[id^='ConformingAction_S'],[id^='PartialConformingAction_S'],[id^='NonConformingAction_S']", template).change(function(){
var actionOBJ = $(this);
var subTemplate = actionOBJ.parents("[id^='template_']");
var idKeyword = actionOBJ.attr("id").split("_S:");
idKeyword = idKeyword[0];
var dscpObj = $("[id^='"+idKeyword+"_DSCPMark']", subTemplate);
var dscpInputObj = $("[id^='other_"+idKeyword+"_DSCPMark']", subTemplate);
var m802Obj = $("[id^='"+idKeyword+"_802Mark']", subTemplate);
var dscpSelectRow = dscpObj.parent().parent();
var dscpInputRow = dscpInputObj.parent().parent();
var m802Row = m802Obj.parent().parent();
var actionVal = actionOBJ.val();
if (actionVal == "Null" || actionVal == "Drop")
{
dscpSelectRow.hide();
dscpInputRow.hide();
m802Row.hide();
}
else if (actionVal == "DSCPMark")
{
dscpSelectRow.show();
dscpObj.change();
m802Row.hide();
}
else if (actionVal == "802.1pMark")
{
dscpSelectRow.hide();
dscpInputRow.hide();
m802Row.show();
}
else if (actionVal == "DSCPMark&802.1pMark")
{
dscpSelectRow.show();
dscpObj.change();
m802Row.show();
}
else
{
}
});
$("[id^='ConformingAction_DSCPMark'],[id^='PartialConformingAction_DSCPMark'],[id^='NonConformingAction_DSCPMark']", template).change(function(){
var thisObj = $(this);
var subTemplate = thisObj.parents("[id^='template_']");
var idKw = thisObj.attr("id").split(":");
idKw = idKw[0];
var inputObj = $("[id^='other_"+idKw+"']", subTemplate);
var inputRow = inputObj.parent().parent();
var selectVal = thisObj.val();
if (selectVal != "other")
{
inputRow.hide();
}
else
{
inputRow.show();
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"CommittedRate": {
"required": true,
"integer": true,
"extremumRange":["lessThan","PeakRate",{"equal" :true,"separate" : true}],
"range":[8192, 100000000]
},
"CommittedBurstSize": {
"required": true,
"integer": true,
"extremumRange":["lessThan","ExcessBurstSize",{"equal" :true,"separate" : true}],
"range":[1500, 12500000]
},
"ExcessBurstSize": {
"required": true,
"integer": true,
"range":[1500, 12500000],
"extremumRange":["greatThan","CommittedBurstSize",{"equal" :true,"separate" : true}]
},
"PeakRate": {
"required": true,
"integer": true,
"range":[8192, 100000000],
"extremumRange":["greatThan","CommittedRate",{"equal" :true,"separate" : true}]
},
"PeakBurstSize": {
"required": true,
"integer": true,
"range":[1500, 12500000]
},
"other_ConformingAction_DSCPMark": {
"required": true,
"integer": true,
"range":[0, 63]
},
"other_PartialConformingAction_DSCPMark": {
"required": true,
"integer": true,
"range":[0, 63]
},
"other_NonConformingAction_DSCPMark": {
"required": true,
"integer": true,
"range":[0, 63]
},
"Alias": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,64]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if(ActionByApplyResult(xml, template, "Alias") == 0 )
{
var pArr = {
"PartialConformingAction" : {
ValueOrigin: ""
}
};
xmlParaInInstOperate(xml, "OBJ_QOSQP_ID", 0, pArr);
$("[id^='PartialConformingAction\\:']", template).val(pArr.PartialConformingAction.ValueOrigin);
template.trigger("fillDataByCustom",[0, template, xml]);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_QOSQP_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var actionHiddenObjs = $("[id^='ConformingAction'],[id^='PartialConformingAction'],[id^='NonConformingAction']", template);
actionHiddenObjs.each(function(){
var actionHiddenOBJ = $(this);
var subTemplate = actionHiddenOBJ.parents("[id^='template_']");
var idKeyword = actionHiddenOBJ.attr("id").split(":");
idKeyword = idKeyword[0];
var dscpObj = $("[id^='"+idKeyword+"_DSCPMark']", subTemplate);
var dscpInputObj = $("[id^='other_"+idKeyword+"_DSCPMark']", subTemplate);
var m802Obj = $("[id^='"+idKeyword+"_802Mark']", subTemplate);
var actionObj = $("[id^='"+idKeyword+"_S']", subTemplate);
var vdscp = dscpObj.val();
if (vdscp == "other")
{
vdscp = dscpInputObj.val();
}
var v802p = m802Obj.val();
var actionVal = actionObj.val();
if (actionVal == "DSCPMark&802.1pMark")
{
var combVal = vdscp+":"+v802p;
actionHiddenOBJ.val(combVal);
}
else if (actionVal == "802.1pMark")
{
var combVal = ":"+v802p;
actionHiddenOBJ.val(combVal);
}
else if (actionVal == "DSCPMark")
{
var combVal = vdscp;
actionHiddenOBJ.val(combVal);
}
else
{
actionHiddenOBJ.val(actionVal);
}
});
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_QosSpeed(CustomizeParams);
});
}
$(document).ready(function(){
var QosSpeedHeadID = "QosSpeed";
var QosSpeedHead = $("#"+QosSpeedHeadID);
var QosSpeedtemplateID = "template_"+ QosSpeedHeadID;
var QosSpeedServerAddr = $("address span", QosSpeedHead).text();
initial_template_QosSpeed(QosSpeedtemplateID);
QosSpeedHead.succfunction = function(xml){
QosSpeedHead.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_QOSQP_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_QOSQP_ID"];
QosSpeedHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",QosSpeedHead).length <= 0 )
{
QosSpeedHead.dataTransfer(QosSpeedServerAddr,"GET",QosSpeedHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(QosSpeedHead);
}
});
})();
</script>
