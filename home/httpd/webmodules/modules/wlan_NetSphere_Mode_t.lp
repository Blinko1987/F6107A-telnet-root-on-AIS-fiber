<%
cgilua.lp.include("../../webmodules/modules/wlan_NetSphere_Mode_js.lp")
%>
<div id="NetSphereMAPMode" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wlan_NetSphere_Mode_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MAPMode">EasyMesh</h1>
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
<label for="Enable" class="left w200">Mesh Enable</label>
<div id="Enable" class="right">
<input type="radio" id="Enable0" name="Enable" value="1"/>
<label for="Enable0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="Enable1" name="Enable" value="0"/>
<label for="Enable1">&?public_034;</label>
</div>
</div>
<div class="row" id="EnBandSteer_Enable">
<label for="EnBandSteer" class="left w200">&?pro_MAP_010;</label>
<div id="EnBandSteer" class="right">
<input type="radio" id="EnBandSteer0" name="EnBandSteer" value="1"/>
<label for="EnBandSteer0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="EnBandSteer1" name="EnBandSteer" value="0"/>
<label for="EnBandSteer1">&?public_034;</label>
</div>
</div>
<%
if env.getenv("Right") == "1" then
%>
<div class="row" id="RssiLmt24G">
<label for="BsRssiLmt24G" style="padding-left: 20px;" class="left w180">&?pro_MAP_011;</label>
<div class="right">
<input type="text" id="BsRssiLmt24G" name="BsRssiLmt24G" value="" class="inputNorm" style="width:50px;"/>dBm
<span style="display:none;">&?pro_MAP_012; -60dBm</span>
</div>
</div>
<div class="row" id="RssiLmt5G">
<label for="BsRssiLmt5G" style="padding-left: 20px;" class="left w180">&?pro_MAP_013;</label>
<div class="right">
<input type="text" id="BsRssiLmt5G" name="BsRssiLmt5G" value="" class="inputNorm" style="width:50px;"/>dBm
<span style="display:none;">&?pro_MAP_012; -110dBm</span>
</div>
</div>
<%
end
%>
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
