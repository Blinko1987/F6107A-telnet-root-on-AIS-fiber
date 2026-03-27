<%
cgilua_lp.include("../../webmodules/modules/wlan_wlanbasicadconf_js.lp", getfenv(1))
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
<div id="WlanBasicAdConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_wlanbasicadconf_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="WlanBasicAdConfBar">&?WlanBasicAd_003;</h1>
<div id="WlanBasicAdConf_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_WlanBasicAdConf" style="display:none;">
<form class="form_content">
<div id="topLine_WlanBasicAdConf" class="formTblCtrlBar">
<a id="instName_WlanBasicAdConf" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);"></a>
</div>
<div id="changeArea_WlanBasicAdConf" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="BasicDataRates" value="">
<input type="hidden" id="OpDataRates" value="">
<input type="hidden" id="11nMode" value="">
<input type="hidden" id="GreenField" value="">
<input type="hidden" id="AutoChannelEnabled" value="">
<input type="hidden" id="Band" value="">
<input type="hidden" id="Channel" value="">
<input type="hidden" id="SideBand" value="">
<input type="hidden" id="Standard" value="">
<input type="hidden" id="BandWidth" value="">
<input type="hidden" id="AutoChRange" value="">
<input type="hidden" id="CardMode" value="" class="PostIgnore">
<div class="row">
<label for="UI_Channel" class="left w180">&?WlanBasicAd_017;</label>
<div class="right">
<select name="UI_Channel" id="UI_Channel" class="selectLong PostIgnore">
</select>
</div>
</div>
<%
if (CountryCode=="36") then
%>
<div class="row" id="div_BandBEnabled" style="display:none;">
<label for="div_BandBEnabled" class="left w180">&?WlanBandB;</label>
<div class="right">
<select name="BandBEnabled" id="BandBEnabled" class="selectLong">
<option value ="0" title='&?WlanBasicAd_112;'>&?WlanBasicAd_112;</option>
<option value ="1" title='&?WlanBasicAd_113;'>&?WlanBasicAd_113;</option>
</select>
</div>
</div>
<%
end
if (CountryCode=="1") or (CountryCode=="14") or (CountryCode=="66") then
%>
<div class="row" id="div_MUMIMOEnable">
<label for="MUMIMOEnable" class="left w180">&?WlanBasicAdProduct_003;</label>
<div id="MUMIMOEnable" class="right">
<input type="radio" id="MUMIMOEnable0" name="MUMIMOEnable" value="1"/>
<label for="MUMIMOEnable0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="MUMIMOEnable1" name="MUMIMOEnable" value="0"/>
<label for="MUMIMOEnable1">&?public_034;</label>
</div>
</div>
<%
end
%>
<div class="row">
<label for="UI_Standard" class="left w180">&?WlanBasicAd_016;</label>
<div class="right">
<select name="UI_Standard" id="UI_Standard" class="selectLong PostIgnore">
</select>
</div>
</div>
<%
if (Right == "1") or NoRightDiff or (CountryCode == "14") or (CountryCode == "112") or ( CountryCode == "3") or ( CountryCode == "1")
or ( CountryCode == "66") or ( CountryCode == "120") or (CountryCode == "146") or (CountryCode == "128") or (CountryCode == "20") then
%>
<div class="row" id="div_SSIDIsolationEnable" style="display:none;">
<label for="SSIDIsolationEnable" class="left w180">&?WlanBasicAd_036;</label>
<div id="SSIDIsolationEnable" class="right">
<input type="radio" id="SSIDIsolationEnable0" name="SSIDIsolationEnable" value="1"/>
<label for="SSIDIsolationEnable0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="SSIDIsolationEnable1" name="SSIDIsolationEnable" value="0"/>
<label for="SSIDIsolationEnable1">&?public_034;</label>
</div>
</div>
<div class="row" id="div_CountryCode">
<label for="CountryCode" class="left w180">&?WlanBasicAd_037;</label>
<div class="right">
<select name="CountryCode" id="CountryCode" class="selectLong">
<option value ="CNI" title='&?WlanBasicAd_021;'>&?WlanBasicAd_021;</option>
<option value ="AUI" title='&?WlanBasicAd_022;'>&?WlanBasicAd_022;</option>
<option value ="BRI" title='&?WlanBasicAd_023;'>&?WlanBasicAd_023;</option>
<option value ="CAI" title='&?WlanBasicAd_024;'>&?WlanBasicAd_024;</option>
<option value ="EGI" title='&?WlanBasicAd_025;'>&?WlanBasicAd_025;</option>
<option value ="FRI" title='&?WlanBasicAd_026;'>&?WlanBasicAd_026;</option>
<option value ="DEI" title='&?WlanBasicAd_027;'>&?WlanBasicAd_027;</option>
<option value ="GRI" title='&?WlanBasicAd_028;'>&?WlanBasicAd_028;</option>
<option value ="HKI" title='&?WlanBasicAd_029;'>&?WlanBasicAd_029;</option>
<option value ="ITI" title='&?WlanBasicAd_030;'>&?WlanBasicAd_030;</option>
<option value ="KRI" title='&?WlanBasicAd_031;'>&?WlanBasicAd_031;</option>
<option value ="ESI" title='&?WlanBasicAd_032;'>&?WlanBasicAd_032;</option>
<option value ="GBI" title='&?WlanBasicAd_033;'>&?WlanBasicAd_033;</option>
<option value ="USI" title='&?WlanBasicAd_034;'>&?WlanBasicAd_034;</option>
</select>
</div>
</div>
<%
end
if (Right == "1") or NoRightDiff or (CountryCode == "14") or (CountryCode == "112") or ( CountryCode == "3")
or ( CountryCode == "1") or ( CountryCode == "137") or ( CountryCode == "163") or (CountryCode == "146") or (CountryCode == "128") or (CountryCode == "20") or (CountryCode == "95") then
%>
<div class="row" id="div_BandWidth">
<label for="UI_BandWidth" class="left w180">&?WlanBasicAd_038;</label>
<div class="right">
<select name="UI_BandWidth" id="UI_BandWidth" class="selectLong PostIgnore">
</select>
</div>
</div>
<%
end
if (Right == "1") or NoRightDiff or (CountryCode == "14") or (CountryCode == "112") or ( CountryCode == "3") or ( CountryCode == "1") or ( CountryCode == "137") or (CountryCode == "146") then
%>
<div class="row" id="div_SideBand" style="display:none;">
<label for="UI_SideBand" class="left w180">&?WlanBasicAd_039;</label>
<div class="right">
<select name="UI_SideBand" id="UI_SideBand" class="selectLong PostIgnore">
</select>
</div>
</div>
<%
end
if (Right == "1") or NoRightDiff or (CountryCode == "14") or (CountryCode == "112") or ( CountryCode == "3") or ( CountryCode == "1") or ( CountryCode == "137")
or (CountryCode == "146") or (CountryCode == "128") or (CountryCode == "20") then
%>
<div class="row" id="div_SGIEnabled">
<label for="SGIEnabled" class="left w180">&?WlanBasicAd_040;</label>
<div id="SGIEnabled" class="right">
<input type="radio" id="SGIEnabled0" name="SGIEnabled" value="1"/>
<label for="SGIEnabled0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="SGIEnabled1" name="SGIEnabled" value="0"/>
<label for="SGIEnabled1">&?public_034;</label>
</div>
</div>
<div class="row" id="div_BeaconInterval">
<label for="BeaconInterval" class="left w180">&?WlanBasicAd_041;</label>
<div class="right">
<input type="text" id="BeaconInterval" name="BeaconInterval" class="inputLong"/>&?public_052;
<span style="display:none;">&?public_072;100 ~ 1000</span>
</div>
</div>
<%
end
if (Right == "1") or NoRightDiff or (CountryCode == "14") or (CountryCode == "112") or ( CountryCode == "3")
or ( CountryCode == "1") or ( CountryCode == "137") or ( CountryCode == "163") or (CountryCode == "146") or (CountryCode == "20") or (CountryCode == "95") then
%>
<div class="row" id="div_TxPower">
<label for="TxPower" class="left w180">&?WlanBasicAd_042;</label>
<div class="right">
<select name="TxPower" id="TxPower" class="selectLong">
<option value ="100%" title='100%'>100%</option>
<option value ="50%" title='50%'>50%</option>
</select>
</div>
</div>
<%
end
if (Right == "1") or NoRightDiff or (CountryCode == "14") or (CountryCode == "112")
or ( CountryCode == "3") or ( CountryCode == "1") or (CountryCode == "146") or ( CountryCode == "66") then
%>
<div class="row" id="div_QosType" style="display:none">
<label for="QosType" class="left w180">&?WlanBasicAd_044;</label>
<div class="right">
<select name="QosType" id="QosType" class="selectLong PostIgnore">
<option value ="Disabled" title='&?public_133;'>&?public_133;</option>
<option value ="WMM" title='&?public_134;'>&?public_134;</option>
<option value ="SSID" title='&?public_117;'>&?public_117;</option>
</select>
</div>
</div>
<%
if ("54" == CountryCode) or ("122" == CountryCode) then
%>
<div class="row" id="div_WorkMode">
<label for="WorkMode" class="left w180">&?WlanBasicAd_109;</label>
<div id="WorkMode" class="right">
<input type="radio" id="WorkMode0" name="WorkMode" value="1"/>
<label for="WorkMode0">&?WlanBasicAd_107;</label>
&nbsp;&nbsp;
<input type="radio" id="WorkMode1" name="WorkMode" value="2"/>
<label for="WorkMode1">&?WlanBasicAd_108;</label>
</div>
</div>
<%
end
end
%>
<%
if (CountryCode=="36") then
%>
<div class="row div_DownLinkMUMIMO">
<label for="DownLinkMUMIMO" class="left w180">&?wlansnc_001;</label>
<div class="right">
<input type="checkbox" value="" id="DownLinkMUMIMO" name="DownLinkMUMIMO"/>
</div>
</div>
<div class="row div_UPLinkMUMIMO">
<label for="UPLinkMUMIMO" class="left w180">&?wlansnc_002;</label>
<div class="right">
<input type="checkbox" value="" id="UPLinkMUMIMO" name="UPLinkMUMIMO"/>
</div>
</div>
<%
end
%>
<%
if (CountryCode=="37") then
%>
<div class="row" id="div_QosType">
<label for="QosType" class="left w180">&?WlanBasicAd_044;</label>
<div class="right">
<select name="QosType" id="QosType" class="selectLong">
<option value ="Disabled" title='&?public_133;'>&?public_133;</option>
<option value ="WMM" title='&?public_134;'>&?public_134;</option>
<option value ="SSID" title='&?public_117;'>&?public_117;</option>
</select>
</div>
</div>
<div class="row" id="div_RtsCts">
<label for="RtsCts" class="left w180">&?WlanBasicAd_045;</label>
<div class="right">
<input type="text" id="RtsCts" name="RtsCts" class="inputLong"/>
<span style="display:none;">&?public_072;0 ~ 2347</span>
</div>
</div>
<div class="row" id="div_DTIM">
<label for="DTIM" class="left w180">&?WlanBasicAd_046;</label>
<div class="right">
<input type="text" id="DTIM" name="DTIM" class="inputLong"/>
<span style="display:none;">&?public_072;1 ~ 5</span>
</div>
</div>
<%
end
%>
<div class="row" id="div_PreambleType" style="display:none">
<label for="PreambleType" class="left w180">&?WlanBasicAdProduct_008;</label>
<div class="right">
<select name="PreambleType" id="PreambleType" class="selectLong">
<option value ="0" title='&?WlanBasicAd_112;'>&?WlanBasicAdProduct_009;</option>
<option value ="1" title='&?WlanBasicAd_113;'>&?WlanBasicAdProduct_010;</option>
<option value ="2" title='&?WlanBasicAd_113;'>&?WlanBasicAdProduct_011;</option>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_WlanBasicAdConf" name="Btn_cancel_WlanBasicAdConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_WlanBasicAdConf" name="Btn_apply_WlanBasicAdConf" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div id="WlanBasicAdConf_Refresh" style="display:none;">
<input type="hidden" id="WlanBasicAdConf_Refresh_button">
</div>
</div>
</div>
