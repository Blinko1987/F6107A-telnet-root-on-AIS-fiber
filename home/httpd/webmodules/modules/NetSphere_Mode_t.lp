<%
cgilua.lp.include("../../webmodules/modules/NetSphere_Mode_js.lp")
%>
<div id="NetSphereMAPMode" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=NetSphere_Mode_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MAPMode">&?pro6640_MAP_001;</h1>
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
<%
if (env.getenv("CountryCode")=="77") or (env.getenv("CountryCode")=="79") then
%>
<div class="row">
<label for="BandSteerEnable" class="cfgLabel w200">&?mesh_003;</label>
<div class="right" id="BandSteerEnable">
<input type="radio" id="BandSteerEnable1" name="BandSteerEnable" value="1"/>
<label for="BandSteerEnable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="BandSteerEnable0" name="BandSteerEnable" value="0"/>
<label for="BandSteerEnable0" >&?public_034;</label>
</div>
</div>
<%end%>
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
