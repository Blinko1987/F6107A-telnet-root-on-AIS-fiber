<script type="text/javascript">
(function() {
var TimeTimerID;
var count = 0;
function fillInfo(xml, ContainerOBJ)
{
$("#DDRStatus",ContainerOBJ).text("OK").attr("title", "OK");
$("#FlashStatus",ContainerOBJ).text("OK").attr("title", "OK");
var TxObj = $("#TxStatus",ContainerOBJ);
var RxObj = $("#RxStatus",ContainerOBJ);
var LosInfo = xml["OBJ_LOS_INFO_ID"]["Instance"][0]["LosInfo"];
if(LosInfo == "1")
{
TxObj.text("DOWN").attr("title", "DOWN");
RxObj.text("DOWN").attr("title", "DOWN");
}
else
{
var TxVal = xml["OBJ_PON_OPTICALPARA_ID"]["Instance"][0]["TxPower"];
var RxVal = xml["OBJ_PON_OPTICALPARA_ID"]["Instance"][0]["RxPower"];
if ( parseInt(TxVal) != 0 )
{
TxObj.text("UP").attr("title", "UP");
}
else
{
TxObj.text("DOWN").attr("title", "DOWN");
}
if ( parseInt(RxVal) != 0 )
{
RxObj.text("UP").attr("title", "UP");
}
else
{
RxObj.text("DOWN").attr("title", "DOWN");
}
}
if (xml["OBJ_USBSTORAGE_ID"]["Instance"].length > 0)
{
$("#USBStatus",ContainerOBJ).text("UP").attr("title", "UP");
}
else
{
$("#USBStatus",ContainerOBJ).text("DOWN").attr("title", "DOWN");
}
var ETHOBJ = xml["OBJ_PON_PORT_BASIC_STATUS_ID"];
var RuleNum = ETHOBJ["Instance"].length;
for(var i=0; i < RuleNum; i++)
{
var Val = ETHOBJ["Instance"][i]["Status"];
if ( parseInt(Val) == 0)
{
$("#ETHStatus"+i,ContainerOBJ).text("UP").attr("title", "UP");
}
else
{
$("#ETHStatus"+i,ContainerOBJ).text("DOWN").attr("title", "DOWN");
}
}
var WLANOBJ = xml["OBJ_WLANSETTING_ID"];
RuleNum = WLANOBJ["Instance"].length;
for(var i=0; i < RuleNum; i++)
{
var Val = WLANOBJ["Instance"][i]["RadioStatus"];
if ( parseInt(Val) == 1)
{
$("#WLANStatus"+i,ContainerOBJ).text("UP").attr("title", "UP");
}
else
{
$("#WLANStatus"+i,ContainerOBJ).text("DOWN").attr("title", "DOWN");
}
}
}
function g_StatusOpt()
{
var Head = $("#HWDiag");
var ServerAddr = $("address span", Head).text();
var template = $("#template_HWDiag");
Head.getSuccfunction = function(xml){
if (Head.hasError(xml) == 0)
{
count++;
if (count >= 4)
{
showWaitTip(false);
clearTimeout(TimeTimerID);
fillInfo(xml, template);
$("#btndiagnose").val("&?hwdiag_001;");
$("#btndiagnose").prop("disabled","").removeClass("disableBtn");
}
if(count < 4)
{
showWaitTip(true, "&?hwdiag_015;");
TimeTimerID = setTimeout(g_StatusOpt, 3000);
}
}
};
Head.getFailfunction = function(xml){
};
Head.dataTransfer(ServerAddr, "GET", Head.getSuccfunction, Head.getFailfunction, false);
}
$(document).ready(function(){
var HeadID = "HWDiag";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
var ServerAddr = $("address span", Head).text();
colorTblRow(".colorTbl", "even", Head);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
g_StatusOpt();
}
};
$("#btndiagnose", Head).bind("click", {templateOBJ:template}, function(event){
var diagBtn = $(this);
var template = event.data.templateOBJ;
diagBtn.val("&?hwdiag_015;");
diagBtn.attr("disabled","disabled").addClass("disableBtn");
showWaitTip(true, "&?hwdiag_015;");
count = 0;
setTimeout(function(){
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
true);
}, 3000);
});
showWaitTip(false);
initial_collapBarWithDataTrans(Head);
});
})();
</script>
