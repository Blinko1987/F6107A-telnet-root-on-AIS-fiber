<script type="text/javascript">
(function(){
function Show_SingalStrength_Div(templete_obj)
{
var sigVol_span = templete_obj.find("[id^='C_SignalStrength']");
var sigVol_tr = sigVol_span.find("tr");
var sigVol_td = sigVol_tr.find("td");
sigVol_td.clone().appendTo(sigVol_tr);
sigVol_td.clone().appendTo(sigVol_tr);
sigVol_td.clone().appendTo(sigVol_tr);
sigVol_td.clone().appendTo(sigVol_tr);
var sigVol_div = sigVol_span.find("div");
$.each(sigVol_div, function(n) {
$(this).css({
"width":"8px",
"overflow":"hidden",
"background-color":"rgb(183,183,183)"
});
$(this).height( (4*(n+1) + "px") );
});
var sigVol_value = $("[id^='SignalStrength']",templete_obj).val();
var l_count = Math.ceil( parseInt(sigVol_value)/20 );
$.each(sigVol_div, function(n) {
if(n<l_count)
{
$(this).css({
"background-color":"#01B0EE"
});
}
});
}
function change_err_inform(templete_obj)
{
var MobileAlarmValue = $("[id^='MobileAlarm']", templete_obj).val();
var C_MobileAlarmOBJ = templete_obj.find("[id^='C_MobileAlarm']");
if (MobileAlarmValue == 0)
{
C_MobileAlarmOBJ.parent().hide();
}
else
{
C_MobileAlarmOBJ.parent().show();
}
var text = "error";
alarm = parseInt(MobileAlarmValue, 10);
switch(alarm)
{
case 1:
{
text = "&?Internet3GStatus_006;";
break;
}
case 2:
{
text = "&?Internet3GStatus_007;";
break;
}
case 3:
{
text = "&?Internet3GStatus_008;";
break;
}
case 4:
{
text = "&?Internet3GStatus_009;";
break;
}
case 5:
{
text = "&?Internet3GStatus_010;";
break;
}
case 6:
{
text = "&?Internet3GStatus_011;";
break;
}
default:
break;
}
C_MobileAlarmOBJ.text(text);
}
$(document).ready(function(){
var HeadID = "Mobile3GStatus";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
RefreshClickHandle(Head);
Head.fillDataByCustom = function(suffix,ContainerOBJ) {
Show_SingalStrength_Div(ContainerOBJ);
change_err_inform(ContainerOBJ);
$("#InsertCardBefore span").text("&?Pinpublic_018_LTE;");
}
Head.succfunction = function(xml) {
var DongleStatus = $("DongleStatus", $(xml)).text();
var DevType = $("DevType", $(xml)).text();
var DongleType = $("DongleType", $(xml)).text();
$("#InsertCardBefore",Head).showIt(false);
$("#NotSupport",Head).showIt(false);
if ( DongleStatus == "Dev_FAILURE" )
{
$("#InsertCardBefore",Head).showIt(true);
}
else if( DongleType == "2")
{
$("#NotSupport",Head).showIt(true);
}
else
{
Head.hasError(xml,"externErrorHint");
var StatusOBJ = $(xml).find("OBJ_WWANMOBILEINFO_ID");
var RuleNum = $("Instance", StatusOBJ).length;
var OBJID = ["OBJ_WWANMOBILEINFO_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
var div_CustomCard = $(".CustomCard", Head);
if ("1" == DevType && "1" == DongleType)
{
div_CustomCard.showIt(true);
}
else
{
div_CustomCard.showIt(false);
$("[id^='div_MobileAlarm']",Head).showIt(false);
}
colorTblRow(".colorTbl", "even", Head);
}
$.publish("/some/entryModify", [1]);
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
