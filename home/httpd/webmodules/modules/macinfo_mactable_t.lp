<%
cgilua_lp.include("../../webmodules/modules/macinfo_mactable_js.lp", getfenv(1))
%>
<div class="instCfgArea">
<div id="MacTable" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=macinfo_mactable_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapsibleBar" id="macTableBar">&?MacTable_001;</h1>
<div id="MacTable_container" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<div>&?public_023;</div>
</div>
<div class="colorTbl form_content">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="MacTable_title" class="colorTblRow emFont titleRow">
<span class="w100" title="&?public_056;">&?public_056;</span>
<span class="w200" title="&?public_010;">&?public_010;</span>
<span class="w120" title="&?MacTable_005;">&?MacTable_005;</span>
</div>
<div id="template_MacTable" class="colorTblRow" style="display:none;" >
<span class="w100" id="LanName" title=""></span>
<span class="w200" id="MACAddr" title=""></span>
<span class="w120" id="AgingTm" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_MacTable" name="Btn_refresh_MacTable" value="&?public_003;" />
</div>
</div>
</div>
</div>
