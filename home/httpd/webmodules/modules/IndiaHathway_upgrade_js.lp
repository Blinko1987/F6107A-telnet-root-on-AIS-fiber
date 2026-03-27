<script type="text/javascript">
function IfServerLive()
{
var HeadID = "FirmwareUpgr";
var Head = $("#"+HeadID);
var ServerAddr = "/?_type=hiddenData&_tag=upgrade_firmware";
Head.succfunction = function(xml){
Head.hasError(xml);
showWaitTip(false);
return;
};
Head.failfunction = function(XMLHttpRequest,textStatus){
setTimeout("IfServerLive()", 30000);
};
Head.dataTransfer(ServerAddr, "GET", Head.succfunction,
Head.failfunction, false);
}
function queryUpgradeStatus()
{
var HeadID = "FirmwareUpgr";
var Head = $("#"+HeadID);
var ServerAddr = "/?_type=hiddenData&_tag=upgrade_firmware";
Head.dataTransfer(ServerAddr, "GET", g_upgrQueryLogic, undefined, false);
}
function g_upgrQueryLogic(xml){
var HeadID = "FirmwareUpgr";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var template = $("#"+templateID);
if (Head.hasError(xml) == 0)
{
var OBJID = "OBJ_FAKE_UPGR_ID";
var upgrDesc = getParaValueInXML(xml, OBJID, 0, "upgrDesc");
var needRefresh = getParaValueInXML(xml, OBJID, 0, "needRefresh");
var refreshInterval = getParaValueInXML(xml, OBJID, 0, "refreshInterval");
var willReboot = getParaValueInXML(xml, OBJID, 0, "willReboot");
var confirmMsg = $("#confirmMsg");
confirmMsg.find("p").text(upgrDesc);
if ( "true" == needRefresh )
{
setTimeout("queryUpgradeStatus()", refreshInterval);
}
else
{
if ( "true" == willReboot )
{
setTimeout("IfServerLive()", parseInt("5", 10) * 60000);
}
else
{
var waitingImgArea = $("#waitingImgArea");
waitingImgArea.hide();
var confirmOK = $("#confirmOK");
$("#confirmMsg", confirmOK.parents("#tipLayer")).addClass("updFail");
var tipLayer = $("#tipLayer");
var confirmOK = $("#confirmOK", tipLayer);
confirmOK.unbind("click");
confirmOK.bind("click", function(event){
showWaitTip(false);
});
confirmOK.show();
}
}
}
}
function g_upLoadAllowHandle(xml)
{
var HeadID = "FirmwareUpgr";
var Head = $("#"+HeadID);
if (Head.hasError(xml) == 0)
{
showWaitTip(true, "&?UpgradeQuery_006;");
$("#VersionUpload").trigger("begin_uploading_file");
}
else
{
showWaitTip(false);
}
}
$(document).ready(function(){
showWaitTip(false);
var HeadID = "FirmwareUpgr";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var template = $("#"+templateID);
var ServerAddr = "/?_type=hiddenData&_tag=upgrade_firmware";
var uploadForm = template.find("form");
uploadForm.validate({
"rules": {
"VersionUpload": {
"required": true
}
}
});
var fileURL = "/?_type=hiddenData&_tag=firmware_upgrade"
+ "&_sessionTOKEN="+document.getElementById("TOKEN_UPLOAD").value;
$("#VersionUpload").AjaxFileUpload({
action: fileURL,
onComplete: function(filename, response) {
showWaitTip(true, "&?UpgradeQuery_010;");
Head.dataTransfer(ServerAddr, "GET", g_upgrQueryLogic, undefined, false);
}
});
$("#Btn_Upload").bind("click", function(){
var msg = "&?FirmwareUpgr_006;";
if ( true == uploadForm.valid() )
{
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", function(){
var loadAllowAddr = "/?_type=hiddenData&_tag=updownload_prevent"
+ "&sessToken=" +document.getElementById("TOKEN_UPLOAD").value;
Head.dataTransfer(loadAllowAddr, "GET", g_upLoadAllowHandle, undefined, false);
});
}
});
initial_collapBarWithDataTrans(Head);
});
</script>
