<script type="text/javascript">
(function () {
function initial_QueryAccessDeviceLinkDmz()
{
var linkSelector = "._LuQUID_SelAccessDeviceDmz";
var selDevLinks = $(linkSelector);
if ( selDevLinks.length == 0 )
{
return;
}
selDevLinks.each(function(){
var selDevLink = $(this);
selDevLink.css("display", "block");
var rowObj = selDevLink.parents(".row").eq(0);
rowObj.append("<div class='clear'></div>");
var macID = rowObj.find(".mac").eq(0).attr("id");
var macIDStriped = macID;
var paraID = macIDStriped.match(/^sub_(.+)\d$/)[1];
var headID = selDevLink.parents(".HeadDIV").attr("id");
var suffix = ":"+paraID+":"+headID;
var devListHTML = ''
+ '<div class="_LuQUID_AccessDeviceList" name="_LuQUID_AccessDeviceInfo'+suffix+'" style="display:none;">'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_InstNum'+suffix+'" value="0">'
+ '<p id="_LuQUID_NoAccessDev'+suffix+'">&?public_145;</p>'
+ '<p id="_LuQUID_template_AccessDeviceInfo'+suffix+'" style="display:none">'
+ '<label class="cfgLabel">&nbsp;</label>'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_HostName'+suffix+'" value="">'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_MACAddress'+suffix+'" value="">'
+ '<input type="hidden" class="PostIgnore" id="_LuQUID_IPAddress'+suffix+'" value="">'
+ '<input type="radio" class="PostIgnore" id="_LuQUID_AccessDeviceRadio'+suffix+'" name="_LuQUID_AccessDeviceRadio'+suffix+'" value=""/>'
+ '<label for="_LuQUID_AccessDeviceRadio'+suffix+'">'
+ '&?public_146;: [<span id="_LuQUID_StrHostName'+suffix+'">&?public_006;</span>]'
+ '-&?public_010;: [<span id="_LuQUID_StrMACAddress'+suffix+'"></span>]'
+ '-&?public_044;: [<span id="_LuQUID_StrIPAddress'+suffix+'"></span>]'
+ '</label>'
+ '</p>'
+ '<a class="_LuQUID_HideAccessDevice">&?public_144;</a>'
+ '</div>';
var macObj = rowObj.find(".right");
var devListObj = $(devListHTML).insertAfter(macObj);
var labelObj = selDevLink.parent().prev();
var labelWidth = labelObj.css("width");
devListObj.css("margin-left", labelWidth);
});
var devRadios = $("input[name^='_LuQUID_AccessDeviceRadio']");
devRadios.click(function(event){
var devRadio = $(this);
var templateSelector = "[id^='_LuQUID_template_AccessDeviceInfo']";
var templateDev = devRadio.parents(templateSelector);
var devListObj = devRadio.parents("[name^='_LuQUID_AccessDeviceInfo']");
var rowObj = devRadio.parents(".row").eq(0);
var deviceRadioSelector = "input[name^='_LuQUID_AccessDeviceRadio']";
$(deviceRadioSelector, devListObj).prop("checked", false);
devRadio.prop("checked", true);
var devMACObj = $("[id^='_LuQUID_MACAddress']", templateDev);
var macID = rowObj.find(".mac").eq(0).attr("id");
var macIDStriped = colonStrippingLast(macID);
var subID = macIDStriped.match(/^(sub_.+)\d$/)[1];
devMACObj.FillIPorMacDataBySplit(subID, ":", 6);
if(devListObj.parents("[id^='template_Ipv4Dmz']").length>0)
{
var mac = devMACObj.val();
var template = devListObj.parents("[id^='template_Ipv4Dmz']");
$("[id^='InternalClient']",template).val(mac);
}
var lastSubMAC = rowObj.find(".mac").last();
lastSubMAC.focus().blur();
});
var hideDevLinks = $("._LuQUID_HideAccessDevice");
hideDevLinks.unbind("click");
hideDevLinks.click(function(event){
event.preventDefault();
var devListObj = $(this).parents("[name^='_LuQUID_AccessDeviceInfo']");
devListObj.hide();
});
selDevLinks.unbind("click");
selDevLinks.click(function(event){
event.preventDefault();
var selDevLink = $(this);
var rowObj = selDevLink.parents(".row");
var devListObj = rowObj.find("[name^='_LuQUID_AccessDeviceInfo']");
if (devListObj.is(":visible"))
{
devListObj.hide();
return;
}
var InstNumBefore = $("[id^='_LuQUID_InstNum']", devListObj).val();
for ( var i=0; i<InstNumBefore; i++ )
{
var selector = "[id$='_"+i+"']"
+"[id^='_LuQUID_template_AccessDeviceInfo']";
$(selector, devListObj).remove();
}
devListObj.AccessDeviceXMLDealWith = function(xml){
devListObj.hasError(xml,"externErrorHint");
var ACCESSDEVRuleOBJ = $(xml).find("OBJ_ACCESSDEV_ID");
var RuleNum = $("Instance", ACCESSDEVRuleOBJ).length;
var OBJID = ["OBJ_ACCESSDEV_ID"];
var templateSelector = "[id^='_LuQUID_template_AccessDeviceInfo']";
var TemplateOBJ = $(templateSelector, devListObj);
$("[id^='_LuQUID_InstNum']", devListObj).val(RuleNum);
var NoAccessDevObj = $("[id^='_LuQUID_NoAccessDev']", devListObj);
if (RuleNum == 0 )
{
NoAccessDevObj.show();
}
else
{
NoAccessDevObj.hide();
}
for (var i=0; i<RuleNum; i++)
{
var clone = TemplateOBJ.cloneWithSuffix(i);
TemplateOBJ.before(clone);
clone.fillDataByOBJID(xml, OBJID, clone, i);
var HostNameStr = $("[id^='_LuQUID_HostName']", clone).val();
var IPAddress = $("[id^='_LuQUID_IPAddress']", clone).val();
var MACAddress = $("[id^='_LuQUID_MACAddress']", clone).val();
if (HostNameStr == "")
{
if (IPAddress != "")
{
HostNameStr = "PC" + IPAddress;
}
else if (MACAddress != "")
{
HostNameStr = "PC" + MACAddress
}
else
{
HostNameStr = "&?public_006;";
}
}
$("[id^='_LuQUID_StrHostName']", clone).text(HostNameStr);
var MACAddress = $("[id^='_LuQUID_MACAddress']", clone).val();
$("[id^='_LuQUID_StrMACAddress']", clone).text(MACAddress);
var IPAddress = $("[id^='_LuQUID_IPAddress']", clone).val();
$("[id^='_LuQUID_StrIPAddress']", clone).text(IPAddress);
clone.show();
}
devListObj.show();
};
var accessMode = selDevLink.attr("_LuQUID_Access_Mode")
var AccessModeSet =
[
"ETH",
"WLAN",
"ALL"
];
if ( -1 == $.inArray(accessMode, AccessModeSet) )
{
var devTypeList = AccessModeSet.join("/")
consoleLog("_LuQUID_Access_Mode must be set as one of "+devTypeList);
return ;
}
var ServerAddr = "/?_type=hiddenData&_tag=accessdev_data&";
ServerAddr += "DeveiceType="+accessMode;
showWaitTip(true);
devListObj.dataTransfer(ServerAddr,
"GET",
devListObj.AccessDeviceXMLDealWith,
undefined,
undefined,
false);
});
}
function initial_template_Ipv4Dmz(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
var checkJson = {
"rules": {
"InternalClient": {
"required": true,
"ASCII": true
}
},
"messages": {
}
};
$.publish("/some/dmzModify", [checkJson]);
instForm.validate(checkJson);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_FWDMZ_ID"];
ActionByCancelResult(xml, template, OBJID);
});
}
$(document).ready(function(){
var HeadID = "Ipv4Dmz";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_Ipv4Dmz(templateID);
initial_QueryAccessDeviceLinkDmz();
$.publish("/some/dmzEntryModify", Head);
Head.succfunction = function(xml){
var template = $("[id^='template_']",Head);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_FWDMZ_ID"];
Head.fillDataByOBJID(xml ,OBJID, template,0);
$.callModifier("Ipv4Dmz/WANCViewName/onlyInternet");
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
