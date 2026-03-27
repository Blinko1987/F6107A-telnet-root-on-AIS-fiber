<%
cgilua_lp.include("../../webmodules/modules/multicast_basic_js.lp", getfenv(1))
%>
<div id="MulticastBasic" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=igmp_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MulticastBasicBar">&?public_002;</h1>
<div id="MulticastBasic_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_MulticastBasic">
<div id="changeArea_MulticastBasic" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<div class="row">
<label for="Agtime" class="cfgLabel w200">&?Multicast_002;</label>
<div class="right">
<input class="inputLong" type="text" id="Agtime" name="Agtime" value="" class="inputNorm"/>&?public_013;
<span style="display:none;">&?public_072;1 ~ 604800</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MulticastBasic" name="Btn_cancel_MulticastBasic" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MulticastBasic" name="Btn_apply_MulticastBasic" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
