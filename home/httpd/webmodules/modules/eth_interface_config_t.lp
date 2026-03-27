<%
cgilua_lp.include("../../webmodules/modules/eth_interface_config_js.lp", getfenv(1))
%>
<div id="lanInterface" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=eth_interface_config_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="lanInterfaceBar">&?lanPortconf_001;</h1>
<div id="lanInterface_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_lanInterface" style="display:none;">
<form class="form_content">
<div id="topLine_lanInterface" class="formTblCtrlBar">
<a id="instName_lanInterface" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);"></a>
</div>
<div id="changeArea_lanInterface" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Autoneg" value="">
<input type="hidden" id="MaxBitRate" value="">
<input type="hidden" id="DuplexMode" value="">
<div>
<p class="row"><label class="cfgLabel w200">&?InternetDE_046;</label><input type="radio" id="Auto" name="ModType"/>&nbsp;&nbsp;<label for="Auto">&?InternetDE_127;</label></p>
<p class="row"><label class="cfgLabel w200">&nbsp;</label><input type="radio" id="Mod1000MF" name="ModType"/>&nbsp;&nbsp;<label for="Mod1000MF">&?InternetDE_122;</label></p>
<p class="row"><label class="cfgLabel w200">&nbsp;</label><input type="radio" id="Mod1000MH" name="ModType"/>&nbsp;&nbsp;<label for="Mod1000MH">&?lanPortconf_004;</label></p>
<p class="row"><label class="cfgLabel w200">&nbsp;</label><input type="radio" id="Mod100MF" name="ModType"/>&nbsp;&nbsp;<label for="Mod100MF">&?InternetDE_124;</label></p>
<p class="row"><label class="cfgLabel w200">&nbsp;</label><input type="radio" id="Mod100MH" name="ModType"/>&nbsp;&nbsp;<label for="Mod100MH">&?InternetDE_123;</label></p>
<p class="row"><label class="cfgLabel w200">&nbsp;</label><input type="radio" id="Mod10MF" name="ModType"/>&nbsp;&nbsp;<label for="Mod10MF">&?InternetDE_126;</label></p>
<p class="row"><label class="cfgLabel w200">&nbsp;</label><input type="radio" id="Mod10MH" name="ModType"/>&nbsp;&nbsp;<label for="Mod10MH">&?InternetDE_125;</label></p>
</div>
<div class="segmentRow"></div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_lanInterface" name="Btn_cancel_lanInterface" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_lanInterface" name="Btn_apply_lanInterface" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
