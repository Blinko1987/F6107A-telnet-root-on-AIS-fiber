<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"RipAuthKey": {
"required":true,
"PasswordASCII": true,
"rangelength":[1,16]
}
},
"messages": {
}
});
$("#RipAuthType", template).change(function(){
var AuthType = $(this).val();
if ( AuthType == 0)
{
$("#div_RipAuthKey").showIt(false);
$("#RipAuthKey").addClass("PostIgnore");
}
else
{
$("#div_RipAuthKey").showIt(true);
$("#RipAuthKey").removeClass("PostIgnore");
}
});
$("#RipProtocol", template).change(function(){
var Protocol = $(this).val();
if ( Protocol == 1)
{
$("#div_RipAuthType").showIt(true);
$("#RipAuthType").change();
$("#RipAuthType").removeClass("PostIgnore");
}
else
{
$("#div_RipAuthType, #div_RipAuthKey").showIt(false);
$("#RipAuthType, #RipAuthKey").addClass("PostIgnore");
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_RIP_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ){
$("#RipProtocol").change();
$("#RipAuthType").change();
});
template.bind("hiddenValueChangeByCustom", function(event,template){
});
}
$(document).ready(function(){
var HeadID = "RIP";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_RIP_ID"];
var template = $("#"+templateID);
Head.fillDataByOBJID(xml, OBJID, template, 0);
template.trigger("fillDataByCustom",[0, template]);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
