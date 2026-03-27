<script type="text/javascript">
var CountryCode = "<%=env.getenv("CountryCode")%>";
(function(){
var getXml;
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("hiddenValueChangeByCustom", function(event,template){
if($("[id^='UserNameSuffix:']", template).css('display') != 'none')
{
var DigestUserNameval = $("[id^='Digesttmp']", template).val();
var suffix = $("[id^='UserNameSuffix']", template).val();
$("[id^='DigestUserName']", template).val(DigestUserNameval+suffix);
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPSIPLINE_ID","OBJ_VOIPVPLINE_ID"];
ActionByCancelResult(xml, template, OBJID);
var _instid = getParaValueInXML(xml, "OBJ_VOIPSIPLINE_ID", 0, "_InstID");
$("[id^='_InstID:']", template).val(_instid);
var _instidvp = getParaValueInXML(xml, "OBJ_VOIPVPLINE_ID", 0, "_InstID");
$("[id^='_InstIDVP:']", template).val(_instidvp);
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"AuthUserName": {
"ASCII": true,
"rangelength":[0,127]
},
"AuthPassword": {
"PasswordASCII": true,
"rangelength":[0,31]
},
"DigestUserName": {
"ASCII": true,
"rangelength":[0,127]
},
"Digesttmp": {
"ASCII": true,
"rangelength":[0,113]
},
"DirectoryNumber": {
"ASCII": true,
"rangelength":[0,31]
},
},
"messages": {
"AuthUserName": {
"ASCII": "&?public_error018;"
}
}
};
$.callModifier("VOIPbasic/UserNameASCII", checkJSONTempObj);
template.setPromptCheckJSON(checkJSONTempObj, template);
});
if(commConf.passCanSee.indexOf("VoipBasic") != -1){
g_ChangePass2See(template,"AuthPassword");
}
}
$(document).ready(function(){
var HeadID = "VOIPSipAccountConf";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var PhoneIndex = parseInt(suffix)+1;
var VOIPRegStatusBarOBJ = ContainerOBJ.find("[id^='VOIPRegStatusBar:']");
VOIPRegStatusBarOBJ.append(PhoneIndex);
var _instid = getParaValueInXML(getXml, "OBJ_VOIPSIPLINE_ID", suffix, "_InstID");
$("[id^='_InstID:']", ContainerOBJ).val(_instid);
var _instidvp = getParaValueInXML(getXml, "OBJ_VOIPVPLINE_ID", suffix, "_InstID");
$("[id^='_InstIDVP:']", ContainerOBJ).val(_instidvp);
var DigestUserNameVal = getParaValueInXML(getXml, "OBJ_VOIPSIPLINE_ID", suffix, "DigestUserName");
if($("[id^='UserNameSuffix:']", ContainerOBJ).css('display') != 'none')
{
var PostfixVal = $("[id^='UserNameSuffix:']", ContainerOBJ).val();
var PostfixIndex = DigestUserNameVal.lastIndexOf(PostfixVal);
if(PostfixIndex != -1)
{
DigestUserNameVal = DigestUserNameVal.substring(0,PostfixIndex);
}
$("[id^='Digesttmp:']", ContainerOBJ).val(DigestUserNameVal);
}
};
Head.chanegeDataByCustom =function(xml){
;
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
getXml = xml;
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_VOIPSIPLINE_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_VOIPSIPLINE_ID","OBJ_VOIPVPLINE_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
var templateID = "template_" + Head.attr("id");
var template = $("[id^='"+templateID+"_']",Head).eq(0);
$(".collapsibleBar",template).eq(0).click();
$.callModifier("VOIPbasic/hideUserName", [1]);
};
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
});
})();
</script>
