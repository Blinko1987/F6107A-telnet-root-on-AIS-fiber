<%
cgilua_lp.include("../../webmodules/modules/poninfo_status_js.lp", getfenv(1))
%>
<div id="PonInfoOptical" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=optical_info_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="ManagStatusBar">&?PonInfoOptical_001;</h1>
<div id="PonInfoOptical_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_PonInfoOptical" class="colorTbl">
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_009;">&?PonInfoOptical_009;</span>
<span class="w250" id="RegStatus" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_003;">&?PonInfoOptical_003;</span>
<span class="w250" id="RxPower" title=""></span>
<% if CountryCode == "95" then %>
<span>(&?pro_MAP_012; -25~-15dBm)</span>
<%end%>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_004;">&?PonInfoOptical_004;</span>
<span class="w250" id="TxPower" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_005;" id="Volt_font">&?PonInfoOptical_005;</span>
<span class="w250" id="Volt" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_006;">&?PonInfoOptical_006;</span>
<span class="w250" id="Current" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_007;">&?PonInfoOptical_007;</span>
<span class="w250" id="Temp" title=""></span>
</div>
<%if env.getenv("catvSupport") ~= "0" then%>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_012;">&?PonInfoOptical_012;</span>
<span class="w250" id="RFTxPower" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?PonInfoOptical_013;">&?PonInfoOptical_013;</span>
<span class="w250" id="VideoRxPower" title=""></span>
</div>
<%end%>
<div id="div_Time" class="colorTblRow" style="display:none;">
<span class="w330 emFont" title="&?PonInfoOptical_014;">&?PonInfoOptical_014;</span>
<span class="w250" id="PONOnTime" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_PonInfoOptical" name="Btn_refresh_PonInfoOptical" value=&?public_003; />
</div>
</div>
</div>
