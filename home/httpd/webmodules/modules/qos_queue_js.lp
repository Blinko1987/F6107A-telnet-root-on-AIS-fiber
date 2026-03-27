<script type="text/javascript">
(function(){
var CapacityObj="";
jQuery.validator.addMethod(
"TCRules",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var valArray = value.split(",");
for (var i = 0; i < valArray.length; i++)
{
if (/^-?\d+$/.test(valArray[i]))
{
if (valArray[i] < 1 || valArray[i] > 128)
{
return false;
}
}
else
{
return false;
}
}
return true;
},
jQuery.validator.format("&?QosCongestion_021;")
);
function initial_template_Congestion(templateID)
{
var template = $("#"+templateID);
var qbwMin = $("[id^='QBW_MIN']",template);
var qbwMax = $("[id^='QBW_MAX']",template);
qbwMin.text(reformString(qbwMin.text(), 3));
qbwMax.text(reformString(qbwMax.text(), 3));
$("[id^='SchedulerAlgorithm']",template).change(function(event){
var Algorithm = $(this);
var template = Algorithm.parents("[id^='template_']");
var Algorithm = Algorithm.val();
var weightObj = $("[id^='Weight']", template);
var pctObj = $("[id^='percent']", template);
if (Algorithm == "SP")
{
weightObj.parent().parent().hide();
weightObj.addClass("PostIgnore");
}
else if (Algorithm == "WRR")
{
weightObj.parent().parent().show();
weightObj.removeClass("PostIgnore");
weightObj.rules("remove", "range");
weightObj.rules("add", {"range" : [1,32]});
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
weightObj.next().text("&?public_072;1 ~ 32");
pctObj.hide();
}
else if (Algorithm == "WFQ")
{
weightObj.parent().parent().show();
weightObj.removeClass("PostIgnore");
weightObj.rules("remove", "range");
weightObj.rules("add", {"range" : [1,100]});
weightObj.next().text("&?public_072;1 ~ 100");
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
pctObj.show();
}
else
{
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"Alias": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,64]
},
"Weight": {
"required": true,
"integer": true,
"range":[1,100]
},
"TrafficClasses": {
"TCRules": true,
"rangelength": [0,256]
},
"ShapingRate": {
"integer": true,
"ranges":[0, [8192, 100000000]]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if ( ActionByApplyResult(xml, template, "Alias") == 0 )
{
var pArr = {
"DefaultQueue" : {
ValueOrigin: ""
}
};
xmlParaInInstOperate(xml, "OBJ_QOSQQ_ID", 0, pArr);
if (pArr.DefaultQueue.ValueOrigin == "1")
{
$("[id^='DefaultQueue0']", $("#QoSQueueCongestionCfg_container")).each(function(){
$(this).prop("checked", true);
});
$("[id^='DefaultQueue1']", template).prop("checked", true);
$("[id^='Enable1']", template).prop("checked", true);
}
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_QOSQQ_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var obj_container = template.parent();
var InterfaceFilter = $("[id^='InterfaceFilter']", obj_container);
var inter = $("[id^='QueueInterface']", template);
inter.val(InterfaceFilter.val());
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
var portNameValue = {
"ShapingRate" : ""
};
if (portNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "-1";
}
});
template.bind("fillDataByCustom", function(event, suffix, template, xml){
template.collapsibleInstTitleChange("Alias");
var rateObj = $("[id^='ShapingRate']", template);
if (rateObj.val() == "-1")
{
rateObj.val("");
}
var weightObj = $("[id^='Weight']", template);
if (weightObj.val() == "0")
{
weightObj.val("");
}
$("[id^='SchedulerAlgorithm']", template).change();
});
}
function handleByCapacity(capobj,fatherattr,childattr,htmlobj)
{
if (capobj.hasOwnProperty(fatherattr))
{
if (childattr == "Display")
{
if (capobj[fatherattr].hasOwnProperty("Display"))
{
if(capobj[fatherattr][childattr] == "hide")
{
htmlobj.showIt(false);
}
else if (capobj[fatherattr][childattr] == "show")
{
htmlobj.showIt(true);
htmlobj.disableIt(false);
}
else if (capobj[fatherattr][childattr] == "disable")
{
htmlobj.showIt(true);
htmlobj.attr("disabled", "disabled");
}
}
else
{
htmlobj.showIt(true);
htmlobj.disableIt(false);
}
return;
}
if (childattr == "WFQWeightRange")
{
if (capobj[fatherattr].hasOwnProperty(childattr))
{
var minMax = capobj[fatherattr][childattr];
WFQWeightMin = minMax[0];
WFQWeightMax = minMax[1];
}
else
{
}
}
if (childattr == "SelectValue")
{
if (capobj[fatherattr].hasOwnProperty(childattr))
{
$("option",htmlobj).remove();
for (var key in capobj[fatherattr][childattr])
{
htmlobj.append("<option value="+capobj[fatherattr][childattr][key]+">"+capobj[fatherattr][childattr][key]+"</option>");
}
}
else
{
}
}
}
else
{
if (childattr == "Display")
{
htmlobj.showIt(true);
htmlobj.disableIt(false);
}
if (childattr == "SelectValue")
{
}
}
}
function chageTemplateByInterface(interVal)
{
if (CapacityObj != "")
{
if (!CapacityObj.hasOwnProperty(interVal))
{
for (var key in CapacityObj)
{
if (CapacityObj[key].hasOwnProperty("InterfaceValue") && CapacityObj[key]["InterfaceValue"] == interVal)
{
interVal = key;
break;
}
}
}
if (CapacityObj.hasOwnProperty(interVal))
{
var obj = CapacityObj[interVal];
handleByCapacity(obj,"AddButton","Display",$("#addInstBar_QoSQueueCongestionCfg"));
handleByCapacity(obj,"DelButton","Display",$("#instDelete_QoSQueueCongestionCfg"));
handleByCapacity(obj,"ShapingRate","Display",$("#ShapingRate").parent().parent());
handleByCapacity(obj,"NeedStats","Display",$("#NeedStats").parent());
handleByCapacity(obj,"DefaultQueue","Display",$("#DefaultQueue").parent());
handleByCapacity(obj,"QueueNum","Display",$("#QueueNum"));
handleByCapacity(obj,"Enable","Display",$("#Enable"));
handleByCapacity(obj,"HardQoSWeight","Display",$("#percent"));
handleByCapacity(obj,"ValidateRules","WFQWeightRange",$("#Weight"));
handleByCapacity(obj,"SchedulerAlgorithm","SelectValue",$("#SchedulerAlgorithm"));
}
}
}
function initial_collapBarWithDataTrans_customize(Head)
{
var UnderControlContainer = $("#"+ Head.attr("id") +"_container");
UnderControlContainer.hide();
$(".collapBarWithDataTrans",Head).click(function(event){
event.preventDefault();
var collapBar = $(this);
if ( $("#DataHasBeenGot",Head).val() == 0 )
{
showWaitTip(true);
setTimeout(function(){
var ServerAddr = $("address span", Head).text();
var interVal = $("#InterfaceFilter",Head).val();
if (interVal != "")
{
ServerAddr = ServerAddr + "&InterfaceFilter="+interVal;
}
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
undefined,
undefined,
false
);
$("#DataHasBeenGot",Head).val(1);
collapBarAction(collapBar);
}, 2);
}
else
{
collapBarAction(collapBar);
}
});
}
function initInterfaceEnvent(InterfaceOBJ, Head)
{
InterfaceOBJ.change(function(event){
var interVal = $(this).val();
var ServerAddr = $("address span", Head).text();
if (interVal != "")
{
ServerAddr = ServerAddr + "&InterfaceFilter="+interVal;
}
Head.succfunction = function(xml){
chageTemplateByInterface(interVal);
Head.hasError(xml,"externErrorHint");
var OBJ = "OBJ_QOSQQ_ID";
var OBJID = [OBJ];
var QOSQQOBJ = $(xml).find(OBJ);
var QOSQQNum = $("Instance", QOSQQOBJ).length;
$("[id^='template_QoSQueueCongestionCfg_']").remove();
Head.createPageDataByClone(QOSQQNum,
OBJID,
xml,
Head.fillDataByCustom);
var InstNumOBJ = $("#_InstNum",Head);
var AddInstLink = Head.find(".addInst");
if ( IfCreateInstChk(Head, InstNumOBJ, AddInstLink) )
{
addInst(Head, InstNumOBJ);
}
};
if ( $("#DataHasBeenGot",Head).val() != 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans_customize(Head);
}
});
}
function initCustomizeInterface()
{
if (CapacityObj != "")
{
$("#InterfaceFilter option").remove();
for (var key in CapacityObj)
{
if (CapacityObj[key].hasOwnProperty("InterfaceValue"))
{
var optval = CapacityObj[key]["InterfaceValue"];
}
else
{
var optval = key;
}
$("#InterfaceFilter").append("<option value="+optval+">"+key+"</option>");
}
}
}
$(document).ready(function(){
var QoSQueueCongestionHeadID = "QoSQueueCongestionCfg";
var QoSQueueCongestionHead = $("#"+QoSQueueCongestionHeadID);
var Basic_templateID = "template_"+ QoSQueueCongestionHeadID;
initial_template_Congestion(Basic_templateID);
var InterfaceFilter = $("[id^='InterfaceFilter']", QoSQueueCongestionHead);
initInterfaceEnvent(InterfaceFilter, QoSQueueCongestionHead);
initCustomizeInterface();
InterfaceFilter.change();
});
})();
</script>
