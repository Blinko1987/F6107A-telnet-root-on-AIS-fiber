<%
cgilua_lp.include("../../webmodules/modules/status_lan_info_js.lp", getfenv(1))
%>
<div id="lan_info" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=status_lan_info_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="lan_infoBar">&?Status_lan_info_018;</h1>
<div id="lan_info_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="form_content">
<div id="template_lan_info" class="colorTbl" style="display:none;">
<div id="" class="colorTblRow emFont titleRow">
<span class="w330 emFont" title="&?Status_lan_info_003;">&?Status_lan_info_003;</span>
<span class="w250" id="AliasName" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_004;">&?Status_lan_info_004;</span>
<span class="w250" id="Status" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_006;">&?Status_lan_info_006;</span>
<span class="w250" id="InBytes" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_007;">&?Status_lan_info_007;</span>
<span class="w250" id="InPkts" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_008;">&?Status_lan_info_008;</span>
<span class="w250" id="InUnicast" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_009;">&?Status_lan_info_009;</span>
<span class="w250" id="InMulticast" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_010;">&?Status_lan_info_010;</span>
<span class="w250" id="InError" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?Status_lan_info_011;">&?Status_lan_info_011;</span>
<span class="w250" id="InDiscard" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_lan_info" name="Btn_refresh_lan_info" value=&?public_003; />
<% if "66" == CountryCode and "1" == Right then %>
<input type="button" class="Button" id="LANStatus_Btn_clear" name="LANStatus_Btn_clear" value="&?LogManag_010;"/>
<% end %>
</div>
</div>
</div>
</div>
