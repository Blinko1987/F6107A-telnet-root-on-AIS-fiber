<%
cgilua_lp.include("../../webmodules/modules/hardware_diag_js.lp", getfenv(1))
%>
<div id="HWDiag" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=hardware_diag_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="HWDiagBar">&?hwdiag_001;</h1>
<div id="HWDiag_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="1">
<div class="form_content">
<div id="template_HWDiag" class="colorTbl">
<div class="colorTblRow emFont titleRow">
<span class="w330 emFont" title="&?hwdiag_002;">&?hwdiag_002;</span>
<span class="w250" title="&?hwdiag_003;">&?hwdiag_003;</span>
</div>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_004;">&?hwdiag_004;</span>
<span class="w250" id="DDRStatus" title=""></span>
</div>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_005;">&?hwdiag_005;</span>
<span class="w250" id="FlashStatus" title=""></span>
</div>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_006;">&?hwdiag_006;</span>
<span class="w250" id="TxStatus" title=""></span>
</div>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_007;">&?hwdiag_007;</span>
<span class="w250" id="RxStatus" title=""></span>
</div>
<%
local lanCount = env.getenv("lanSupport")
local Num = lanCount - 1
local strhtml = ""
for i=0, Num do
strhtml = '<div class=\"colorTblRow\"> <span class=\"w330 emFont\" title=\"' .. lang.hwdiag_008 .. i+1 .. '\">'
.. lang.hwdiag_008 .. i+1 .. '</span><span class=\"w250\" id=\"ETHStatus' .. i .. '\" title=\"\">' ..
'</span>' .. '</div>'
%>
<%=strhtml%>
<%
end
if env.getenv("usbSupport") ~= "0" then
%>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_012;">&?hwdiag_012;</span>
<span class="w250" id="USBStatus" title=""></span>
</div>
<%
end
if env.getenv("wifiSupport") ~= "0" then
%>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_013;">&?hwdiag_013;</span>
<span class="w250" id="WLANStatus0" title=""></span>
</div>
<%
end
if env.getenv("wifiSupport") == "2" then
%>
<div class="colorTblRow">
<span class="w330 emFont" title="&?hwdiag_014;">&?hwdiag_014;</span>
<span class="w250" id="WLANStatus1" title=""></span>
</div>
<%end%>
</div>
<div class="unfloatBtnGroup">
<input type="button" class="longBtn" id="btndiagnose" name="btndiagnose" value="&?hwdiag_001;"/>
</div>
</div>
</div>
</div>
