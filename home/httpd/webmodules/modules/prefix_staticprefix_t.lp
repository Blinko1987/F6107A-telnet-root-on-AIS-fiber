<%
cgilua_lp.include("../../webmodules/modules/prefix_staticprefix_js.lp", getfenv(1))
%>
<div id="PrefixMgr" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=prefix_staticprefix_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PrefixMgrBar">&?LanMgrIpv6_007;</h1>
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="PrefixMgr_container">
<input type="hidden" id="_InstNum" value="0">
<div id="template_PrefixMgr" style="display:none;">
<form class="form_content">
<div id="topLine_PrefixMgr" class="formTblCtrlBar">
<span id="instName_PrefixMgr" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_PrefixMgr" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_PrefixMgr" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="Alias:PrefixMgr" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" id="Alias:PrefixMgr" name="Alias:PrefixMgr" value="" class="w150"/>&nbsp;
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="Prefix:PrefixMgr" class="left w150">&?LanMgrIpv6_008;</label>
<div class="right">
<input type="text" id="Prefix:PrefixMgr" name="Prefix:PrefixMgr" value="" class="w150"/> /
<input type="text" id="PrefixLen:PrefixMgr" name="PrefixLen:PrefixMgr" value="64" class="w37"/>
<span style="display:none;">&?public_072;1 ~ 64</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_PrefixMgr" name="Btn_cancel_PrefixMgr" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_PrefixMgr" name="Btn_apply_PrefixMgr" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar">
<span id="addInstBar_PrefixMgr" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
