<%
cgilua_lp.include("../../webmodules/modules/voip_sipdigitmap_js.lp", getfenv(1))
%>
<div id="VoipSipDigitMap" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Voip_sipdigitmap_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="VoipSipDigitMapBar">&?SipDigitMap_001;</h1>
<div id="VoipSipDigitMap_container">
<input type="hidden" id="_InstNum" value="0">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_VoipSipDigitMap" class="formTblWrap" style="display:none;">
<div id="topLine_VoipSipDigitMap" class="formTblCtrlBar">
<span id="instName_VoipSipDigitMap" class="instName collapsibleInst instNameExp">&?public_041;</span>
</div>
<div id="changeArea_VoipSipDigitMap" class="ChangeArea formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="_InstID_timer" value="">
<div class="staticInfoHint">
<p>&?SipDigitMap_003;</p>
</div>
<% if _G.commConf.voipMap == true then %>
<div class="row" id="div_receiving_short">
<label for="ShortTimer" class="cfgLabel w200">&?voip_Map001;</label>
<div class="right">
<input type="text" id="ShortTimer" name="ShortTimer" value=""/>&?voip_Map003;
<span style="display: none;">&?public_072;0 ~ 1000</span>
</div>
</div>
<div class="row" id="div_receiving_long">
<label for="LongTimer" class="cfgLabel w200">&?voip_Map002;</label>
<div class="right">
<input type="text" id="LongTimer" name="LongTimer" value=""/>&?voip_Map003;
<span style="display: none;">&?public_072;400 ~ 2000</span>
</div>
</div>
<%end%>
<div class="textareaRow">
<textarea id="DigitMap" needPost="needPost" value=""></textarea>
<span class="dTip" style="display: none;">&?public_073;1 ~ 4096</span>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_applyp" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
