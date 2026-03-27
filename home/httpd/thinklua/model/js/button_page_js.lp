<script type="text/javascript">
(function(){
var pageConf = JSON.parse("<%=page.jsInfo%>");
var pageId = pageConf.id;
var pageAction = pageConf.action;
var pagePost = pageConf.POST;
var pageMsg = pageConf.Msg;
var pageOk = pageConf.OK;
function IfServerLive()
{
var HeadID = pageId;
var Head = $("#" + HeadID);
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
Head.hasError(xml);
showWaitTip(false);
return;
};
Head.failfunction = function(XMLHttpRequest, textStatus){
setTimeout(function(){IfServerLive();}, 30000);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction, Head.failfunction, false);
}
$(document).ready(function(){
var buttonHeadID = pageId;
var buttonHead = $("#" + buttonHeadID);
var buttonTemplate = $("#template_" + buttonHeadID);
var buttonAction = pageAction;
var buttonPOST = pagePost;
buttonTemplate.bind("fillDataByRestartResult", function(event, xml, buttonTemplate){
if (buttonTemplate.hasError(xml) == 0)
{
setTimeout(function(){IfServerLive();}, 30000);
}
else
{
showWaitTip(false);
}
});
buttonAction = "." + buttonAction;
$(buttonAction).bind("click", {templateOBJ:buttonTemplate}, function(event){
var buttonTemplate = event.data.templateOBJ;
var buttonMsg = pageMsg;
$("#Msg").val(buttonMsg);
$.publish("/some/ctcchangeMsg", [buttonTemplate]);
buttonMsg = $("#Msg").val();
var buttonConfirmLayerOBJ = IniConfirm(buttonMsg);
$("#confirmOK", buttonConfirmLayerOBJ).bind("click", {buttonFuncOBJ:buttonTemplate}, function(event){
showWaitTip(false);
var buttonTemplate = event.data.buttonFuncOBJ;
var buttonHead = buttonTemplate.parents(".HeadDIV");
var ServerAddr = $("address span", buttonHead).text();
showWaitTip(true, pageOk);
dataPost(buttonPOST, "fillDataByRestartResult", ServerAddr, buttonTemplate, undefined, false);
});
});
showWaitTip(false);
initial_collapBarWithDataTrans(buttonHead);
});
})();
</script>
