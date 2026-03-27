<%
cgilua_lp.include("../../webmodules/modules/route_routestaticipv4_js.lp", getfenv(1))
%>
<div id="StaticRoute" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routestaticipv4_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="StaticRouteBar">&?RouteIpv4_006;</h1>
<div id="StaticRoute_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?RouteIpv4_018;</a></div>
<div class="sceneTip_container">
<p>&?RouteIpv4_020;</p>
<p>&?RouteIpv4_021;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_StaticRoute" style="display:none;">
<form class="form_content">
<div id="topLine_StaticRoute" class="formTblCtrlBar">
<span id="instName_StaticRoute" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_StaticRoute" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_StaticRoute" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="DestIP" value="">
<input type="hidden" id="DestIPMask" value="">
<input type="hidden" id="GWIP" value="">
<input type="hidden" id="Type" value="Network">
<input type="hidden" id="Enable" value="1">
<div class="row">
<label for="Alias:StaticRoute" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" id="Alias:StaticRoute" name="Alias:StaticRoute" value="" class="w150"/>&nbsp;
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="Interface:StaticRoute" class="left w150">&?public_151;</label>
<div class="right">
<select name="Interface:StaticRoute" id="Interface:StaticRoute" class="selectNorm">
<option value="" title='&?public_089;' selected="selected">&?public_089;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv4Route"))
%>
</select>
</div>
</div>
<div class="row">
<label for="sub_DestIP0:StaticRoute" class="left w150">&?RouteIpv4_004;</label>
<div class="right">
<input name="sub_DestIP0:StaticRoute" type="text" maxlength="3" id="sub_DestIP0:StaticRoute" value="" class="ip" />.
<input name="sub_DestIP1:StaticRoute" type="text" maxlength="3" id="sub_DestIP1:StaticRoute" value="" class="ip" />.
<input name="sub_DestIP2:StaticRoute" type="text" maxlength="3" id="sub_DestIP2:StaticRoute" value="" class="ip" />.
<input name="sub_DestIP3:StaticRoute" type="text" maxlength="3" id="sub_DestIP3:StaticRoute" value="" class="ip" />
</div>
</div>
<div class="row">
<label for="sub_DestIPMask0:StaticRoute" class="left w150">&?public_030;</label>
<div class="right">
<input name="sub_DestIPMask0:StaticRoute" type="text" maxlength="3" id="sub_DestIPMask0:StaticRoute" value="" class="ip" />.
<input name="sub_DestIPMask1:StaticRoute" type="text" maxlength="3" id="sub_DestIPMask1:StaticRoute" value="" class="ip" />.
<input name="sub_DestIPMask2:StaticRoute" type="text" maxlength="3" id="sub_DestIPMask2:StaticRoute" value="" class="ip" />.
<input name="sub_DestIPMask3:StaticRoute" type="text" maxlength="3" id="sub_DestIPMask3:StaticRoute" value="" class="ip" />
</div>
</div>
<div class="row">
<label for="sub_GWIP0" class="left w150">&?public_031;</label>
<div class="right">
<input name="sub_GWIP0" type="text" maxlength="3" id="sub_GWIP0" value="" class="ip" />.
<input name="sub_GWIP1" type="text" maxlength="3" id="sub_GWIP1" value="" class="ip" />.
<input name="sub_GWIP2" type="text" maxlength="3" id="sub_GWIP2" value="" class="ip" />.
<input name="sub_GWIP3" type="text" maxlength="3" id="sub_GWIP3" value="" class="ip" />
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_StaticRoute" name="Btn_cancel_StaticRoute" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_StaticRoute" name="Btn_apply_StaticRoute" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar">
<span id="addInstBar_StaticRoute" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
