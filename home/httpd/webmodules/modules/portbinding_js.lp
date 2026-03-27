<script type="text/javascript">
(function(){
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_PORT_BINDING_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
ContainerOBJ.collapsibleInstTitleChange("WAN_name");
var LANBinded = $("[id^='LANViewName']",ContainerOBJ).val();
var LANBindArray = LANBinded.split(",");
$("[id^='template_WANLAN_']",ContainerOBJ).each(function(){
var LANTemplate = $(this);
var LANInst = $("[id^='_InstID_LAN_']",LANTemplate).val();
var Elem = $(":checkbox", LANTemplate);
if ( $.inArray(LANInst,LANBindArray) != -1 )
{
Elem.prop("checked", true);
}
else
{
Elem.prop("checked",false);
}
});
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var LANViewStr = "";
$("[id^='template_WANLAN_']",template).each(function(){
var LANTemplate = $(this);
var Elem = $(":checkbox", LANTemplate);
if( Elem.is(':checked'))
{
LANViewStr = LANViewStr
+ $("[id^='_InstID_LAN']",LANTemplate).val()
+ ",";
}
});
$("[id^='LANViewName']",template).val(LANViewStr);
});
}
function division_checkbox()
{
var tempname = "";
return function (lanvalue)
{
var ret = false;
if ("" == tempname)
{
tempname = lanvalue.replace(/\d+$/, "");
ret = false;
}
else
{
var str = lanvalue.replace(/\d+$/, "");
if (str != tempname)
{
ret = true;
tempname = str;
}
}
return ret;
}
}
$(document).ready(function(){
var HeadID = "PortBindingConf";
var Head = $("#"+HeadID);
var templateID = "template_"+HeadID;
var ServerAddr = $("address span", Head).text();
initial_template(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
Head.hasError(xml,"externErrorHint");
var OBJ_LAN = $(xml).find("OBJ_WANLAN_ID");
var RuleNum_LAN = $("Instance", OBJ_LAN).length;
var TemplateLANOBJ = $("#template_WANLAN", Head);
var tempfun = division_checkbox();
for (var i=0; i<RuleNum_LAN; i++)
{
var clone = TemplateLANOBJ.cloneWithSuffix(i,"_");
var instances;
instances = $("Instance", OBJ_LAN);
var InstOBJ = instances.eq(i);
var tempret = false;
InstOBJ.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ("LAN_name" == ParaName)
{
tempret = tempfun(ParaValue);
}
var Elems = $("[id^='"+ParaName+"']", clone);
if ( Elems.length > 0 )
{
Elems.fillDataByType(ParaValue);
}
});
if (tempret)
{
TemplateLANOBJ.before("</br><div class='clear'></div>");
}
TemplateLANOBJ.before(clone);
clone.showIt(true);
}
var OBJ_PORTBind = $(xml).find("OBJ_PORT_BINDING_ID");
var RuleNum = $("Instance", OBJ_PORTBind).length;
if (0 == RuleNum)
{
$(".noDataHint",Head).showIt(true);
}
else
{
var OBJID = ["OBJ_PORT_BINDING_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
}
$.publish("/some/softVersionModify", [Head]);
$.publish("/some/sncTAHidden", [Head]);
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
