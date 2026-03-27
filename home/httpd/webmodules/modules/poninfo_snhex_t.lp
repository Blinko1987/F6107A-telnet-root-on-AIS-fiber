<%
cgilua_lp.include("../../webmodules/modules/poninfo_snhex_js.lp", getfenv(1))
%>
<div id="PonSn" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=poninfo_snhex_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PonSnBar">&?PON_005;</h1>
<div id="template_PonSn">
<div id="PonSn_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="IsPwd" name="IsRidPwd" value="1"/>
<div class="row">
<label for="Sn" class="cfgLabel w150">&?PON_005;</label>
<div class="right">
<input class="inputNorm" type="text" id="Sn" name="Sn" value="" disabled/>
</div>
</div>
<div class="row">
<label for="PwFlag" class="cfgLabel w150">&?PON_010;</label>
<div class="right" id="PwFlag">
<input type="radio" id="PwFlag1" name="PwFlag" value="1"/><label for="PwFlag1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="PwFlag0" name="PwFlag" value="0"/><label for="PwFlag0" >&?public_034;</label>
</div>
</div>
<div class="row">
<div class="w150" style="float:left">
<label for="Ridpw">&?PON_004;</label>&nbsp;&nbsp;
</div>
<div class="right">
<input class="inputNorm SpecialPassword" type="password" id="Ridpw" name="Ridpw" value="" autocomplete="new-password" />
<span class="dTip" style="display: none;">&?public_073;1 ~ 10</span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;"/>
<input type="button" class="Button Btn_apply" id="Btn_apply" name="Btn_apply" value="&?public_018;"/>
</div>
</div>
</div>
</div>
</div>
</div>
