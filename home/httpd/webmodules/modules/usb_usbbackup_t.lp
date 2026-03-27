<%
cgilua_lp.include("../../webmodules/modules/usb_usbbackup_js.lp", getfenv(1))
%>
<div id="Usbbackup" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=usb_usbrestore_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="UsbbackupBar">&?Usbbackup_001;</h1>
<div id="template_Usbbackup">
<div id="Usbbackup_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<div class="staticInfoHint" style="display:none;">
<p>&?Usbbackup_003;</p>
</div>
<input type="hidden" id="_InstID" value="">
<input type="hidden" class="inputLong" id="StartBackup" name="StartBackup" value=""/>
<div class="row">
<label for="SelectPath" class="left w150">&?public_056;</label>
<div class="right">
<select class="selectNorm" id="SelectPath" name="SelectPath">
</select>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button PostIgnore" id="Apply_Usbbackup" name="Apply_Usbbackup" value="&?Usbbackup_005;" />
</div>
</div>
</div>
</div>
</div>
</div>
