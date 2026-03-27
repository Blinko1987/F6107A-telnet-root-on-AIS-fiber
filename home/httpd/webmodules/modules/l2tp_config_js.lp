<script type="text/javascript">
(function(){
function initial_L2TPCONF(templateID)
{
var template = $("#"+templateID);
$("input[type='radio'][name='Method']", template).change(function(event){
var iTemplate = $(this).parents("[id^='template_']");
var wanRow = $("[id^='Row_LowIFID']", iTemplate);
var autoObj = $("[id^='AutoSense']", iTemplate);
if (autoObj.is(':checked'))
{
wanRow.hide();
}
else
{
wanRow.show();
}
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var wanObj = $("[id^='LowIFID']",template);
if ($("[id^='AutoSense']",template).is(':checked'))
{
wanObj.val("");
}
});
template.bind("fillDataByCustom", function(event, suffix, template){
template.collapsibleInstTitleChange("SessionName");
if ($("[id^='LowIFID']",template).val() == "")
{
$("[id^='AutoSense']",template).prop("checked",true);
}
else
{
$("[id^='Manual']",template).prop("checked",true);
}
$(":radio[name^='Method']",template).change();
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_L2TP_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template, "SessionName");
});
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"SessionName": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,64]
},
"UserName": {
"ASCII": true,
"required": true,
"rangelength":[1,64]
},
"Password": {
"PasswordASCII": true,
"required": true,
"rangelength":[1,64]
},
"L2tpServer1": {
"required": true
},
"LowIFID": {
"required": true
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
if(commConf.passCanSee.indexOf("L2tp") != -1){
g_ChangePass2See(template,"Password");
}
}
$(document).ready(function(){
var HeadID = "L2TPCONF";
var Head = $("#"+HeadID);
var tempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_L2TPCONF(tempalteID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_L2TP_ID");
var RuleNum = $("Instance", OBJ).length;
var OBJID = ["OBJ_L2TP_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
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
