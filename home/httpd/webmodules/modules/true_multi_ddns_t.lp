<%
cgilua_lp.include("../../webmodules/modules/true_multi_ddns_js.lp", getfenv(1))
local DDNSOptionStr = ""
local retTab = cmapi.querylist("OBJ_DDNSSERVICE_ID", "IGD")
for i, v in ipairs(retTab) do
local DDNS_IDENTITY = v
local t = cmapi.getinst("OBJ_DDNSSERVICE_ID", DDNS_IDENTITY)
local Name = t.Name
local serviceUrl = t.Server
local webName = Name
if Name == "phddns" then
webName = lang.Ddns_015
end
DDNSOptionStr = DDNSOptionStr .. "<option serviceInst='" .. DDNS_IDENTITY
.. "' serviceUrl='" .. _G.encodeHTML(serviceUrl)
.. "' value='" .. _G.encodeHTML(Name)
.. "' title='" .. _G.encodeHTML(webName)
.. "'>" .. _G.encodeHTML(webName)
.. "</option>"
end
%>
<div id="Ddns" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=true_multi_ddns_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="DdnsBar">&?Ddns_001;</h1>
<div id="Ddns_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<input type="hidden" id="_InstNum" value="0">
<div id="template_Ddns" style="display:none;">
<form class="formTbl form_content">
<div id="topLine_Ddns" class="formTblCtrlBar">
<span id="instName_Ddns" class="instName collapsibleInst">&?public_041;</span>
<span class="instSwitch">
</span>
<span id="instDelete_Ddns" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_Ddns" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<input type="hidden" id="_InstID" value="">
<input type="hidden" id="Service" value="">
<input type="hidden" id="serviceInst" value="">
<input type="hidden" id="Name" value="">
<input type="hidden" id="Status" value="" class="PostIgnore">
<input type="hidden" id="UserType" value="" class="PostIgnore">
<div class="row">
<label for="Provider" class="cfgLabel w130">&?Ddns_004;</label>
<div class="right">
<select class="PostIgnore selectNorm" id="Provider" name="Provider">
<%
cgilua.put(DDNSOptionStr)
%>
</select>
</div>
</div>
<div class="row" id="div_Enable">
<label class="cfgLabel w130">&?Ddns_003;</label>
<div class="right" id="Enable">
<input type="radio" id="Enable1" name="Enable" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" value="0" checked/><label for="Enable0" >&?public_034;</label>
</div>
</div>
<div class="row" style="display:none" id="div_Status">
<label for="Span_Refresh" class="cfgLabel w130">&?Ddns_010;</label>
<div class="right">
<span class="PostIgnore" id="StatusStr" title=""></span>
<span class="clickable Btn_refresh" style="display:none" id="Span_Refresh" style="vertical-align: middle;"><img src="img/sync_s.png" alt="refresh"/></span>
</div>
</div>
<div class="row" id="div_ServiceUrl">
<label for="serviceUrl" class="cfgLabel w130">&?Ddns_005;</label>
<div class="right">
<input type="text" class="inputLong readonlyInputBg" id="serviceUrl" name="serviceUrl" value="" readonly/>
</div>
</div>
<div class="row" id="div_Username">
<label for="Username" class="cfgLabel w130">&?public_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="Username" name="Username" value=""/>
<span style="display: none;">&?public_073;1 ~ 256</span>
</div>
</div>
<div class="row" id="div_Password">
<label for="Password" class="cfgLabel w130">&?public_027;</label>
<div class="right">
<input type="password" class="inputNorm SpecialPassword" id="Password" name="Password" value="" autocomplete="new-password"/>
<span style="display: none;">&?public_073;1 ~ 256</span>
</div>
</div>
<div class="row" id="div_DomainName">
<label for="DomainName" class="cfgLabel w130">&?Ddns_006;</label>
<div class="right">
<input type="text" class="inputNorm" id="DomainName" name="DomainName" value=""/>
<span style="display: none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row" style="display:none" id="div_phddns_Username">
<label for="phddns_Username" class="cfgLabel w130">&?public_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="phddns_Username" name="phddns_Username" value=""/>
<span style="display: none;">&?public_073;5 ~ 16</span>
</div>
</div>
<div class="row" style="display:none" id="div_phddns_Password">
<label for="phddns_Password" class="cfgLabel w130">&?public_027;</label>
<div class="right">
<input type="password" class="inputNorm SpecialPassword" id="phddns_Password" name="phddns_Password" value="" autocomplete="new-password"/>
<span style="display: none;">&?public_073;6 ~ 16</span>
</div>
</div>
<div class="row" style="display:none" id="div_UserType">
<label for="UserTypeStr" class="cfgLabel w130">&?Ddns_008;</label>
<div class="right">
<input type="text" class="PostIgnore inputNorm readonlyInputBg" id="UserTypeStr" name="UserTypeStr" value="" readonly/>
</div>
</div>
<div class="row selectRow" style="display:none" id="div_DomainInfo">
<label for="DomainInfo" class="cfgLabel w130">&?Ddns_009;</label>
<div class="right">
<select class="PostIgnore selectNorm" id="DomainInfo" name="DomainInfo" size="4" style="height:auto">
</select>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_Ddns" name="Btn_cancel_Ddns" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_Ddns" name="Btn_apply_Ddns" value="&?public_018;" />
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_Ddns" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
