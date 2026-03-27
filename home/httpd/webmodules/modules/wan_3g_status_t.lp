<%
cgilua_lp.include("../../webmodules/modules/wan_3g_status_js.lp", getfenv(1))
%>
<div id="WAN3GStatus" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wan_3g_status_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WAN3GStatusBar">&?Internet3G_040;</h1>
<div id="WAN3GStatus_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="noDataHint" id="InsertCardBefore" style="display:none;">
<span>&?Pinpublic_018;</span>
</div>
<div class="noDataHint" id="NoItem" style="display:none;">
<span>&?public_023;</span>
</div>
<div id="template_WAN3GStatus" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="colorTbl form_content">
<input type="hidden" id="TtyPDPType" value="">
<input type="hidden" id="IsNAT" value="">
<input type="hidden" id="ConnStatus" value="">
<input type="hidden" id="ConnError" value="">
<input type="hidden" id="DNS1" value="">
<input type="hidden" id="DNS2" value="">
<input type="hidden" id="DNS3" value="">
<input type="hidden" id="IPAddress" value="">
<input type="hidden" id="SubnetMask" value="">
<div id="WAN3GStatus_title" class="colorTblRow emFont titleRow">
<span class="w250 emFont" title="&?InternetDE_005;">&?InternetDE_005;</span>
<span class="w250 emFont" id="WANCName" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?Internet3G_006;">&?Internet3G_006;</span>
<span class="w250" id="C_TtyPDPType" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?Internet3G_007;">&?Internet3G_007;</span>
<span class="w250" id="TtyAPN" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?Internet3G_008;">&?Internet3G_008;</span>
<span class="w250" id="TtyDialNum" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?InternetDE_022;">&?InternetDE_022;</span>
<span class="w250" id="C_IsNAT" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?public_007;">&?public_007;</span>
<span class="w250" id="IPAndMask" title=""></span>
</div>
<div class="colorTblRow">
<span class="w250 emFont" title="&?public_107;">&?public_107;</span>
<span class="w250" id="DNS" title=""></span>
</div>
<div class="colorTblRow RouterSpecial">
<span class="w250 emFont" title="&?InternetAIS_020;">&?InternetAIS_020;</span>
<span class="w250" id="GateWay" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?InternetAIS_013;">&?InternetAIS_013;</span>
<span class="w250" id="C_ConnStatus" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?InternetAIS_088;">&?InternetAIS_088;</span>
<span class="w250" id="C_ConnError" title=""></span>
</div>
<div class="colorTblRow ModemSpecial">
<span class="w250 emFont" title="&?InternetAIS_019;">&?InternetAIS_019;</span>
<span class="w250" id="UpTime" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="WAN3GStatus_Btn_refresh" name="WAN3GStatus_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
