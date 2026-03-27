<%
cgilua_lp.include("../../webmodules/modules/loopback_vlan_js.lp", getfenv(1))
%>
<div id="LoopbackDetectVlan" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=loopback_vlan_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LoopbackDetectVlanBar">&?public_136;</h1>
<div id="LoopbackDetectVlan_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LoopbackDetectVlan" style="display:none;">
<form class="form_content">
<div id="topLine_LoopbackDetectVlan" class="formTblCtrlBar">
<span id="instName_LoopbackDetectVlan" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_LoopbackDetectVlan" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_LoopbackDetectVlan" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="vlanCount" value="1">
<div class="row">
<label for="PortID" class="left w150">&?public_135;</label>
<div class="right">
<select name="PortID" id="PortID" class="selectNorm">
<%
cgilua.put(_G.CreateIFOpStr("LoopbackDetect"))
%>
</select>
</div>
</div>
<div class="row">
<label for="VidStr" class="left w150">&?public_137;</label>
<div class="right">
<input type="text" class="inputNorm" id="VidStr" name="VidStr" value=""/>
<span style="display:none;">&?public_072;1 ~ 4094</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_LoopbackDetectVlan" name="Btn_cancel_LoopbackDetectVlan" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_LoopbackDetectVlan" name="Btn_apply_LoopbackDetectVlan" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar">
<span id="addInstBar_LoopbackDetectVlan" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
