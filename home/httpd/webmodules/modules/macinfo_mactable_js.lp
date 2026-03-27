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
"VlanID" : {
ValueOrigin: "",
setAction: function(ParaNameSel, ParaValSel, SelfVal){
if (SelfVal == "65534")
{
ParaValSel.text("&?public_074;");
}
}
}
};
var InstNum = $("Instance", $("OBJ_GETMACINST_ID", $(xml))).length;
for(var i=0; i<InstNum; i++)
{
xmlParaInInstOperate(xml, "OBJ_GETMACINST_ID", i, ToOperParaArr);
}
}
$(document).ready(function(){
var HeadID = "MacTable";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head, false);
var template = $("#template_MacTable");
template.bind("fillData", function(event, xml, template){
var Head = template.parents(".HeadDIV");
if (Head.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_GETMACINST_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_GETMACINST_ID"];
ChanegeDataByCustom(xml);
Head.createPageDataByClone(RuleNum, OBJID, xml);
$.publish("/some/sncTAHidden", [xml]);
colorTblRow(".colorTbl", "even", Head);
}
});
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var showInst = $("showInst", $(xml)).text();
if(1 == showInst)
{
var OBJ = $(xml).find("OBJ_GETMACINST_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_GETMACINST_ID"];
ChanegeDataByCustom(xml);
Head.createPageDataByClone(RuleNum, OBJID, xml);
$.publish("/some/sncTAHidden", [xml]);
colorTblRow(".colorTbl", "even", Head);
showWaitTip(false);
}
else if(0 == showInst)
{
var msg = "&?MacTable_006;";
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
