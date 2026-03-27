<script type="text/javascript">
function initial_template(templateID) {
var template = $("#" + templateID);
var instForm = template.find("form")
var ServerAddr = "/?_type=menuData&_tag=wlan_interference_lua.lua";
instForm.validate({
"rules": {
"StartTime":{
"required":true,
"checkTimeHMS":true,
"timeComparison":["earlierThan","EndTime"],
},
"EndTime":{
"required":true,
"checkTimeHMS":true,
"timeComparison":["laterThan","StartTime"],
},
"PeriodTime": {
"required": true,
"integer": true,
"range":[900,86399],
},
},
"messages": {},
})
template.bind("fillDataByApplyResult", function (event, xml, template) {
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function (event, xml, template) {
var OBJID = ["OBJ_WLANINTERFERENCE_ID"];
ActionByCancelResult(xml, template, OBJID);
});
$("#Btn_Forced_startup").unbind("click");
$("#Btn_Forced_startup").bind("click",function(event){
var PostData = "IF_ACTION=startup";
dataPost("wlanInterferenceStartup", "", ServerAddr, template, PostData);
});
$("#Active").unbind("change");
$("#Active").bind("change",function(event){
if($("#Active").prop("checked") == false){
$("#StartTime").prop("disabled","true");
$("#EndTime").prop("disabled","true");
$("#PeriodTime").prop("disabled","true");
}
else{
$("#StartTime").removeAttr("disabled");
$("#EndTime").removeAttr("disabled");
$("#PeriodTime").removeAttr("disabled");
}
})
}
$(document).ready(function () {
var StartTime = jeDate("#StartTime", {
minDate: "00:00:00",
maxDate: "23:59:59",
format: "hh:mm:ss"
});
var EndTime = jeDate("#EndTime", {
minDate: "00:00:00",
maxDate: "23:59:59",
format: "hh:mm:ss"
});
var HeadID = "WlanInterference";
var Head = $("#" + HeadID);
var templateID = "template_" + HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function (xml) {
if (Head.hasError(xml) == 0) {
var OBJID = "OBJ_WLAN_INTERFERENCE_ID";
OBJ_Temp = $(xml).find(OBJID);
INSTs = $("Instance", OBJ_Temp);
for(var i=1;i<=INSTs.length;i++)
{
var INST = INSTs.eq(i-1);
INST.find("ParaName").each(function()
{
ParaName = $(this).text();
ParaValue = $(this).next().text();
if ( ParaName == "Active")
{
$("#Active").prop("checked", ParaValue==1?true:false);
if($("#Active").prop("checked") == false){
$("#StartTime").prop("disabled","true")
$("#EndTime").prop("disabled","true")
$("#PeriodTime").prop("disabled","true")
}
else{
$("#StartTime").removeAttr("disabled")
$("#EndTime").removeAttr("disabled")
$("#PeriodTime").removeAttr("disabled")
}
}
else{
$("#"+ParaName).prop("value",ParaValue);
}
});
}
<% if env.getenv("OperationMode")=="3" then %>
disable_all_templte(templateID);
Head.find(":button").showIt(false);
<%end%>
}
};
if ($(".collapBarWithDataTrans", Head).length <= 0) {
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
} else {
initial_collapBarWithDataTrans(Head);
}
})
</script>
