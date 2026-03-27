<script type="text/javascript">
(function () {
function init_template_AISRestoreFromServer() {
var HeadID = "AISRestoreFromServer";
var Head = $("#" + HeadID);
var template = $("#template_" + HeadID);
var backupAddr = "/?_type=menuData&_tag=restoreCfg_from_server_lua.lua";
var nullCount = 0;
function GetStatus(xml) {
dataPost("GetStatus", "actionAfterGetStatus", backupAddr, template, undefined, false);
}
function IfServerLive()
{
Head.succfunction = function(xml){
Head.hasError(xml);
showWaitTip(false);
return;
};
Head.failfunction = function(XMLHttpRequest,textStatus){
setTimeout("IfServerLive()", 30000);
};
Head.dataTransfer(backupAddr, "GET", Head.succfunction,
Head.failfunction, false);
}
template.unbind("actionAfterGetStatus");
template.bind("actionAfterGetStatus", function (event, xml, template) {
var tipList =
{
"download_start": "&?pro_standard_026;",
"download_fail": "&?pro_standard_027;",
"incorrect_file": "&?pro_standard_028;",
"decrypt_fail": "&?pro_standard_029;",
"flash_fail": "&?pro_standard_030;",
"success": "&?pro_standard_031;",
"":"&?pro_standard_026;"
}
var ToOperParaArray = {
"DownloadStatus": {
ValueOrigin: ""
},
};
xmlParaInInstOperate(xml, "OBJ_CFGAROUNDSERVER_ID", 0, ToOperParaArray);
var DownloadStatus = ToOperParaArray["DownloadStatus"].ValueOrigin;
var tipStr = tipList[DownloadStatus];
var confirmLayerOBJ = $("#confirmLayer");
$("#confirmMsg p", confirmLayerOBJ).text(tipStr);
switch (DownloadStatus) {
case "":
nullCount++;
if(nullCount >= 3)
{
nullCount = 0;
$("#confirmMsg p", confirmLayerOBJ).text("&?pro_standard_027;");
$("#waitingImgArea", confirmLayerOBJ).hide();
$("#confirmOK", confirmLayerOBJ).show();
break;
}
$("#waitingImgArea", confirmLayerOBJ).show();
setTimeout(function () {
GetStatus(xml);
}, 1000);
break;
case "download_start":
$("#waitingImgArea", confirmLayerOBJ).show();
setTimeout(function () {
GetStatus(xml);
}, 1000);
break;
case "success":
nullCount = 0;
$("#confirmMsg p", confirmLayerOBJ).text("&?UpgradeQuery_008;");
$("#waitingImgArea", confirmLayerOBJ).show();
setTimeout("IfServerLive()", parseInt("1", 10) * 60000);
break;
default:
nullCount = 0;
$("#waitingImgArea", confirmLayerOBJ).hide();
$("#confirmOK", confirmLayerOBJ).show();
}
})
template.bind("actionAfterTrigger", function (event, xml, template) {
if (Head.hasError(xml) == 0) {
succHintShow(template);
var msg = "&?pro_standard_026;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmCancel", confirmLayerOBJ).hide();
$("#confirmOK", confirmLayerOBJ).hide();
$("#confirmOK", confirmLayerOBJ).bind("click", function (event) {
showWaitTip(false);
});
setTimeout(function () {
GetStatus(xml);
}, 1000);
}
else {
showWaitTip(false);
}
});
template.bind("actionInit", function (event, xml, template) {
if (Head.hasError(xml) == 0) {
var OBJID = ["OBJ_CFGAROUNDSERVER_ID"];
Head.fillDataByOBJID(xml, OBJID, template, 0);
}
});
}
$(document).ready(function () {
var HeadID = "AISRestoreFromServer";
var Head = $("#" + HeadID);
var template = $("#template_" + HeadID);
var backupAddr = "/?_type=menuData&_tag=restoreCfg_from_server_lua.lua";
init_template_AISRestoreFromServer();
showWaitTip(false);
dataPost("GetStatus", "actionInit", backupAddr, template, undefined, false);
$("#Btn_RestoreFromServer").bind("click", function () {
dataPost("Trigger", "actionAfterTrigger", backupAddr, template, undefined, false);
});
});
})();
</script>
