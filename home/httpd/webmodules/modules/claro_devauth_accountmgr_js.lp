<script type="text/javascript">
(function(){
function hidePassLevelNote(template)
{
var passLevelOBJ = $("[id^='pwStrth']", template);
passLevelOBJ.text("");
passLevelOBJ.attr("class", "");
passLevelOBJ.css("display","none");
}
function customRuleFuncClaro(o,v)
{
var myTplt = o.closest("[id^=template_]");
var relVal = $("[id^='Username']", myTplt).val();
var r = {
txt: "&?public_172;",
aClass: "redFont"
};
if(/[a-z]/.test(v) &&
/[A-Z]/.test(v) &&
/[0-9]/.test(v) &&
/[`~!@#\$%\^&\*\(\)_\+\-=\[\]\{\}\'\;\,\./:\"\?><\\\| ]/.test(v) &&
(v.length >= 10) &&
(v != relVal && v != relVal.split("").reverse().join("")))
{
r.txt = "";
}
return r;
};
jQuery.validator.addMethod(
"chkPassClaro",
function(val,element)
{
var myTplt = element.closest("[id^=template_]");
var relVal = $("[id^='Username']", myTplt).val();
if(/[a-z]/.test(val) &&
/[A-Z]/.test(val) &&
/[0-9]/.test(val) &&
/[`~!@#\$%\^&\*\(\)_\+\-=\[\]\{\}\'\;\,\./:\"\?><\\\| ]/.test(val) &&
(val.length >= 10) &&
(val != relVal && relVal != val.split("").reverse().join("")))
{
return true;
}
return false;
},
$.validator.format("&?public_error067;")
);
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
if (ActionByApplyResult(xml, template) == 0){
$("[id^='Password'],[id^='NewPassword'],[id^='NewConfirmPassword']",template).val("");
hidePassLevelNote(template);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
if (ActionByCancelResult(xml, template, ["OBJ_USERINFO_ID"]) == 0){
$("[id^='Password'],[id^='NewPassword'],[id^='NewConfirmPassword']",template).val("");
hidePassLevelNote(template);
}
});
template.bind("applyPromptCheckJSON", function(event, template){
var NewID = "[id^='"+ $("[id^='NewPassword']",template).attr("id")+"']";
var checkJSONTempObj = {
"rules": {
"Username": {
"required": true,
"ASCII": true,
"rangelength":[1,256]
},
"NewPassword": {
"ASCII": true,
required: true,
"chkPassClaro":true,
},
"NewConfirmPassword": {
"ASCII": true,
"equalTo": NewID,
"chkPassClaro":true,
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var AccountManagBarOBJ = ContainerOBJ.find("[id^='AccountManagBar']");
var AccountRight = ContainerOBJ.find("[id^='Right']").val();
var UsernameOBJ = ContainerOBJ.find("[id^='Username']");
UsernameOBJ.removeAttr("disabled");
var DivPasswordOBJ = ContainerOBJ.find("[id^='div_password']");
DivPasswordOBJ.css("display", "none");
var PasswordOBJ = ContainerOBJ.find("[id^='Password']");
if ( AccountRight == "1")
{
AccountManagBarOBJ.text("&?AccountManag_007;");
if("<%=Right%>" == "1")
{
UsernameOBJ.attr("disabled","true");
DivPasswordOBJ.css("display", "");
}
}
else if ( AccountRight == "2" )
{
AccountManagBarOBJ.text("&?AccountManag_support;");
if("<%=Right%>" == "2"||"<%=Right%>" == "3")
{
UsernameOBJ.attr("disabled","true");
DivPasswordOBJ.css("display", "");
}
}
else
{
AccountManagBarOBJ.text("&?AccountManag_008;");
if("<%=Right%>" == "4")
{
UsernameOBJ.attr("disabled","true");
DivPasswordOBJ.css("display", "");
}
}
});
}
$(document).ready(function(){
var HeadID = "AccountManag";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
var tmpPrompt = "&?userInfoModify_claro_001;";
new CheckPwdStrengthClass("NewPassword", "Username", "template_"+HeadID, customRuleFuncClaro, tmpPrompt);
Head.createAccountPageDataByClone = function(RuleNum,DataOBJID,xml,fillDataByCustom){
var Head = $(this);
var HeadID = Head.attr("id");
var TemplateOBJ = $("#template_"+HeadID);
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
if(1==i&& ("2" == "<%=Right%>"||"3" == "<%=Right%>"))
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
};
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
});
})();
</script>
