<%
cgilua_lp.include("../../webmodules/modules/firewall_conntrack_js.lp", getfenv(1))
%>
<div id="ConntrackStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_conntrack_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ConntrackStatusBar">&?Conntracks_001;</h1>
<div id="ConntrackStatus_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_ConntrackStatus" class="colorTbl">
<div id="" class="colorTblRow">
<span class="w250 emFont" id="ModelName_text" title="&?Conntracks_003;">&?Conntracks_003;</span>
<span class="w250" id="ConntrackMax" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w250 emFont" title="&?Conntracks_004;">&?Conntracks_004;</span>
<span class="w250" id="ConntrackUsed" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_ConntrackStatus" name="Btn_refresh_ConntrackStatus" value=&?public_003; />
</div>
</div>
</div>
