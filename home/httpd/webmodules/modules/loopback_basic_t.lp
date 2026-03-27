<%
cgilua_lp.include("../../webmodules/modules/loopback_basic_js.lp", getfenv(1))
%>
<div id="LoopbackDetectBasic" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=loopback_basic_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LoopbackDetectBasicBar">&?LoopbackDetect_003;</h1>
<div id="LoopbackDetectBasic_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_LoopbackDetectBasic" style="display:none;">
<div id="changeArea_LoopbackDetectBasic" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Ethertype" value="">
<div class="row">
<label class="left w180">&?LoopbackDetect_004;</label>
<div class="right" id="DMac">
<input type="radio" id="DMac0" name="DMac" value="ff:ff:ff:ff:ff:ff" checked="checked"/><label for="DMac0">&?LoopbackDetect_005;</label>&nbsp;&nbsp;
<input type="radio" id="DMac1" name="DMac" value="01:80:c2:00:00:00"/><label for="DMac1" >&?LoopbackDetect_006;</label>
</div>
</div>
<div class="row">
<label for="V_Ethertype" class="left w180">&?LoopbackDetect_007;</label>
<div class="right">
<input type="text" class="inputNorm" id="V_Ethertype" name="V_Ethertype" value=""/>
<span style="display:none;">&?LoopbackDetect_008;&?public_072;0 ~ 80ff, 8101 ~ ffff</span>
</div>
</div>
<div class="row">
<label for="Sendinterval" class="left w180">&?LoopbackDetect_009;</label>
<div class="right">
<input type="text" class="inputNorm" id="Sendinterval" name="Sendinterval" value=""/>&?public_052;
<span style="display:none;">&?public_072;100 ~ 1000</span>
</div>
</div>
<div class="row">
<label for="RenewTime" class="left w180">&?LoopbackDetect_010;</label>
<div class="right">
<input type="text" class="inputNorm" id="RenewTime" name="RenewTime" value=""/>&?public_013;
<span style="display:none;">&?public_072;60 ~ 300</span>
</div>
</div>
<div class="row">
<label for="CheckInterval" class="left w180">&?LoopbackDetect_011;</label>
<div class="right">
<input type="text" class="inputNorm" id="CheckInterval" name="CheckInterval" value=""/>&?public_013;
<span style="display:none;">&?public_072;5 ~ 300</span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_LoopbackDetectBasic" name="Btn_cancel_LoopbackDetectBasic" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_LoopbackDetectBasic" name="Btn_apply_LoopbackDetectBasic" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
