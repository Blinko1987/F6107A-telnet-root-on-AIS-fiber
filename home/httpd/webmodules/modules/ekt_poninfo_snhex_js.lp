<script type="text/javascript">
(function(){
function HexCheckPass(Key)
{
if(Key.length == 6)
{
var k = 0;
for (k = 0 ;k < 6; k++)
{
var ch = Key.charCodeAt(k);
if(ch == 9)
continue;
else
break;
}
if(k == 6)
return true;
}
for (var j = 0 ;j < Key.length; j++)
{
var ch = Key.charCodeAt(j);
if (!((ch >= 65 && ch <= 70)
||(ch >= 97 && ch <= 102)
||(ch >= 48 && ch <= 57)))
{
return false;
}
}
return true;
}
jQuery.validator.addMethod(
"HEXPASS",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if ( HexCheckPass(value) == false )
{
return false;
}
return true;
},
"&?public_error021;"
);
function initial_template_PonSn(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"Ridpw": {
"PasswordASCII": true,
"required": true,
"rangelength":[1,10]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_PWFLAG_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "PonSn";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_PonSn("template_"+HeadID);
var PwdObj = $("#Ridpw",Head);
var pwdCheckFlag = $("[name='PwFlag']", Head);
pwdCheckFlag.each(function(){
$(this).click(function(){
var val = $(this).val();
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
if ("0" == val)
{
PwdObj.rules("remove","rangelength");
PwdObj.rules("remove","HEXPASS");
PwdObj.rules("add",{"rangelength" : [1,10],"PasswordASCII": true});
PwdObj.next().text("&?public_073;1 ~ 10");
}
if("1" == val)
{
PwdObj.rules("remove","rangelength");
PwdObj.rules("remove","PasswordASCII");
PwdObj.rules("add",{"rangelength" : [1,20],"HEXPASS" : true});
PwdObj.next().text("&?public_073;1 ~ 20");
}
});
});
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
var OBJ = $(xml).find("OBJ_PWFLAG_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_PonSn");
var OBJID = ["OBJ_PWFLAG_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
if($('input[name="PwFlag"]:checked').val()=="1")
{
$("#PwFlag1").trigger("click");
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
