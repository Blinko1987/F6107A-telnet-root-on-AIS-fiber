<%
cgilua_lp.include("../../webmodules/modules/qos_shaper_js.lp", getfenv(1))
%>
<div id="QosShaper" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=qos_shaper_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="QosShaperBar">&?QosShaper_001;</h1>
<div id="QosShaper_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?QosShaper_005;</a></div>
<div class="sceneTip_container">
<p>&?QosShaper_003;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_QosShaper" style="display:none;">
<form class="form_content">
<div id="topLine_QosShaper" class="formTblCtrlBar">
<span id="instName_QosShaper" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
<div id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0" checked="checked"/><label for="Enable0" >&?public_034;</label>
</div>
</span>
<span id="instDelete_QosShaper" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_QosShaper" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="Alias" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Alias" name="Alias" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073; 1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="Interface" class="left w150">&?public_056;</label>
<div class="right">
<select class="selectNorm" id="Interface" name="Interface">
<option value="WAN" title='&?public_128;'>&?public_128;</option>
<%cgilua.put(_G.CreateIFOpStr("QoSShaper"))%>
</select>
</div>
</div>
<div class="row">
<label for="ShapingRate" class="left w150">&?QosShaper_004;</label>
<div class="right">
<input type="text" class="inputNorm" id="ShapingRate" name="ShapingRate" value=""/>&?public_081;
<span class="dTip" style="display: none;">&?public_072;0, <span id="QBW_MIN">8192</span> ~ <span id="QBW_MAX">100000000</span></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_QosShaper" name="Btn_cancel_QosShaper" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_QosShaper" name="Btn_apply_QosShaper" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_QosShaper" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
