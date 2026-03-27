<script type="text/javascript">
var CapacityObj2="";
function RefreshClickHandleforQos(Head)
{
$(".Btn_refresh", Head).each(function(){
$(this).unbind("click");
$(this).bind("click", function(){
var HeadID = Head.attr("id");
$("[id^='QoSStatistics_trans']", Head).showIt(true);
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var interface = $("[id^='QueueInterface']", Head);
var ServerAddr = $("address span", Head).text();
ServerAddr = ServerAddr + "&InterfaceFilter="+interface.val();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
true);
});
})
}
function initInterfaceEnvent2(InterfaceOBJ, Head)
{
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_QOSQQSTATS_ID");
var RuleNum = $("Instance", OBJ).length;
var HeadID = Head.attr("id");
var ruleTemplate = $("#data_QoSStatisticsCfg",Head);
var TemplateOBJ = $("#template_"+HeadID,Head);
$("[id^='data_QoSStatisticsCfg_']", TemplateOBJ).remove();
$("#_InstNum", Head).val(RuleNum);
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
TemplateOBJ.showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
for (var i=0; i<RuleNum; i++)
{
var clone = ruleTemplate.cloneWithSuffix(i, "_");
ruleTemplate.before(clone);
var DataOBJID = ["OBJ_QOSQQSTATS_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
clone.showIt(true);
}
TemplateOBJ.showIt(true);
}
reposition_box("QoSStatisticsDiv_copy");
var TiplayerResize = window.onresize ;
window.onresize = function()
{
TiplayerResize();
if ($("#QoSStatisticsDiv_copy").css("display") != "none")
{
reposition_box("QoSStatisticsDiv_copy");
}
}
colorTblRow(".colorRowforQos", "odd", Head);
$("[id^='QoSStatistics_trans']", Head).showIt(false);
};
InterfaceOBJ.change(function(event){
var Interface = $(this);
var InterfaceVal = Interface.val();
$("[id^='QoSStatistics_trans']", Head).showIt(true);
var ServerAddr = $("address span", Head).text();
if (InterfaceVal != "")
{
ServerAddr = ServerAddr + "&InterfaceFilter="+InterfaceVal;
}
Head.dataTransfer(ServerAddr, "GET", Head.succfunction,undefined,false);
var inter = $("[id^='QueueInterface']", Head);
inter.val(InterfaceVal);
});
var template = $("[id^='template_QoSStatisticsCfg']", Head);
template.bind("fillDataByResetResult", function(event,xml, template){
Head.succfunction(xml);
});
$("#"+"Statistics_Btn_reset", Head).bind("click", function(event){
var ServerAddr = $("address span", Head).text();
var HeadID = Head.attr("id");
$("[id^='QoSStatistics_trans']", Head).showIt(true);
var templateID = "template_"+ HeadID;
$("[id^='" +templateID + "']", Head).each(function(){
var temp = $(this);
dataPost("Reset", "fillDataByResetResult", ServerAddr, temp, undefined, false);
});
});
$("#"+"instDelete_QoSStatistics", Head).bind("click", function(event){
showWaitTip(false);
$("#QoSStatisticsDiv_copy").remove();
});
RefreshClickHandleforQos(Head);
}
function initCustomizeInterfaceFilter2(InterfaceFilter2)
{
if (CapacityObj2 != ""){
$("option",InterfaceFilter2).remove();
for (var key in CapacityObj2){
if (!CapacityObj2[key].hasOwnProperty("Statistics") || CapacityObj2[key]["Statistics"] == "yes")
{
if (CapacityObj2[key].hasOwnProperty("InterfaceValue"))
{
var optval = CapacityObj2[key]["InterfaceValue"];
}
else
{
var optval = key;
}
InterfaceFilter2.append("<option value="+optval+">"+key+"</option>");
}
}
}
}
function QoSStatistics()
{
$("#blackMask").css("display", "block");
var source = $("#QoSStatisticsDiv");
var clone = source.clone(true);
clone.attr("id", clone.attr("id")+"_copy");
clone.showIt(true);
clone.appendTo('body');
var InterfaceFilter2 = $("[id^='InterfaceFilter2']", clone);
var QoSStatisticsHead = $("#QoSStatisticsCfg",clone);
initInterfaceEnvent2(InterfaceFilter2, QoSStatisticsHead);
var InterfaceFilter = $("[id^='InterfaceFilter']", $("#QoSQueueCongestionCfg_container"));
InterfaceFilter2.val(InterfaceFilter.val());
reposition_box("QoSStatisticsDiv_copy");
initCustomizeInterfaceFilter2(InterfaceFilter2);
InterfaceFilter2.change();
$("#QoSStatisticsDiv_copy").css("display", "block");
}
</script>
