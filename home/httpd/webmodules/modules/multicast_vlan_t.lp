<%
cgilua_lp.include("../../webmodules/modules/multicast_vlan_js.lp", getfenv(1))
%>
<div id="MulticastVlanConf" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=multicast_vlan_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MulticastVlanConfBar">&?Multicast_005;</h1>
<div id="MulticastVlanConf_container">
<input type="hidden" id="_InstNum" value="0">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_MulticastVlanConf" style="display:none;">
<form class="form_content">
<div id="topLine_MulticastVlanConf" class="formTblCtrlBar">
<span id="instName_MulticastVlanConf" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_MulticastVlanConf" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_MulticastVlanConf" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<div class="row">
<label for="PortViewName" class="cfgLabel w130">&?public_135;</label>
<div class="right">
<select class="selectNorm" id="PortViewName" name="PortViewName">
<%
cgilua.put(_G.CreateIFOpStr("MulticastVlan"))
%>
</select>
</div>
</div>
<div class="row">
<label for="MultSrcVid" class="cfgLabel w130">&?Multicast_006;</label>
<div class="right">
<input type="text" class="inputNorm" id="MultSrcVid" name="MultSrcVid" value=""/>
<span style="display: none;">&?public_072;1 ~ 4094</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MulticastVlanConf" name="Btn_cancel_MulticastVlanConf" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MulticastVlanConf" name="Btn_apply_MulticastVlanConf" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar">
<span id="addInstBar_MulticastVlanConf" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
