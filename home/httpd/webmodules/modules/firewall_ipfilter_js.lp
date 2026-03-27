<script type="text/javascript">
(function(){
function initial_template_IPFilter(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
SrcIP: "SourceIP SMask",
DstIP: "DestIP DMask",
SrcPort: "MinSrcPort MaxSrcPort",
DstPort: "MinDstPort MaxDstPort"
},
"rules": {
"Name": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,32]
},
"MinSrcPort": {
"integer": true,
"range":[1,65535],
"extremumRange":["lessThan","MaxSrcPort",{"equal" :true}]
},
"MaxSrcPort": {
"integer": true,
"range":[1,65535],
"extremumRange":["greatThan","MinSrcPort",{"equal" :true}]
},
"MinDstPort": {
"integer": true,
"range":[1,65535],
"extremumRange":["lessThan","MaxDstPort",{"equal" :true}]
},
"MaxDstPort": {
"integer": true,
"range":[1,65535],
"extremumRange":["greatThan","MinDstPort",{"equal" :true}]
},
"inputProtocol": {
"integer": true,
"range":[-1, 255],
},
"DSCP": {
"integer": true,
"range":[0, 63],
},
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
$("[id^='hiddenProtocol']",template).change(function(event){
var ProtocolOBJ = $(this);
var template = ProtocolOBJ.parents("[id^='template_']");
var portattribute = ProtocolOBJ.find("option:selected").attr("portattr");
var controlledOBJ = $("[id^='PortPara']", template);
var textinput = $("[id^='textinput']", template);
if (portattribute == "0")
{
showOrHideRowDiv("hide", controlledOBJ, textinput);
}
else if (portattribute == "2")
{
showOrHideRowDiv("hide", controlledOBJ);
showOrHideRowDiv("show", textinput);
}
else if (portattribute == "1")
{
showOrHideRowDiv("hide", textinput);
showOrHideRowDiv("show", controlledOBJ);
}
});
$("[id^='IPVersion']",template).change(function(event){
var IPOBJ = $(this);
var IPVersion = $(this).val();
var template = IPOBJ.parents("[id^='template_']");
var ProtocolObj = $("[id^='hiddenProtocol']",template);
var ProtocolValue = ProtocolObj.val();
var optionICMPv4 = '<option value=\"1\" title=\"ICMP\" portattr=\"0\">&?public_038;</option>';
var optionICMPv6 = '<option value=\"58\" title=\"ICMPv6\" portattr=\"0\">&?Security_075;</option>';
var optionUDP = $("option[value='17']",ProtocolObj);
var optionTCP = $("option[value='6']",ProtocolObj);
var INCViewOBJ = $("[id^='INCViewName']",template);
var OUTViewOBJ = $("[id^='OUTCViewName']",template);
var INCwanIPv6 = $("option[ipmode='2']",INCViewOBJ);
var OUTwanIPv6 = $("option[ipmode='2']",OUTViewOBJ);
var INCwanIPv4 = $("option[ipmode='1']",INCViewOBJ);
var OUTwanIPv4 = $("option[ipmode='1']",OUTViewOBJ);
if ( IPVersion == 4 )
{
if ($("option[value='58']",ProtocolObj).length > 0)
{
$("option[value='58']",ProtocolObj).remove();
}
if ($("option[value='1']",ProtocolObj).length == 0)
{
optionTCP.before(optionICMPv4);
}
INCwanIPv6.wrap("<span id='IPv6Wanc' style='display:none'></span>");
OUTwanIPv6.wrap("<span id='IPv6Wanc' style='display:none'></span>");
if($("[id^='IPv4Wanc']",template).length > 0){
INCwanIPv4.unwrap();
OUTwanIPv4.unwrap();
}
if (ProtocolValue == 58)
{
ProtocolObj.val("1" );
}
}
else if ( IPVersion == 6 )
{
if ($("option[value='1']",ProtocolObj).length > 0)
{
$("option[value='1']",ProtocolObj).remove();
}
if ($("option[value='58']",ProtocolObj).length == 0)
{
optionUDP.after(optionICMPv6);
}
INCwanIPv4.wrap("<span id='IPv4Wanc' style='display:none'></span>");
OUTwanIPv4.wrap("<span id='IPv4Wanc' style='display:none'></span>");
if($("[id^='IPv6Wanc']",template).length > 0){
INCwanIPv6.unwrap();
OUTwanIPv6.unwrap();
}
if (ProtocolValue == 1)
{
ProtocolObj.val("58");
}
}
else
{
if ($("option[value='1']",ProtocolObj).length == 0)
{
optionTCP.before(optionICMPv4);
}
if ($("option[value='58']",ProtocolObj).length == 0)
{
optionUDP.after(optionICMPv6);
}
if($("[id^='IPv6Wanc']",template).length > 0){
INCwanIPv6.unwrap();
OUTwanIPv6.unwrap();
}
if($("[id^='IPv4Wanc']",template).length > 0){
INCwanIPv4.unwrap();
OUTwanIPv4.unwrap();
}
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Name");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_FWIP_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
ContainerOBJ.collapsibleInstTitleChange("Name");
var protocol = $( "[id^='Protocol']", ContainerOBJ);
var hiddenprotocol = $( "[id^='hiddenProtocol']", ContainerOBJ);
var inputProtocol = $( "[id^='inputProtocol']", ContainerOBJ);
if ($("option[value='"+protocol.val()+"']", hiddenprotocol).length > 0)
{
hiddenprotocol.val(protocol.val());
}
else
{
hiddenprotocol.val("other");
var value = protocol.val();
inputProtocol.val(value);
}
var objStr = "[id^='MinSrcPort'],[id^='MaxSrcPort'],[id^='MinDstPort'],[id^='MaxDstPort']"
var pOBJs = $(objStr, ContainerOBJ);
pOBJs.each(function(){
if ($(this).val() == "-1" )
{
$(this).val("");
}
});
var dOBJs = $( "[id^='DSCP']", ContainerOBJ);
dOBJs.each(function(){
if ($(this).val() == "-1" )
{
$(this).val("");
}
});
var SourceIPMask = $("[id^='SourceIPMask:']",ContainerOBJ);
var SourceIPMaskOBJ = SourceIPMask.val();
var DestIPMask = $("[id^='DestIPMask:']",ContainerOBJ);
var DestIPMaskOBJ = DestIPMask.val();
if (SourceIPMaskOBJ != ""){
var smask = SourceIPMaskOBJ.substring(SourceIPMaskOBJ.lastIndexOf("\/") + 1);
$("[id^='SMask']",ContainerOBJ).val(smask);
}
if (DestIPMaskOBJ != ""){
var dmask = DestIPMaskOBJ.substring(DestIPMaskOBJ.lastIndexOf("\/") + 1);
$("[id^='DMask']",ContainerOBJ).val(dmask);
}
$("[id^='hiddenProtocol']",ContainerOBJ).change();
$("[id^='IPVersion']",ContainerOBJ).change();
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var protocol = $( "[id^='Protocol']", template);
var hiddenprotocol = $( "[id^='hiddenProtocol']", template);
var inputProtocol = $( "[id^='inputProtocol']", template);
if (hiddenprotocol.val()!="other")
{
inputProtocol.val(hiddenprotocol.val());
}
else
{
}
protocol.val(inputProtocol.val());
var SourceIP = $("[id^='SourceIP:']",template);
var SMask = $("[id^='SMask']",template);
var DestIP = $("[id^='DestIP:']",template);
var DMask = $("[id^='DMask']",template);
if (SMask && SMask.val() != ""){
$("[id^='SourceIPMask']",template).val(SourceIP.val()+"/"+SMask.val());
}
if (SMask && SMask.val() == ""){
$("[id^='SourceIPMask']",template).val("");
}
if (DMask && DMask.val() != ""){
$("[id^='DestIPMask']",template).val(DestIP.val()+"/"+DMask.val());
}
if (DMask && DMask.val() == ""){
$("[id^='DestIPMask']",template).val("");
}
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
var portNameValue = {
"MinSrcPort" : "",
"MaxSrcPort" : "",
"MinDstPort" : "",
"MaxDstPort" : "",
"DSCP": ""
};
if ( portNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "-1";
}
});
}
$(document).ready(function(){
var HeadID = "IPFilter";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_IPFilter(templateID);
var data = {};
data.template = Head;
$.callModifier("IPFilter/ipFilterModify", data);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var FWIPOBJ = $(xml).find("OBJ_FWIP_ID");
var RuleNum = $("Instance", FWIPOBJ).length;
var OBJID = ["OBJ_FWIP_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
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
