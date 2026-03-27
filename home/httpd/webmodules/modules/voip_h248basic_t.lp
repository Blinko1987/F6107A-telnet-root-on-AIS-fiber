<%
cgilua_lp.include("../../webmodules/modules/voip_h248basic_js.lp", getfenv(1))
%>
<div id="H248Basic" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_h248basic_lua.lua</span>
</address>
<h1 class="collapBarWithDataTrans" id="H248BasicBar">&?H248Basic_001;</h1>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="H248Basic_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_H248Basic" class="formTblWrap" style="display:none;">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="LocalPort" class="left w150">&?H248Basic_003;</label>
<div class="right">
<input type="text" id="LocalPort" name="LocalPort" value="" class="inputNorm"/>
<span style="display:none;">&?public_072;1024 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="MGCAddr1" class="left w150">&?H248Basic_004;</label>
<div class="right">
<input type="text" id="MGCAddr1" name="MGCAddr1" value="" class="inputNorm"/>
<span style="display:none;">&?public_073;0 ~ 63</span>
</div>
</div>
<div class="row">
<label for="MGCPort1" class="left w150">&?H248Basic_005;</label>
<div class="right">
<input type="text" id="MGCPort1" name="MGCPort1" value="" class="inputNorm"/>
<span style="display:none;">&?public_072;1024 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="MGCAddr2" class="left w150">&?H248Basic_006;</label>
<div class="right">
<input type="text" id="MGCAddr2" name="MGCAddr2" value="" class="inputNorm"/>
<span style="display:none;">&?public_073;0 ~ 63</span>
</div>
</div>
<div class="row">
<label for="MGCPort2" class="left w150">&?H248Basic_007;</label>
<div class="right">
<input type="text" id="MGCPort2" name="MGCPort2" value="" class="inputNorm"/>
<span style="display:none;">&?public_072;1024 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="MGMIDType" class="left w150">&?H248Basic_008;</label>
<div class="right">
<select name="MGMIDType" id="MGMIDType" class="selectNorm">
<option value="0" title='&?public_095;'>&?public_095;</option>
<option value="2" title='&?H248Basic_009;'>&?H248Basic_009;</option>
<option value="4" title='&?H248Basic_010;'>&?H248Basic_010;</option>
</select>
</div>
</div>
<div class="row" id="Row_MGMID">
<label for="MGMID" class="left w150">&?H248Basic_011;</label>
<div class="right">
<input type="text" id="MGMID" name="MGMID" value="" class="inputNorm"/>
<span style="display:none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_H248Basic" name="Btn_cancel_H248Basic" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_H248Basic" name="Btn_apply_H248Basic" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
