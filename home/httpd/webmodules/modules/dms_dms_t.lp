<%
cgilua_lp.include("../../webmodules/modules/dms_dms_js.lp", getfenv(1))
%>
<div id="DMS" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=dms_dms_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_DMS">
<h1 class="collapBarWithDataTrans" id="DMSBar">&?DMS_001;</h1>
<div id="DMS_container">
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
<input type="hidden" id="ContentList" value="">
<div class="row">
<label for="Enable" class="cfgLabel w180">&?DMS_003;</label>
<div class="right" id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0"/><label for="Enable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="DmsName" class="cfgLabel w180">&?DMS_002;</label>
<div class="right">
<input type="text" id="DmsName" name="DmsName" value="" class="inputNorm">
<span style="display: none;">&?public_073;1~128</span>
</div>
</div>
<div class="row">
<label for="RescanTime" class="cfgLabel w180">&?DMS_004;</label>
<div class="right">
<select id="RescanTime" name="RescanTime" class="selectNorm">
<option value="-1" title="&?DMS_005;">&?DMS_005;</option>
<option value="0" title="&?DMS_006;">&?DMS_006;</option>
<option value="1" title="&?DMS_007;">&?DMS_007;</option>
</select>
</div>
</div>
<div class="row" id="TR_RescanTimeValue">
<label for="RescanTimeValue" class="cfgLabel w180">&?DMS_008;</label>
<div class="right">
<input type="text" class="PostIgnore inputNorm" id="RescanTimeValue" name="RescanTimeValue" value="">&?public_012;
<span style="display: none;">&?public_072;1~1440</span>
</div>
</div>
<div class="row">
<label for="Path0" class="cfgLabel w180">&?DMS_009;1</label>
<div class="right">
<input type="text" class="PostIgnore inputNorm" id="Path0" name="Path0" value="">&nbsp;&nbsp;
<input type="button" class="Button BrowseBtn PostIgnore" id="Browse0" name="Browse0" value="&?public_066;"/>
</div>
</div>
<div class="row">
<label for="Path1" class="cfgLabel w180">&?DMS_009;2</label>
<div class="right PostIgnore">
<input type="text" class="PostIgnore inputNorm" id="Path1" name="Path1" value="">&nbsp;&nbsp;
<input type="button" class="Button BrowseBtn PostIgnore" id="Browse1" name="Browse1" value="&?public_066;"/>
</div>
</div>
<div class="row">
<label for="Path2" class="cfgLabel w180">&?DMS_009;3</label>
<div class="right PostIgnore">
<input type="text" class="PostIgnore inputNorm" id="Path2" name="Path2" value="">&nbsp;&nbsp;
<input type="button" class="Button BrowseBtn PostIgnore" id="Browse2" name="Browse2" value="&?public_066;"/>
</div>
</div>
<div class="row">
<label for="Path3" class="cfgLabel w180">&?DMS_009;4</label>
<div class="right PostIgnore">
<input type="text" class="PostIgnore inputNorm" id="Path3" name="Path3" value="">&nbsp;&nbsp;
<input type="button" class="Button BrowseBtn PostIgnore" id="Browse3" name="Browse3" value="&?public_066;"/>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
