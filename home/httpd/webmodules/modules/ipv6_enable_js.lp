<script type="text/javascript">
(function(){
function IfServerLive()
{
var HeadID = "IPv6Switch";
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
function initial_template_IPv6Switch(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
if (template.hasError(xml) == 0)
{
$("#Btn_restart", template).click();
}
else
{
showWaitTip(false);
}
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_IPGLOBAL_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[template]);
});
template.bind("fillDataByCustom", function(event, template){
var pVal = $("#IPv6EnableSet", template).val();
$("#OldSwitchSet", template).val(pVal);
});
$("#Apply_VoIPPtclSwitch", template).click(function(event){
var pVal = $("#IPv6EnableSet", template).val();
var oldPVal = $("#OldSwitchSet", template).val();
if (pVal == oldPVal)
{
var msg = "&?IPV6Switch_008;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmCancel",confirmLayerOBJ).css( "display","none" );
$("#confirmOK",confirmLayerOBJ).unbind("click").focus();
$("#confirmOK",confirmLayerOBJ).bind("click", template, function(event){
showWaitTip(false);
});
}
else
{
var msg = "&?IPV6Switch_007;";
$("#Msg").val(msg);
$.publish("/some/changeMsg", [Msg]);
msg = $("#Msg").val();
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).unbind("click")
$("#confirmOK",confirmLayerOBJ).bind("click", template, function(event){
showWaitTip(true, "&?VoIPPtclSwitch_010;");
var Head = template.parents(".HeadDIV");
var ServerAddr = $("address span", Head).text();
dataPost("Apply", "fillDataByApplyResult", ServerAddr, template, undefined, false);
});
}
});
$("#Btn_restart", template).click(function(event){
var Head = template.parents(".HeadDIV");
var ServerAddr = $("address span", Head).text();
showWaitTip(true, "&?DeviceManag_011;");
dataPost("Restart", "fillDataByRestartResult", ServerAddr, template, undefined, false);
});
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
}
$(document).ready(function(){
var HeadID = "IPv6Switch";
var Head = $("#"+HeadID);
var TemplateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
var Template = $("#"+TemplateID);
initial_template_IPv6Switch(TemplateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_IPGLOBAL_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_IPGLOBAL_ID"];
Template.fillDataByOBJID(xml, OBJID, Template, 0);
Template.trigger("fillDataByCustom", Template);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
