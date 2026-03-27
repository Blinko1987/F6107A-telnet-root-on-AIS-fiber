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
function initial_template_Ddns(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"ServerPort": {
"required": true,
"integer": true,
"range":[1,65535]
},
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
});
template.bind("fillDataByApplyResult", function(event,xml, template){
var OBJID = ["OBJ_DDNSCLIENT_ID"];
ActionByApplyResult(xml, template);
template.fillDataByOBJID(xml, OBJID, template, 0);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DDNSCLIENT_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event,template,actionType){
var ProviderSelected = $("#Provider",template).find("option:selected");
var serviceurlSelected = ProviderSelected.attr("serviceurl");
var serviceNameSelected = ProviderSelected.val();
var serviceportSelected = ProviderSelected.attr("servicePort");
var urlObj = $("#serviceUrl",template);
var portObj = $("#ServerPort",template);
var urlVal = urlObj.val();
var portVal = portObj.val();
if(serviceNameSelected == "Other")
{
if(urlVal != serviceurlSelected)
{
ProviderSelected.attr("serviceurl", urlVal);
serviceurlSelected = urlVal;
}
if(portVal != serviceportSelected)
{
ProviderSelected.attr("servicePort", portVal);
}
}
var serviceInstSelected = ProviderSelected.attr("serviceinst");
$("#Server",template).val(serviceurlSelected);
$("#Name",template).val(serviceNameSelected);
$("#serviceInst",template).val(serviceInstSelected);
$("#Service",template).val(serviceNameSelected);
if ($("#Service",template).val() == "phddns")
{
var UsernameObj = $("#Username",template);
var PasswordObj = $("#Password",template);
var phddnsUsernameObj = $("#phddns_Username",template);
var phddnsPasswordObj = $("#phddns_Password",template);
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
var serviceValue = $("#Service",ContainerOBJ).val();
var provider = $("#Provider",ContainerOBJ);
if ( serviceValue == "" )
{
serviceValue = $("option",provider).eq(0).val();
}
provider.val(serviceValue);
$("#Provider",ContainerOBJ).change();
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
$("#Provider",template).change(function(event){
var provider = $(this);
var template = provider.parents("[id^='template_']");
var providerSelected = provider.find("option:selected");
var serUrlSelected = providerSelected.attr("serviceurl");
var providerURL = $("#serviceUrl",template);
providerURL.val(serUrlSelected);
var serPortSelected = providerSelected.attr("servicePort");
var providerPort = $("#ServerPort",template);
providerPort.val(serPortSelected);
var provideTmp = providerSelected.val();
var domainNameLabel = $("label[for='DomainName']",template).eq(0);
var domainNameDiv = $("#div_DomainName",template);
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
$.publish("/some/selectModify", [template]);
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
if(commConf.passCanSee.indexOf("Ddns") != -1){
g_ChangePass2See(template,"Password");
g_ChangePass2See(template,"phddns_Password");
}
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
Head.hasError(xml);
var OBJID = ["OBJ_DDNSCLIENT_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
template.trigger("fillDataByCustom",[0, template, xml]);
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
