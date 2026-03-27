<script type="text/javascript">
(function(){
var newIPaddr = "192.168.1.1";
var enableChanged = false;
function IfServerLive()
{
var HeadID = "OperationMode";
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
function ConfirmModeChange()
{
var tipLayer = $("#tipLayer");
$("#confirmOK", tipLayer).bind("click", function(event){
showWaitTip(false);
var template = $("#template_OperationMode");
$(".Btn_apply", template).click();
if ( enableChanged == true ){
setTimeout(function(){
window.location.href = "http://" + newIPaddr;
},3000);
}
});
$("#confirmCancel").click(function(){
showWaitTip(false);
});
$("#waitingImgArea").hide();
$("#confirmOK, #confirmCancel").show();
$("#confirmCancel").focus();
}
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
if ( enableChanged == true ){
window.location.reload();
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_NETSPHERE_MAP_SETMODE_ID"];
ActionByCancelResult(xml, template, OBJID);
var CurrentMode = $("#CurrentMode").val()
$("#OPMode"+CurrentMode, "#RegionCode").prop("checked", true);
});
$("#Btn_apply_Mode_Confirm", template).click(function(){
var NewMode = $("input:radio[name^='RegionCode']:checked").val();
var CurrentMode = $("#CurrentMode").val();
if ( NewMode == CurrentMode )
{
enableChanged = false;
return;
}
var text = "&?pro_OPMode_018;";
if (NewMode == 2)
{
newIPaddr = "192.168.10.1";
text += newIPaddr + "&?pro_OPMode_017;";
}
else if (CurrentMode ==2 )
{
text += newIPaddr + "&?pro_OPMode_017;";
}
else if (NewMode ==3 )
{
text = "&?pro_OPMode_019;";
}
else
{
newIPaddr = "192.168.1.1";
text += newIPaddr;
}
enableChanged = true;
showWaitTip(true, text);
ConfirmModeChange();
});
}
$(document).ready(function(){
var HeadID = "OperationMode";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_NETSPHERE_MAP_SETMODE_ID"];
var template = $("[id^='template_']",Head);
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
var CurrentMode = $("#CurrentMode").val()
var array = {"0":"&?pro_OPMode_013;", "1":"&?pro_OPMode_009;", "2":"&?pro_OPMode_010;", "3":"&?pro_OPMode_011;"};
$("#curr_mode").text(array[CurrentMode]).attr("title", array[CurrentMode]);
$("#OPMode"+CurrentMode, "#RegionCode").prop("checked", true);
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
