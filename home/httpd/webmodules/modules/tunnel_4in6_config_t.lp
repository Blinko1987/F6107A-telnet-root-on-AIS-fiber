<%
cgilua_lp.include("../../webmodules/modules/tunnel_4in6_config_js.lp", getfenv(1))
%>
<div id="Dslite_4in6" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=tunnel_4in6_config_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="Dslite_4in6Bar">&?Internet4in6_003;</h1>
<div id="Dslite_4in6_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_Dslite_4in6" style="display:none;">
<div id="topLine_Dslite_4in6" class="formTblCtrlBar">
<span id="instName_Dslite_4in6" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
</span>
<span id="instDelete_Dslite_4in6" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_Dslite_4in6" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<form class="form_content formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="Wanctype" value="2">
<input type="hidden" id="TUN46Localv4Addr" _LuQUID_splitIPID="sub_TUN46Localv4Addr" value="">
<div class="row">
<label for="Tunnel46name" class="cfgLabel w150">&?Internet4in6_004;</label>
<div class="right">
<input class="inputNorm" type="text" id="Tunnel46name" name="Tunnel46name" value=""/>
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label class="left w150">&?public_015;</label>
<div id="Method" class="right">
<input type="radio" id="AutoSense" name="Method" value="1" checked="checked"><label for="AutoSense">&?public_094;</label>&nbsp;&nbsp;
<input type="radio" id="Manual" name="Method" value="0"><label for="Manual">&?public_093;</label>
</div>
</div>
<div class="row" id="Div_TUN46WANCViewName" style="display:none;">
<label for="TUN46WANCViewName" class="cfgLabel w150">&nbsp;</label>
<div class="right">
<select id="TUN46WANCViewName" name="TUN46WANCViewName" class="selectNorm">
<option value="" title='&?public_089;' selected="selected">&?public_089;</option>
<%cgilua.put(_G.CreateIFOpStr("Tunnel4in6"))%>
</select>
</div>
</div>
<div class="row">
<label for="TUN46Localv4Addr" class="cfgLabel w150">&?Internet4in6_007;</label>
<div class="right">
<input class="ip readonlyInputBg" disabled="disabled" value="192" name="sub_TUN46Localv4Addr0" type="text" maxlength="3" id="sub_TUN46Localv4Addr0" />.
<input class="ip readonlyInputBg" disabled="disabled" value="0" name="sub_TUN46Localv4Addr1" type="text" maxlength="3" id="sub_TUN46Localv4Addr1" />.
<input class="ip readonlyInputBg" disabled="disabled" value="0" name="sub_TUN46Localv4Addr2" type="text" maxlength="3" id="sub_TUN46Localv4Addr2" />.
<input class="ip" name="sub_TUN46Localv4Addr3" type="text" maxlength="3" id="sub_TUN46Localv4Addr3" />
<span style="display:none;">&?public_072;2 ~ 6</span>
</div>
</div>
<div id="IsHMREMOTEAddrSrc" class="row radiobutton">
<label class="cfgLabel w150">&?Internet4in6_008;</label>
<input id="IsHMREMOTEAddrSrc1" type="radio" value="1" name="IsHMREMOTEAddrSrc" >
<label for="IsHMREMOTEAddrSrc1">&?public_033;</label>&nbsp;&nbsp;
<input id="IsHMREMOTEAddrSrc0" type="radio" value="0" name="IsHMREMOTEAddrSrc" checked="checked">
<label for="IsHMREMOTEAddrSrc0">&?public_034;</label>
</div>
<div class="row" id="Prefix_sub_TUN46REMOTEIPAddr" style="display:none">
<label for="TUN46REMOTEIPAddr" class="cfgLabel w150" >&?Internet4in6_009;</label>
<div class="right">
<input class="inputNorm PostIgnore" type="text" id="TUN46REMOTEIPAddr" name="TUN46REMOTEIPAddr" value=""/>
<span style="display:none;">&?public_073;1 ~ 256</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_internet" name="Btn_cancel_IPFilter" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_internet" name="Btn_apply_IPFilter" value="&?public_018;" />
</div>
</form>
</div>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_Internet" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
