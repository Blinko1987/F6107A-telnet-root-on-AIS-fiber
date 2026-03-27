<%
cgilua_lp.include("../../webmodules/modules/dns_hostname_js.lp", getfenv(1))
%>
<div id="HostName" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=dns_hostname_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="HostNameBar">&?DNS_004;</h1>
<div id="HostName_container">
<input type="hidden" id="_InstNum" value="0">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_HostName" style="display:none;">
<form class="form_content">
<div id="topLine_HostName" class="formTblCtrlBar">
<span id="instName_HostName" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_HostName" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_HostName" class="formTblWrap ChangeArea" style="display:none">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="OBJID" value="DNS">
<input type="hidden" id="LeaseTime" value="isDNSHOSTInst">
<div class="row">
<label for="HostName" class="left w150">&?DNS_005;</label>
<div class="right">
<input class="inputNorm" type="text" id="HostName" name="HostName" value=""/>
<span class="dTip" style="display: none;">&?public_073;1 ~ 255</span>
</div>
</div>
<div class="row">
<label for="IPAddress" class="left w150">&?public_007;</label>
<div class="right">
<input class="inputNorm" type="text" id="IPAddress" name="IPAddress" value=""/>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel PostIgnore" id="Btn_cancel_HostName" name="Btn_cancel_HostName" value="&?public_019;" />
<input type="button" class="Button Btn_apply PostIgnore" id="Btn_apply_HostName" name="Btn_apply_HostName" value="&?public_018;" />
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
