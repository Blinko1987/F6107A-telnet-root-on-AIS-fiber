<script type="text/javascript">
(function () {
function initial_template_AISBackUpToServer() {
var HeadID = "AISBackUpToServer";
var Head = $("#" + HeadID);
var template = $("#template_" + HeadID);
var backupAddr = "/?_type=menuData&_tag=backupCfg_to_server_lua.lua";
var nullCount = 0;
function GetStatus(xml) {
dataPost("GetStatus", "actionAfterGetStatus", backupAddr, template, undefined, false);
}
template.unbind("actionAfterGetStatus");
template.bind("actionAfterGetStatus", function (event, xml, temp) {
var tipList =
{
"upload_start": "&?pro_standard_023;",
"upload_fail": "&?pro_standard_024;",
"success": "&?pro_standard_025;",
"": "&?pro_standard_023;"
}
var ToOperParaArray = {
"UploadStatus": {
ValueOrigin: ""
},
};
xmlParaInInstOperate(xml, "OBJ_CFGAROUNDSERVER_ID", 0, ToOperParaArray);
var UploadStatus = ToOperParaArray["UploadStatus"].ValueOrigin;
var tipStr = tipList[UploadStatus];
var confirmLayerOBJ = $("#confirmLayer");
$("#confirmMsg p", confirmLayerOBJ).text(tipStr);
switch (UploadStatus) {
case "":
nullCount++;
if(nullCount >= 3){
nullCount = 0;
$("#confirmMsg p", confirmLayerOBJ).text("&?pro_standard_024;");
$("#waitingImgArea", confirmLayerOBJ).hide();
$("#confirmOK", confirmLayerOBJ).show();
break;
}
$("#waitingImgArea", confirmLayerOBJ).show();
setTimeout(function () {
GetStatus(xml);
}, 1000);
break;
case "upload_start":
$("#waitingImgArea", confirmLayerOBJ).show();
setTimeout(function () {
GetStatus(xml);
}, 1000);
break;
default:
nullCount = 0;
$("#waitingImgArea", confirmLayerOBJ).hide();
$("#confirmOK", confirmLayerOBJ).show();
}
});
template.bind("actionAfterTrigger", function (event, xml, temp) {
if (Head.hasError(xml) == 0) {
succHintShow(template);
} else {
showWaitTip(false);
}
});
template.bind("actionInit", function (event, xml, temp) {
if (Head.hasError(xml) == 0) {
var OBJID = ["OBJ_CFGAROUNDSERVER_ID"];
Head.fillDataByOBJID(xml, OBJID, Head, 0);
}
});
}
$(document).ready(function () {
showWaitTip(false);
var HeadID = "AISBackUpToServer";
var Head = $("#" + HeadID);
var template = $("#template_" + HeadID);
var backupAddr = "/?_type=menuData&_tag=backupCfg_to_server_lua.lua";
initial_template_AISBackUpToServer();
$("#Btn_BackUpToServer").bind("click", function () {
dataPost("Trigger", "actionAfterTrigger", backupAddr, template, undefined, false);
});
dataPost("GetStatus", "actionInit", backupAddr, template, undefined, false);
});
})();
</script>
