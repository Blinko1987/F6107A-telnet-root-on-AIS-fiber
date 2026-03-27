<%
cgilua.lp.include("../../webmodules/modules/Localnet_NetSphere_Mode_js.lp")
%>
<div id="NetSphereMAPMode" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_NetSphere_Mode_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MAPMode">&?pro_MAP_001;</h1>
<div id="NetSphereMAPMode_container" class="formTblWrap">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_NetSphereMAPMode" class="formTbl">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="DEV.MULTIAPCFG">
<input type="hidden" id="CurrentMode" value="">
<input type="hidden" id="CurrentEnable" value="">
<div class="row" id="MAP_Enable">
<label for="Enable" class="left w200">&?pro_MAP_003;</label>
<div id="Enable" class="right">
<input type="radio" id="Enable0" name="Enable" value="1"/>
<label for="Enable0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="Enable1" name="Enable" value="0"/>
<label for="Enable1">&?public_034;</label>
</div>
</div>
<div class="row" id="11kv_Enable" style="display:none;">
<label for="EnLegacyStaRoam" class="left w200">&?pro_MAP_017;</label>
<div id="EnLegacyStaRoam" class="right">
<input type="radio" id="EnLegacyStaRoam0" name="EnLegacyStaRoam" value="1"/>
<label for="EnLegacyStaRoam0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="EnLegacyStaRoam1" name="EnLegacyStaRoam" value="0"/>
<label for="EnLegacyStaRoam1">&?public_034;</label>
</div>
</div>
<div class="row" id="div_RoamRssiLmt24G">
<label for="RoamRssiLmt24G" class="left w200">&?wlanRoam_004;</label>
<div class="right">
<input type="text" id="RoamRssiLmt24G" name="RoamRssiLmt24G" value="" class="inputNorm" />
<span id="RangeRoamRssiLmt24G" style="display:none;">&?public_072;-110 ~ -40</span>dBm
</div>
</div>
<div class="row" id="div_RoamRssiLmt5G">
<label for="RoamRssiLmt5G" class="left w200">&?wlanRoam_005;</label>
<div class="right">
<input type="text" id="RoamRssiLmt5G" name="RoamRssiLmt5G" value="" class="inputNorm">
<span id="RangeRoamRssiLmt5G" style="display: none;">&?public_072;-110 ~ -40</span>dBm
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_Mode" name="Btn_cancel_Mode" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_Mode" name="Btn_apply_Mode" value="&?public_018;" style="display:none;"/>
<input type="button" class="Button" id="Btn_apply_Mode_Confirm" name="Btn_apply_Mode_Confirm" value="&?public_018;"/>
</div>
</div>
</div>
</div>
</div>
