<script type="text/javascript">
(function(){
function FillOption(template){
var MaxBitRate = $("[id^='MaxBitRate:']", template).val();
var DuplexMode = $("[id^='DuplexMode:']", template).val();
var Auto = $("[id^='Autoneg:']", template).val();
if(MaxBitRate == "3" && DuplexMode == "1" && Auto !="1")
{
$("[id^='Mod1000MH']", template).prop("checked", true);
}
else if(MaxBitRate == "3" && DuplexMode == "2" && Auto !="1")
{
$("[id^='Mod1000MF']", template).prop("checked", true);
}
if(MaxBitRate == "2" && DuplexMode == "1" && Auto !="1")
{
$("[id^='Mod100MH']", template).prop("checked", true);
}
else if(MaxBitRate == "2" && DuplexMode == "2" && Auto !="1")
{
$("[id^='Mod100MF']", template).prop("checked", true);
}
else if(MaxBitRate == "1" && DuplexMode == "1" && Auto !="1")
{
$("[id^='Mod10MH']", template).prop("checked", true);
}
else if(MaxBitRate == "1" && DuplexMode == "2" && Auto !="1")
{
$("[id^='Mod10MF']", template).prop("checked", true);
}
else if(Auto =="1")
{
$("[id^='Auto']", template).prop("checked", true);
}
else
{
}
}
function initial_template_lanInterface(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
if (template.hasError(xml) == 0)
{
var OBJID = ["OBJ_LANCONF_ID"];
ActionByCancelResult(xml, template, OBJID);
}
});
template.bind("fillDataByCustom", function(event, suffix, template,xml){
var OBJ = $(xml).find("OBJ_LANCONF_ID");
var instances = $("Instance", OBJ);
for ( var i=0; i<instances.length; i++ )
{
FillOption(template);
}
});
template.bind("hiddenValueChangeByCustom", function(event,template){
if($("[id^='Mod1000MH']", template).is(':checked'))
{
$("[id^='MaxBitRate:']", template).val("3" );
$("[id^='DuplexMode:']", template).val("1");
$("[id^='Autoneg:']", template).val("0");
}
else if($("[id^='Mod1000MF']", template).is(':checked'))
{
$("[id^='MaxBitRate:']", template).val("3" );
$("[id^='DuplexMode:']", template).val("2");
$("[id^='Autoneg:']", template).val("0");
}
if($("[id^='Mod100MH']", template).is(':checked'))
{
$("[id^='MaxBitRate:']", template).val("2" );
$("[id^='DuplexMode:']", template).val("1");
$("[id^='Autoneg:']", template).val("0");
}
else if($("[id^='Mod100MF']", template).is(':checked'))
{
$("[id^='MaxBitRate:']", template).val("2" );
$("[id^='DuplexMode:']", template).val("2");
$("[id^='Autoneg:']", template).val("0");
}
else if($("[id^='Mod10MH']", template).is(':checked'))
{
$("[id^='MaxBitRate:']", template).val("1" );
$("[id^='DuplexMode:']", template).val("1");
$("[id^='Autoneg:']", template).val("0");
}
else if($("[id^='Mod10MF']", template).is(':checked'))
{
$("[id^='MaxBitRate:']", template).val("1" );
$("[id^='DuplexMode:']", template).val("2");
$("[id^='Autoneg:']", template).val("0");
}
else if($("[id^='Auto']", template).is(':checked'))
{
$("[id^='Autoneg:']", template).val("1");
}
else
{
}
});
}
$(document).ready(function(){
var HeadID = "lanInterface";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_lanInterface(templateID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
var OBJID = ["OBJ_LANCONF_ID"];
Head.fillData = function(suffix, template)
{
FillOption(template);
};
var lanconf = $(xml).find("OBJ_LANCONF_ID");
var RuleNum = $("Instance", lanconf).length;
Head.createPageDataByClone(RuleNum, OBJID, xml,Head.fillData);
for(i=0;i<RuleNum;i++){
$(".instName").eq(i).text("LAN"+(i+1));
}
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,"GET",Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
