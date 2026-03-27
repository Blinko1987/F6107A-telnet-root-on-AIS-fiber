<script type="text/javascript">
(function(){
$(document).ready(function(){
var RouteTblHeadID = "RouteTable";
var RouteTblHead = $("#"+RouteTblHeadID);
var RouteTblTempalteID = "template_"+ RouteTblHeadID;
var RouteTblServerAddr = $("address span", RouteTblHead).text();
RefreshClickHandle(RouteTblHead);
RouteTblHead.fillDataByCustom = function(suffix,ContainerOBJ){
var IPObj = $("[id^='DestIP']", ContainerOBJ);
var pLen = $("[id^='PrefixLen']", ContainerOBJ).val();
IPObj.text(IPObj.text() + "/" + pLen);
IPObj.attr("title", IPObj.text());
};
RouteTblHead.succfunction = function(xml){
RouteTblHead.hasError(xml,"externErrorHint");
var TemplateOBJ = $("#template_" + RouteTblHeadID, RouteTblHead);
var RouteTblOBJ = $(xml).find("OBJ_ROUTETABLE6_ID");
var RuleNum = $("Instance", RouteTblOBJ).length;
var OBJID = ["OBJ_ROUTETABLE6_ID"];
if (RuleNum == 0)
{
$(".noDataHint",RouteTblHead).showIt(true);
TemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint",RouteTblHead).showIt(false);
TemplateOBJ.parent().showIt(true);
RouteTblHead.createPageDataByClone(RuleNum,OBJID,xml,
RouteTblHead.fillDataByCustom);
colorTblRow(".colorTbl", "even", RouteTblHead);
}
};
if ( $(".collapBarWithDataTrans",RouteTblHead).length <= 0 )
{
RouteTblHead.dataTransfer(RouteTblServerAddr,
"GET",
RouteTblHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(RouteTblHead);
}
});
})();
</script>
