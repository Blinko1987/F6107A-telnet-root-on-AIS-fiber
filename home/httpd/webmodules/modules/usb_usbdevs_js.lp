<script type="text/javascript">
(function () {
$(document).ready(function(){
var USBDevsHeadID = "USBDevs";
var USBDevsHead = $("#"+USBDevsHeadID);
var USBDevsServerAddr = $("address span", USBDevsHead).text();
USBDevsHead.succfunction = function(xml){
USBDevsHead.fillDataByCustom = function(suffix,ContainerOBJ){
var USBOBJ = ContainerOBJ.find("[id^='USBNum']");
USBOBJ.text("&?public_140;"+(parseInt(suffix,10)+1));
USBOBJ.attr("title", USBOBJ.text());
};
if (USBDevsHead.hasError(xml) == 0)
{
var USBDevsTemplateOBJ = $("#template_"+USBDevsHeadID,USBDevsHead);
var USBDevsOBJ = $(xml).find("OBJ_USBSTORAGE_ID");
var USBDevsRuleNum = $("Instance", USBDevsOBJ).length;
var OBJID = ["OBJ_USBSTORAGE_ID"];
if (USBDevsRuleNum == 0)
{
$(".noDataHint", USBDevsHead).showIt(true);
USBDevsTemplateOBJ.parent().showIt(false);
}
else
{
$(".noDataHint", USBDevsHead).showIt(false);
USBDevsTemplateOBJ.parent().showIt(true);
USBDevsHead.createPageDataByClone(USBDevsRuleNum, OBJID,
xml, USBDevsHead.fillDataByCustom);
colorTblRow(".colorTbl", "even", USBDevsHead);
}
}
};
if ( $(".collapBarWithDataTrans",USBDevsHead).length <= 0 )
{
USBDevsHead.dataTransfer(USBDevsServerAddr, "GET", USBDevsHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(USBDevsHead);
}
RefreshClickHandle(USBDevsHead);
});
})();
</script>
