<script type="text/javascript">
(function () {
$(document).ready(function(){
var LANDevsHeadID = "LANDevs";
var LANDevsHead = $("#"+LANDevsHeadID);
var LANDevsServerAddr = $("address span", LANDevsHead).text();
LANDevsHead.fillDataByCustom = function(suffix,ContainerOBJ){
var clientIndex = parseInt(suffix, 10) + 1;
var clientName = "&?LocalnetStatus_018;-"+clientIndex;
var cnObj = $("[id^='ClientNum']", ContainerOBJ);
cnObj.text(clientName);
cnObj.attr("title", clientName);
};
LANDevsHead.succfunction = function(xml){
if (LANDevsHead.hasError(xml) == 0)
{
var data = {};
data.xml = xml;
$.callModifier("/accessdev/TAHidden",data);
var LANDevsTemplateOBJ = $("#template_"+LANDevsHeadID,LANDevsHead);
var LANDevsOBJ = $(xml).find("OBJ_ACCESSDEV_ID");
var LANDevsRuleNum = $("Instance", LANDevsOBJ).length;
var OBJID = ["OBJ_ACCESSDEV_ID"];
if (LANDevsRuleNum == 0)
{
$(".noDataHint",LANDevsHead).showIt(true);
LANDevsTemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint",LANDevsHead).showIt(false);
LANDevsTemplateOBJ.parent().showIt(true);
LANDevsHead.createPageDataByClone(LANDevsRuleNum,
OBJID,
xml,
LANDevsHead.fillDataByCustom);
$.publish("/some/sncTAHidden", [xml]);
colorTblRow(".colorTbl", "even", LANDevsHead);
}
}
};
if ( $(".collapBarWithDataTrans",LANDevsHead).length <= 0 )
{
LANDevsHead.dataTransfer(LANDevsServerAddr, "GET", LANDevsHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(LANDevsHead);
}
RefreshClickHandle(LANDevsHead);
});
})();
</script>
