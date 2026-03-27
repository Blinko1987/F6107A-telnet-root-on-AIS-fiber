<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"Timeout": {
"required":true,
"integer": true,
"range": [1,30]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_USERIF_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "LoginTimeout";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_USERIF_ID"];
Head.fillDataByOBJID(xml, OBJID, $("#"+templateID), 0);
}
};
initial_collapBarWithDataTrans(Head);
});
})();
</script>
