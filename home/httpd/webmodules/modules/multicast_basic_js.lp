<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"Agtime": {
"required":true,
"integer": true,
"range": [1,604800]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_IGMPBASIC_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "MulticastBasic";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_IGMPBASIC_ID"];
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
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
