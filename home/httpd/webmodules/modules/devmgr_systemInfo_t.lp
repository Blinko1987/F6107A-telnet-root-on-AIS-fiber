<%
cgilua_lp.include("../../webmodules/modules/devmgr_systemInfo_js.lp", getfenv(1))
%>
<div id="SystemInfo" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=devmgr_systemInfo_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="SystemInfoBar">&?SystemInfo_002;</h1>
<div id="SystemInfo_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<input id="TotalFlash" type="hidden" value="">
<input id="Flash_Percent_Used" type="hidden" value="">
<div id="template_SystemInfo" class="colorTbl">
<div id="div_CPU_Usage" class="colorTblRow">
<span class="w250 emFont" title="&?StatusManag_015;">&?StatusManag_015;</span>
<span class="w250" id="CPU_Usage" title=""></span>
</div>
<div id="div_Memory_Usage" class="colorTblRow">
<span class="w250 emFont" title="&?StatusManag_016;">&?StatusManag_016;</span>
<span class="w250" id="Memory_Usage" title=""></span>
</div>
<div id="div_Power_On_Time" class="colorTblRow">
<span class="w250 emFont" title="&?SystemInfo_004;">&?SystemInfo_004;</span>
<span class="w250" id="Power_On_Time" title=""></span>
</div>
<div id="div_Flash_Usage" class="colorTblRow">
<span class="w250 emFont" title="&?SystemInfo_001;">&?SystemInfo_001;</span>
<span class="w250" id="Flash_Usage" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_SystemInfo" name="Btn_refresh_SystemInfo" value=&?public_003; />
</div>
</div>
</div>
