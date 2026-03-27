<script type="text/javascript">
(function () {
$(document).ready(function(){
var HeadID = "LANStatus";
var Head = $("#"+HeadID);
var tempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var statusOBJ = $("[id^='Status']", ContainerOBJ);
if (statusOBJ.text() == "Up")
{
statusOBJ.text("&?LocalnetStatusAd_007;");
statusOBJ.attr("title", "&?LocalnetStatusAd_007;");
}
else
{
statusOBJ.text("&?LocalnetStatusAd_008;");
statusOBJ.attr("title", "&?LocalnetStatusAd_008;");
}
var BytesReceived = $("[id^='BytesReceived']", ContainerOBJ).val();
var BytesSent = $("[id^='BytesSent']", ContainerOBJ).val();
var BytesCount = BytesReceived+"/"+BytesSent;
var bcObj = $("[id^='BytesCount']", ContainerOBJ);
bcObj.text(BytesCount);
bcObj.attr("title", BytesCount);
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var ETHOBJ = $(xml).find("OBJ_ETH_ID");
var RuleNum = $("Instance", ETHOBJ).length;
var OBJID = ["OBJ_ETH_ID", "OBJ_WANLAN_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml,Head.fillDataByCustom);
colorTblRow(".colorTbl", "even", Head);
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
