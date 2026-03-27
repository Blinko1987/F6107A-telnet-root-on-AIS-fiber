<%
cgilua_lp.include("../../webmodules/modules/telnet_js.lp", getfenv(1))
%>
<div id="LocalTELNET" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=telnet_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalTELNETBar">&?Telnet_001;</h1>
<div id="LocalTELNET_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalTELNET">
<form class="form_content">
<div id="changeArea_LocalTELNET" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="TS_Enable" value="">
<input type="hidden" id="Wan_Enable" value="">
<input type="hidden" id="Lan_Enable" value="">
<div class="row">
<label for="F_TS_Enable" class="cfgLabel w150">&?Telnet_001;</label>
<div class="right" id="F_TS_Enable">
<input type="radio" id="F_TS_Enable1" name="F_TS_Enable" value="1"/><label for="F_TS_Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="F_TS_Enable0" name="F_TS_Enable" value="0"/><label for="F_TS_Enable0">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_instCfgArea" name="Btn_cancel_instCfgArea" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_instCfgArea" name="Btn_apply_instCfgArea" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
