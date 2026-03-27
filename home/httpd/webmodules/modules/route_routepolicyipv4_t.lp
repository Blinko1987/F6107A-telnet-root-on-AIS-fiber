<%
cgilua_lp.include("../../webmodules/modules/route_routepolicyipv4_js.lp", getfenv(1))
%>
<div id="PolicyRoute" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routepolicyipv4_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PolicyRouteBar">&?RouteIpv4_008;</h1>
<div id="PolicyRoute_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_PolicyRoute" style="display:none;">
<form class="form_content">
<div id="topLine_PolicyRoute" class="formTblCtrlBar">
<span id="instName_PolicyRoute" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_PolicyRoute" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_PolicyRoute" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="SrcIP" value="">
<input type="hidden" id="DestIP" value="">
<input type="hidden" id="DestIPMask" value="">
<input type="hidden" id="SrcIPMask" value="">
<input type="hidden" id="SrcMAC" value="">
<input type="hidden" id="Dscp" value="-1">
<div class="row">
<label for="Alias:PolicyRoute" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" id="Alias:PolicyRoute" name="Alias:PolicyRoute" value="" class="inputNorm"/>&nbsp;
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="DestInterface" class="left w150">&?public_151;</label>
<div class="right">
<select name="DestInterface" id="DestInterface" class="selectNorm">
<option value="" title='&?public_089;' selected="selected">&?public_089;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv4Route"))
%>
</select>
</div>
</div>
<div class="row">
<label for="sub_SrcIP0" class="left w150">&?RouteIpv4_009;</label>
<div class="right">
<input name="sub_SrcIP0" type="text" maxlength="3" id="sub_SrcIP0" value="" class="ip" />.
<input name="sub_SrcIP1" type="text" maxlength="3" id="sub_SrcIP1" value="" class="ip" />.
<input name="sub_SrcIP2" type="text" maxlength="3" id="sub_SrcIP2" value="" class="ip" />.
<input name="sub_SrcIP3" type="text" maxlength="3" id="sub_SrcIP3" value="" class="ip" />
</div>
</div>
<div class="row">
<label for="sub_SrcIPMask0" class="left w150">&?RouteIpv4_010;</label>
<div class="right">
<input name="sub_SrcIPMask0" type="text" maxlength="3" id="sub_SrcIPMask0" value="" class="ip" />.
<input name="sub_SrcIPMask1" type="text" maxlength="3" id="sub_SrcIPMask1" value="" class="ip" />.
<input name="sub_SrcIPMask2" type="text" maxlength="3" id="sub_SrcIPMask2" value="" class="ip" />.
<input name="sub_SrcIPMask3" type="text" maxlength="3" id="sub_SrcIPMask3" value="" class="ip" />
</div>
</div>
<div class="row">
<label for="sub_DestIP0" class="left w150">&?RouteIpv4_011;</label>
<div class="right">
<input name="sub_DestIP0" type="text" maxlength="3" id="sub_DestIP0" value="" class="ip" />.
<input name="sub_DestIP1" type="text" maxlength="3" id="sub_DestIP1" value="" class="ip" />.
<input name="sub_DestIP2" type="text" maxlength="3" id="sub_DestIP2" value="" class="ip" />.
<input name="sub_DestIP3" type="text" maxlength="3" id="sub_DestIP3" value="" class="ip" />
</div>
</div>
<div class="row">
<label for="sub_DestIPMask0" class="left w150">&?RouteIpv4_012;</label>
<div class="right">
<input name="sub_DestIPMask0" type="text" maxlength="3" id="sub_DestIPMask0" value="" class="ip" />.
<input name="sub_DestIPMask1" type="text" maxlength="3" id="sub_DestIPMask1" value="" class="ip" />.
<input name="sub_DestIPMask2" type="text" maxlength="3" id="sub_DestIPMask2" value="" class="ip" />.
<input name="sub_DestIPMask3" type="text" maxlength="3" id="sub_DestIPMask3" value="" class="ip" />
</div>
</div>
<div class="row">
<label for="Protocol" class="left w150">&?public_053;</label>
<div class="right">
<select name="Protocol" id="Protocol" class="selectNorm">
<option value="TCP" title='&?public_036;'>&?public_036;</option>
<option value="UDP" title='&?public_037;'>&?public_037;</option>
<option value="ICMP" title='&?public_038;'>&?public_038;</option>
<option value="ANY" title='&?public_039;' selected="selected">&?public_039;</option>
</select>
</div>
</div>
<div class="row" style="display:none;">
<label for="SrcPort" class="left w150">&?RouteIpv4_013;</label>
<div class="right">
<input type="text" id="SrcPort" name="SrcPort" value="" class="inputNorm"/>&nbsp;
<span style="display:none;">&?public_072;1 ~ 65535</span>
</div>
</div>
<div class="row" style="display:none;">
<label for="DestPort" class="left w150">&?RouteIpv4_014;</label>
<div class="right">
<input type="text" id="DestPort" name="DestPort" value="" class="inputNorm"/>&nbsp;
<span style="display:none;">&?public_072;1 ~ 65535</span>
</div>
</div>
<div class="row">
<label for="sub_SrcMAC0" class="left w150">&?RouteIpv4_015;</label>
<div class="right">
<input name="sub_SrcMAC0" type="text" class="mac" maxlength="2" id="sub_SrcMAC0" value="" />:
<input name="sub_SrcMAC1" type="text" class="mac" maxlength="2" id="sub_SrcMAC1" value="" />:
<input name="sub_SrcMAC2" type="text" class="mac" maxlength="2" id="sub_SrcMAC2" value="" />:
<input name="sub_SrcMAC3" type="text" class="mac" maxlength="2" id="sub_SrcMAC3" value="" />:
<input name="sub_SrcMAC4" type="text" class="mac" maxlength="2" id="sub_SrcMAC4" value="" />:
<input name="sub_SrcMAC5" type="text" class="mac" maxlength="2" id="sub_SrcMAC5" value="" />
<a class="_LuQUID_SelAccessDevice" _LuQUID_Access_Mode="ALL">&?public_143;</a>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_PolicyRoute" name="Btn_cancel_PolicyRoute" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_PolicyRoute" name="Btn_apply_PolicyRoute" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar">
<span id="addInstBar_PolicyRoute" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
