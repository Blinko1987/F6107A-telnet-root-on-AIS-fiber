<%
cgilua_lp.include("../../webmodules/modules/multicast_igmpwan_js.lp", getfenv(1))
%>
<div id="IGMPWan" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=multicast_igmpwan_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="IGMPWanBar">&?IGMP_008;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="IGMPWan_container">
<div id="template_IGMPWan">
<form class="form_content">
<div id="changeArea_IGMPWan" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label class="cfgLabel w150" for="WanCID">&?public_015;</label>
<div class="right">
<select name="WanCID" id="WanCID" class="selectNorm">
<option value="" title='&?public_089;'>&?public_089;</option>
<%
local OptAttrTbl = {"IPMode"}
cgilua.put(_G.CreateIFOpStr("IGMP", nil, OptAttrTbl))
%>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_IGMPWan" name="Btn_cancel_IGMPWan" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_IGMPWan" name="Btn_apply_IGMPWan" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
