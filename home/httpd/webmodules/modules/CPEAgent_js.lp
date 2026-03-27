<script type="text/javascript">
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
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"FirstServer": {
"required":true,
"nmsURLPrefix": true
},
"FirstIntervalTime" : {
"required":true,
"integer": true,
"range": [1,86400]
},
"SecondServer": {
"nmsURLPrefix": true
},
"SecondIntervalTime" : {
"required":true,
"integer": true,
"range": [1,86400]
}
},
"messages": {
}
});
var temp =$("#SecondServer",template).val();
if(temp == ""){
$("#SecondIntervalTime",template).rules("remove","range");
}
$("[id$=ServerEnable]",template).click(function(){
if($(this).val()== "1"){
$(this).prop("checked",false);
$(this).val("0");
}
else{
$(this).prop("checked",true);
$(this).val("1");
}
});
}
$(document).ready(function(){
var HeadID = "AgentConf";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_WIFIAGENT_ID"];
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
ToOperParaArr = {
"FirstServerEnable": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal == "1") {
$("#FirstServerEnable", Head).prop("checked", true);
$("#FirstServerEnable", Head).val("1");
} else {
$("#FirstServerEnable", Head).prop("checked", false);
$("#FirstServerEnable", Head).val("0");
}
}
},
"SecondServerEnable": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
if (SelfVal == "1") {
$("#SecondServerEnable", Head).prop("checked", true);
$("#SecondServerEnable", Head).val("1");
} else {
$("#SecondServerEnable", Head).prop("checked", false);
$("#SecondServerEnable", Head).val("0");
}
}
},
"FirstServerStat": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
$("#FirstServerStat", Head).val(SelfVal);
}
},
"SecondServerStat": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
$("#SecondServerStat", Head).val(SelfVal);
}
},
"ImmediatelySendStat": {
ValueOrigin: "",
setAction: function (ParaNameSel, ParaValSel, SelfVal) {
$("#ImmediatelySendStat", Head).val(SelfVal);
}
},
}
xmlParaInInstOperate(xml, "OBJ_WIFIAGENT_ID", 0, ToOperParaArr);
}
};
var template = $("#" + templateID);
$("#ImmediatelySend",Head).click(function(){
var template = $(this).parents("[id^='template_']");
var ImmediatelySend = $("#ImmediatelySend",Head).val("1");
var data = "IF_ACTION=Apply&ImmediatelySend=" + $("#ImmediatelySend",Head).val();
dataPost("Apply", "fillDataByWIFIAgent", ServerAddr, template, data, true);
template.bind("fillDataByWIFIAgent", function (event, xml) {
var temp = $("#ImmediatelySend",template).parent();
if (temp.hasError(xml) == 0)
{
Head.succfunction(xml);
$("#errortip",Head).css("display","none");
}
else{
$("#errortip",Head).css("display","")
}
});
});
template.bind("fillDataByApplyResult", function (event, xml, template)
{
var isError = ActionByApplyResult(xml, template);
if(isError == 0)
{
Head.succfunction(xml);
}
});
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
</script>
