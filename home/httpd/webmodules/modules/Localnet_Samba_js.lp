<script type="text/javascript">
(function(){
function checkPassConfirm(template)
{
var msg = "&?msgpassword;";
var confirmLayerOBJ = IniConfirm(msg);
$("#confirmOK",confirmLayerOBJ).bind("click", function(event) {
$("#Btn_apply_Samba",template).click();
});
}
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"NetbiosName": {
"required":true,
"rangelength":[2,15],
"HostName": true
}
},
"messages": {
}
});
$("#AuthType").click(function(){
var AuthType = $("input[name=AuthType]:checked").val();
if ( AuthType == 0)
{
$("[id^='template_UserConf_']",template).showIt(false);
$("[id^='UserName_']",template).addClass("PostIgnore");
$("[id^='PassWord_']",template).addClass("PostIgnore");
$("[id^='UserEnable_']",template).addClass("PostIgnore");
$("[id^='UserRight_']",template).addClass("PostIgnore");
}
else
{
$("[id^='template_UserConf_']",template).showIt(true);
$("[id^='UserName_']",template).removeClass("PostIgnore");
$("[id^='PassWord_']",template).removeClass("PostIgnore");
$("[id^='UserEnable_']",template).removeClass("PostIgnore");
$("[id^='UserRight_']",template).removeClass("PostIgnore");
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_SAMBACFG_ID"];
ActionByCancelResult(xml, template, OBJID);
var OBJ = $(xml).find("OBJ_SAMBAUSER_ID");
var RuleNum = $("Instance", OBJ).length;
for (var i=0; i<RuleNum; i++)
{
var ruleTemplate = $("[id^='template_UserConf_"+i+"']",template);
var DataOBJID = ["OBJ_SAMBAUSER_ID"];
ruleTemplate.fillDataByOBJID(xml, DataOBJID, ruleTemplate, i, "_");
}
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
var EnableSmb = $("#EnableSmb",ContainerOBJ).val();
var AutoRun = $("#AutoRun",ContainerOBJ).val();
var RadioChecked;
if ( AutoRun == 1 )
{
RadioChecked = 1;
}
else
{
if ( EnableSmb == 1 )
{
RadioChecked = 2;
}
else
{
RadioChecked = 3;
}
}
var radioObj = $("input[type=radio]", $("#SambaSwitch",ContainerOBJ));
radioObj.each(function(){
var thisObj = $(this);
if (thisObj.val() == RadioChecked)
{
thisObj.prop("checked", true);
}
else
{
thisObj.prop("checked",false);
}
});
var AuthTypeOBJ = $("#AuthType");
$("input[type=radio]", AuthTypeOBJ).each(function(){
var AuthTypeRadio = $(this);
if (AuthTypeRadio.is(':checked'))
{
AuthTypeRadio.change();
}
});
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var EnableSmbObj = $("#EnableSmb",template);
var AutoRunObj = $("#AutoRun",template);
var RadioChecked = $('input:radio[name="SambaSwitch"]:checked').val();
if ( RadioChecked == 3 )
{
EnableSmbObj.val(0);
AutoRunObj.val(0);
}
else if ( RadioChecked == 2 )
{
EnableSmbObj.val(1);
AutoRunObj.val(0);
}
else if ( RadioChecked == 1 )
{
EnableSmbObj.val(0);
AutoRunObj.val(1);
}
else
{
consoleLog("SambaSwitch Value is illegal["+RadioChecked+"]");
}
});
if(commConf.passCanSee.indexOf("Samba") != -1){
g_ChangePass2See(template,"PassWord");
}
}
$(document).ready(function(){
var HeadID = "Samba";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_SAMBACFG_ID"];
var template = $("#"+templateID);
Head.fillDataByOBJID(xml, OBJID, template, 0);
template.trigger("fillDataByCustom",[0, template]);
var OBJ = $(xml).find("OBJ_SAMBAUSER_ID");
var RuleNum = $("Instance", OBJ).length;
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
var ruleTemplate = $("#template_UserConf");
var clone = ruleTemplate.cloneWithSuffix(i, "_");
var DataOBJID = ["OBJ_SAMBAUSER_ID"];
ruleTemplate.before(clone);
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
clone.showIt(true);
new CheckPwdStrengthClass("PassWord", "UserName", "template_UserConf_"+i);
}
if(RuleNum != 0)
{
$("[id^='UserName_']",Head).each(function(){
$(this).rules("add",{
"required":true,
"ASCII": true,
"rangelength":[1,8]
});
});
$("[id^='PassWord_']",Head).each(function(){
$(this).rules("add",{
"PasswordASCII": true,
"rangelength":[0,32]
});
});
$("#AuthType").click();
$("[id^='UserEnable']",template).addClass("PostIgnore");
$("[id^='UserRight']",template).addClass("PostIgnore");
}
}
$.publish("/some/displayParams", [template]);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
