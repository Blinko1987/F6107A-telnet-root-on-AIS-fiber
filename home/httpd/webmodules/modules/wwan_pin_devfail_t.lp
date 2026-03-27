<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_devfail_js.lp", getfenv(1))
%>
<div id="PinDevFail" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PinDevFailBar">&?PinDevFail_001;</h1>
<div id="PinDevFail_container" >
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?PinDevFail_004;</a></div>
<div class="sceneTip_container">
<p>&?PinDevFail_005;</p>
<p>&?PinDevFail_006;</p>
<p>&?PinDevFail_007;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_PinDevFail" class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<input type="hidden" id="AutoRefreshTime" value="7000">
<form class="formTbl">
<div class="colorTblRow">
<span class="w400">
&?PinDevFail_002;
</span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh_pin" refreshTime="5000" id="Btn_refresh_PinDevFail" name="Btn_refresh_PinDevFail" value="&?public_003;" />
</div>
</div>
</div>
