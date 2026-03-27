<script type="text/javascript">
(function(){
function Customize_T46Status(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
var ConnStatus = $("[id^='ConnStatus']", ContainerOBJ);
if ("0" == ConnStatus.text())
{
ConnStatus.text("&?Tnl4in6Status_004;");
}
else
{
ConnStatus.text("&?Tnl4in6Status_005;");
}
ConnStatus.attr("title", ConnStatus.text());
var TUN46WANName = $("[id^='TUN46WANName']", ContainerOBJ);
if ("" == TUN46WANName.text())
{
TUN46WANName.text("&?public_094;");
}
TUN46WANName.attr("title", TUN46WANName.text());
}
$(document).ready(function(){
var HeadID = "Tnl4in6Status";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_T46Status(CustomizeParams);
};
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_TUNNEL46_ID");
var RuleNum = $("Instance", OBJ).length;
if (0 == RuleNum)
{
$(".noDataHint",Head).showIt(true);
}
else
{
$(".noDataHint",Head).showIt(false);
var OBJID = ["OBJ_TUNNEL46_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml,Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
}
$.publish("/some/connectionStatusHide", [$("[id^='template_Tnl4in6Status'")]);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
RefreshClickHandle(Head);
});
})();
</script>
