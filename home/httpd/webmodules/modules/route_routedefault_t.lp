<%
cgilua_lp.include("../../webmodules/modules/route_routedefault_js.lp", getfenv(1))
%>
<div id="RouteDefault" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=route_routedefault_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="RouteDefaultBar">&?DialPlan_009;</h1>
<div id="RouteDefault_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_RouteDefault">
<form class="form_content">
<div id="changeArea_RouteDefault" class="ChangeArea formTblWrap">
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
cgilua.put(_G.CreateIFOpStr("IPv4DefaultRoute"))
%>
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_RouteDefault" name="Btn_cancel_RouteDefault" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_RouteDefault" name="Btn_apply_RouteDefault" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
