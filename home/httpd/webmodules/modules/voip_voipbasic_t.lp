<%
cgilua_lp.include("../../webmodules/modules/voip_voipbasic_js.lp", getfenv(1))
%>
<div id="VOIPSipAccountConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_voipbasic_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_VOIPSipAccountConf" style="display:none;">
<h1 class="collapsibleBar" id="VOIPRegStatusBar">&?VoipBasic_002;</h1>
<div id="VOIPSipAccountConf_container" style="display:none;">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?VoipBasic_003;</a></div>
<div class="sceneTip_container">
<p>&?VoipBasic_004;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="_InstIDVP" value="">
<div class="row" id="div_Enable" style="display:none;">
<label for="Enable" class="cfgLabel w150">&?MgcpBasic_015;</label>
<div class="right" id="Enable">
<input type="radio" id="Enable1" name="Enable" value="2"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="1"/><label for="Enable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="AuthUserName" class="cfgLabel w150" id="Lable_AuthUserName">&?VoipBasic_005;</label>
<div class="right">
<input type="text" id="AuthUserName" name="AuthUserName" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;0 ~ 127</span>
</div>
</div>
<div class="row" id="TR_DirectoryNumber" style="display: none;">
<label for="DirectoryNumber" class="cfgLabel w150">&?VoipBasic_005;</label>
<div class="right">
<input type="text" id="DirectoryNumber" name="DirectoryNumber" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;0 ~ 31</span>
</div>
</div>
<div class="row">
<label for="DigestUserName" class="cfgLabel w150">&?VoipBasic_007;</label>
<div class="right">
<input type="text" id="DigestUserName" name="DigestUserName" class="inputNorm"/>
<span style="display: none;">&?public_073;0 ~ 127</span>
<input type="text" id="Digesttmp" name="Digesttmp" class="inputNorm" style="display: none;"/>
<span style="display: none;">&?public_073;0 ~ 113</span>
<input type="text" id="UserNameSuffix" class="inputNorm" style="display: none;"/>
</div>
</div>
<div class="row">
<label for="AuthPassword" class="cfgLabel w150">&?public_027;</label>
<div class="right">
<input class="SpecialPassword inputNorm" type="password" id="AuthPassword" name="AuthPassword" value="						" autocomplete="new-password"/>
<span style="display: none;">&?public_073;0 ~ 31</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_VOIPSipAccountConf" name="Btn_cancel_VOIPSipAccountConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_VOIPSipAccountConf" name="Btn_apply_VOIPSipAccountConf" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
