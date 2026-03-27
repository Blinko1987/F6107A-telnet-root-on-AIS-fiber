<%
cgilua.lp.include("../../webmodules/modules/Manag_Operation_Mode_js.lp")
%>
<div id="OperationMode" class="instCfgArea HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Manag_Operation_Mode_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="OPMode">&?pro_OPMode_001;</h1>
<div id="OperationMode_container" class="formTblWrap">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_OperationMode" class="formTbl">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="CurrentMode" value="">
<div id="" class="colorTblRow">
<span class="left w100">&?pro_OPMode_004;</span>
<span class="right" id="curr_mode"></span>
</div>
<div id="RegionCode">
<% if cgilua.getCurrentSessAttr("Right") == "1" then %>
<p class="row"><label class="cfgLabel w100">&nbsp;</label><input type="radio" id="OPMode0" name="RegionCode" value="0"/>&nbsp;&nbsp;<label for="OPMode0">&?pro_OPMode_012;</label></p>
<% end %>
<p class="row"><label class="cfgLabel w100">&nbsp;</label><input type="radio" id="OPMode1" name="RegionCode" value="1"/>&nbsp;&nbsp;<label for="OPMode1">&?pro_OPMode_005;</label></p>
<p class="row"><label class="cfgLabel w100">&nbsp;</label><input type="radio" id="OPMode2" name="RegionCode" value="2" />&nbsp;&nbsp;<label for="OPMode2">&?pro_OPMode_006;</label></p>
<% if cgilua.getCurrentSessAttr("Right") == "1" then %>
<p class="row"><label class="cfgLabel w100">&nbsp;</label><input type="radio" id="OPMode3" name="RegionCode" value="3"/>&nbsp;&nbsp;<label for="OPMode3">&?pro_OPMode_007;</label></p>
<% end %>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_Mode" name="Btn_cancel_Mode" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_Mode" name="Btn_apply_Mode" value="&?public_018;" style="display:none;"/>
<input type="button" class="Button" id="Btn_apply_Mode_Confirm" name="Btn_apply_Mode_Confirm" value="&?public_018;"/>
</div>
</div>
</div>
</div>
</div>
