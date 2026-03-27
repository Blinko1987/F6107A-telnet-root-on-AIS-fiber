<%
cgilua_lp.include("../../webmodules/modules/ais_wlan_wlanbandsteering_js.lp", getfenv(1))
%>
<div id="WlanBandSteering" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=ais_wlan_wlanbandsteering_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="WlanBandSteering">&?wlan_bandsteering_001;</h1>
<div id="WlanBandSteering_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_WlanBandSteering" class="formTblWrap" style="display:block;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="SSIDSync" value="">
<div class="row">
<label for="BsSSIDEnable15" class="left w70">&?BS_SSID_001;</label>
<div id="BsSSIDEnable15" class="right">
<input type="radio" id="BsSSIDEnable01" name="BsSSIDEnable15" value="1">
<label for="BsSSIDEnable01">&?Pinpublic_013;</label>
&nbsp;&nbsp;
<input type="radio" id="BsSSIDEnable00" name="BsSSIDEnable15" value="0">
<label for="BsSSIDEnable00">&?Pinpublic_012;</label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<label for="BsSSIDName0">&?BS_SSID_005;</label>
<input type="text" class="inputNorm" id="BsSSIDName0" name="BsSSIDName15" value="">
</div>
</div>
<div class="row">
<label for="BsSSIDEnable26" class="left w70">&?BS_SSID_002;</label>
<div id="BsSSIDEnable26" class="right">
<input type="radio" id="BsSSIDEnable11" name="BsSSIDEnable26" value="1">
<label for="BsSSIDEnable11">&?Pinpublic_013;</label>
&nbsp;&nbsp;
<input type="radio" id="BsSSIDEnable10" name="BsSSIDEnable26" value="0">
<label for="BsSSIDEnable10">&?Pinpublic_012;</label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<label for="BsSSIDName1">&?BS_SSID_005;</label>
<input type="text" class="inputNorm" id="BsSSIDName1" name="BsSSIDName26" value="">
</div>
</div>
<div class="row">
<label for="BsSSIDEnable37" class="left w70">&?BS_SSID_003;</label>
<div id="BsSSIDEnable37" class="right">
<input type="radio" id="BsSSIDEnable21" name="BsSSIDEnable37" value="1">
<label for="BsSSIDEnable21">&?Pinpublic_013;</label>
&nbsp;&nbsp;
<input type="radio" id="BsSSIDEnable20" name="BsSSIDEnable37" value="0">
<label for="BsSSIDEnable20">&?Pinpublic_012;</label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<label for="BsSSIDName2">&?BS_SSID_005;</label>
<input type="text" class="inputNorm" id="BsSSIDName2" name="BsSSIDName37" value="">
</div>
</div>
<div class="row">
<label for="BsSSIDEnable48" class="left w70">&?BS_SSID_004;</label>
<div id="BsSSIDEnable48" class="right">
<input type="radio" id="BsSSIDEnable31" name="BsSSIDEnable48" value="1">
<label for="BsSSIDEnable31">&?Pinpublic_013;</label>
&nbsp;&nbsp;
<input type="radio" id="BsSSIDEnable30" name="BsSSIDEnable48" value="0">
<label for="BsSSIDEnable30">&?Pinpublic_012;</label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<label for="BsSSIDName3">&?BS_SSID_005;</label>
<input type="text" class="inputNorm" id="BsSSIDName3" name="BsSSIDName48" value="">
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_WlanBandSteering" name="Btn_cancel_WlanBandSteering" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_WlanBandSteering" name="Btn_apply_WlanBandSteering" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
