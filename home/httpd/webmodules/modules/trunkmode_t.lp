<%
cgilua_lp.include("../../webmodules/modules/trunkmode_js.lp", getfenv(1))
%>
<div id="TrunkMode" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=trunkmode_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="TrunkModeBar">&?Trunk_001;</h1>
<div id="TrunkMode_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_TrunkMode">
<form class="form_content">
<div id="changeArea_TrunkMode" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<div class="staticInfoHint">
<p>&?Trunk_002;</p>
</div>
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="L2BTrunk" class="cfgLabel w150">&?Trunk_001;</label>
<div class="right" id="L2BTrunk">
<input type="radio" id="L2BTrunk1" name="L2BTrunk" value="1"/><label for="L2BTrunk1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="L2BTrunk0" name="L2BTrunk" value="0"/><label for="L2BTrunk0" >&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_TrunkMode" name="Btn_cancel_TrunkMode" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_TrunkMode" name="Btn_apply_TrunkMode" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
