<script type="text/javascript">
(function(){
function g_ChanegeDataByCustom(xml)
{
var OBJs = $(xml).find("OBJ_VOIPLINEVMEDAI_ID");
OBJs.each(function(){
var OBJ = $(this);
var instances = $("Instance", OBJ);
instances.each(function(){
var inst = $(this);
var codecType = "";
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "MediaVCodec" )
{
var Media2CodecType = {
"1":"G711U",
"2":"G723",
"4":"G711A",
"8":"G729",
"16":"G722",
"32":"G726",
"512":"G726_24k",
"1024":"G726_32k"
};
codecType = "Other";
for ( var mediaTmp in Media2CodecType )
{
if ( ParaValue == mediaTmp )
{
codecType = Media2CodecType[mediaTmp];
break;
}
}
}
});
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
$(this).text(ParaName+"_"+codecType);
});
});
});
}
function initial_template_SIPMediaConf(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
succHintShow(template);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
template.hasError(xml);
var SIPMediaHeadID = "SIPMediaConf";
var SIPMediaHead = $("#"+SIPMediaHeadID);
g_ChanegeDataByCustom(xml);
var SIPMediaOBJ = $(xml).find("OBJ_VOIPLINEVMEDAI_ID");
var instNum = $("Instance", SIPMediaOBJ).length;
var OBJID = ["OBJ_VOIPLINEVMEDAI_ID"];
for( var j=0; j<instNum; j++ )
{
SIPMediaHead.fillDataByOBJID(xml, OBJID, template, j);
}
});
<%
if "17" == env.getenv("CountryCode") then
%>
$("[id^='MediaSSuprs_G729']",template).bind("change", function () {
var G729SSOBJ = $(this);
var subTemplate = G729SSOBJ.parents("[id^='template_']");
var G729VELabOBJ = $("[id^='MediaVEnable_G729_Lab']",subTemplate);
if(G729SSOBJ.is(":checked"))
{
G729VELabOBJ.html("G729B");
}
else
{
G729VELabOBJ.html("G729A");
}
});
<%
end
%>
var mediaPriCheckRules = {
"required": true,
"integer": true,
"range": [1, 16]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"MediaVPri_G711U": mediaPriCheckRules,
"MediaVPri_G711A": mediaPriCheckRules,
"MediaVPri_G729": mediaPriCheckRules,
"MediaVPri_G726": mediaPriCheckRules,
"MediaVPri_G723": mediaPriCheckRules,
"MediaVPri_G722": mediaPriCheckRules,
"MediaVPri_G726_24k": mediaPriCheckRules,
"MediaVPri_G726_32k": mediaPriCheckRules,
"MediaVPri_Other": mediaPriCheckRules
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
$(document).ready(function(){
var SIPMediaHeadID = "SIPMediaConf";
var SIPMediaHead = $("#"+SIPMediaHeadID);
var ServerAddr = $("address span", SIPMediaHead).text();
initial_template_SIPMediaConf("template_"+SIPMediaHeadID);
SIPMediaHead.fillDataByCustom = function(suffix,ContainerOBJ){
var PhoneIndex = parseInt(suffix)+1;
var SIPMediaBarOBJ = ContainerOBJ.find("[id^='SIPMediaBar']");
SIPMediaBarOBJ.append(PhoneIndex);
};
SIPMediaHead.succfunction = function(xml){
SIPMediaHead.hasError(xml);
g_ChanegeDataByCustom(xml);
var SIPMediaOBJ = $(xml).find("OBJ_VOIPVPLINE_ID");
var RuleNum = $("Instance", SIPMediaOBJ).length;
var OBJID = ["OBJ_VOIPVPLINE_ID"];
SIPMediaHead.createPageDataByClone(RuleNum, OBJID, xml,
SIPMediaHead.fillDataByCustom);
for( var i=0; i<RuleNum; i++ )
{
var SIPMediaInst = $(xml).find("OBJ_VOIPLINEVMEDAI_ID").get(i);
var instNum = $("Instance", SIPMediaInst).length;
var OBJID = [];
OBJID[0] = "OBJ_VOIPLINEVMEDAI_ID:"+i;
var templateObj = $("#template_SIPMediaConf_"+i);
for( var j=0; j<instNum; j++ )
{
SIPMediaHead.fillDataByOBJID(xml, OBJID, templateObj, j);
}
var tempObj = $("#template_SIPMediaConf_"+i);
var codecInstElems = $("[id^='_InstID_']", tempObj);
codecInstElems.each(function(){
var eleID = $(this).attr("id");
var eleSuffix = eleID.replace("_InstID_", "");
eleSuffix = eleSuffix.replace(":", "\\:");
var eleVal = $(this).val();
if ( eleVal == "" )
{
$("[id^='div_"+eleSuffix+"']", tempObj).remove();
}
});
<%
if "17" == env.getenv("CountryCode") then
%>
$("[id^='MediaSSuprs_G729:']", tempObj).change();
<%
end
%>
}
$(".collapsibleBar", SIPMediaHead).eq(0).click();
};
SIPMediaHead.dataTransfer(ServerAddr,
"GET",
SIPMediaHead.succfunction);
});
})();
</script>
