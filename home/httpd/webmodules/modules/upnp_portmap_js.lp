<script type="text/javascript">
(function(){
$(document).ready(function(){
var HeadID = "PortMap";
var Head = $("#"+HeadID);
var TempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var TemplateOBJ = $("#template_" + HeadID, Head);
var PortMapOBJ = $(xml).find("OBJ_UPNPPORTMAP_ID");
var RuleNum = $("Instance", PortMapOBJ).length;
var OBJID = ["OBJ_UPNPPORTMAP_ID"];
if (RuleNum == 0)
{
$(".noDataHint",Head).showIt(true);
TemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint",Head).showIt(false);
TemplateOBJ.parent().showIt(true);
Head.createPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
