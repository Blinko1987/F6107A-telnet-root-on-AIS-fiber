<script type="text/javascript">
function customize_pin_status_general_display(templeteOBJ)
{
var C_error_PinStatus = $("[id^='C_error_PinStatus']", templeteOBJ);
C_error_PinStatus.showIt(false);
var C_PinStatus = $("[id^='C_PinStatus']", templeteOBJ);
var pin_enable = $("[id^='PinStatus']", templeteOBJ).val();
if(pin_enable == 0)
{
C_PinStatus.html("&?Pinpublic_012;");
}
else if(pin_enable == 1)
{
C_PinStatus.html("&?Pinpublic_013;");
}
else
{
consoleLog("PinStatus mode error");
C_PinStatus.html("&?public_006;");
C_error_PinStatus.showIt(true);
}
}
function initial_template_PinReadyStatus(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ) {
customize_pin_status_general_display(ContainerOBJ);
callback_check = function(tDongleStatus, tPinStatus) {
if ( "SIM_READY" == tDongleStatus )
{
consoleLog("not to do anything");
}
else
{
top.location.href = top.location.href;
}
var new_PinStatus = tPinStatus;
var old_PinStatus = $("[id^='PinStatus']", ContainerOBJ).val();
if(new_PinStatus != old_PinStatus)
{
$("[id^='PinStatus']", ContainerOBJ).val(new_PinStatus);
customize_pin_status_general_display(ContainerOBJ);
}
}
});
}
$(document).ready(function() {
var HeadID = "PinReadyStatus";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
var templateID = "template_"+ HeadID;
initial_template_PinReadyStatus(templateID);
Head.succfunction = function(xml) {
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_WWANPINCFG_ID"];
var template = $("[id^='template_']",Head);
Head.fillDataByOBJID(xml ,OBJID, template, 0);
template.trigger("fillDataByCustom",[0, template]);
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
