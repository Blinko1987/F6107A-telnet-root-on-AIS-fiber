<script type="text/javascript">
(function () {
function findBandOfSSID(template, xml)
{
var CardInstID = $("[id^='WLANViewName_']", template).val();
var OBJ = "OBJ_WLANSETTING_ID";
var WLANSettingXML = $(xml).find(OBJ);
var cardInsts = WLANSettingXML.find("Instance");
var cardNum = cardInsts.length;
var band = "";
for ( var i=0; i<cardNum; i++ )
{
var ToOperParaArray = {
"_InstID" : {
ValueOrigin: ""
},
"Band" : {
ValueOrigin: ""
}
};
xmlParaInInstOperate(xml, OBJ, i, ToOperParaArray);
var instid = ToOperParaArray["_InstID"].ValueOrigin;
if ( instid == CardInstID )
{
band = ToOperParaArray["Band"].ValueOrigin;
break;
}
}
return band;
}
function initial_template_ACLPolicy(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
var templateID = template.attr("id");
if (template.hasError(xml) == 0)
{
succHintShow(template);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var templateID = template.attr("id");
var isError = template.hasError(xml);
if (isError == 0)
{
var RuleNum = $("#_InstNum", template).val();
for (var i=0; i<RuleNum; i++)
{
var _InstID = $("[id^='_InstID_']", template).eq(i).val();
var RuleObj = $("[id^='div_ACLPolicy_']", template).eq(i);
var DataOBJID = ["OBJ_WLANAP_ID"];
var suffix = getInstIndexByPath(xml, DataOBJID[0], _InstID);
RuleObj.fillDataByOBJID(xml, DataOBJID, RuleObj, suffix, "_");
}
}
});
}
$(document).ready(function(){
var HeadID = "MACFilterACLPolicy";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_ACLPolicy("template_"+HeadID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var SSIDOBJ = $(xml).find("OBJ_WLANAP_ID");
var RuleNum = $("Instance", SSIDOBJ).length;
$("#_InstNum", Head).val(RuleNum);
var objACLPolicy = $("#div_ACLPolicy");
for (var i=0; i<RuleNum; i++)
{
var clone = objACLPolicy.cloneWithSuffix(i, "_");
objACLPolicy.before(clone);
var DataOBJID = ["OBJ_WLANAP_ID"];
clone.fillDataByOBJID(xml, DataOBJID, clone, i, "_");
var AliasName = $("[id^='Alias_']",clone).val();
$("label[for^='ACLPolicy_']", clone).text(AliasName)
clone.showIt(true);
}
$.publish("/some/softVersionModify", [Head]);
$.callModifier("/wlanmacfil/addsceneTip");
};
wlanDisableControl(HeadID);
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
