<%
cgilua_lp.include("../../webmodules/modules/usb_usbfunccfg_js.lp", getfenv(1))
%>
<div id="LocalUSBFuncCfg" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=usb_usbfunccfg_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalUSBFuncCfgBar">&?public_140;</h1>
<div id="LocalUSBFuncCfg_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalUSBFuncCfg">
<form class="form_content">
<div id="changeArea_LocalUSBFuncCfg" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="PrinterEnable" class="cfgLabel w150">&?USBFuncCfg_002;</label>
<div class="right" id="PrinterEnable">
<input type="radio" id="PrinterEnable1" name="PrinterEnable" value="1"/><label for="PrinterEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="PrinterEnable0" name="PrinterEnable" value="0"/><label for="PrinterEnable0" >&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_instCfgArea" name="Btn_cancel_instCfgArea" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_instCfgArea" name="Btn_apply_instCfgArea" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
