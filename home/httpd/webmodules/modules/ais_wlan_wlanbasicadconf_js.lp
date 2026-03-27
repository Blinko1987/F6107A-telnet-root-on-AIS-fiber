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
var GlobalStandard="";
(function () {
<%
cgilua_lp.include("../../webmodules/modules/wlan_basic_comm_js.lp", getfenv(1))
%>
var g_CfgGlobalXMLLocalCache;
function g_getAutoChannelList( bandIN, bandWidthIN)
{
var AutoChRange = "";
if ( bandIN == "5GHz" )
{
if(bandWidthIN == "20MHz")
{
AutoChRange="36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,140,149,153,157,161,165";
}
else if(bandWidthIN == "40MHz")
{
AutoChRange="36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,149,153,157,161";
}
else if(bandWidthIN == "80MHz")
{
AutoChRange="36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,149,153,157,161";
}
else if(bandWidthIN == "160MHz")
{
AutoChRange="36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128";
}
else
{
AutoChRange="36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,149,153,157,161";
}
}
else
{
AutoChRange="1,2,3,4,5,6,7,8,9,10,11,12,13";
}
return AutoChRange;
}
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
if (Right=="1") or NoRightDiff then
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
g_CtrlWlanBasicAdConf(template);
}
function g_BindChannelAutoRadioClick(tempObj)
{
obj = $("[name^='Channel_Auto_Radio']", tempObj);
var objvalue=$("input[name^='Channel_Auto_Radio']:checked",tempObj).val();
var bandWidth = $("[id^='UI_BandWidth:']", tempObj).val();
if(objvalue=='0')
{
$("[id^='Pre_UI_Auto_Channel_Band']", tempObj).hide();
}
else
{
$("[id^='Pre_UI_Auto_Channel_Band1_List:']", tempObj).show();
$("[id^='Pre_UI_Auto_Channel_Band2_List:']", tempObj).show();
if (bandWidth != "160MHz"){
$("[id^='Pre_UI_Auto_Channel_Band3_List:']", tempObj).show();
}
}
obj.change(function(){
var TypeOBJ = $(this);
if (TypeOBJ.val() =="0")
{
$("[id^='Pre_UI_Auto_Channel_Band']", tempObj).hide();
}
else
{
$("[id^='Pre_UI_Auto_Channel_Band1_List:']", tempObj).show();
$("[id^='Pre_UI_Auto_Channel_Band2_List:']", tempObj).show();
if (bandWidth != "160MHz"){
$("[id^='Pre_UI_Auto_Channel_Band3_List:']", tempObj).show();
}
var band = $("[id^='Band:']", tempObj).val();
g_fillAutoChannelInitData(tempObj,band);
}
});
$("[id^='UI_Auto_Channel_Band']",tempObj).change(function(){
var RadioObj = $(this);
var band = $("[id^='Band:']", tempObj).val();
var ParentObj;
if( RadioObj.attr("id").indexOf("List_All") > 0 )
{
ParentObj=RadioObj.parent();
$("[id^='UI_Auto_Channel_Band']",ParentObj).each(function(){
var ObjIt = $(this);
if (RadioObj.is(":checked") == true)
{
ObjIt.prop("checked", true);
}
else
{
ObjIt.prop("checked", false);
}
});
}
else
{
ParentObj=RadioObj.parent().parent();
var bandWidth = $("[id^='UI_BandWidth:']", tempObj).val();
if (band == "5GHz")
{
if (bandWidth == "20MHz")
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
}
}
else if (bandWidth == "40MHz")
{
var svalue=RadioObj.val();
if (svalue < 65 || (svalue > 99 && svalue < 137) )
{
if(svalue < 65)
{ svalue=(svalue-36)/4; }
else
{ svalue=(svalue-100)/4; }
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
if(svalue%2 ==0)
{
RadioObj.next().next().next().prop("checked", true);
}
else
{
RadioObj.prev().prev().prev().prop("checked", true);
}
}
else
{
if(svalue%2 ==0)
{
RadioObj.next().next().next().prop("checked", false);
}
else
{
RadioObj.prev().prev().prev().prop("checked", false);
}
}
}
else if( svalue !=140 && svalue !=165)
{
if(svalue==132 || svalue==149 || svalue==157 )
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
RadioObj.next().next().next().prop("checked", true);
}
else
{
RadioObj.next().next().next().prop("checked", false);
}
}
else
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
RadioObj.prev().prev().prev().prop("checked", true);
}
else
{
RadioObj.prev().prev().prev().prop("checked", false);
}
}
}
else
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
}
}
}
else if (bandWidth == "80MHz" || bandWidth == "Auto")
{
var svalue=RadioObj.val();
if (svalue ==36 || svalue ==52 || svalue ==100 || svalue ==116 || svalue ==149)
{
var obj1=RadioObj.next().next().next();
var obj2=obj1.next().next().next();
var obj3=obj2.next().next().next();
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
obj1.prop("checked", true);
obj2.prop("checked", true);
obj3.prop("checked", true);
}
else
{
obj1.prop("checked", false);
obj2.prop("checked", false);
obj3.prop("checked", false);
}
}
else if (svalue ==40 || svalue ==56 || svalue ==104 || svalue ==120 || svalue ==153)
{
var obj1=RadioObj.prev().prev().prev();
var obj2=RadioObj.next().next().next();
var obj3=obj2.next().next().next();
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
obj1.prop("checked", true);
obj2.prop("checked", true);
obj3.prop("checked", true);
}
else
{
obj1.prop("checked", false);
obj2.prop("checked", false);
obj3.prop("checked", false);
}
}
else if (svalue ==44 || svalue ==60 || svalue ==108 || svalue ==124 || svalue ==157)
{
var obj1=RadioObj.prev().prev().prev();
var obj2=obj1.prev().prev().prev();
var obj3=RadioObj.next().next().next();
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
obj1.prop("checked", true);
obj2.prop("checked", true);
obj3.prop("checked", true);
}
else
{
obj1.prop("checked", false);
obj2.prop("checked", false);
obj3.prop("checked", false);
}
}
else if(svalue ==48 || svalue ==64 || svalue ==112 || svalue ==128 || svalue ==161)
{
var obj1=RadioObj.prev().prev().prev();
var obj2=obj1.prev().prev().prev();
var obj3=obj2.prev().prev().prev();
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
obj1.prop("checked", true);
obj2.prop("checked", true);
obj3.prop("checked", true);
}
else
{
obj1.prop("checked", false);
obj2.prop("checked", false);
obj3.prop("checked", false);
}
}
else
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
}
}
}
else
{
var svalue=RadioObj.val();
if (svalue < 65 || ( svalue > 99 && svalue < 129) )
{
$("[id^='UI_Auto_Channel_Band']",ParentObj).each(function(){
var ObjIt = $(this);
if (RadioObj.is(":checked") == true)
{
ObjIt.prop("checked", true);
}
else
{
ObjIt.prop("checked", false);
}
});
}
else
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
}
}
}
}
else
{
if (RadioObj.is(":checked") == true)
{
$("[id*='List_All']",ParentObj).prop("checked", true);
}
}
var UnCheckedNum = 0;
var SumNum = 0;
$("[id^='UI_Auto_Channel_Band']",ParentObj).each(function(){
var ObjIt = $(this);
if( ObjIt.attr("id").indexOf("List_All") < 0 )
{
SumNum++;
if (!ObjIt.is(":checked"))
{
UnCheckedNum++;
}
}
});
if(UnCheckedNum == SumNum)
{
$("[id*='List_All']",ParentObj).prop("checked", false);
}
}
});
}
function g_fillAutoChannelInitData(tempObj,band)
{
if( band == "5GHz")
{
var obj=$("[id^='Pre_UI_Auto_Channel_Band1_List']", tempObj);
var bandWidth = $("[id^='UI_BandWidth:']", tempObj).val();
var standard = $("[id^='UI_Standard:1']", tempObj).val();
if( standard == "a") bandWidth="20MHz";
$("[id^='UI_Auto_Channel_Band1_List']",obj).each(function(){
var RadioObj = $(this);
if( RadioObj.attr("id").indexOf("List_All") > 0 )
{
RadioObj.prop("checked", true);
}
else if(parseInt(RadioObj.val()) < 65)
{
RadioObj.prop("checked", true);
}
else
{
RadioObj.prop("checked", false);
}
});
obj=$("[id^='Pre_UI_Auto_Channel_Band2_List']", tempObj);
$("[id^='UI_Auto_Channel_Band2_List']",obj).each(function(){
var RadioObj = $(this);
RadioObj.prop("checked", false);
});
if (bandWidth != "160MHz"){
obj=$("[id^='Pre_UI_Auto_Channel_Band3_List']", tempObj);
$("[id^='UI_Auto_Channel_Band3_List']",obj).each(function(){
var RadioObj = $(this);
if(RadioObj.attr("id").indexOf("List_All")>0)
{
RadioObj.prop("checked", true);
}
else if(parseInt(RadioObj.val()) < 162)
{
RadioObj.prop("checked", true);
}
else
{
RadioObj.prop("checked", false);
}
});
}
}
else if( band == "2.4GHz")
{
var obj=$("[id^='Pre_UI_Auto_Channel_Band1_List']", tempObj);
$("[id^='UI_Auto_Channel_Band1_List']",obj).each(function(){
var RadioObj = $(this);
if(parseInt(RadioObj.val()) < 12)
{
RadioObj.prop("checked", true);
}
else
{
RadioObj.prop("checked", false);
}
});
}
}
function g_fulfilThailandOption(tempObj)
{
var AutoChRange=$("[id^='AutoChRange:']", tempObj).val();
if( AutoChRange == "default" || AutoChRange == "" )
{
$("[id^='Pre_UI_Channel_Auto:']", tempObj).parent().show();
$("[id^='Channel_Auto_Radio0:']", tempObj).prop("checked", true);
$("[id^='Pre_UI_Auto_Channel_Band']", tempObj).hide();
}
else
{
$("[id^='Pre_UI_Channel_Auto:']", tempObj).parent().show();
$("[id^='Channel_Auto_Radio1:']", tempObj).prop("checked", true);
$("[id^='Pre_UI_Auto_Channel_Band']", tempObj).show();
AutoChRange=","+AutoChRange+",";
$("[id*='List_All']",tempObj).prop("checked", false);
$("[id^='UI_Auto_Channel_Band']",tempObj).each(function(){
var ObjIt = $(this);
if( ObjIt.attr("id").indexOf("List_All") < 0 )
{
var ParentObj=ObjIt.parent().parent();
var value=ObjIt.val();
value=","+value+",";
if (AutoChRange.indexOf(value)>=0)
{
ObjIt.prop("checked", true);
$("[id*='List_All']",ParentObj).prop("checked", true);
}
else
{
ObjIt.prop("checked", false);
}
}
});
}
}
function g_fillCustomData(tempObj)
{
var AutoChannelEnabled=$("[id^='AutoChannelEnabled:']", tempObj).val();
var currentcountry = $("[id^='CountryCode:']", tempObj).val();
if (AutoChannelEnabled =="1" && currentcountry == "THI")
{
g_fulfilThailandOption(tempObj);
}
else
{
$("[id^='Pre_UI_Channel_Auto:']", tempObj).parent().hide();
}
}
function g_fulfilAutoChannelOption( tempObj )
{
var countryCode = $("[id^='CountryCode:']", tempObj).val();
var AutoChannelObj = $("[id^='Pre_UI_Auto_Channel_Band1_List:']", tempObj);
var AutoChannelID = AutoChannelObj.attr("id");
var TempIndex=AutoChannelID.substr(-1);
var ChannelAutoRadio = $("input[name^='Channel_Auto_Radio']:checked",tempObj).val();
var band = $("[id^='Band:']", tempObj).val();
var bandWidth = $("[id^='UI_BandWidth:']", tempObj).val();
var standard = $("[id^='UI_Standard:1']", tempObj).val();
if( standard == "a") bandWidth="20MHz";
var channelList = g_getAutoChannelList( band, bandWidth);
var channelArr = channelList.split(",");
$("[id^='Pre_UI_Auto_Channel_Band2_List:']", tempObj).remove();
$("[id^='Pre_UI_Auto_Channel_Band3_List:']", tempObj).remove();
var CheckBoxStr = "";
var num=0;
var index=0;
if( band == "5GHz" )
{
var recommendtext = "&?WlanBasicAd_132;&?Customize_WlanBasicAd_002;36-64 and Ch.149-161)";
var bandnum =4;
if( bandWidth == "160MHz")
{
bandnum = 3;
recommendtext = "&?WlanBasicAd_132;&?Customize_WlanBasicAd_002;36-64)";
}
$("[id^='Label_Channel_Auto_Radio0:']", tempObj).text(recommendtext);
for(var j=1;j < bandnum; j++)
{
CheckBoxStr += '<div name="Pre_UI_Auto_Channel_Band'+j+'_List:'+TempIndex+'" id="Pre_UI_Auto_Channel_Band'+j+'_List:'+TempIndex+'" class="right">';
CheckBoxStr += '<input type="checkbox" style="margin-left:20px;" name="UI_Auto_Channel_Band'+j+'_List_All:'+TempIndex+'" id="UI_Auto_Channel_Band'+j+'_List_All:'+TempIndex+'" value="1000">'+
'<label for="UI_Auto_Channel_Band'+j+'_List_All:'+TempIndex+'">&?Customize_WlanBasicAd_005; '+j+'</label><br>';
if(j==2)
{
CheckBoxStr +='<div class="right w130">'
for (var i=0; i < channelArr.length; i++)
{
index = i;
if(channelArr[i]<100 || channelArr[i]>140)
continue;
num++;
if( num > 8)
{
break;
}
CheckBoxStr += '&nbsp;&nbsp;<input type="checkbox" name="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'" id="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'" value="'+channelArr[i]+'">'+
'<label for="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'">&?Customize_WlanBasicAd_006; '+channelArr[i]+'</label><br>'
}
CheckBoxStr +='</div>';
if (channelArr[index] <149 && bandWidth != "160MHz")
{
CheckBoxStr +='<div class="right w130">';
for (var i=index; i<channelArr.length; i++)
{
if(channelArr[i]<100 || channelArr[i]>140)
continue;
CheckBoxStr += '&nbsp;&nbsp;<input type="checkbox" name="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'" id="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'" value="'+channelArr[i]+'">'+
'<label for="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'">&?Customize_WlanBasicAd_006; '+channelArr[i]+'</label><br>'
}
CheckBoxStr +='</div>'
}
}
else
{
CheckBoxStr +='<div class="right w130">'
for (var i=0; i<channelArr.length; i++)
{
if(j==1 && (channelArr[i]<36 || channelArr[i]>64))
continue;
if(j==3 && (channelArr[i]<149 || channelArr[i]>165))
continue;
CheckBoxStr += '&nbsp;&nbsp;<input type="checkbox" name="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'" id="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'" value="'+channelArr[i]+'">'+
'<label for="UI_Auto_Channel_Band'+j+'_List'+i+':'+TempIndex+'">&?Customize_WlanBasicAd_006; '+channelArr[i]+'</label><br>'
}
CheckBoxStr +='</div>'
}
CheckBoxStr +='</div>';
}
}
else
{
$("[id^='Label_Channel_Auto_Radio0:']", tempObj).text("&?WlanBasicAd_132;&?Customize_WlanBasicAd_002;1-11)");
var linenum=parseInt(channelArr.length/3);
var CheckBoxStr = '<div name="'+AutoChannelID+'" id="'+AutoChannelID+'" class="right"> <div class="right w120">';
for (var i=0; i<linenum; i++)
{
CheckBoxStr += '&nbsp;&nbsp;<input type="checkbox" name="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'" id="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'" value="'+channelArr[i]+'">'+
'<label for="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'">&?Customize_WlanBasicAd_006; '+channelArr[i]+'</label><br>'
}
CheckBoxStr +='</div>';
CheckBoxStr += '<div class="right w120">';
for (var i=linenum; i<linenum*2; i++)
{
CheckBoxStr += '&nbsp;&nbsp;<input type="checkbox" name="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'" id="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'" value="'+channelArr[i]+'">'+
'<label for="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'">&?Customize_WlanBasicAd_006; '+channelArr[i]+'</label><br>'
}
CheckBoxStr +='</div>';
CheckBoxStr += '<div class="right w120">';
for (var i=linenum*2; i<channelArr.length; i++)
{
CheckBoxStr += '&nbsp;&nbsp;<input type="checkbox" name="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'" id="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'" value="'+channelArr[i]+'">'+
'<label for="UI_Auto_Channel_Band1_List'+i+':'+TempIndex+'">&?Customize_WlanBasicAd_006; '+channelArr[i]+'</label><br>'
}
CheckBoxStr +='</div></div>';
}
AutoChannelObj.replaceWith(CheckBoxStr);
if( num > 8)
{
$("[id^='UI_Auto_Channel_Band2_List_All']", tempObj).css({"margin-left": 88});
}
if (ChannelAutoRadio ==0)
{
$("[name^='Pre_UI_Auto_Channel_Band']", tempObj).hide();
}
else
{
$("[id^='Channel_Auto_Radio1:']", tempObj).prop("checked", true);
$("[name^='Pre_UI_Auto_Channe1_Band']", tempObj).show();
}
g_fillAutoChannelInitData(tempObj,band);
g_BindChannelAutoRadioClick(tempObj);
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
if (Right=="1") or NoRightDiff then
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
if (channel =="Auto")
{
$("[id^='Pre_UI_Channel_Auto:']", template).parent().show();
}
else
{
$("[id^='Pre_UI_Channel_Auto:']", template).parent().hide();
}
g_fulfilChannelOption(template);
g_fulfilAutoChannelOption(template);
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
function g_updatefillCustomData(tempObj)
{
var currentcountry = $("[id^='CountryCode:']", tempObj).val();
var UI_Channel = $("[id^='UI_Channel:']", tempObj).val();
if (UI_Channel == "Auto" && currentcountry == "THI")
{
g_fulfilThailandOption(tempObj);
}
else
{
$("[id^='Pre_UI_Channel_Auto:']", tempObj).parent().hide();
}
}
function g_PageUpdate_WlanBasicAdConf(template)
{
g_updateChannelWithStatus(template);
g_updateSideBandWithStatus(template);
g_CtrlDispCtrl_WlanBasicAdConf(template);
g_updatefillCustomData(template);
}
function g_CountryCodeOptionAdd(template)
{
var countryCodeOBJ = $("#CountryCode", template);
<%
local countryC = ""
local countryT = ""
if _G.ssidConf["wlanCountryConf"] ~= nil then
countryC = _G.ssidConf["wlanCountryConf"][1]
countryT = _G.ssidConf["wlanCountryConf"][2]
countryT = lang[countryT]
end
%>
var countryCodeEx = "<%=countryC%>";
var countryCodeTitle = "<%=countryT%>";
if(countryCodeEx != "")
{
var optionStr = "<option value ='"+countryCodeEx+"' title='"+countryCodeTitle+"'>"+countryCodeTitle+"</option>";
countryCodeOBJ.append(optionStr);
}
}
function initial_template_WlanBasicAdConf(templateID)
{
var template = $("#"+templateID);
g_CountryCodeOptionAdd(template);
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
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"rules": {
"BeaconInterval": {
"required": true,
"integer": true,
"range": [100, 1000]
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByCustom", function(event, suffix, template){
template.collapsibleInstTitleChange("Band");
g_fulfilWorkModeOption(template);
g_displayWorkModeCurVal(template);
g_fulfilBandWidthOption(template);
g_displayBandWidthCurVal(template);
g_fulfilChannelOption(template);
g_fulfilAutoChannelOption(template);
g_displayChannelCurVal(template);
g_fulfilSideBandOption(template);
g_displaySideBandCurVal(template);
g_CtrlDispCtrl_WlanBasicAdConf(template);
g_fillCustomData(template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
var isError = ActionByApplyResult(xml, template);
<%
if (Right=="2") and (not NoRightDiff) then
%>
if ( isError == 0 )
{
$(".Btn_cancel", template).click();
}
<%
end
%>
var StandardStr = $("[id^='Standard']",template).val();
if(GlobalStandard!=StandardStr)
{
window.alert("&?Wlan_basicConf_001;");
top.location.href = top.location.href;
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
ActionByCancelResult(xml, template, ["OBJ_WLANSETTING_ID"
])
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("hiddenValueChangeByCustom", function(event, template){
GlobalStandard = $("[id^='Standard']",template).val();
var channel = $("[id^='UI_Channel:']", template).val();
var autoVal;
var skipDFS = "0";
if ( channel == "Auto" )
{
autoVal = "1";
var ChannelAutoRadio=$("input[name^='Channel_Auto_Radio']:checked",template).val();
if (ChannelAutoRadio =="0")
{
$("[id^='AutoChRange:']", template).val("default");
}
else
{
var AutoChRange="";
$("[id^='UI_Auto_Channel_Band']",template).each(function(){
var RadioObj = $(this);
if( RadioObj.attr("id").indexOf("List_All") < 0 && RadioObj.is(':checked'))
{
if (AutoChRange == "")
{
AutoChRange+=RadioObj.val();
}
else
{
AutoChRange+=","+RadioObj.val();
}
}
});
$("[id^='AutoChRange:']", template).val(AutoChRange);
}
$("[id^='Channel:']", template).val("NULL");
}
else
{
autoVal = "0";
$("[id^='Channel:']", template).val(channel);
$("[id^='AutoChRange:']", template).val("");
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
