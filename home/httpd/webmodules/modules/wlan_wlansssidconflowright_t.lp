<%
cgilua_lp.include("../../webmodules/modules/wlan_wlansssidconflowright_js.lp", getfenv(1))
%>
<div id="WLANSSIDConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_wlansssidconf_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="WLANSSIDConfBar">&?WlanBasic_005;</h1>
<div id="WLANSSIDConf_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?WlanBasic_014;</a></div>
<div class="sceneTip_container">
<p>&?WlanBasic_006;</p>
<p>&?WlanBasic_007;</p>
<p>&?WlanBasic_008;</p>
<p>&?WlanBasic_009;</p>
<p>&?WlanBasic_010;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_WLANSSIDConf" style="display:none;">
<form class="form_content">
<div id="topLine_WlanBasicAdConf" class="formTblCtrlBar">
<a id="instName_WlanBasicAdConf" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);"></a>
</div>
<div id="changeArea_WLANSSIDConf" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="LockStatus" class="PostIgnore" value="">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Band" class="PostIgnore" value="">
<input type="hidden" id="WLANViewName" class="PostIgnore" value="">
<input type="hidden" id="_WLANCONIG" value="Y">
<input type="hidden" id="_WEPCONIG" value="N">
<input type="hidden" id="_PSKCONIG" value="N">
<input type="hidden" id="BeaconType" value="">
<input type="hidden" id="WEPAuthMode" value="">
<input type="hidden" id="WPAAuthMode" value="">
<input type="hidden" id="11iAuthMode" value="">
<input type="hidden" id="WPAEncryptType" value="">
<input type="hidden" id="11iEncryptType" value="">
<input type="hidden" id="_InstID_WEP0" value="">
<input type="hidden" id="_InstID_WEP1" value="">
<input type="hidden" id="_InstID_WEP2" value="">
<input type="hidden" id="_InstID_WEP3" value="">
<input type="hidden" id="_InstID_PSK" value="">
<div class="row">
<label for="ESSID" class="left w150">&?WlanBasic_011;</label>
<div class="right">
<input type="text" id="ESSID" name="ESSID" class="inputLong" />
<span style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="EncryptionType" class="left w150">&?WlanBasic_012;</label>
<div class="right">
<select id="EncryptionType" name="EncryptionType" class="selectLong">
<option value="No Security" title='&?public_059;'>&?public_059;</option>
<option value="WPA-PSK-TKIP" title='&?WlanBasicAd_061;'>&?WlanBasicAd_061;</option>
<option value="WPA-PSK-AES" title='&?WlanBasicAd_082;'>&?WlanBasicAd_082;</option>
<option value="WPA-PSK-TKIP/AES" title='&?WlanBasicAd_083;'>&?WlanBasicAd_083;</option>
<option value="WPA2-PSK-TKIP" title='&?WlanBasicAd_084;'>&?WlanBasicAd_084;</option>
<option value="WPA2-PSK-AES" title='&?WlanBasicAd_062;'>&?WlanBasicAd_062;</option>
<option value="WPA2-PSK-TKIP/AES" title='&?WlanBasicAd_081;'>&?WlanBasicAd_081;</option>
<option value="WPA/WPA2-PSK-TKIP/AES" title='&?WlanBasicAd_063;'>&?WlanBasicAd_063;</option>
<option value="WPA/WPA2-PSK-TKIP" title='&?WlanBasicAd_085;'>&?WlanBasicAd_085;</option>
<option value="WPA/WPA2-PSK-AES" title='&?WlanBasicAd_086;'>&?WlanBasicAd_086;</option>
<option value="WEP-OpenSystem" title='&?WlanBasicAd_064;'>&?WlanBasicAd_064;</option>
<option value="WEP-ShareKey" title='&?WlanBasicAd_065;'>&?WlanBasicAd_065;</option>
</select>
</div>
</div>
<div class="row" id="div_ShowKeyPassphrase" style="display:none">
<label for="ShowKeyPassphrase" class="left w150">&?WlanBasic_021;</label>
<div class="right">
<input type="checkbox" value="" id="ShowKeyPassphrase" name="ShowKeyPassphrase"/>
</div>
</div>
<div class="row" id="div_KeyPassphrase" style="display:none">
<label for="KeyPassphrase" class="left w150">&?WlanBasic_013;</label>
<div class="right">
<input class="inputNorm valid" type="password" id="KeyPassphrase" name="KeyPassphrase" value="" style="width: 330px" />
<input type="text" id="KeyPassphrase" name="KeyPassphrase" class="PostIgnore" style="display:none"/>
<span style="display:none">&?public_073;8 ~ 63</span>
</div>
</div>
<div class="row" id="div_WEPKeyIndex" style="display:none">
<label for="WEPKeyIndex" class="left w150">&?WlanBasic_015;</label>
<div class="right">
<select id="WEPKeyIndex" name="WEPKeyIndex" class="selectLong" >
<option value="1" title='1'>1</option>
<option value="2" title='2'>2</option>
<option value="3" title='3'>3</option>
<option value="4" title='4'>4</option>
</select>
</div>
</div>
<div class="row" id="div_ShowWEPKey" style="display:none">
<label for="ShowWEPKey" class="left w150">&?WlanBasic_021;</label>
<div class="right">
<input type="checkbox" value="" id="ShowWEPKey" name="ShowWEPKey"/>
</div>
</div>
<div class="row" id="div_WEPKey00" style="display:none">
<label for="WEPKey00" class="left w150">&?WlanBasic_019;</label>
<div class="right">
<input class="inputNorm valid" type="password" id="WEPKey00" name="WEPKey00" value="" style="width: 330px" />
<input type="text" id="WEPKey00" name="WEPKey00" class="PostIgnore" style="display:none"/>
</div>
</div>
<div class="row" id="div_WEPKey01" style="display:none">
<label for="WEPKey01" class="left w150">&?WlanBasic_016;</label>
<div class="right">
<input class="inputNorm valid" type="password" id="WEPKey01" name="WEPKey01" value="" style="width: 330px" />
<input type="text" id="WEPKey01" name="WEPKey01" class="PostIgnore" style="display:none"/>
</div>
</div>
<div class="row" id="div_WEPKey02" style="display:none">
<label for="WEPKey02" class="left w150">&?WlanBasic_017;</label>
<div class="right">
<input class="inputNorm valid" type="password" id="WEPKey02" name="WEPKey02" value="" style="width: 330px" />
<input type="text" id="WEPKey02" name="WEPKey02" class="PostIgnore" style="display:none"/>
</div>
</div>
<div class="row" id="div_WEPKey03" style="display:none">
<label for="WEPKey03" class="left w150">&?WlanBasic_018;</label>
<div class="right">
<input class="inputNorm valid" type="password" id="WEPKey03" name="WEPKey03" value="" style="width: 330px" />
<input type="text" id="WEPKey03" name="WEPKey03" class="PostIgnore" style="display:none"/>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_WLANSSIDConf" name="Btn_cancel_WLANSSIDConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_WLANSSIDConf" name="Btn_apply_WLANSSIDConf" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div id="WLANSSIDConf_Refresh" style="display:none;">
<input type="hidden" id="WLANSSIDConf_Refresh_button">
</div>
</div>
</div>
</div>
