<script type="text/javascript">
var OperationMode = "<%=env.getenv('OperationMode')%>";
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"BsSSIDName0": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
},
"BsSSIDName1": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
},
"BsSSIDName2": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
},
"BsSSIDName3": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_AIS_BANDSTEERING_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var SSIDSyncStr = "";
for(let i=0;i<4;i++)
{
if($("#BsSSIDEnable" + i + "1").is(":checked"))
{
SSIDSyncStr = "1" + SSIDSyncStr;
}
else
{
SSIDSyncStr = "0" + SSIDSyncStr;
}
}
$("#SSIDSync").val(parseInt(SSIDSyncStr,2));
});
template.bind("fillDataByCustom", function(event, suffix, template, xml){
var SSIDNameList = {}
var SSIDOBJ = $(xml).find("OBJ_WLANAP_ID");
var Instance = $("Instance", SSIDOBJ);
Instance.each(function(i){
var ssidNum = parseInt(i);
var inst = $(this);
var ssidIndex = "";
var SSIDName = "";
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if( ParaName == "_InstID" )
ssidIndex = ParaValue
else if ( ParaName == "ESSID" )
SSIDName = ParaValue
});
SSIDNameList["SSID" + ssidIndex[ssidIndex.length-1]] = SSIDName;
});
var SSIDSync = getParaValueInXML(xml, "OBJ_AIS_BANDSTEERING_ID", 0, "SSIDSync");
SSIDSync = parseInt(SSIDSync).toString(2);
var SSIDSyncLen = SSIDSync.length;
for(let i=0;i<4-SSIDSyncLen;i++)
{
SSIDSync = "0" + SSIDSync;
}
SSIDSync = SSIDSync.split("").reverse().join("");
var SSIDSyncByte = "";
for(let i=0;i<4;i++)
{
SSIDSyncByte = SSIDSync[i];
if(SSIDSyncByte=="1")
{
$("#BsSSIDEnable" + i + "1").prop("checked","checked");
$("#BsSSIDName" + i).val(SSIDNameList["SSID"+(i+1)]);
$("#BsSSIDName" + i).disableIt(false);
$("#BsSSIDName" + i).removeClass("PostIgnore");
}
else
{
$("#BsSSIDEnable" + i + "0").prop("checked","checked");
$("#BsSSIDName" + i).val("aisfibre_" + (i+1));
$("#BsSSIDName" + i).disableIt(true);
$("#BsSSIDName" + i).addClass("PostIgnore");
}
}
if(OperationMode == "3")
{
$("[id^='BsSSIDName']").disableIt(true);
}
});
$("[id^='BsSSIDEnable'][type='radio']",template).click(function(){
var thisID = $(this).attr("id");
var thisName = $(this).attr("name");
var ssidName = thisID.substring(0,thisID.length-1).replace("Enable","Name");
var ssidNameObj = $("[id^='"+ssidName+"']",template);
if($(this).val()=="1"){
ssidNameObj.disableIt(false);
ssidNameObj.removeClass("PostIgnore");
}
else{
ssidNameObj.disableIt(true);
ssidNameObj.val("aisfibre_" + thisName[thisName.length-2]);
ssidNameObj.addClass("PostIgnore");
}
});
}
$(document).ready(function(){
var HeadID = "WlanBandSteering";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_AIS_BANDSTEERING_ID"];
var template = $("[id^='template_']",Head);
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
template.trigger("fillDataByCustom",[0, template, xml]);
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
