<%
cgilua_lp.include("../../webmodules/modules/wlan_wlanbasicadconf_js.lp", getfenv(1))
local NoRightDiff = false
if _G.ssidConf["NoRightDiff"] ~= nil then
if string.find(_G.ssidConf["NoRightDiff"],"WlanBasicAdConf") ~= nil then
NoRightDiff = true
end
end
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
<input type="hidden" id="CardMode" value="" class="PostIgnore">
<div class="row">
<label for="UI_Channel" class="left w180">&?WlanBasicAd_017;</label>
<div class="right">
<select name="UI_Channel" id="UI_Channel" class="selectLong PostIgnore">
</select>
</div>
</div>
<div class="row">
<label for="UI_Standard" class="left w180">&?WlanBasicAd_016;</label>
<div class="right">
<select name="UI_Standard" id="UI_Standard" class="selectLong PostIgnore">
</select>
</div>
</div>
<%
if Right == "1" or Right == "2" or NoRightDiff then
%>
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
if Right == "1" or Right == "2" or NoRightDiff then
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
if Right == "1" or Right == "2" or NoRightDiff then
%>
<div class="row" id="div_SideBand" style="display:none;">
<label for="UI_SideBand" class="left w180">&?WlanBasicAd_039;</label>
<div class="right">
<select name="UI_SideBand" id="UI_SideBand" class="selectLong PostIgnore">
</select>
</div>
</div>
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
<%
end
if Right == "1" or Right == "2" or NoRightDiff then
%>
<div class="row" id="div_BeaconInterval">
<label for="BeaconInterval" class="left w180">&?WlanBasicAd_041;</label>
<div class="right">
<input type="text" id="BeaconInterval" name="BeaconInterval" class="inputLong"/>&?public_052;
<span style="display:none;">&?public_072;100 ~ 1000</span>
</div>
</div>
<%
end
if Right == "1" or Right == "2" or NoRightDiff then
%>
<div class="row" id="div_TxPower">
<label for="TxPower" class="left w180">&?WlanBasicAd_042;</label>
<div class="right">
<select name="TxPower" id="TxPower" class="selectLong">
<option value ="100%" title='100%'>100%</option>
<option value ="80%" title='80%'>80%</option>
<option value ="60%" title='60%'>60%</option>
<option value ="40%" title='40%'>40%</option>
<option value ="20%" title='20%'>20%</option>
</select>
</div>
</div>
<%
end
if Right == "1" or Right == "2" or NoRightDiff then
%>
<%
end
%>
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
