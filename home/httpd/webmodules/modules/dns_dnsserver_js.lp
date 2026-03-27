<script type="text/javascript">
(function () {
function customize_dns_server(CustomizeParams)
{
var ContainerOBJ = CustomizeParams["ContainerOBJ"];
var obj1 = $("[id^='SerIPv6Address1']", ContainerOBJ);
var obj2 = $("[id^='SerIPv6Address2']", ContainerOBJ);
if ('::' == obj1.val())
{
obj1.val('');
}
if ('::' == obj2.val())
{
obj2.val('');
}
}
function initial_template_server(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
var IPCheckRules = {
"required": true,
"integer": true,
"range":[0,255]
};
instForm.validate({
"groups": {
SerIPAddress1: "sub_SerIPAddress10 sub_SerIPAddress11 sub_SerIPAddress12 sub_SerIPAddress13",
SerIPAddress2: "sub_SerIPAddress20 sub_SerIPAddress21 sub_SerIPAddress22 sub_SerIPAddress23"
},
"rules": {
"sub_SerIPAddress10": IPCheckRules,
"sub_SerIPAddress11": IPCheckRules,
"sub_SerIPAddress12": IPCheckRules,
"sub_SerIPAddress13": IPCheckRules,
"sub_SerIPAddress20": IPCheckRules,
"sub_SerIPAddress21": IPCheckRules,
"sub_SerIPAddress22": IPCheckRules,
"sub_SerIPAddress23": IPCheckRules,
"SerIPv6Address1": {
"IPv6Addr": true
},
"SerIPv6Address2": {
"IPv6Addr": true
}
},
"messages": {
}
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
var prefixNameValue = {
"SerIPv6Address1" : "",
"SerIPv6Address2" : ""
};
if ( prefixNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "::";
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
var obj1 = $("[id^='SerIPv6Address1']", template);
var obj2 = $("[id^='SerIPv6Address2']", template);
if ('::' == obj1.val())
{
obj1.val('');
}
if ('::' == obj2.val())
{
obj2.val('');
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_DNS_ID"];
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
customize_dns_server(CustomizeParams)
});
}
$(document).ready(function(){
var HeadID = "LocalDnsServer";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_server("template_"+HeadID);
Head.chanegeDataByCustom =function(xml){
};
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
customize_dns_server(CustomizeParams);
};
Head.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",Head);
if (cmapiErrorContainer.hasError(xml) == 0)
{
Head.chanegeDataByCustom(xml);
var OBJ = $(xml).find("OBJ_DNS_ID");
var RuleNum = $("Instance", OBJ).length;
var tempobj = $("#template_LocalDnsServer");
var OBJID = ["OBJ_DNS_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
Head.fillDataByCustom(0, tempobj);
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
