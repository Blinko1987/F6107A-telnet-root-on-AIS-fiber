<script type="text/javascript">
$(document).ready(function() {
var HeadID = "PinExcept";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.fillDataByCustom = function(suffix,ContainerOBJ) {
callback_check = function(tDongleStatus) {
if (tDongleStatus == "PAGE_OTHER_STATE")
{
consoleLog("not to do anything");
}
else
{
top.location.href = top.location.href;
}
}
}
Head.succfunction = function(xml) {
Head.hasError(xml,"externErrorHint");
Head.fillDataByCustom();
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
</script>
