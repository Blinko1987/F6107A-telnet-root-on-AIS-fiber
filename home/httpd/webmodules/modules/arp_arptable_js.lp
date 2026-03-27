<script type="text/javascript">
(function() {
function RefreshClickHandle(Head)
{
$(".Btn_refresh", Head).each(function(){
$(this).unbind("click");
$(this).bind("click", function(){
showWaitTip(true);
var HeadID = Head.attr("id");
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
true);
});
})
}
function ChanegeDataByCustom(xml)
{
var ToOperParaArr = {
"Status" : {
ValueOrigin: "",
setAction: function(ParaNameSel, ParaValSel, SelfVal){
if(SelfVal == 0)
{
ParaValSel.text("&?ArpTable_009;");
}
else
{
ParaValSel.text("&?ArpTable_008;");
}
}
}
};
var InstNum = $("Instance", $("OBJ_GETARPINST_ID", $(xml))).length;
for(var i=0; i<InstNum; i++)
{
xmlParaInInstOperate(xml, "OBJ_GETARPINST_ID", i, ToOperParaArr);
}
}
$(document).ready(function(){
var HeadID = "ArpTable";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head, false);
var showInst = "";
var template = $("#template_ArpTable");
template.bind("fillData", function(event, xml, template){
var Head = template.parents(".HeadDIV");
if (Head.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_GETARPINST_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_GETARPINST_ID"];
ChanegeDataByCustom(xml);
Head.createPageDataByClone(RuleNum, OBJID, xml);
colorTblRow(".colorTbl", "even", Head);
}
});
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
showInst = $("showInst", $(xml)).text();
if(1 == showInst)
{
var OBJ = $(xml).find("OBJ_GETARPINST_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_GETARPINST_ID"];
ChanegeDataByCustom(xml);
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
showWaitTip(false);
}
else if(0 == showInst)
{
var msg = "&?ArpTable_006;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", function(event){
var PostData = "IF_ACTION=DISPALL";
dataPost(undefined, "fillData", ServerAddr, template, PostData);
});
$("#confirmCancel",confirmLayerOBJ).unbind("click");
$("#confirmCancel",confirmLayerOBJ).bind("click", function(event){
var PostData = "IF_ACTION=DISPPART";
dataPost(undefined, "fillData", ServerAddr, template, PostData);
});
}
}
else
{
showWaitTip(false);
}
};
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,undefined,false);
$(".collapsibleBar", Head).click();
});
})();
</script>
