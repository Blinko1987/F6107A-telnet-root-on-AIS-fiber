<%
cgilua_lp.include("../../webmodules/modules/route_routedefaultipv6_js.lp", getfenv(1))
%>
<div id="RouteDefaultIpv6" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routedefaultipv6_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="RouteDefaultIpv6Bar">&?DialPlan_009;</h1>
<div id="RouteDefaultIpv6_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_RouteDefaultIpv6">
<form class="form_content">
<div id="changeArea_RouteDefaultIpv6" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label for="DefRTInterface" class="cfgLabel w130">&?public_015;</label>
<div class="right">
<select class="selectNorm" id="DefRTInterface" name="DefRTInterface">
<option value="" title='&?public_089;'>&?public_089;</option>
<%
cgilua.put(_G.CreateIFOpStr("IPv6DefaultRoute"))
%>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_RouteDefaultIpv6" name="Btn_cancel_RouteDefaultIpv6" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_RouteDefaultIpv6" name="Btn_apply_RouteDefaultIpv6" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
