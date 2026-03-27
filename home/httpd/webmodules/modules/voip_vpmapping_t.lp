<%
cgilua_lp.include("../../webmodules/modules/voip_vpmapping_js.lp", getfenv(1))
%>
<div id="VPMapping" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=voip_vpmapping_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="template_VPMapping" style="display:none;">
<h1 class="collapsibleBar" id="VPMappingBar">&?VoipVPMap_003;</h1>
<div id="VPMapping_container" style="display:none;">
<div class="formTblWrap">
<div id="errorHint" class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="PhyList" value="">
<div class="row">
<label for="Phone1Enable" class="left w200">&?VoipVPMap_004;1</label>
<div id="Phone1Enable" class="right">
<input type="radio" id="Phone1Enable1" name="Phone1Enable" value="1"/>
<label for="Phone1Enable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="Phone1Enable0" name="Phone1Enable" value="0"/>
<label for="Phone1Enable0">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="Phone2Enable" class="left w200">&?VoipVPMap_004;2</label>
<div id="Phone2Enable" class="right">
<input type="radio" id="Phone2Enable1" name="Phone2Enable" value="1"/>
<label for="Phone2Enable1">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="Phone2Enable0" name="Phone2Enable" value="0"/>
<label for="Phone2Enable0">&?public_034;</label>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_VPMapping" name="Btn_cancel_VPMapping" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_VPMapping" name="Btn_apply_VPMapping" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="fakeHeadDIV"></div>
</div>
</div>
