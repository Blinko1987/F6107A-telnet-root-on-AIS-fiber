<%
cgilua_lp.include("../../webmodules/modules/devauth_accountmgr_js.lp", getfenv(1))
%>
<div id="AccountManag" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=devauth_accountmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_AccountManag" style="display:none;">
<h1 class="collapsibleBar" id="AccountManagBar"></h1>
<div id="AccountManag_container" class="formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Right" value="">
<input type="hidden" id="Enable" value="">
<div class="row">
<label for="Username" class="cfgLabel w150">&?public_026;</label>
<div class="right">
<input type="text" id="Username" name="Username" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;1~256</span>
</div>
</div>
<div class="row" id="div_password">
<label for="Password" class="cfgLabel w150">&?AccountManag_004;</label>
<div class="right">
<input type="password" id="Password" name="Password" value="" class="inputNorm" autocomplete="new-password"/>
</div>
</div>
<div class="row">
<label for="NewPassword" class="cfgLabel w150">&?AccountManag_005;</label>
<div class="right">
<input type="password" id="NewPassword" name="NewPassword" value="" class="inputNorm" autocomplete="new-password"/>
<label id="pwStrth" style="display: none;">&?public_157;</label>
</div>
</div>
<div class="row">
<label for="NewConfirmPassword" class="cfgLabel w150">&?AccountManag_006;</label>
<div class="right">
<input type="password" id="NewConfirmPassword" name="NewConfirmPassword" value="" class="inputNorm PostIgnore" autocomplete="new-password"/>
</div>
</div>
<div class="row" id="div_Keyword" style="display:none;">
<label for="Keyword" class="cfgLabel w150">&?public_156;</label>
<div class="right">
<input type="text" id="Keyword" name="Keyword" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;0~63</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_AccountManag" name="Btn_cancel_AccountManag" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_AccountManag" name="Btn_apply_AccountManag" value="&?public_018;" />
</div>
</form>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
