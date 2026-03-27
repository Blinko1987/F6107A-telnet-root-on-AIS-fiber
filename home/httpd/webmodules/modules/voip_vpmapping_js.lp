<script type="text/javascript">
(function(){
function initial_template_VPMapping(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
if (ActionByApplyResult(xml, template) == 0)
{
template.trigger("fillDataByCustom", [0, template, xml]);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPVPLINE_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var PhyListVal = "";
var Phone1EnableVal = $("input:radio[name^='Phone1Enable']:checked", template).val();
var Phone2EnableVal = $("input:radio[name^='Phone2Enable']:checked", template).val();
if(Phone1EnableVal == "1" && Phone2EnableVal == "1")
{
PhyListVal = "0,1";
}
else
{
if(Phone1EnableVal == "1")
{
PhyListVal = "0";
}
else if(Phone2EnableVal == "1")
{
PhyListVal = "1";
}
}
$("[id^='PhyList']",template).val(PhyListVal);
});
}
function setRadioByName(RadiaoName,Val,template)
{
var radioObj = $("[name^="+RadiaoName+"]",template);
radioObj.each(function(){
var thisObj = $(this);
if (Val == thisObj.val())
{
thisObj.prop("checked", true);
}
else
{
thisObj.prop("checked", false);
}
});
}
$(document).ready(function(){
var VPMappingHeadID = "VPMapping";
var VPMappingHead = $("#"+VPMappingHeadID);
var ServerAddr = $("address span", VPMappingHead).text();
initial_template_VPMapping("template_"+VPMappingHeadID);
VPMappingHead.fillDataByCustom = function(suffix,ContainerOBJ){
var PhoneIndex = parseInt(suffix)+1;
var VPMappingBarOBJ = ContainerOBJ.find("[id^='VPMappingBar']");
VPMappingBarOBJ.append(PhoneIndex);
var PhyListVal = $("[id^='PhyList']",ContainerOBJ).val();
var arr_PhyList = PhyListVal.split(",");
var Phone1Val = "0";
var Phone2Val = "0";
if(arr_PhyList != "")
{
if(arr_PhyList.length == 2)
{
Phone1Val = "1";
Phone2Val = "1";
}
else
{
if("0" == PhyListVal)
Phone1Val = "1";
else
Phone2Val = "1";
}
}
setRadioByName("Phone1Enable",Phone1Val,ContainerOBJ);
setRadioByName("Phone2Enable",Phone2Val,ContainerOBJ);
};
VPMappingHead.succfunction = function(xml){
VPMappingHead.hasError(xml);
var VPMappingOBJ = $(xml).find("OBJ_VOIPVPLINE_ID");
var RuleNum = $("Instance", VPMappingOBJ).length;
var OBJID = ["OBJ_VOIPVPLINE_ID"];
VPMappingHead.createPageDataByClone(RuleNum, OBJID, xml,
VPMappingHead.fillDataByCustom);
$(".collapsibleBar", VPMappingHead).eq(0).click();
};
VPMappingHead.dataTransfer(ServerAddr,
"GET",
VPMappingHead.succfunction);
});
})();
</script>
