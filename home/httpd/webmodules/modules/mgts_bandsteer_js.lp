<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"BsRssiLmt24G": {
"required": true,
"integer": true,
"range":[-110,-40]
},
"BsRssiLmt5G": {
"required": true,
"integer": true,
"range":[-110,-40]
},
"BsStaIdleRateLmt24G": {
"required": true,
"integer": true,
"range":[0,100]
},
"BsStaIdleRateLmt5G": {
"required": true,
"integer": true,
"range":[0,100]
},
"BsBwUtil24G": {
"required": true,
"integer": true,
"range":[0,100]
},
"BsBwUtil5G": {
"required": true,
"integer": true,
"range":[0,100]
},
"BsAcceptBwUtil24G": {
"required": true,
"integer": true,
"range":[0,100]
},
"BsAcceptBwUtil5G": {
"required": true,
"integer": true,
"range":[0,100]
},
"BsAcceptRssi24G": {
"required": true,
"integer": true,
"range":[-2147483648,-1]
},
"BsAcceptRssi5G": {
"required": true,
"integer": true,
"range":[-2147483648,-1]
},
"BsBounceDetectTimeLmt": {
"required": true,
"integer": true,
"range":[1,2147483647]
},
"BsBounceCountsLmt": {
"required": true,
"integer": true,
"range":[1,2147483647]
},
"BsBounceDwellTimeLmt": {
"required": true,
"integer": true,
"range":[1,2147483647]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_MGTS_BANDSTEER_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
function initial_enableArea()
{
var template = $("div#enablesArea");
var collapsibleInstObj = $(".collapsibleInst",template);
collapsibleInstObj.unbind("click");
collapsibleInstObj.click(function(event){
var collapsibleInst = $(this);
var ChangeArea = $(".ChangeArea",template);
if ( ChangeArea.is(":hidden") ) {
ChangeArea.showIt(true);
collapsibleInst.addClass("instNameExp");
} else {
ChangeArea.showIt(false);
collapsibleInst.removeClass("instNameExp");
$(".Btn_cancel",ChangeArea).click();
}
});
template.bind("callbackEnableAreaApply", function(event,xml, template){
succHintShow(template);
fillDataInEnableArea(xml);
});
$("#Btn_cancel_Enable").unbind("click").click(function(){
showWaitTip(true);
$.get("/?_type=menuData&_tag=mgts_bandsteer_lua.lua",function(xml){
fillDataInEnableArea(xml);
});
});
$("#Btn_apply_Enable").unbind("click").click(function(){
showWaitTip(true);
var template = $("div#enablesArea");
var _InstIDValue = $("#_InstID",template).val();
var EnBandSteerValue = $("#EnBandSteer0",template).is(":checked") ? 1 : 0;
var ServerAddr = "/?_type=menuData&_tag=mgts_bandsteer_lua.lua";
var PostData = "IF_ACTION=SET_ENABLES"+"&"
+ "EnBandSteer="+EnBandSteerValue+"&"
+ "_InstID=" + _InstIDValue;
dataPost("SET_ENABLES", "callbackEnableAreaApply", ServerAddr, template, PostData);
});
}
function fillDataInEnableArea(xml)
{
var template = $("div#enablesArea");
template.hasError(xml, undefined, "enablesArea");
template.fillDataByOBJID(xml, ["OBJ_BANDSTEER_ENABLE_ID"], template, 0);
showWaitTip(false);
}
function displayCtrl()
{
$("[id^='instName_WLANBandSteer:0']").text("2.4G");
$("[id^='24Garea:0']").show();
$("[id^='5Garea:0']").hide();
$("#instName_WLANBandSteer").text("5G");
$("#24Garea").hide();
$("#5Garea").show();;
}
$(document).ready(function(){
var HeadID = "WLANBandSteer";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
initial_enableArea();
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var tempobj = $("#template_WLANBandSteer");
var OBJID = ["OBJ_MGTS_BANDSTEER_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
Head.createPageDataByClone(1,OBJID,xml);
displayCtrl();
fillDataInEnableArea(xml);
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
