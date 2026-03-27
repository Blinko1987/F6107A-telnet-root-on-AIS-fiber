<%
cgilua_lp.include("../../webmodules/modules/devmgr_statusmgr_js.lp", getfenv(1))
%>
<div id="ManagStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=devmgr_statusmgr_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ManagStatusBar">&?StatusManag_001;</h1>
<div id="ManagStatus_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_ManagStatus" class="colorTbl">
<div id="" class="colorTblRow">
<span class="w250 emFont" id="ModelName_text" title="&?StatusManag_002;">&?StatusManag_002;</span>
<span class="w250" id="ModelName" title=""></span>
</div>
<div id="div_SerialNumber" class="colorTblRow">
<span class="w250 emFont" title="&?StatusManag_003;">&?StatusManag_003;</span>
<span class="w250" id="SerialNumber" title=""></span>
</div>
<div id="dev_sVerExtent" class="colorTblRow">
<span class="w250 emFont" id="SoftwareVerExtent_text" title="&?StatusManag_004;">&?StatusManag_004;</span>
<span class="w250" id="SoftwareVerExtent" title=""></span>
</div>
<div id="div_HardwareVer" class="colorTblRow">
<span class="w250 emFont" title="&?StatusManag_005;">&?StatusManag_005;</span>
<span class="w250" id="HardwareVer" title=""></span>
</div>
<div id="div_SoftwareVer" class="colorTblRow">
<span class="w250 emFont" title="&?StatusManag_006;">&?StatusManag_006;</span>
<span class="w250" id="SoftwareVer" title=""></span>
</div>
<div id="div_BootVer" class="colorTblRow">
<span class="w250 emFont" id="BootVer_text" title="&?StatusManag_007;">&?StatusManag_007;</span>
<span class="w250" id="BootVer" title=""></span>
</div>
<div id="div_OnuAlias" class="colorTblRow">
<span class="w250 emFont" title="&?StatusManag_009;">&?StatusManag_009;</span>
<span class="w250" id="OnuAlias" title=""></span>
</div>
<div id="div_VerDate" class="colorTblRow" style="display:none;">
<span class="w250 emFont" title="&?StatusManag_010;">&?StatusManag_010;</span>
<span class="w250" id="VerDate" title=""></span>
</div>
<div id="div_ManuFacturer" class="colorTblRow" style="display:none;">
<span class="w250 emFont" title="&?StatusManag_011;">&?StatusManag_011;</span>
<span class="w250" id="ManuFacturer" title=""></span>
</div>
<div id="div_CpuUse" class="colorTblRow" style="display:none;">
<span class="w250 emFont" title="&?StatusManag_015;">&?StatusManag_015;</span>
<span class="w250" id="CpuUsage" title=""></span>
</div>
<div id="div_MemUse" class="colorTblRow" style="display:none;">
<span class="w250 emFont" title="&?StatusManag_016;">&?StatusManag_016;</span>
<span class="w250" id="MemUsage" title=""></span>
</div>
<div id="div_Time" class="colorTblRow" style="display:none;">
<span class="w250 emFont" title="&?StatusManag_017;">&?StatusManag_017;</span>
<span class="w250" id="PoweronTime" title=""></span>
</div>
<div id="div_SubVersion" class="colorTblRow" style="display:none;">
<span class="w250 emFont" title="&?StatusManag_022;">&?StatusManag_022;</span>
<span class="w250" id="ReuseSubVersion" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_ManagStatus" name="Btn_refresh_ManagStatus" value=&?public_003; />
</div>
</div>
</div>
