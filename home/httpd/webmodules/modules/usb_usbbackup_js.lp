<script type="text/javascript">
(function () {
var GetXml;
function initial_template_Usbbackup(templateID)
{
var Head = $("#Usbbackup");
var ServerAddr = $("address span", Head).text();
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
succHintShow(template);
}
});
$("#Apply_Usbbackup", template).click(function(event){
var OBJ = $(GetXml).find("OBJ_USBBACKUPSTORAGE_ID");
var InstNum = $("Instance", OBJ).length;
var pVal = $("#SelectPath", template).val();
var enableFlag = 0;
if (("" != pVal) && ("N/A" != pVal) && (null != pVal))
{
for (var i = 0;i < InstNum; i++ )
{
if(pVal == getParaValueInXML(GetXml, "OBJ_USBBACKUPSTORAGE_ID", i, "Path"))
{
if(1 == getParaValueInXML(GetXml, "OBJ_USBBACKUPSTORAGE_ID", i, "BakFileExist"))
enableFlag = 1;
}
}
}
if (1 == enableFlag)
{
var msg = "&?Usbbackup_004;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).unbind("click")
$("#confirmOK",confirmLayerOBJ).bind("click", template, function(event){
showWaitTip(false);
$("#StartBackup", template).val("1");
dataPost("Apply", "fillDataByApplyResult", ServerAddr, template, undefined, false);
});
}
else
{
$("#StartBackup", template).val("1");
dataPost("Apply", "fillDataByApplyResult", ServerAddr, template, undefined, false);
}
});
}
$(document).ready(function(){
var HeadID = "Usbbackup";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_Usbbackup("template_"+HeadID);
Head.succfunction = function(xml){
GetXml = xml;
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var OBJ_RESTORE = $(xml).find("OBJ_USBBACKUPSTORAGE_ID");
var InstNum = $("Instance", OBJ_RESTORE).length;
var OBJ = $(xml).find("OBJ_USBBAKRST_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_Usbbackup");
var OBJID = ["OBJ_USBBAKRST_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
$("#SelectPath").html("");
if(InstNum == 0)
{
$(".staticInfoHint").css('display','block');
}
else if(InstNum > 0)
{
for (var i = 0;i < InstNum; i++ )
{
var pValOption = getParaValueInXML(GetXml, "OBJ_USBBACKUPSTORAGE_ID", i, "Path");
var optionAppend = "<option value='"+pValOption+"'>"+pValOption+"</option>";
$("#SelectPath").append(optionAppend);
}
}
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
