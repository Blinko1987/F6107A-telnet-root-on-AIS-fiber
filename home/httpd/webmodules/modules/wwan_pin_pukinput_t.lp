<%
cgilua_lp.include("../../webmodules/modules/wwan_pin_pukinput_js.lp", getfenv(1))
%>
<div id="PukInput" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wwan_pin_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PukInputBar">&?PukInput_001;</h1>
<div id="PukInput_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?PukInput_015;</a></div>
<div class="sceneTip_container">
<p>&?PukInput_016;</p>
<p>&?PukInput_017;</p>
<p>&?PukInput_018;</p>
<p>&?PukInput_019;</p>
<p>&?PukInput_020;</p>
<p>&?PukInput_021;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_PukInput">
<div id="changeArea_PukInput" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="AutoRefreshTime" value="10000">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="SimStatus" value="">
<input type="hidden" id="Flag" value="">
<input type="hidden" id="SimPinOP" value="">
<div id="puk_warn1" class="infoHint">
<span class="caption1">
<p>&?PukInput_002;</p>
<p>&?PukInput_003;</p>
</span>
</div>
<div id="puk_warn2" class="errorHint" style="display:none">
<span class="caption1">
<p></p>
</span>
</div>
<div class="row">
<label for="SimPuk" class="cfgLabel w70">
<div class="colorTblRow">
&?PukInput_022;
</div>
</label>
<div class="right w180">
<span id="refresh_puk">
<span>&?PukInput_005;</span>
<span class="PostIgnore pin_remain" id="PukRemain"></span>
<span>&?PukInput_006;</span>
</span>
</div>
<div class="right">
<input type="text" class="inputNorm" id="SimPuk" name="SimPuk" value=""/>
<span style="display: none;">&?public_073;8</span>
</div>
</div>
<div class="row">
<label for="SimPin" class="cfgLabel w250">
<div class="colorTblRow">&?PukInput_010;</div>
</label>
<div class="right">
<input type="text" class="inputNorm" id="SimPin" name="SimPin" value=""/>
<span style="display: none;">&?public_073;4 ~ 8</span>
</div>
</div>
<div class="row">
<label for="SimNewPin" class="cfgLabel w250">
<div class="colorTblRow">&?PukInput_011;</div>
</label>
<div class="right">
<input type="text" class="inputNorm" id="SimNewPin" name="SimNewPin" value=""/>
<span style="display: none;">&?public_073;4 ~ 8</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_PukInput" name="Btn_cancel_PukInput" value="&?public_019;" />
<input type="button" class="Button" id="Btn_apply_PukInput_Confirm" name="Btn_apply_PukInput_Confirm" value="&?public_018;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_PukInput" name="Btn_apply_PukInput" value="&?public_018;" style="display:none" />
</div>
</form>
</div>
</div>
</div>
</div>
