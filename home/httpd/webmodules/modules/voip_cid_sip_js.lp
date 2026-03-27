<script type="text/javascript">
(function(){
var getXml;
function initial_template_CIDSip(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPDTMF_ID","OBJ_VOIPSIP_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ,xml){
var _instid = getParaValueInXML(getXml, "OBJ_VOIPSIP_ID", 0, "_InstID");
$("#_InstID", ContainerOBJ).val(_instid);
_instid = getParaValueInXML(getXml, "OBJ_VOIPDTMF_ID", 0, "_InstID");
$("#_InstID_CIDSIP", ContainerOBJ).val(_instid);
});
}
$(document).ready(function(){
var SIPCIDHeadID = "VoIPCIDSIP";
var SIPCIDHead = $("#"+SIPCIDHeadID);
var ServerAddr = $("address span", SIPCIDHead).text();
initial_template_CIDSip("template_"+SIPCIDHeadID);
SIPCIDHead.succfunction = function(xml){
var cmapiErrorContainer = $(".errorHint",SIPCIDHead);
if (cmapiErrorContainer.hasError(xml) == 0)
{
getXml = xml;
var OBJID = ["OBJ_VOIPDTMF_ID","OBJ_VOIPSIP_ID"];
var tempobj = $("#template_VoIPCIDSIP");
SIPCIDHead.fillDataByOBJID(xml, OBJID, tempobj, 0);
tempobj.trigger("fillDataByCustom", tempobj);
}
};
if ( $(".collapBarWithDataTrans",SIPCIDHead).length <= 0 )
{
SIPCIDHead.dataTransfer(ServerAddr,
"GET",
SIPCIDHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(SIPCIDHead);
}
$("#ETSICallIDStandard").change(function(){
if($(":radio[name=ETSICallIDStandard]:checked", SIPCIDHead).val() == 0)
{
$("#FskFrameType", SIPCIDHead).val("1");
}
else
{
$("#FskFrameType", SIPCIDHead).val("0");
}
});
});
})();
</script>
