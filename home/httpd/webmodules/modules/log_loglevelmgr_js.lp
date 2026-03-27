<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
if (ActionByApplyResult(xml, template) == 0)
{
var OBJID = ["OBJ_LOG_ID"];
template.fillDataByOBJID(xml ,OBJID, template,0);
}
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_LOG_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "LvlLogManagerConf";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_LOG_ID"];
var template = $("#"+templateID);
Head.fillDataByOBJID(xml, OBJID, template, 0);
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
