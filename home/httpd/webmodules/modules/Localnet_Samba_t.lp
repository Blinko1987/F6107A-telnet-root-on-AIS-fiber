<%
cgilua_lp.include("../../webmodules/modules/Localnet_Samba_js.lp", getfenv(1))
%>
<div id="Samba" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Samba_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SambaBar">&?Samba_001;</h1>
<div id="Samba_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_Samba" style="display:block;">
<div id="changeArea_Samba" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="_InstNum" value="">
<input type="hidden" id="EnableSmb" value="">
<input type="hidden" id="AutoRun" value="">
<div id="SambaSwitch">
<p class="row"><label class="cfgLabel w150">&?Samba_001;</label><input type="radio" id="SambaSwitch2" name="SambaSwitch" value="2" />&nbsp;&nbsp;<label for="SambaSwitch2">&?public_033;</label></p>
<p class="row"><label class="cfgLabel w150">&nbsp;</label><input type="radio" id="SambaSwitch3" name="SambaSwitch" value="3" />&nbsp;&nbsp;<label for="SambaSwitch3">&?public_034;</label></p>
<p class="row"><label class="cfgLabel w150">&nbsp;</label><input type="radio" id="SambaSwitch1" name="SambaSwitch" value="1"/>&nbsp;&nbsp;<label for="SambaSwitch1">&?Samba_004;</label></p>
</div>
<div class="segmentRow"></div>
<div class="row">
<label for="NetbiosName" class="cfgLabel w150">&?Samba_005;</label>
<div class="right">
<input class="inputNorm" type="text" id="NetbiosName" name="NetbiosName" value=""/>
<span style="display: none;">&?public_073;2 ~ 15</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w150">&?Samba_007;</label>
<div class="right" id="AuthType">
<input type="radio" id="AuthType1" name="AuthType" value="0"/><label for="AuthType1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="AuthType0" name="AuthType" value="1"/><label for="AuthType0" >&?public_034;</label>
</div>
</div>
<div id="template_UserConf" style="display:none;">
<input type="hidden" id="_InstID" value="">
<div class="row" id="div_UserEnable" style="display:none">
<label class="cfgLabel w150">&?Samba_011;</label>
<div class="PostIgnore right" id="UserEnable">
<input type="radio" id="UserEnable1" name="UserEnable" value="1"/><label for="UserEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="UserEnable0" name="UserEnable" value="0"/><label for="UserEnable0" >&?public_034;</label>
</div>
</div>
<div class="row" id="div_UserName">
<label for="UserName" class="cfgLabel w150">&?Samba_008;</label>
<div class="right">
<input class="inputNorm" type="text" id="UserName" name="UserName" value=""/>
<span style="display: none;">&?Samba_010;&?public_073;1 ~ 8</span>
</div>
</div>
<div class="row" id="div_PassWord">
<label for="PassWord" class="cfgLabel inputNorm">&?Samba_009;</label>
<div class="right">
<input class="inputNorm SpecialPassword" type="password" id="PassWord" name="PassWord" value="						"/>
<span style="display: none;">&?public_073;0 ~ 32</span>
</div>
</div>
<div class="row" id="div_UserRight" style="display:none">
<label class="cfgLabel w150" for="UserRight">&?Samba_013;</label>
<div class="right">
<select name="UserRight" id="UserRight" class="PostIgnore selectNorm">
<option value="0" title='&?Samba_014;'>&?Samba_014;</option>
<option value="1" title='&?Samba_015;'>&?Samba_015;</option>
</select>
</div>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_Samba" name="Btn_cancel_Samba" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_Samba" name="Btn_apply_Samba" value="&?public_018;"/>
</div>
</form>
</div>
</div>
</div>
</div>
