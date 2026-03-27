<script type="text/javascript">
(function(){
function hidePassLevelNote(template)
{
var passLevelOBJ = $("[id^='pwStrth']", template);
passLevelOBJ.text("");
passLevelOBJ.attr("class", "");
passLevelOBJ.css("display","none");
}
jQuery.validator.addMethod(
"chkKeyword",
function(value, element)
{
if (value.match("[^0-9a-zA-Z,.? _-]") != null)
return false;
return true;
},
$.validator.format("&?public_error055;")
);
function checkPasswordString(sz)
{
if(/[^0-9]/g.test(sz) == false)
{
return -1;
}
else if(/[a-z]/.test(sz) && /[A-Z]/.test(sz) && /[0-9]/.test(sz))
{
return -2;
}
else
{
return -3;
}
}
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
if (ActionByApplyResult(xml, template) == 0){
$("[id^='Password'],[id^='NewPassword'],[id^='NewConfirmPassword']",template).val("");
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
if (ActionByCancelResult(xml, template, ["OBJ_USERINFO_ID"]) == 0){
$("[id^='Password'],[id^='NewPassword'],[id^='NewConfirmPassword']",template).val("");
}
});
template.bind("hiddenValueChangeByCustom", function(event,template){
$("[id^='NewConfirmPassword']",template).addClass("PostIgnore");
});
template.bind("applyPromptCheckJSON", function(event, template){
var NewID = "[id^='"+ $("[id^='NewPassword']",template).attr("id")+"']:not(.PostIgnore)";
var checkJSONTempObj = {
"rules": {
"Username": {
"required": true,
"ASCII": true,
"rangelength":[1,256]
},
"NewConfirmPassword": {
"ASCII": true,
"equalTo": NewID
},
"NewPassword": {
"ASCII": true,
<%
if _G.commConf.ChgpwdStrong then
%>
"ChkPass": true,
<%
end
%>
"required": true
}
},
"messages": {
}
};
$.publish("/some/AccountPwdChk", [template]);
$.publish("/some/ChangeRules", [checkJSONTempObj]);
var data={};
data.checkJson = checkJSONTempObj;
data.template=template;
$.callModifier("devAccount/ChangePWDRules", data);
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var AccountManagBarOBJ = ContainerOBJ.find("[id^='AccountManagBar']");
var AccountRight = ContainerOBJ.find("[id^='Right']").val();
var UsernameOBJ = ContainerOBJ.find("[id^='Username']");
UsernameOBJ.disableIt(false);
var DivPasswordOBJ = ContainerOBJ.find("[id^='div_password']");
DivPasswordOBJ.css("display", "none");
var PasswordOBJ = ContainerOBJ.find("[id^='Password']");
if ( AccountRight == "1")
{
AccountManagBarOBJ.text("&?AccountManag_007;");
if(<%=Right%> == "1")
{
DivPasswordOBJ.css("display", "");
}
}
else if ( AccountRight == "2" )
{
AccountManagBarOBJ.text("&?AccountManag_008;");
if(<%=Right%> == "2"||<%=Right%> == "3")
{
DivPasswordOBJ.css("display", "");
}
}
else
{
AccountManagBarOBJ.text("&?AccountManag_009;");
if(<%=Right%> == "4")
{
DivPasswordOBJ.css("display", "");
}
}
});
if(commConf.passCanSee.indexOf("AccountMgr") != -1){
g_ChangePass2See(template,"Password");
g_ChangePass2See(template,"NewPassword");
g_ChangePass2See(template,"NewConfirmPassword");
}
}
$(document).ready(function(){
var HeadID = "AccountManag";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
var data={};
data.relatParam = "Username";
data.func="";
data.strTips="&?public_174;";
$.callModifier("devAccount/StrongChangeTips",data)
new CheckPwdStrengthClass("NewPassword", data.relatParam, "template_"+HeadID, data.func, data.strTips, data.minLongth);
Head.createAccountPageDataByClone = function(RuleNum,DataOBJID,xml,fillDataByCustom){
var Head = $(this);
var HeadID = Head.attr("id");
var TemplateOBJ = $("#template_"+HeadID);
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
if(1==i&& ("2" == <%=Right%>||"3" == <%=Right%>))
{
return;
}
if(0 == getParaValueInXML(xml, "OBJ_USERINFO_ID", i, "Enable"))
{
continue;
}
var clone = TemplateOBJ.cloneWithSuffix(i);
TemplateOBJ.before(clone);
clone.fillDataByOBJID(xml ,DataOBJID, clone, i);
if ( $.isFunction(fillDataByCustom) )
{
fillDataByCustom(i,clone);
}
else
{
clone.trigger("fillDataByCustom",[i,clone]);
}
$("[id^='Password']",Head).val("");
clone.showIt(true);
}
var lastAccObj = $("[id^='template_AccountManag_']:last", Head);
lastAccObj.find(".fakeHeadDIV").remove();
}
Head.chanegeDataByCustom =function(xml){
;
};
Head.succfunction = function(xml){
if (Head.hasError(xml,"externErrorHint") == 0)
{
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_USERINFO_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_USERINFO_ID"];
Head.createAccountPageDataByClone(RuleNum,OBJID,xml);
}
var templateID = "template_" + Head.attr("id");
var template = $("[id^='"+templateID+"_']",Head).eq(0);
$(".collapsibleBar",template).eq(0).click();
$.publish("/some/ctcHideUser", [Head]);
};
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
$.publish("/some/showTips4Viettel", [$("[id^='template_AccountManag_']")]);
});
})();
</script>
