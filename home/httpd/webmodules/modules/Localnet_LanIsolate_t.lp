<%
cgilua_lp.include("../../webmodules/modules/Localnet_LanIsolate_js.lp", getfenv(1))
%>
<div id="LanIsolate" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_LanIsolate_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LanIsolateBar">&?LanIsolate_001;</h1>
<div id="LanIsolate_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LanIsolate">
<form class="form_content">
<div id="changeArea_LanIsolate" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="IsolateEnable" class="cfgLabel w200">&?LanIsolate_002;</label>
<div class="right" id="IsolateEnable">
<input type="radio" id="IsolateEnable1" name="IsolateEnable" value="1"/><label for="IsolateEnable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="IsolateEnable0" name="IsolateEnable" value="0"/><label for="IsolateEnable0" >&?public_034;</label>
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
