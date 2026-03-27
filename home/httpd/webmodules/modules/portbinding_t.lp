<%
cgilua_lp.include("../../webmodules/modules/portbinding_js.lp", getfenv(1))
%>
<div id="PortBindingConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=portbinding_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PortBindingConfBar">&?PortBinding_001;</h1>
<div id="PortBindingConf_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_PortBindingConf" style="display:none;">
<div id="topLine" class="formTblCtrlBar">
<span id="instName" class="instName collapsibleInst">&?public_041;</span>
</div>
<div id="changeArea_PortBindingConf" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="WAN_name" value="" class="PostIgnore">
<input type="hidden" id="WAN_servlist" value="" class="PostIgnore">
<input type="hidden" id="WANViewName" value="">
<input type="hidden" id="LANViewName" value="">
<div class="rowWithoutClear left w120" id="template_WANLAN" style="display:none;">
<input type="hidden" id="_InstID_LAN" value="" class="PostIgnore">
<input type="checkbox" name="Enable" id="Enable" class="PostIgnore">
<label for="Enable" id="LAN_name"></label>
</div>
<div class="row"></div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_PORTBindConf" name="Btn_cancel_PORTBindConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_PORTBindConf" name="Btn_apply_PORTBindConf" value="&?public_018;" />
<span class="AllOn emColor ctrlFont" id="allOn_PORTBind" name="allOn_PORTBind">&?public_042;</span>
&nbsp;&nbsp;|&nbsp;&nbsp;
<span class="AllOff emColor ctrlFont" id="allOff_PORTBind" name="allOn_PORTBind">&?public_043;</span>
</div>
</form>
</div>
</div>
</div>
</div>
