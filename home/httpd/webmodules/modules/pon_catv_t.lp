<%
cgilua_lp.include("../../webmodules/modules/pon_catv_js.lp", getfenv(1))
%>
<div id="CATV" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=pon_catv_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="CATVBar">&?poncatv005;</h1>
<div id="CATV_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_CATV">
<div id="changeArea_CATV" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="AgcOffset" value="226">
<div class="row">
<label for="CatvEnable" class="cfgLabel w130">&?poncatv001;</label>
<div class="right" id="CatvEnable">
<input type="radio" id="CatvEnable1" name="CatvEnable" value="1"/><label for="CatvEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="CatvEnable0" name="CatvEnable" value="0"/><label for="CatvEnable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="AOS" class="cfgLabel w130">&?poncatv003;</label>
<div class="right">
<input type="text" class="inputNorm" id="AOS" name="AOS" value=""/> -12.8~12.7dB &?poncatv004;:0.1dB
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_CATV" name="Btn_cancel_CATV" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_CATV" name="Btn_apply_CATV" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
