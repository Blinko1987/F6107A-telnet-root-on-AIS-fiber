<script type="text/javascript">
(function(){
function Customize_MACFilter(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Name");
var MACJSON = {
"SrcMacAddr":"sub_SrcMacAddr",
"DstMacAddr":"sub_DstMacAddr"
};
for (var MACTmp in MACJSON)
{
$("[id^='"+MACTmp+"']",ContainerOBJ).FillIPorMacDataBySplit(MACJSON[MACTmp], ":", 6);
}
$("[id^='Type']",ContainerOBJ).change();
$("[id^='select_protocol']",ContainerOBJ).val($("[id^='Protocol']",ContainerOBJ).val());
}
function initial_template_MACFilter(templateID)
{
var template = $("#"+templateID);
var MACCheckRules = {
"required": true,
"HEX": true,
"fixedlength": 2
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
SrcMacAddrGroup: "sub_SrcMacAddr0 sub_SrcMacAddr1 sub_SrcMacAddr2 sub_SrcMacAddr3 sub_SrcMacAddr4 sub_SrcMacAddr5",
DstMacAddrGroup: "sub_DstMacAddr0 sub_DstMacAddr1 sub_DstMacAddr2 sub_DstMacAddr3 sub_DstMacAddr4 sub_DstMacAddr5"
},
"rules": {
"Name:MACFilter": {
"required": true,
"utf8": true,
"utf8LengthRange":[1,32]
},
"sub_SrcMacAddr0": MACCheckRules,
"sub_SrcMacAddr1": MACCheckRules,
"sub_SrcMacAddr2": MACCheckRules,
"sub_SrcMacAddr3": MACCheckRules,
"sub_SrcMacAddr4": MACCheckRules,
"sub_SrcMacAddr5": MACCheckRules,
"sub_DstMacAddr0": MACCheckRules,
"sub_DstMacAddr1": MACCheckRules,
"sub_DstMacAddr2": MACCheckRules,
"sub_DstMacAddr3": MACCheckRules,
"sub_DstMacAddr4": MACCheckRules,
"sub_DstMacAddr5": MACCheckRules
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
$("[id^='Type']",template).change(function(event){
var TypeOBJ = $(this);
var template = TypeOBJ.parents("[id^='template_']");
var type = TypeOBJ.val();
var controlledOBJ = $("[id^='div_DstMacAddr']", template);
var bridgeSelectStr = "<select class='w150' id='select_protocol' name='select_protocol' class='PostIgnore'>"
+"<option value='ALL' title='&?public_039;'>&?public_039;</option>"
+"<option value='IP' title='&?public_044;'>&?public_044;</option>"
+"<option value='ARP' title='&?public_045;'>&?public_045;</option>"
+"<option value='RARP' title='&?public_046;'>&?public_046;</option>"
+"<option value='PPPoE' title='&?public_047;'>&?public_047;</option>"
+"</select>";
var routeSelectStr = "<select class='w150' id='select_protocol' name='select_protocol' class='PostIgnore'>"
+"<option value='ALL' title='&?public_039;'>&?public_039;</option>"
+"<option value='IP' title='&?public_044;'>&?public_044;</option>"
+"</select>";
var protocolTmpStr = bridgeSelectStr;
if ( type == "Route" )
{
controlledOBJ.hide();
$("[id^='DstMacAddr']",template).addClass("PostIgnore");
protocolTmpStr = routeSelectStr;
}
else
{
controlledOBJ.show();
$("[id^='DstMacAddr']",template).removeClass("PostIgnore");
}
$("[id^='div_Protocol']",template).empty().append(protocolTmpStr);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Name");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_MACFILTER_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_MACFilter(CustomizeParams);
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var MACJSON = {
"SrcMacAddr":"sub_SrcMacAddr",
"DstMacAddr":"sub_DstMacAddr"
};
for (var MACTmp in MACJSON)
{
$("[id^='"+MACTmp+"']",template).FillIPorMacDataCombination(MACJSON[MACTmp],":", 6);
}
var selectProtocolVal = $("[id^='select_protocol']",template).val();
$("[id^='Protocol']",template).val(selectProtocolVal);
});
}
$(document).ready(function(){
var HeadID = "MACFilter";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_MACFilter(templateID);
Head.succfunction = function(xml){
$("[id^='Type']").change();
Head.hasError(xml,"externErrorHint");
var MACFILTEROBJ = $(xml).find("OBJ_MACFILTER_ID");
var RuleNum = $("Instance", MACFILTEROBJ).length;
var OBJID = ["OBJ_MACFILTER_ID"];
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
