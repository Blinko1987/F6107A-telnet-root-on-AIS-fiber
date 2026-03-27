<script type="text/javascript">
(function(){
var UserTypeTarget =
{
"0" : "&?Ddns_011;",
"1" : "&?Ddns_012;",
"2" : "&?Ddns_013;",
"3" : "&?Ddns_014;"
};
var StatusTarget =
{
"Disconnected": "&?Ddns_016;",
"Connecting" : "&?Ddns_017;",
"Connected" : "&?Ddns_018;",
"ConnectFail" : "&?Ddns_019;"
};
function set_Ddns_switch(template, val)
{
var radioObj = $("[name^='Enable']",template);
radioObj.each(function(){
var thisObj = $(this);
if (val == thisObj.val())
{
thisObj.prop("checked", true);
}
else
{
thisObj.prop("checked", false);
}
});
}
function initial_check_even(template)
{
template.bind("applyPromptCheckJSON", function(event, template)
{
var checkJSONTempObj = {
"rules": {
"Username": {
"required": true,
"ASCII": true,
"rangelength":[1,256]
},
"Password": {
"PasswordASCII": true,
"rangelength":[1,256]
},
"phddns_Username": {
"required": true,
"ASCII": true,
"rangelength":[5,16]
},
"phddns_Password": {
"PasswordASCII": true,
"rangelength":[6,16]
},
"DomainName": {
"required": true,
"rangelength":[1,64]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
function initial_template_Ddns(templateID)
{
var template = $("#"+templateID);
initial_check_even(template);
$("[id^='Provider']").change();
template.bind("fillDataByApplyResult", function(event,xml, template){
var OBJID = ["OBJ_DDNSCLIENT_ID"];
ActionByApplyResult(xml, template);
template.fillDataByOBJID(xml, OBJID, template, 0);
template.trigger("fillDataByCustom",[0, template, xml]);
var modifingInstNum = $("[id^='_InstID']").eq(-2).val().substr(9);
var currentInstNameSpan = $("[id^='instName']", template);
if(currentInstNameSpan.text() == "New Item"){
currentInstNameSpan.text(modifingInstNum);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
if($("[id^='_InstID']",template).val() == ""){
template.remove();
return;
}
var OBJID = ["OBJ_DDNSCLIENT_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
$("[id^='Provider']",template).change();
});
template.bind("fillDataByDeleteResult", function(event,xml, template){
template.remove();
});
template.bind("hiddenValueChangeByCustom", function(event,template,actionType){
var ProviderSelected = $("[id^='Provider']",template).find("option:selected");
var serviceNameSelected = ProviderSelected.val();
var serviceInstSelected = ProviderSelected.attr("serviceinst");
var serviceUrl = $("[id^='serviceUrl']",template).val();
ProviderSelected.attr("serviceurl", serviceUrl)
$("[id^='Name']",template).val(serviceNameSelected);
$("[id^='serviceInst']",template).val(serviceInstSelected);
$("[id^='Service']",template).val(serviceNameSelected);
if ($("[id^='Service']",template).val() == "phddns")
{
var UsernameObj = $("[id^='Username']",template);
var PasswordObj = $("[id^='Password']",template);
var phddnsUsernameObj = $("[id^='phddns_Username']",template);
var phddnsPasswordObj = $("[id^='phddns_Password']",template);
UsernameObj.val(phddnsUsernameObj.val());
PasswordObj.val(phddnsPasswordObj.val());
if (actionType == "Apply")
{
set_Ddns_switch(template, "1");
}
if (actionType == "Cancel")
{
set_Ddns_switch(template, "0");
}
}
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var serviceValue = $("[id^='Service']",ContainerOBJ).val();
var provider = $("[id^='Provider']",ContainerOBJ);
if ( serviceValue == "" )
{
serviceValue = $("option",provider).eq(0).val();
}
provider.val(serviceValue);
$("[id^='Provider']",ContainerOBJ).change();
var ret1 = "&?Ddns_020;";
var DDNSStatus = $("#Status",ContainerOBJ).val();
if (StatusTarget[DDNSStatus])
{
ret1 = StatusTarget[DDNSStatus];
}
$("#StatusStr",ContainerOBJ).text(ret1);
$("#StatusStr",ContainerOBJ).attr("title", ret1);
template.trigger("fillDomainByCustom",[xml]);
var ret2 = "---";
var UserTypeNum = $("#UserType",ContainerOBJ).val();
if (UserTypeTarget[UserTypeNum])
{
ret2 = UserTypeTarget[UserTypeNum];
}
$("#UserTypeStr",ContainerOBJ).val(ret2);
});
$("[id^='Provider']",template).change(function(event){
var provider = $(this);
var template = provider.parents("[id^='template_']");
var providerSelected = provider.find("option:selected");
var serUrlSelected = providerSelected.attr("serviceurl");
var providerURL = $("[id^='serviceUrl']",template);
providerURL.val(serUrlSelected);
var provideTmp = providerSelected.val();
var domainNameLabel = $("label[for^='DomainName']",template).eq(0);
var domainNameDiv = $("[id^='div_DomainName']",template);
switch (provideTmp)
{
case "DtDNS":
case "phddns":
{
showOrHideRowDiv("hide", domainNameDiv);
$("#DomainName").addClass("PostIgnore");
break;
}
case "dipc":
{
showOrHideRowDiv("show", domainNameDiv);
$("#DomainName").removeClass("PostIgnore");
domainNameLabel.text("&?Ddns_006;");
break;
}
case "No-IP":
case "DynDNS":
{
showOrHideRowDiv("show", domainNameDiv);
$("#DomainName").removeClass("PostIgnore");
domainNameLabel.text("&?Ddns_007;");
break;
}
default:
{
showOrHideRowDiv("show", domainNameDiv);
$("#DomainName").removeClass("PostIgnore");
domainNameLabel.text("&?Ddns_006;");
break;
}
}
});
template.bind("fillDomainByCustom", function(event, xml){
var OBJID = "OBJ_DDNSHOSTNAME_ID";
var DomainInfoObj = $("#DomainInfo",template);
DomainInfoObj.hide();
DomainInfoObj.empty("");
var ToOperParaArr = {
"Name" : {ValueOrigin: ""}
};
var InstNum = $("Instance", $(OBJID, $(xml))).length;
for (var i=0; i<InstNum; i++)
{
xmlParaInInstOperate(xml, OBJID, i, ToOperParaArr);
var TempName = ToOperParaArr.Name.ValueOrigin;
var DomainInfoOption = "<option disabled='disabled"
+ "' value='" + TempName
+ "' title='" + TempName
+ "'>" + TempName
+ "</option>";
DomainInfoObj.append(DomainInfoOption);
}
DomainInfoObj.change();
DomainInfoObj.show();
});
$(".addInstBar").unbind("click");
$(".addInstBar").click(function(){
$("[id^='Provider']").change();
});
}
$(document).ready(function(){
var HeadID = "Ddns";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_Ddns(templateID);
RefreshClickHandle(Head);
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml, "externErrorHint");
var OBJID = ["OBJ_DDNSCLIENT_ID"];
var OBJ = $(xml).find("OBJ_DDNSCLIENT_ID");
var RuleNum = $("Instance", OBJ).length;
Head.createPageDataByClone(RuleNum,OBJID,xml);
var instNameSpans = $(".instName");
var instIDEles = $("[id^='_InstID']");
for(var i = 0; i < RuleNum; i++){
instNameSpans.eq(i).text(instIDEles.eq(i).val().substr(9));
var OBJ = $("OBJ_DDNSCLIENT_ID", $(xml));
}
$("[id^='Provider']",template).change();
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
