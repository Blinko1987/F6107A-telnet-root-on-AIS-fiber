<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_PON_IGMPMODE_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var multicastmodeXML = getParaValueInXML(xml, "OBJ_IGMPMODE_ID", 0, "multicastmode");
var multicastmodeObj = $("#multicastmode", ContainerOBJ);
if ( multicastmodeXML == "" )
{
multicastmodeXML = $("option",multicastmodeObj).eq(0).val();
}
multicastmodeObj.val(multicastmodeXML);
multicastmodeObj.change();
});
}
$(document).ready(function(){
var HeadID = "MulticastMode";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_IGMPMODE_ID"];
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
