<%
cgilua_lp.include("../../webmodules/modules/route_routestaticipv6_js.lp", getfenv(1))
%>
<div id="StaticRoute" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routestaticipv6_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="StaticRouteBar">&?RouteIpv4_006;</h1>
<div id="StaticRoute_container">
<div class="sceneTip">
<div class="sceneTipLink"><a>&?RouteIpv6_004;</a></div>
<div class="sceneTip_container">
<p>&?RouteIpv6_005;</p>
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
<input type="hidden" id="Type" value="Network">
<input type="hidden" id="Enable" value="1">
<div class="row">
<label for="Alias:StaticRoute" class="left w150">&?public_016;</label>
<div class="right">
<input type="text" id="Alias:StaticRoute" name="Alias:StaticRoute" value="" class="inputNorm"/>&nbsp;
<span class="utf8Compatible" style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="Interface:StaticRoute" class="left w150">&?public_151;</label>
<div class="right">
<select name="Interface:StaticRoute" id="Interface:StaticRoute" class="selectNorm">&nbsp;
<option value="" title='&?public_089;' selected="selected">&?public_089;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv6Route"))
%>
</select>
</div>
</div>
<div class="row">
<label for="DestIP:StaticRoute" class="left w150">&?RouteIpv6_003;</label>
<div class="right">
<input type="text" id="DestIP:StaticRoute" name="DestIP:StaticRoute" value="" class="inputNorm"/> /
<input type="text" id="PrefixLen:StaticRoute" name="PrefixLen:StaticRoute" value="" class="w37"/>
<span style="display:none;">&?public_072;0 ~ 128</span>
</div>
</div>
<div class="row">
<label for="GWIP:StaticRoute" class="left w150">&?public_031;</label>
<div class="right">
<input type="text" id="GWIP:StaticRoute" name="GWIP:StaticRoute" value="" class="inputNorm"/>&nbsp;
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
