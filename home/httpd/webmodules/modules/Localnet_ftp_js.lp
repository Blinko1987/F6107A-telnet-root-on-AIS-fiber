<script type="text/javascript">
(function(){
jQuery.validator.addMethod("ftpUsernameandPassword", function(value, element) {
return ( this.optional(element) || value.match("[= ]") == null );
}, $.validator.format("&?FTP_006;"));
function initial_template_LocalFtp(templateID)
{
var template = $("#"+templateID);
var checkJSONTempObj = {
"rules": {
"Username": {
"ASCII": true,
"required": true,
"rangelength":[1,256],
"ftpUsernameandPassword":true
},
"Password": {
"PasswordASCII": true,
"required": true,
"rangelength":[1,256],
"ftpUsernameandPassword":true
}
},
"messages": {
}
};
var data={};
data.checkJson = checkJSONTempObj;
data.template=template;
$.callModifier("ftp/ChangePWDRules", data);
template.setPromptCheckJSON(checkJSONTempObj, template);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_FMFTPSERVERCFG_ID", "OBJ_FMFTPUSER_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var checkedRadio = $("[name='FtpAnon']:checked", ContainerOBJ);
checkedRadio.click();
});
if(commConf.passCanSee.indexOf("Ftp") != -1){
g_ChangePass2See(template,"Password");
}
}
$(document).ready(function(){
var HeadID = "LocalFtp";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_LocalFtp("template_"+HeadID);
new CheckPwdStrengthClass("Password", "Username", "template_"+HeadID);
var ftpAnonObjs = $("[name='FtpAnon']", Head);
ftpAnonObjs.each(function(){
$(this).click(function(){
var val = $(this).val();
if ("0" == val)
{
$("#div_FTPUsername, #div_FTPPassword", Head).show();
$("#Username, #Password", Head).removeClass("PostIgnore");
}
else
{
$("#div_FTPUsername, #div_FTPPassword").hide();
$("#Username, #Password", Head).addClass("PostIgnore");
}
});
});
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_FMFTPSERVERCFG_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_LocalFtp");
var OBJID = ["OBJ_FMFTPSERVERCFG_ID", "OBJ_FMFTPUSER_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
tempobj.trigger("fillDataByCustom",[0, tempobj, xml]);
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
