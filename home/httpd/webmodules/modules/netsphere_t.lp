<%
cgilua_lp.include("../../webmodules/modules/netsphere_js.lp", getfenv(1))
%>
<div id="Netsphere" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=netsphere_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="NetsphereBar">&?mesh_001;</h1>
<div id="Netsphere_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_Netsphere">
<form class="form_content">
<div id="changeArea_Netsphere" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="Enable" class="cfgLabel w150">&?mesh_002;</label>
<div class="right" id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0"/><label for="Enable0" >&?public_034;</label>
</div>
</div>
<div class="row">
<label for="BsEnable" class="cfgLabel w150">&?mesh_003;</label>
<div class="right" id="BsEnable">
<input type="radio" id="BsEnable1" name="BsEnable" value="1"/><label for="BsEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="BsEnable0" name="BsEnable" value="0"/><label for="BsEnable0" >&?public_034;</label>
</div>
</div>
<div class="row">
<label for="RoamRssiLmt24G" class="left w150">&?mesh_004;</label>
<div class="right">
<input type="text" id="RoamRssiLmt24G" name="RoamRssiLmt24G" value="" class="inputNorm" style="width:50px;"/>(-65dBm &?mesh_005;)
</div>
</div>
<div class="row">
<label for="RoamRssiLmt5G" class="left w150">&?mesh_006;</label>
<div class="right">
<input type="text" id="RoamRssiLmt5G" name="RoamRssiLmt5G" value="" class="inputNorm" style="width:50px;"/>(-70dBm &?mesh_005;)
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
