<script type="text/javascript">
(function(){
var pageConf = JSON.parse("<%=page.jsInfo%>");
function initial_template_multiConf(zeroTemplate) {
var checkRule = new Object();
var haveCheck = false;
for(var para in pageConf.check){
haveCheck = true;
checkRule[para] = new Object();
var chkList = pageConf.check[para].rule.split(":");
for(var i in chkList){
var chk = chkList[i];
checkRule[para][chk] = true;
}
if(pageConf.check[para].range != undefined ){
var rangList = pageConf.check[para].range.split(":");
var min = rangList[0];
var max = rangList[1];
if(pageConf.check[para].type == "string"){
if(pageConf.check[para].rule.indexOf("utf8") != -1){
checkRule[para]["utf8LengthRange"] = rangList;
min = Math.ceil(parseInt(min)/ $.utf8Realbyte);
max = Math.floor(parseInt(max) / $.utf8Realbyte);
}
else{
checkRule[para]["rangelength"] = rangList;
}
}
var noteSpan = $("#"+para,zeroTemplate).next("span");
var noteStr = noteSpan.html() + min + " ~ " + max;
noteSpan.html(noteStr);
}
}
if(haveCheck){
zeroTemplate.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": checkRule,
"messages": {}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
zeroTemplate.bind("fillDataByApplyResult", function(event,xml, template){
if(pageConf.titleChange.length > 0){
ActionByApplyResult(xml, template, pageConf.titleChange);
}
else{
ActionByApplyResult(xml, template);
}
if ( template.hasError(xml) == 0 ){
if(pageConf.modify == 0){
$("[id^='Btn_apply']", template).addClass("disableBtn");
}
}
});
zeroTemplate.bind("fillDataByCancelResult", function(event,xml, template){
ActionByCancelResult(xml, template, pageConf.objList);
template.trigger("fillDataByCustom",[0, template, xml]);
});
zeroTemplate.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
if(pageConf.titleChange.length > 0){
ContainerOBJ.collapsibleInstTitleChange(pageConf.titleChange);
}
if(pageConf.modify == 0){
$("[id^='Btn_apply']", ContainerOBJ).addClass("disableBtn");
}
});
}
$(document).ready(function(){
var multiConfigHeadID = pageConf.id;
var multiConfigHead = $("#"+multiConfigHeadID);
var multiConfigContainer = $("#"+multiConfigHeadID+"_container");
var multiConfigTemplate = $("#template_"+multiConfigHeadID);
var ServerAddr = $("address span", multiConfigHead).text();
initial_template_multiConf(multiConfigTemplate);
multiConfigHead.succfunction = function(xml){
if (multiConfigHead.hasError(xml) == 0){
var OBJName = pageConf.objList[0];
var instNum = xml[OBJName].Instance.length;
multiConfigHead.createPageDataByClone(instNum,pageConf.objList,xml);
}
};
if ( $(".collapBarWithDataTrans",multiConfigHead).length <= 0 ){
multiConfigHead.dataTransfer(ServerAddr,"GET",multiConfigHead.succfunction);
}
else{
initial_collapBarWithDataTrans(multiConfigHead);
}
});
})();
</script>
