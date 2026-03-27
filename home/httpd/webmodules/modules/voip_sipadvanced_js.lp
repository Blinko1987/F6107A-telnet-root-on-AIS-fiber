<script type="text/javascript">
(function(){
function initial_template_SIPAdv(templateID)
{
var template = $("#"+templateID);
$("[id^='JitMode']", template).change(function(event){
var JitModeOBJ = $(this);
var subTemplate = JitModeOBJ.parents("[id^='template_']");
var jitModeValue = JitModeOBJ.val();
var adaptJitLenOBJ = $("[id^='AdaptJitMax:'],[id^='AdaptJitMin:']", subTemplate);
var FixedJitLenOBJ = $("[id^='FixedJitLen:']", subTemplate);
if (jitModeValue == 0)
{
adaptJitLenOBJ.parent().parent().hide();
FixedJitLenOBJ.parent().parent().show();
adaptJitLenOBJ.addClass("PostIgnore");
FixedJitLenOBJ.removeClass("PostIgnore");
}
else
{
FixedJitLenOBJ.parent().parent().hide();
adaptJitLenOBJ.parent().parent().show();
adaptJitLenOBJ.removeClass("PostIgnore");
FixedJitLenOBJ.addClass("PostIgnore");
}
});
<% if (CountryCode=="85") then %>
$("[id^='DTMFMethod']", template).change(function(event){
var DTMModeOBJ = $(this);
var subTemplate = DTMModeOBJ.parents("[id^='template_']");
var DTMModeValue = DTMModeOBJ.val();
if(DTMModeValue=="1"){
$("[id^='div_RFC2833EncryptEnable']", subTemplate).show();
}
else{
$("[id^='div_RFC2833EncryptEnable']", subTemplate).hide();
$("[id^='RFC2833EncryptEnable']", subTemplate).prop("checked",false);
}
});
<% end %>
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VRTPADV_ID","OBJ_VOIPVPDTMF_ID","OBJ_VOIPDTMFAD_ID"];
ActionByCancelResult(xml, template, OBJID);
$("[id^='JitMode']", template).change();
$("[id^='DTMFMethod']", template).change();
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
var isTR104v2 = "<%=env.getenv("VoIPTR104V2") %>";
var languageTag = (isTR104v2 == 1)? "&?Tr104v2_004;" : "&?SipAdvanced_020;";
$("[id^='instName_VoIPSIPAdvConf:']", ContainerOBJ).text(languageTag+lineIndex);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
$("[id^='JitMode']", ContainerOBJ).change();
$("[id^='DTMFMethod']", ContainerOBJ).change();
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"FixedJitLen": {
"integer": true,
"required":true,
"range": [0,200]
},
"AdaptJitMin": {
"integer": true,
"required":true,
"range": [0,200],
"extremumRange":["lessThan","AdaptJitMax",{"equal" :true}]
},
"AdaptJitMax": {
"integer": true,
"required":true,
"range": [0,200],
"extremumRange":["greatThan","AdaptJitMin",{"equal" :true}]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
$(document).ready(function(){
var SIPAdvHeadID = "VoIPSIPAdvConf";
var SIPAdvHead = $("#"+SIPAdvHeadID);
var ServerAddr = $("address span", SIPAdvHead).text();
initial_template_SIPAdv("template_"+SIPAdvHeadID);
SIPAdvHead.succfunction = function(xml){
SIPAdvHead.hasError(xml);
var SIPAdvOBJ = $(xml).find("OBJ_VRTPADV_ID");
var RuleNum = $("Instance", SIPAdvOBJ).length;
var OBJID = ["OBJ_VRTPADV_ID","OBJ_VOIPVPDTMF_ID","OBJ_VOIPDTMFAD_ID"];
SIPAdvHead.createPageDataByClone(RuleNum, OBJID, xml);
};
initial_collapBarWithDataTrans(SIPAdvHead);
});
})();
</script>
