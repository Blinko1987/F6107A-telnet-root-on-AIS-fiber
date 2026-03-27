<script type="text/javascript">
$(document).ready(function() {
var HeadID = "PinSimFail";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.fillDataByCustom = function(suffix,ContainerOBJ) {
callback_check = function(tDongleStatus) {
if ( "SIM_FAILURE" == tDongleStatus )
{
consoleLog("not to do anything");
}
else
{
top.location.href = top.location.href;
}
}
}
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var template = $("[id^='template_']",Head);
var OBJID = ["OBJ_WWANPINCFG_ID"];
Head.fillDataByOBJID(xml ,OBJID, template, 0);
Head.fillDataByCustom(0, template);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,"GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
</script>
