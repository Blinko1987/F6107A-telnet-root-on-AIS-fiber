<script type="text/javascript">
function g_ChanegeDataByCustom(xml)
{
var OBJ = $(xml).find("OBJ_TR069QUEUECONF_ID");
var instances = $("Instance ", OBJ);
instances.each(function(){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_QUEUE");
}
});
});
}
function ChainListByValue(ContainerOBJ)
{
var templateID = ContainerOBJ.attr("id");
var ChainStr = $("#CertList", ContainerOBJ).val();
var certChainIndex = 0;
var CertName = "";
var OptionStr = "";
ChainStr = ChainStr.split(";");
for ( var i=0; i<ChainStr.length; i++ )
{
if ( "Auto" == ChainStr[i] )
{
CertName = "&?public_071;";
}
else
{
certChainIndex++;
CertName = "&?RemoteManag_002;" + certChainIndex;
}
OptionStr += "<option value='"+ChainStr[i]+"' title='"+CertName+"'>"+CertName+"</option>";
}
$("#select_CertID", ContainerOBJ).empty().append(OptionStr);
}
function Customize_Tr069Basic(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
var PeriodicInfoCheckedRadio = $("[id^='PeriodicInformEnable'][type='radio']",
ContainerOBJ);
var PeriodicInfoIntervalOBJ = $("[id^='PeriodicInformInterval']",ContainerOBJ);
if(PeriodicInfoCheckedRadio.val() == 1
&&(PeriodicInfoCheckedRadio.is(':checked')))
{
$("#div_PeriodicInformInterval", ContainerOBJ).slideDown();
}
else
{
$("#div_PeriodicInformInterval", ContainerOBJ).hide();
}
var CertList = $("#CertList").val();
if ( "" != CertList )
{
ChainListByValue(ContainerOBJ);
var certID = $("#CertID",ContainerOBJ).val();
$("#select_CertID",ContainerOBJ).val(certID);
$("#div_select_CertID").show();
}
else
{
$("#CertID").addClass("PostIgnore");
}
}
jQuery.validator.addMethod(
"nmsURLPrefix",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if(value.match("^(http:\/\/)|(https:\/\/)") == null)
{
return false;
}
return true;
},
"&?RemoteManag_015;"
);
function initial_template(templateID,second_templateID)
{
var template = $("#"+templateID);
var sec_template = $("#"+second_templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"PeriodicInformInterval": {
"required":true,
"integer": true,
"range": [1,42949672]
},
"URL" : {
"required":true,
"url":true,
"nmsURLPrefix": true,
"minlength": 1,
"maxlength": 256
},
"UserName" : {
"required":true,
"ASCII":true,
"minlength": 1,
"maxlength": 256
},
"UserPassword" : {
"PasswordASCII":true,
"minlength": 0,
"maxlength": 256
},
"ConnectionRequestUsername": {
"ASCII":true,
"minlength": 1,
"maxlength": 256
},
"ConnectionRequestPassword": {
"PasswordASCII":true,
"minlength": 0,
"maxlength": 256
}
,
"DSCPRemark": {
"required":true,
"integer": true,
"range": [0,63]
}
},
"messages": {
}
});
var data = {};
data.template = template;
$.callModifier("TR069BasicConf/UserName/changeRules",data);
$("[id^='PeriodicInformEnable'][type='radio']",template).each(function(){
$(this).change(function(){
var radioChangeOBJ = $(this);
var ContainerOBJ = radioChangeOBJ.parents("[id^='template_']");
var PeriodicInformIntervalOBJ = $("#PeriodicInformInterval", ContainerOBJ);
if ( radioChangeOBJ.val() == "1" )
{
$("#div_PeriodicInformInterval", ContainerOBJ).slideDown();
PeriodicInformIntervalOBJ.removeClass("PostIgnore");
}
else
{
$("#div_PeriodicInformInterval", ContainerOBJ).hide();
PeriodicInformIntervalOBJ.addClass("PostIgnore");
}
})
});
template.bind("hiddenValueChangeByCustom", function(event,template){
$("#CertID",template).val(
$("#select_CertID",template).val());
});
template.bind("fillDataByApplyResult", function(event, xml, template){
if (template.hasError(xml) == 0)
{
succHintShow(template);
template.trigger("fillDataByCancelResult",[xml,template]);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_MANAGESERVER_ID","OBJ_TR069QUEUECONF_ID"
];
g_ChanegeDataByCustom(xml);
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
Customize_Tr069Basic(CustomizeParams);
});
if(commConf.passCanSee.indexOf("Tr069") != -1){
g_ChangePass2See(template,"UserPassword");
g_ChangePass2See(template,"ConnectionRequestPassword");
}
}
function fulfillChainSelect()
{
var CertList = $("#CertList").val();
var certChainIndex = 0;
var CertName = "";
var OptionStr = "";
if ( "" == CertList )
{
return;
}
else
{
$("#div_CertID_4Upload").show();
}
ChainStr = CertList.split(";");
for ( var i=0; i<ChainStr.length; i++ )
{
if ( "Auto" == ChainStr[i] )
{
continue;
}
else
{
certChainIndex++;
CertName = "&?RemoteManag_002;" + certChainIndex;
}
OptionStr += "<option value='"+ChainStr[i]+"' title='"+CertName+"'>"+CertName+"</option>";
}
$("#select_CertID_4Upload").append(OptionStr);
}
$(document).ready(function(){
showWaitTip(false);
var TR069BasicHeadID = "TR069BasicConf";
var TR069BasicHead = $("#"+TR069BasicHeadID);
var Basic_templateID = "template_"+TR069BasicHeadID;
var ServerAddr = $("address span", TR069BasicHead).text();
initial_template(Basic_templateID);
TR069BasicHead.fillDataByCustom = function(suffix, ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_Tr069Basic(CustomizeParams);
};
TR069BasicHead.succfunction = function(xml){
if (TR069BasicHead.hasError(xml) == 0)
{
var OBJID = ["OBJ_MANAGESERVER_ID","OBJ_TR069QUEUECONF_ID"
];
var basicTpl = $("#"+Basic_templateID);
g_ChanegeDataByCustom(xml);
TR069BasicHead.fillDataByOBJID(xml, OBJID, basicTpl, 0);
TR069BasicHead.fillDataByCustom(0, basicTpl);
fulfillChainSelect();
}
$(".collapsibleBar", TR069BasicHead).click();
var pageConfigUpperZoneVal = "<%=pageConfigUpperZoneVal%>";
if ("0" == pageConfigUpperZoneVal && $("#TR069BasicConf_container").is(":visible"))
{
$(".collapsibleBar",$("#TR069BasicConf")).click();
}
};
TR069BasicHead.dataTransfer(ServerAddr,
"GET",
TR069BasicHead.succfunction, undefined, false);
});
</script>
