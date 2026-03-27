<script type="text/javascript">
<%
local curv = CountryCode
local NoRightDiff = false
if _G.ssidConf["NoRightDiff"] ~= nil then
if string.find(_G.ssidConf["NoRightDiff"],"WlanBasicAdConf") ~= nil then
NoRightDiff = true
end
elseif _G.ssidConf[Right] ~= nil and _G.ssidConf[Right].NoRightDiff ~= nil then
if string.find(_G.ssidConf[Right].NoRightDiff,"WlanBasicAdConf") ~= nil then
NoRightDiff = true
end
end
%>
var curv = "<%=CountryCode%>";
(function () {
<%
cgilua_lp.include("../../webmodules/modules/wlan_basic_comm_js.lp", getfenv(1))
%>
var g_CfgGlobalXMLLocalCache;
function g_getChannelListFromXMLCache(countryCodeIN, bandIN, bandWidthIN)
{
var xml = g_CfgGlobalXMLLocalCache;
var OBJ = $(xml).find("OBJ_CHANNEL_ID");
var instances = $("Instance", OBJ);
var ChannelList = "";
instances.each(function(i){
var inst = $(this);
var CountryCode = "";
var Band = "";
var BandWidth = "";
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if ( ParaName == "CountryCode" )
{
CountryCode = ParaValue;
}
else if ( ParaName == "Band" )
{
Band = ParaValue;
}
else if ( ParaName == "BandWidth" )
{
BandWidth = ParaValue;
}
else if ( ParaName == "ChannelList" )
{
ChannelList = ParaValue;
}
else
{
}
});
if ( countryCodeIN == CountryCode
&& Band == bandIN
&& BandWidth == bandWidthIN )
{
return false;
}
});
return ChannelList;
}
function g_getCountryCodeFromXMLCache(cardID)
{
var xml = g_CfgGlobalXMLLocalCache;
var OBJ = $(xml).find("OBJ_WLANSETTING_ID");
var instances = $("Instance", OBJ);
for ( var i=0; i<instances.length; i++ )
{
var ToOperParaArr = {
"_InstID" : {
ValueOrigin: ""
},
"CountryCode" : {
ValueOrigin: ""
}
}
xmlParaInInstOperate(xml, "OBJ_WLANSETTING_ID", i, ToOperParaArr);
if ( cardID == ToOperParaArr["_InstID"].ValueOrigin )
{
return ToOperParaArr["CountryCode"].ValueOrigin;
}
}
return null;
}
function g_fulfilWorkModeOption(template)
{
var cardMode = $("[id^='CardMode:']", template).val();
var cardMode2Standard = {
"b,g,bg" : ["b", "g", "b,g"],
"b,g,n,bg,gn,bgn" : ["b", "g", "n", "b,g", "g,n", "b,g,n"],
"a,n,an" : ["a", "n", "a,n"],
"a,b,g,n,an,bg,gn,bgn" : ["a", "b", "g", "n", "a,n", "b,g", "g,n", "b,g,n"],
"a,n,an,anac,ac" : ["a", "n", "ac", "a,n", "a,n,ac"]
,
"b,g,n,bg,gn,bgn,bgnax":["b", "g", "n", "b,g", "g,n", "b,g,n", "b,g,n,ax"],
"a,n,an,anac,ac,anacax":["a", "n", "ac", "a,n", "a,n,ac", "a,n,ac,ax"]
}
var standard2Name = {
"a" : "&?WlanBasicAd_074;",
"b" : "&?WlanBasicAd_066;",
"g" : "&?WlanBasicAd_067;",
"n" : "&?WlanBasicAd_068;",
"a,n" : "&?WlanBasicAd_075;",
"b,g" : "&?WlanBasicAd_070;",
"g,n" : "&?WlanBasicAd_069;",
"b,g,n" : "&?WlanBasicAd_071;",
"a,n,ac" : "&?WlanBasicAd_079;",
"ac" : "&?WlanBasicAd_091;",
"b,g,n,ax":"&?WlanBasicAd_114;",
"a,n,ac,ax":"&?WlanBasicAd_115;"
}
var standardObj = $("[id^='UI_Standard:']", template);
var standardID = standardObj.attr('id');
var selectStr = '<select name="'+standardID+'" id="'+standardID
+'" class="selectLong PostIgnore">';
var standardSet = cardMode2Standard[cardMode];
for ( var index in standardSet )
{
var standard = standardSet[index];
var standardName = standard2Name[standard];
selectStr += "<option value ="+standard+" title='"+standardName+"'>"
+standardName+"</option>";
}
selectStr += "</select>"
standardObj.replaceWith(selectStr);
$("[id^='UI_Standard:']", template).change(function(){
var template = $(this).parents("[id^=template_]");
<%
if (Right=="1") or NoRightDiff or (curv=="14") or (curv=="112") or (curv=="3") or (curv=="1")
or (curv=="163") or (curv=="137") or (curv=="146") or (curv=="66") or (curv=="37") then
%>
g_fulfilBandWidthOption(template);
g_PageUpdate_WlanBasicAdConf(template);
if(!$("[id^='QosType:']", template).hasClass("PostIgnore"))
{
var Standard = $("[id^='UI_Standard:']", template).val();
var qosType = $("[id^='QosType:']", template).val();
if ( "n" == Standard && "Disabled" == qosType )
{
alert("&?WlanBasicAd_035;");
}
}
<%
elseif Right == "2" then
%>
g_updateChannelWithStatus(template);
<%
else
end
%>
});
}
function g_displayWorkModeCurVal(template)
{
var Standard = $("[id^='Standard:']", template).val();
$("[id^='UI_Standard:']", template).val(Standard);
}
function g_fulfilSideBandOption(template)
{
var band = $("[id^='Band:']", template).val();
var bandWidth = $("[id^='UI_BandWidth:']", template).val();
var countryCode = $("[id^='CountryCode:']", template).val();
var channel = $("[id^='UI_Channel:']", template).val();
var channelList = g_getChannelListFromXMLCache(countryCode, band, bandWidth);
var channelArr = channelList.split(",");
var lowerOpStr = "<option value='BelowControlChannel' title='&?WlanBasicAd_072;'>&?WlanBasicAd_072;</option>";
var upperOpStr = "<option value='AboveControlChannel' title='&?WlanBasicAd_073;'>&?WlanBasicAd_073;</option>";
var optStr2ChannelTable = {};
var OpStr = {
"lower": lowerOpStr,
"upper": upperOpStr,
"lower&up": lowerOpStr+upperOpStr
};
var channelmax =Math.max.apply(null,channelArr)
if (channelmax == 11 && band == "2.4GHz")
{
optStr2ChannelTable = {
"upper": [1,2,3,4],
"lower": [8,9,10,11],
"lower&up": [5,6,7]
};
}
else if (channelmax == 13 && band == "2.4GHz")
{
optStr2ChannelTable = {
"upper": [1,2,3,4],
"lower": [10,11,12,13],
"lower&up": [5,6,7,8,9]
};
}
var sideBandObj = $("[id^='UI_SideBand:']", template);
var sideBandID = sideBandObj.attr("id");
var selectStr = '<select name="'+sideBandID+'" id="'+sideBandID
+'" class="selectLong PostIgnore">';
for ( var segmentName in optStr2ChannelTable )
{
var segmentValues = optStr2ChannelTable[segmentName];
for ( var channelTmp in segmentValues )
{
if ( segmentValues[channelTmp] == channel )
{
selectStr += OpStr[segmentName];
}
}
}
selectStr += '</select>';
sideBandObj.replaceWith(selectStr);
}
function g_displaySideBandCurVal(template)
{
var sideband = $("[id^='SideBand:']", template).val();
$("[id^='UI_SideBand:']", template).val(sideband);
}
function g_CtrlDispCtrl_WlanBasicAdConf(template)
{
var Standard = $("[id^='UI_Standard:']", template).val();
var BandWidth = $("[id^='UI_BandWidth:']", template).val();
var Channel = $("[id^='UI_Channel:']", template).val();
var Band = $("[id^='Band:']", template).val();
if("41" == curv)
{
$("[id^='div_CountryCode:']", template).hide();
$("[id^='div_TxPower:']", template).hide();
}
if((curv == "1" || curv == "14" || curv == "66") && Band != "5GHz")
{
$("[id^='div_MUMIMOEnable:']",template).hide()
}
if("36" == curv)
{
var countryCode = $("[id^='CountryCode:1']", template).val();
if(countryCode == "THI" || countryCode == "USI")
{
$("[id^='div_BandBEnabled:1']", template).show();
$("[id^='BandBEnabled:1']", template).val("0");
}
else if(countryCode == "TH_2" || countryCode == "US_2I" )
{
$("[id^='div_BandBEnabled:1']", template).show();
$("[id^='BandBEnabled:1']", template).val("1");
}
else
{
$("[id^='div_BandBEnabled:1']", template).hide();
}
}
if ( (Standard == "n")
|| (Standard == "g,n")
|| (Standard == "a,n")
|| (Standard == "a,n,ac")
|| (Standard == "b,g,n")
|| (Standard == "ac")
||(Standard == "b,g,n,ax")
||(Standard == "a,n,ac,ax"))
{
var divBandWidth = $("[id^='div_BandWidth:']", template);
var inputBandWidth = $("[id^='BandWidth:']", template);
if ( divBandWidth.length == 0 )
{
inputBandWidth.addClass("PostIgnore");
}
else
{
divBandWidth.show();
inputBandWidth.removeClass("PostIgnore");
}
$("[id^='div_SGIEnabled:']", template).show();
$("[id^='SGIEnabled']", template).removeClass("PostIgnore");
if ( ( BandWidth == "40MHz" || BandWidth == "Auto" )
&& Channel != "Auto"
&& Band != "5GHz" )
{
$("[id^='div_SideBand:']", template).show();
$("[id^='SideBand:']", template).removeClass("PostIgnore");
}
else
{
$("[id^='div_SideBand:']", template).hide();
$("[id^='SideBand:']", template).addClass("PostIgnore");
}
}
else
{
$("[id^='div_BandWidth:']", template).hide();
$("[id^='BandWidth:']", template).addClass("PostIgnore");
$("[id^='div_SGIEnabled:']", template).hide();
$("[id^='SGIEnabled']", template).addClass("PostIgnore");
$("[id^='div_SideBand:']", template).hide();
$("[id^='SideBand:']", template).addClass("PostIgnore");
}
if(curv == "1" || curv == "66" )
{
$("[id^='div_QosType:']",template).show();
$("[id^='QosType:']",template).removeClass("PostIgnore");
if(Band == "2.4GHz")
{
$("[id^='div_PreambleType:']",template).show();
}
}
if(curv == "1")
{
$("[id^='div_SSIDIsolationEnable:']",template).show();
$("[id^='SSIDIsolationEnable:']",template).removeClass("PostIgnore");
}
<%if curv == "66" and Right == "2" then %>
$("[id^='CountryCode:']",template).attr("disabled",true);
$("[id^='CountryCode:']",template).addClass("PostIgnore");
<%end%>
g_CtrlWlanBasicAdConf(template);
}
function g_fulfilChannelOption( tempObj )
{
var countryCodeOBJ = $("[id^='CountryCode:']", tempObj);
var countryCode;
if ( countryCodeOBJ.length )
{
countryCode = countryCodeOBJ.val();
}
else
{
var cardID = $("[id^='_InstID:']", tempObj).val();
countryCode = g_getCountryCodeFromXMLCache(cardID);
}
var channelObj = $("[id^='UI_Channel:']", tempObj);
var channelID = channelObj.attr("id");
var selectStr = '<select name="'+channelID+'" id="'+channelID
+'" class="selectLong PostIgnore">';
selectStr += "<option value='Auto' title='&?public_071;'>&?public_071;</option>";
var band = $("[id^='Band:']", tempObj).val();
var bandWidthObj = $("[id^='UI_BandWidth:']", tempObj);
var bandWidth;
var Standard = $("[id^='UI_Standard:']", tempObj).val();
if ( Standard.indexOf("n") == -1 && Standard != "ac")
{
bandWidth = "20MHz";
}
else
{
if ( bandWidthObj.length > 0 )
{
bandWidth = bandWidthObj.val();
}
else
{
bandWidthObj = $("[id^='BandWidth:']", tempObj);
bandWidth = bandWidthObj.val();
}
}
var channelList = g_getChannelListFromXMLCache(countryCode, band, bandWidth);
var channelArr = channelList.split(",");
for (var i=0; i<channelArr.length; i++)
{
selectStr += "<option value='" + channelArr[i]
+ "' title='" + channelArr[i] + "'>"
+ channelArr[i] + "</option>";
}
selectStr += '</select>';
channelObj.replaceWith(selectStr);
$("[id^='UI_Channel:']", tempObj).change(function(){
<%
if (Right=="1") or NoRightDiff or (curv=="14") or (curv=="112") or (curv=="3") or (curv=="1") or (curv=="163") or (curv=="137") or (curv=="146") then
%>
var template = $(this).parents("[id^=template_]");
g_PageUpdate_WlanBasicAdConf(template);
<%
end
%>
});
}
function g_displayChannelCurVal( tempObj )
{
var AutoChannelEnabled = $("[id^='AutoChannelEnabled:']", tempObj).val();
var channelVal;
if ( AutoChannelEnabled == "1" )
{
channelVal = "Auto";
}
else
{
channelVal = $("[id^='Channel:']", tempObj).val();
}
$("[id^='UI_Channel:']", tempObj).val(channelVal);
}
function g_fulfilBandWidthOption(template)
{
var band = $("[id^='Band:']", template).val();
var BandWidth = $("[id^='UI_BandWidth:']", template);
var Standard = $("[id^='UI_Standard:']", template).val();
var bandWidthID = BandWidth.attr('id');
var selectBegin = '<select name="'+bandWidthID+'" id="'+bandWidthID +'" class="selectLong PostIgnore">';
var optionAutoStr = "<option value ='Auto' title='&?public_071;'>&?public_071;</option>";
var option20Str = "<option value ='20MHz' title='20&?public_132;'>20&?public_132;</option>";
var option40Str = "<option value ='40MHz' title='40&?public_132;'>40&?public_132;</option>";
var option80Str = "<option value ='80MHz' title='80&?public_132;'>80&?public_132;</option>";
var option160Str = "<option value ='160MHz' title='160&?public_132;'>160&?public_132;</option>";
var selectEnd = "</select>";
var selectStr = selectBegin;
if ( "5GHz" == band )
{
selectStr += optionAutoStr + option20Str + option40Str;
if ( "a,n,ac" == Standard || "ac" == Standard || "a,n,ac,ax" == Standard)
{
selectStr += option80Str;
selectStr += option160Str;
}
}
else
{
if("17"==curv)
{
optionAutoStr = "<option value ='Auto' title='20/40&?public_132;'>20/40&?public_132;</option>";
}
selectStr += optionAutoStr + option20Str + option40Str;
}
selectStr += selectEnd;
BandWidth.replaceWith(selectStr);
$("[id^='UI_BandWidth:']", template).change(function(){
var template = $(this).parents("[id^=template_]");
g_PageUpdate_WlanBasicAdConf(template);
});
}
function g_displayBandWidthCurVal(template)
{
var BandWidth = $("[id^='BandWidth:']", template).val();
$("[id^='UI_BandWidth:']", template).val(BandWidth);
}
function g_setBandWidthDefaultOption(template)
{
var bandWidthObj = $("[id^='UI_BandWidth:']", template);
var standard = $("[id^='UI_Standard:']", template).val();
var band = $("[id^='Band:']", template).val();
if ( "2.4GHz" == band )
{
bandWidthObj.val("Auto");
}
else
{
if ( "a,n,ac" == standard || "ac" == standard || "a,n,ac,ax" == standard)
{
bandWidthObj.val("80MHz");
}
else
{
bandWidthObj.val("40MHz");
}
}
}
function g_updateChannelWithStatus(template)
{
var channel = $("[id^='UI_Channel:']", template).val();
g_fulfilChannelOption(template);
var optObj = $("[id^='UI_Channel:'] option[value='"+channel+"']", template);
if ( 0 == optObj.length )
{
channel = "Auto";
}
$("[id^='UI_Channel:']", template).fillDataByType(channel);
}
function g_updateSideBandWithStatus(template)
{
var sideband = $("[id^='UI_SideBand:']", template).val();
g_fulfilSideBandOption(template);
optObj = $("[id^='UI_SideBand:'] option[value='"+sideband+"']", template);
if ( 0 != optObj.length )
{
$("[id^='UI_SideBand:']", template).fillDataByType(sideband);
}
}
function g_PageUpdate_WlanBasicAdConf(template)
{
g_updateChannelWithStatus(template);
g_updateSideBandWithStatus(template);
g_CtrlDispCtrl_WlanBasicAdConf(template);
}
function initial_template_WlanBasicAdConf(templateID)
{
var template = $("#"+templateID);
g_WlanCountryCodeOptionAdd(template);
$("#CountryCode", template).change(function(){
var template = $(this).parents("[id^=template_]");
g_PageUpdate_WlanBasicAdConf(template);
});
$("#QosType", template).change(function(){
var template = $(this).parents("[id^=template_]");
var qosType = $(this).val();
var standard = $("[id^='UI_Standard:']",template).val();
if ( "n" == standard && "Disabled" == qosType )
{
alert("&?WlanBasicAd_035;");
}
});
if("36" == curv)
{
$("#BandBEnabled", template).change(function(){
var Option = [
"<option value ='CNI' title='&?WlanBasicAd_021;'>&?WlanBasicAd_021;</option>",
"<option value ='AUI' title='&?WlanBasicAd_022;'>&?WlanBasicAd_022;</option>",
"<option value ='BRI' title='&?WlanBasicAd_023;'>&?WlanBasicAd_023;</option>",
"<option value ='CAI' title='&?WlanBasicAd_024;'>&?WlanBasicAd_024;</option>",
"<option value ='EGI' title='&?WlanBasicAd_025;'>&?WlanBasicAd_025;</option>",
"<option value ='FRI' title='&?WlanBasicAd_026;'>&?WlanBasicAd_026;</option>",
"<option value ='DEI' title='&?WlanBasicAd_027;'>&?WlanBasicAd_027;</option>",
"<option value ='GRI' title='&?WlanBasicAd_028;'>&?WlanBasicAd_028;</option>",
"<option value ='HKI' title='&?WlanBasicAd_029;'>&?WlanBasicAd_029;</option>",
"<option value ='ITI' title='&?WlanBasicAd_030;'>&?WlanBasicAd_030;</option>",
"<option value ='KRI' title='&?WlanBasicAd_031;'>&?WlanBasicAd_031;</option>",
"<option value ='ESI' title='&?WlanBasicAd_032;'>&?WlanBasicAd_032;</option>",
"<option value ='GBI' title='&?WlanBasicAd_033;'>&?WlanBasicAd_033;</option>",
"<option value ='USI' title='&?WlanBasicAd_034;'>&?WlanBasicAd_034;</option>",
"<option value ='THI' title='&?true_WlanBasicAd_001;'>&?true_WlanBasicAd_001;</option>",
"<option value ='US_2I' title='&?WlanBasicAd_034;'>&?WlanBasicAd_034;</option>",
"<option value ='TH_2' title='&?true_WlanBasicAd_001;'>&?true_WlanBasicAd_001;</option>",
];
var template = $(this).parents("[id^=template_]");
var countryCodeOBJ = $("[id^='CountryCode:1']", template);
var DFSOBJ = $("[id^='BandBEnabled:1']", template);
var DFSValue = DFSOBJ.val();
var countryCodeVal = countryCodeOBJ.val();
if(DFSValue == "0")
{
if(countryCodeVal=="TH_2" || countryCodeVal=="US_2I")
{
countryCodeOBJ.empty();
for (var i = 0; i<15; i++){
countryCodeOBJ.append(Option[i]);
}
if(countryCodeVal=="TH_2")
{
countryCodeOBJ.val("THI");
}
else
{
countryCodeOBJ.val("USI");
}
}
}
else
{
if(countryCodeVal=="THI" || countryCodeVal=="USI")
{
countryCodeOBJ.empty();
for (var i = 0; i<17; i++)
{
if (i != 13 && i != 14)
{
countryCodeOBJ.append(Option[i]);
}
}
if(countryCodeVal=="THI")
{
countryCodeOBJ.val("TH_2");
}
else
{
countryCodeOBJ.val("US_2I");
}
}
}
g_PageUpdate_WlanBasicAdConf(template);
});
}
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"BeaconInterval": {
"required": true,
"integer": true,
"range": [100, 1000]
},
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByCustom", function(event, suffix, template){
template.collapsibleInstTitleChange("Band");
if("36" == curv)
{
var Option = [
"<option value ='CNI' title='&?WlanBasicAd_021;'>&?WlanBasicAd_021;</option>",
"<option value ='AUI' title='&?WlanBasicAd_022;'>&?WlanBasicAd_022;</option>",
"<option value ='BRI' title='&?WlanBasicAd_023;'>&?WlanBasicAd_023;</option>",
"<option value ='CAI' title='&?WlanBasicAd_024;'>&?WlanBasicAd_024;</option>",
"<option value ='EGI' title='&?WlanBasicAd_025;'>&?WlanBasicAd_025;</option>",
"<option value ='FRI' title='&?WlanBasicAd_026;'>&?WlanBasicAd_026;</option>",
"<option value ='DEI' title='&?WlanBasicAd_027;'>&?WlanBasicAd_027;</option>",
"<option value ='GRI' title='&?WlanBasicAd_028;'>&?WlanBasicAd_028;</option>",
"<option value ='HKI' title='&?WlanBasicAd_029;'>&?WlanBasicAd_029;</option>",
"<option value ='ITI' title='&?WlanBasicAd_030;'>&?WlanBasicAd_030;</option>",
"<option value ='KRI' title='&?WlanBasicAd_031;'>&?WlanBasicAd_031;</option>",
"<option value ='ESI' title='&?WlanBasicAd_032;'>&?WlanBasicAd_032;</option>",
"<option value ='GBI' title='&?WlanBasicAd_033;'>&?WlanBasicAd_033;</option>",
"<option value ='USI' title='&?WlanBasicAd_034;'>&?WlanBasicAd_034;</option>",
"<option value ='THI' title='&?true_WlanBasicAd_001;'>&?true_WlanBasicAd_001;</option>",
"<option value ='US_2I' title='&?WlanBasicAd_034;'>&?WlanBasicAd_034;</option>",
"<option value ='TH_2' title='&?true_WlanBasicAd_001;'>&?true_WlanBasicAd_001;</option>",
];
var countryCodeOBJ = $("[id^='CountryCode:1']", template);
var countryCode = countryCodeOBJ.val();
countryCodeOBJ.empty();
if(template.attr("id") == "template_WlanBasicAdConf_1")
{
if(countryCode=="USI" || countryCode=="THI")
{
for (var i = 0; i<15; i++)
{
countryCodeOBJ.append(Option[i]);
}
}
else
{
for (var i = 0; i<17; i++)
{
if (i != 13 && i != 14)
{
countryCodeOBJ.append(Option[i]);
}
}
}
countryCodeOBJ.val(countryCode);
}
}
g_fulfilWorkModeOption(template);
g_displayWorkModeCurVal(template);
g_fulfilBandWidthOption(template);
g_displayBandWidthCurVal(template);
g_fulfilChannelOption(template);
g_displayChannelCurVal(template);
g_fulfilSideBandOption(template);
g_displaySideBandCurVal(template);
g_CtrlDispCtrl_WlanBasicAdConf(template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
var isError = ActionByApplyResult(xml, template);
<%
if (Right=="2") and (not NoRightDiff) and (curv~="14") and (curv~="112") and (curv~="3") and (curv~="1") and (curv~="163") and (curv~="137") and (curv~="146") then
%>
if ( isError == 0 )
{
$(".Btn_cancel", template).click();
}
<%
end
%>
});
template.bind("fillDataByCancelResult", function(event,xml, template){
ActionByCancelResult(xml, template, ["OBJ_WLANSETTING_ID"
])
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event, template){
var channel = $("[id^='UI_Channel:']", template).val();
var autoVal;
var skipDFS = "0";
if ( channel == "Auto" )
{
autoVal = "1";
$("[id^='Channel:']", template).val("NULL");
}
else
{
autoVal = "0";
$("[id^='Channel:']", template).val(channel);
var sideband = $("[id^='UI_SideBand:']", template).val();
$("[id^='SideBand:']", template).val(sideband);
}
$("[id^='AutoChannelEnabled:']", template).val(autoVal);
var Standard = $("[id^='UI_Standard:']", template).val();
var standardtemp = Standard;
if (standardtemp == "n")
{
var wlanband = $("[id^='Band:']", template).val();
if (wlanband == "5GHz")
{
standardtemp = "5n";
}
else
{
standardtemp = "2.4n";
}
}
var ParaChangeByStandard = {
"b": {
"BasicDataRates":"1,2",
"OpDataRates":"1,2,5.5,11",
"11nMode":"0",
"GreenField":"0"
},
"g": {
"BasicDataRates":"1,2,5.5,11,6,9,12,18,24",
"OpDataRates":"1,2,5.5,11,6,9,12,18,24,36,48,54",
"11nMode":"0",
"GreenField":"0"
},
"b,g": {
"BasicDataRates":"1,2,5.5,11",
"OpDataRates":"1,2,5.5,11,6,9,12,18,24,36,48,54",
"11nMode":"0",
"GreenField":"0"
},
"2.4n": {
"BasicDataRates":"1,2,5.5,11",
"OpDataRates":"1,2,5.5,11,6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"1"
},
"5n": {
"BasicDataRates":"6,9,12,18,24,36,48,54",
"OpDataRates":"6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"1"
},
"g,n": {
"BasicDataRates":"1,2,5.5,11,6,9,12,18,24",
"OpDataRates":"1,2,5.5,11,6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
},
"b,g,n": {
"BasicDataRates":"1,2,5.5,11",
"OpDataRates":"1,2,5.5,11,6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
},
"b,g,n,ax": {
"BasicDataRates":"1,2,5.5,11",
"OpDataRates":"1,2,5.5,11,6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
},
"a": {
"BasicDataRates":"6,9,12,18,24,36,48,54",
"OpDataRates":"6,9,12,18,24,36,48,54",
"11nMode":"0",
"GreenField":"0"
},
"a,n": {
"BasicDataRates":"6,9,12,18,24,36,48,54",
"OpDataRates":"6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
},
"a,n,ac": {
"BasicDataRates":"6,9,12,18,24,36,48,54",
"OpDataRates":"6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
},
"a,n,ac,ax": {
"BasicDataRates":"6,9,12,18,24,36,48,54",
"OpDataRates":"6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
},
"ac": {
"BasicDataRates":"6,9,12,18,24,36,48,54",
"OpDataRates":"6,9,12,18,24,36,48,54",
"11nMode":"1",
"GreenField":"0"
}
};
var ParaChange = ParaChangeByStandard[standardtemp];
if ( ParaChange )
{
for (var paratmp in ParaChange )
{
$("[id^='"+paratmp+":']",template).val(ParaChange[paratmp]);
}
}
$("[id^='Standard:']", template).val(Standard);
var bandWidthObj = $("[id^='UI_BandWidth:']", template);
if ( bandWidthObj.length > 0 )
{
var bandWidth = bandWidthObj.val();
$("[id^='BandWidth:']", template).val(bandWidth);
}
});
}
$(document).ready(function(){
var HeadID = "WlanBasicAdConf";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template_WlanBasicAdConf("template_"+HeadID);
Head.succfunction = function(xml){
if (Head.hasError(xml) == 0)
{
g_CfgGlobalXMLLocalCache = xml;
var CARDOBJ = $(xml).find("OBJ_WLANSETTING_ID");
var RuleNum = $("Instance", CARDOBJ).length;
var OBJID = ["OBJ_WLANSETTING_ID"
];
Head.fillDataByCustom = undefined;
Head.createPageDataByClone(RuleNum, OBJID, xml,
Head.fillDataByCustom);
firstTemp = $("#template_WlanBasicAdConf_0");
$(".collapsibleInst", firstTemp).click();
<%
if (Right == "2") and (curv =="131") then
%>
Head.find("*").attr("disabled",true);
<%
end
%>
}
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr, "GET", Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
var Btn_WlanBasicAdConf_Refresh= $("#WlanBasicAdConf_Refresh_button", Head);
Btn_WlanBasicAdConf_Refresh.unbind("click");
Btn_WlanBasicAdConf_Refresh.click(function(){
var HeadID = Head.attr("id");
if ( $("[id^='template_"+HeadID+"_']",Head).length > 0 )
{
Head.find("[id^='template_"+HeadID+"_']").each(function(){
$(this).remove();
});
var ServerAddr = $("address span", Head).text();
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
false);
}
});
});
})();
</script>
