<%
cgilua_lp.include("../../webmodules/modules/voip_h248auth_js.lp", getfenv(1))
%>
<div id="H248Auth" class="instCfgArea HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_h248auth_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="H248Auth">&?H248Auth_001;</h1>
<div id="H248Auth_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_H248Auth" style="display:none;">
<div id="changeArea_H248Auth" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="AuthenticationMethID" class="left w150">&?H248Auth_003;</label>
<div class="right">
<select name="AuthenticationMethID" id="AuthenticationMethID" class="selectNorm">
<option value="0" title='0'>0</option>
<option value="1" title='1'>1</option>
<option value="100" title='100'>100</option>
</select>
</div>
</div>
<div class="row beCtrl">
<label for="MD5AuthMGIDType" class="left w150">&?H248Auth_004;</label>
<div class="right">
<select name="MD5AuthMGIDType" id="MD5AuthMGIDType" class="selectNorm">
<option value="0" title='&?public_095;'>&?public_095;</option>
<option value="1" title='&?public_010;'>&?public_010;</option>
<option value="2" title='&?H248Auth_005;'>&?H248Auth_005;</option>
</select>
</div>
</div>
<div class="row beCtrl" id="Row_MD5AuthMGID">
<label for="MD5AuthMGID" class="left w150">&?H248Auth_006;</label>
<div class="right">
<input type="text" id="MD5AuthMGID" name="MD5AuthMGID" value="" class="inputNorm">
<span style="display: none;">&?public_073;0 ~ 63</span>
</div>
</div>
<div class="row beCtrl">
<label for="InitPublicKey" class="left w150">&?H248Auth_007;</label>
<div class="right">
<input type="text" id="InitPublicKey" name="InitPublicKey" value="" class="inputNorm">
<span style="display: none;">&?public_073;0 ~ 63</span>
</div>
</div>
<div class="row beCtrl">
<label for="DhPara_P" class="left w150">&?H248Auth_008;</label>
<div class="right">
<select name="DhPara_P" id="DhPara_P" class="selectNorm">
<option value="1" title='1'>1</option>
<option value="2" title='2'>2</option>
</select>
</div>
</div>
<div class="row beCtrl">
<label for="DhPara_G" class="left w150">&?H248Auth_009;</label>
<div class="right">
<select name="DhPara_G" id="DhPara_G" class="selectNorm">
<option value="0" title='0'>0</option>
<option value="1" title='1'>1</option>
<option value="2" title='2'>2</option>
<option value="3" title='3'>3</option>
<option value="4" title='4'>4</option>
</select>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
