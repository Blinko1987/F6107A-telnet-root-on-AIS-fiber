<script type="text/javascript">
(function(){
var enableChanged = false;
function IfServerLive()
{
var HeadID = "NetSphereMAPSwitch";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
Head.succfunction = function(xml){
Head.hasError(xml);
showWaitTip(false);
return;
};
Head.failfunction = function(XMLHttpRequest,textStatus){
setTimeout("IfServerLive()",30000);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction, Head.failfunction, false);
}
function EnableControlMode(template)
{
var EnableObj = $("input[name='Enable']:checked",template);
if ( EnableObj.val() == "1")
{
$("#Mode").show();
}
else
{
$("#Mode").hide();
}
}
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
if ( enableChanged == true ){
setTimeout(function(){
showWaitTip(true, "&?DeviceManag_011;");
setTimeout("IfServerLive()", 30000);
}, 20);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_NETSPHERE_MAP_ID","OBJ_MAP_MASTER_ID","OBJ_TEMP_DOMAIN_BS"];
ActionByCancelResult(xml, template, OBJID);
var Mode = $("input:radio[name^='Mode']:checked", template).val();
$("#CurrentMode").val(Mode);
var Enable = $("input:radio[name^='Enable']:checked", template).val();
$("#CurrentEnable").val(Enable);
EnableControlMode(template);
});
$("#Btn_apply_Mode_Confirm", template).click(function(){
$(".Btn_apply", template).click();
});
var EnableObj = $("input[name='Enable']",template);
EnableObj.click(function(event){
var thisObj = $(this);
if ( thisObj.is(':checked') && thisObj.val() == "1")
{
$("#Mode").show();
}
else
{
$("#Mode").hide();
}
});
}
$(document).ready(function(){
var HeadID = "NetSphereMAPMode";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
$(".pIntroContent").text("This page provides the function of EasyMesh Multiple APs parameter configuration.");
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_NETSPHERE_MAP_ID","OBJ_MAP_MASTER_ID","OBJ_TEMP_DOMAIN_BS"];
var template = $("[id^='template_']",Head);
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
var Mode = $("input:radio[name^='Mode']:checked", template).val();
$("#CurrentMode").val(Mode);
var Enable = $("input:radio[name^='Enable']:checked", template).val();
$("#CurrentEnable").val(Enable);
EnableControlMode(template);
}
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
