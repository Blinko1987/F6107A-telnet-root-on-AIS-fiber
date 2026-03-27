<script type="text/javascript">
function IfServerLive()
{
var HeadID = "RestartManag";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
Head.hasError(xml);
showWaitTip(false);
return;
};
Head.failfunction = function(XMLHttpRequest,textStatus){
setTimeout("IfServerLive()", 30000);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction, Head.failfunction, false);
}
$(document).ready(function(){
var HeadID = "RestartManag";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
template.bind("fillDataByRestartResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
setTimeout("IfServerLive()", 30000);
}
else
{
showWaitTip(false);
}
});
$(".Btn_restart").bind("click", {templateOBJ:template}, function(event){
var template = event.data.templateOBJ;
var msg = "&?DeviceManag_010;";
$("#Msg").val(msg);
$.publish("/some/ctcchangeMsg", [template]);
msg = $("#Msg").val();
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", {FuncOBJ: template}, function(event){
showWaitTip(false);
var template = event.data.FuncOBJ;
var Head = template.parents(".HeadDIV");
var ServerAddr = $("address span", Head).text();
showWaitTip(true,"&?DeviceManag_011;");
dataPost("Restart", "fillDataByRestartResult", ServerAddr, template, undefined, false);
});
});
showWaitTip(false);
initial_collapBarWithDataTrans(Head);
});
</script>
