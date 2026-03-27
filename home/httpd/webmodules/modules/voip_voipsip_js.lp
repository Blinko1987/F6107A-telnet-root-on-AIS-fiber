<script type="text/javascript">
var CountryCode = "<%=env.getenv("CountryCode")%>";
(function(){
var getXml;
var isTR104v2 = "<%=env.getenv("VoIPTR104V2") %>";
function initial_template(templateID)
{
var template = $("#"+templateID);
jQuery.validator.addMethod("protocolFormat", function(value, element) {
var mediaCodecs = ["G711A", "G711U", "G729", "G722"];
var userInputArr = value.split(",");
var valArr = [];
for(var i=0;i<userInputArr.length;i++){
valArr[i] = userInputArr[i].replace(/(^\s*)|(\s*$)/g, "");
}
if(valArr.sort().toString() == mediaCodecs.sort().toString())
return true;
return false;
}, "&?Tr104v2_006;");
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"UserAgentPort": {
"required":true,
"integer": true,
"range":[1024,65535]
},
"ProxyServerPort1": {
"required":true,
"integer": true,
"range":[1024,65535]
},
"ProxyServerPort2": {
"required":true,
"integer": true,
"range":[1024,65535]
},
"RegisterExpires": {
"required":true,
"integer": true,
"range":[1,4294967295]
},
"StartTimer": {
"required":true,
"integer": true,
"range":[1500,6000]
},
"LinkTestInterval": {
"required":true,
"integer": true,
"range":[1,4294967295]
},
"InviteExpires": {
"integer": true,
"required":true,
"range":[1,4294967295]
}
},
"messages": {
}
};
if(isTR104v2 == 1){
checkJSONTempObj.rules.CodecList_ = {
"required":true,
"protocolFormat": true
};
}
template.setPromptCheckJSON(checkJSONTempObj, template);
});
$("[id^='Opt120FlagControl']",template).click(function(){
var subTemplate = $(this).parents("[id^='template_VoIPSIP']");
if ($("[id^='Opt120FlagControl1']",subTemplate).is(':checked'))
{
$("[id^='RegistrarServer1']", subTemplate).attr("disabled","true");
$("[id^='ProxyServer1']", subTemplate).attr("disabled","true");
$("[id^='OutboundProxy1']", subTemplate).attr("disabled","true");
$("[id^='RegistrarServer2']", subTemplate).attr("disabled","true");
$("[id^='ProxyServer2']", subTemplate).attr("disabled","true");
$("[id^='OutboundProxy2']", subTemplate).attr("disabled","true");
}
else
{
$("[id^='RegistrarServer1']", subTemplate).removeAttr("disabled");
$("[id^='ProxyServer1']", subTemplate).removeAttr("disabled");
$("[id^='OutboundProxy1']", subTemplate).removeAttr("disabled");
$("[id^='RegistrarServer2']", subTemplate).removeAttr("disabled");
$("[id^='ProxyServer2']", subTemplate).removeAttr("disabled");
$("[id^='OutboundProxy2']", subTemplate).removeAttr("disabled");
}
});
template.bind("hiddenValueChangeByCustom", function(event,template,actionType){
if(isTR104v2 == 1){
var mediaCodecs = ["G711A", "G711U", "G729", "G722"];
var CodecList_Val = $("[id^='CodecList_']", template).val();
var arrsToPost = CodecList_Val.split(",");
var postArrs = [];
for(var i=0; i<arrsToPost.length; i++){
postArrs[i] = ".CodecProfile." + ( $.inArray(arrsToPost[i].replace(/(^\s*)|(\s*$)/g, ""), mediaCodecs) + 1 );
}
$("[id^='CodecList:']", template).val(postArrs.join(","));
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPSIP_ID","OBJ_VOIPSIPSERVER_ID","OBJ_VOIPBEARINFO_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ,xml){
var lineIndex = parseInt(suffix, 10)+1;
if(CountryCode == "138")
{
$("[id^='ProxyServer1:']",ContainerOBJ).attr("disabled",true);
$("[id^='OutboundProxy1:']",ContainerOBJ).attr("disabled",true);
}
if($("[id^='div_Opt120FlagControl:']", ContainerOBJ).css('display') != 'none')
{
$("[id^='Opt120FlagControl:']",ContainerOBJ).click();
}
var languageTag = (isTR104v2 == 1) ? "&?Tr104v2_004;" : "&?SipAdvanced_020;";
$("[id^='instName_VoIPSIP:']", ContainerOBJ).text(languageTag+lineIndex);
var _instidsip = getParaValueInXML(getXml, "OBJ_VOIPSIP_ID", suffix, "_InstID");
$("[id^='_InstID:']", ContainerOBJ).val(_instidsip);
var _instid = getParaValueInXML(getXml, "OBJ_VOIPDMTIMER_ID", suffix, "_InstID");
$("[id^='_InstIDTIMER:']", ContainerOBJ).val(_instid);
var _instidbearinfo = getParaValueInXML(getXml, "OBJ_VOIPBEARINFO_ID", suffix, "_InstID");
$("[id^='_InstIDBEARINFO:']", ContainerOBJ).val(_instidbearinfo);
var CodecListXMLOrigin = $("[id^='CodecList:']", ContainerOBJ).val().split(",");
var CodecListXMLArrs = [];
for(var i=0;i<CodecListXMLOrigin.length;i++){
CodecListXMLArrs[i] = CodecListXMLOrigin[i].substr(14, 1);
}
var mediaCodecs = ["G711A", "G711U", "G729", "G722"];
var mediacodecValArrs = [];
for(var i = 0; i < mediaCodecs.length; i++){
mediacodecValArrs[i] = mediaCodecs[CodecListXMLArrs[i]-1];
}
$("[id^='CodecList_']", ContainerOBJ).val( mediacodecValArrs.join(",") );
$("input[type='radio'][name^='Timer']",ContainerOBJ).change();
});
$("input[type='radio'][name^='Timer']",template).change(function() {
var iTemplate = $(this).parents("[id^='template_']");
if($(this).is(":checked")){
if($(this).val() == "0"){
$("[id^='InviteExpires:']",iTemplate).disableIt(true);
}else{
$("[id^='InviteExpires:']",iTemplate).disableIt(false);
}
}
});
}
$(document).ready(function(){
var HeadID = "VoIPSIP";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml);
getXml = xml;
var OBJ = $(xml).find("OBJ_VOIPSIP_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPDMTIMER_ID","OBJ_VOIPSIP_ID","OBJ_VOIPSIPSERVER_ID","OBJ_VOIPBEARINFO_ID"];
Head.createPageDataByClone(RuleNum, OBJID, xml);
};
initial_collapBarWithDataTrans(Head);
});
})();
</script>
