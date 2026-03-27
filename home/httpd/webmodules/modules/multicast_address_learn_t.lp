<%
cgilua_lp.include("../../webmodules/modules/multicast_address_learn_js.lp", getfenv(1))
%>
<div class="instCfgArea">
<div id="AdressLearn" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=multicast_address_learn_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapsibleBar" id="AdressLearnBar">&?MulticastLearn_004;</h1>
<div id="AdressLearn_container">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="noDataHint" style="display:none;">
<div>&?public_023;</div>
</div>
<div class="colorTbl form_content">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="AdressLearn_title" class="colorTblRow emFont titleRow">
<span class="w200" title="&?MulticastLearn_002;">&?MulticastLearn_002;</span>
<span class="w200" title="&?MulticastLearn_003;">&?MulticastLearn_003;</span>
<span class="w200" title="&?MulticastLearn_006;">&?MulticastLearn_006;</span>
</div>
<div id="template_AdressLearn" class="colorTblRow" style="display:none;" >
<span class="w200" id="Vlan" title=""></span>
<span class="w200" id="ClientIPAddr" title=""></span>
<span class="w200" id="Addr" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_AdressLearn" name="Btn_refresh_AdressLearn" value="&?public_003;" />
</div>
</div>
</div>
</div>
