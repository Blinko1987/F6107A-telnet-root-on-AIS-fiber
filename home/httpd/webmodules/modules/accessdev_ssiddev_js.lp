<script type="text/javascript">
(function () {
$(document).ready(function(){
var SSIDDevHeadID = "SSIDDev";
var SSIDDevHead = $("#"+SSIDDevHeadID);
var SSIDDevServerAddr = $("address span", SSIDDevHead).text();
SSIDDevHead.fillDataByCustom = function(suffix,ContainerOBJ){
var clientIndex = parseInt(suffix, 10) + 1;
var clientName = "&?LocalnetStatus_018;-"+clientIndex;
var cnObj = $("[id^='WClientNum']", ContainerOBJ);
cnObj.text(clientName);
cnObj.attr("title", clientName);
};
SSIDDevHead.succfunction = function(xml){
if (SSIDDevHead.hasError(xml) == 0)
{
var SSIDDevTemplateOBJ = $("#template_"+SSIDDevHeadID, SSIDDevHead);
var wlanADOBJ = $(xml).find("OBJ_ACCESSDEV_ID");
var wlanADNum = $("Instance", wlanADOBJ).length;
var OBJID = ["OBJ_ACCESSDEV_ID"];
if (wlanADNum == 0)
{
$(".noDataHint", SSIDDevHead).showIt(true);
SSIDDevTemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint", SSIDDevHead).showIt(false);
SSIDDevTemplateOBJ.parent().showIt(true);
SSIDDevHead.createPageDataByClone(wlanADNum,OBJID,xml,
SSIDDevHead.fillDataByCustom);
colorTblRow(".colorTbl", "even", SSIDDevHead);
}
}
};
if ( $(".collapBarWithDataTrans",SSIDDevHead).length <= 0 )
{
SSIDDevHead.dataTransfer(SSIDDevServerAddr, "GET", SSIDDevHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(SSIDDevHead);
}
RefreshClickHandle(SSIDDevHead);
});
})();
</script>
