<%
cgilua_lp.include("../../webmodules/modules/claro_globalcontrol_js.lp", getfenv(1))
%>
<div id="GlobalEnable" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=claro_globalcontrol_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="GlobalEnableBar">&?BClaro_002;</h1>
<div id="GlobalEnable_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_GlobalEnable">
<div id="changeArea_GlobalEnable" class="ChangeArea">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="formTbl formTblWrap">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="EnableUPnPIGD" class="cfgLabel w200">&?UPnP_001;</label>
<div class="right" id="EnableUPnPIGD">
<input type="radio" id="EnableUPnPIGD1" name="EnableUPnPIGD" value="1"/><label class="input-radio" for="EnableUPnPIGD1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="EnableUPnPIGD0" name="EnableUPnPIGD" value="0"/><label class="input-radio" for="EnableUPnPIGD0">&?public_034;</label>
</div>
</div>
<br>
<div class="row">
<label for="BLOCKWANEnable" class="cfgLabel w200">&?BClaro_004;</label>
<div class="right" id="BLOCKWANEnable">
<input type="radio" id="BLOCKWANEnable1" name="BLOCKWANEnable" value="1"/><label class="input-radio" for="BLOCKWANEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="BLOCKWANEnable0" name="BLOCKWANEnable" value="0"/><label class="input-radio" for="BLOCKWANEnable0">&?public_034;</label>
</div>
</div>
<br>
<div class="row">
<label for="IsIPSECAlg" class="cfgLabel w200">&?Alg_010;</label>
<div class="right" id="IsIPSECAlg">
<input type="radio" id="IsIPSECAlg1" name="IsIPSECAlg" value="1"/><label class="input-radio" for="IsIPSECAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsIPSECAlg0" name="IsIPSECAlg" value="0"/><label class="input-radio" for="IsIPSECAlg0">&?public_034;</label>
</div>
</div>
<br>
<div class="row">
<label for="IsPPTPAlg" class="cfgLabel w200">&?Alg_009;</label>
<div class="right" id="IsPPTPAlg">
<input type="radio" id="IsPPTPAlg1" name="IsPPTPAlg" value="1"/><label class="input-radio" for="IsPPTPAlg1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsPPTPAlg0" name="IsPPTPAlg" value="0"/><label class="input-radio" for="IsPPTPAlg0">&?public_034;</label>
</div>
</div>
<br>
<div class="row">
<label for="multicastmode" class="cfgLabel w200">&?MulticastMode_001;</label>
<div class="right" id="multicastmode">
<input type="radio" id="multicastmode1" name="multicastmode" value="2"/><label class="input-radio" for="multicastmode1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="multicastmode0" name="multicastmode" value="0"/><label class="input-radio" for="multicastmode0">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_GlobalEnable" name="Btn_cancel_GlobalEnable" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_GlobalEnable" name="Btn_apply_GlobalEnable" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
