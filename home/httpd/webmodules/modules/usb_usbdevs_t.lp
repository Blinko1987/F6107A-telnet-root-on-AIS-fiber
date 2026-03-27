<%
cgilua_lp.include("../../webmodules/modules/usb_usbdevs_js.lp", getfenv(1))
%>
<div id="USBDevs" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=usb_usbdevs_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="USBDevsBar">&?LocalnetStatus_014;</h1>
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="USBDevs_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<form class="colorTbl form_content">
<div id="USBDevs_title" class="colorTblRow emFont titleRow">
<span class="w150" title="&?LocalnetStatus_016;">&?LocalnetStatus_016;</span>
<span class="w165" title="&?LocalnetStatus_010;">&?LocalnetStatus_010;</span>
<span class="w165" title="&?LocalnetStatus_012;">&?LocalnetStatus_012;</span>
<span class="w165" title="&?LocalnetStatus_011;">&?LocalnetStatus_011;</span>
</div>
<div id="template_USBDevs" class="colorTblRow" style="display:none;">
<span class="w150" id="USBNum" title=""></span>
<span class="w165" id="DiskName" title=""></span>
<span class="w165" id="StorBlockSize" title=""></span>
<span class="w165" id="StorFreeSize" title=""></span>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="USBDevs_Btn_refresh" name="USBDevs_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
