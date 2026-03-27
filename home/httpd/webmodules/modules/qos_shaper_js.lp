<script type="text/javascript">
(function(){
var CapacityObj="";
function Customize_QosShaper(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Alias");
}
function initial_template_QosShaper(templateID)
{
var template = $("#"+templateID);
var qbwMin = $("[id^='QBW_MIN']",template);
var qbwMax = $("[id^='QBW_MAX']",template);
qbwMin.text(reformString(qbwMin.text(), 3));
qbwMax.text(reformString(qbwMax.text(), 3));
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"ShapingRate": {
"required": true,
"integer": true,
"ranges":[0, [8192, 100000000]]
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
ActionByApplyResult(xml, template, "Alias");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_QOSSHAPER_CONF_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_QosShaper(CustomizeParams);
});
}
function initCustomizeShapingInterface(InterfaceFilter)
{
if (CapacityObj != ""){
$("option",InterfaceFilter).remove();
for (var key in CapacityObj){
if (!CapacityObj[key].hasOwnProperty("EgressShaping") || CapacityObj[key]["EgressShaping"] == 'yes')
{
if (CapacityObj[key].hasOwnProperty("InterfaceValue"))
{
var optval = CapacityObj[key]["InterfaceValue"];
}
else
{
var optval = key;
}
InterfaceFilter.append("<option value="+optval+">"+key+"</option>");
}
}
}
}
$(document).ready(function(){
var QosShaperHeadID = "QosShaper";
var QosShaperHead = $("#"+QosShaperHeadID);
var templateID = "template_"+ QosShaperHeadID;
var ServerAddr = $("address span", QosShaperHead).text();
initial_template_QosShaper(templateID);
QosShaperHead.succfunction = function(xml){
QosShaperHead.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_QOSSHAPER_CONF_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_QOSSHAPER_CONF_ID"];
QosShaperHead.createPageDataByClone(RuleNum, OBJID, xml);
};
var InterfaceFilter= $("#Interface",$("#"+templateID));
initCustomizeShapingInterface(InterfaceFilter);
if ( $(".collapBarWithDataTrans",QosShaperHead).length <= 0 )
{
QosShaperHead.dataTransfer(ServerAddr,"GET",QosShaperHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(QosShaperHead);
}
});
})();
</script>
