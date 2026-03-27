<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_pininput_js.lp", getfenv(1))
%>
<div id="PinInput" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapsibleBar" id="PinInputBar">&?PinInput_001;</h1>
<div id="PinInput_container" style="display:none;">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?PinInput_010;</a></div>
<div class="sceneTip_container">
<p>&?PinInput_011;</p>
<p>&?PinInput_012;</p>
<p>&?PinInput_013;</p>
<p>&?PinInput_014;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<div id="template_PinInput" style="display:block;">
<div id="changeArea_PinInput" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="AutoRefreshTime" value="10000">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="SimStatus" value="">
<input type="hidden" id="Flag" value="">
<input type="hidden" id="SimPinOP" value=""/>
<div id="pin_warn1" class="infoHint">
<span class="caption1">
<p>&?PinInput_002;</p>
</span>
</div>
<div id="pin_warn2" class="warnHint" style="display:none">
<span class="caption1">
<p></p>
</span>
</div>
<div class="row">
<label for="SimPin" class="cfgLabel w70">
<div class="colorTblRow">
&?PinInput_015;
</div>
</label>
<div class="right w180">
<span id="refresh_pin">
<span>&?PinInput_005;</span>
<span class="PostIgnore pin_remain" id="PinRemain"></span>
<span>&?PinInput_006;</span>
</span>
</div>
<div class="right">
<input type="text" id="SimPin" name="SimPin" value="" class="inputNorm"/>
<span style="display: none;">&?public_073;4~8</span>
</div>
</div>
<div class="row">
<label class="cfgLabel w250">
&nbsp;
</label>
<div class="right">
<input id="RemPin" name="RemPin" type="checkbox" checked="checked" value="">
<label for="RemPin">&?PinInput_007;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_PinInput" name="Btn_cancel_PinInput" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_PinInput" name="Btn_apply_PinInput" value="&?public_018;" />
</div>
</form>
</div>
</div>
</div>
</div>
