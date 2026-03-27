<%
cgilua_lp.include("../../webmodules/modules/firewall_dmz_js.lp", getfenv(1))
%>
<div id="Ipv4Dmz" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_dmz_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="Ipv4DmzBar">&?Dmz_003;</h1>
<div id="Ipv4Dmz_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_Ipv4Dmz">
<form class="form_content">
<div id="changeArea_Ipv4Dmz" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="row">
<label class="cfgLabel w130">&?Dmz_005;</label>
<div class="right" id="Enable:Ipv4Dmz">
<input type="radio" id="Enable1:Ipv4Dmz" name="Enable:Ipv4Dmz" value="1"/><label for="Enable1:Ipv4Dmz">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0:Ipv4Dmz" name="Enable:Ipv4Dmz" value="0"/><label for="Enable0:Ipv4Dmz" >&?public_034;</label>
</div>
</div>
<div class="row">
<label for="WANCViewName" class="cfgLabel w130">&?public_015;</label>
<div class="right">
<select class="selectNorm" id="WANCViewName" name="WANCViewName">
<option value="IGD.WANIF" title='&?public_094;' selected="selected">&?public_094;</option>
<%
cgilua.put(_G.CreateIFOpStr("DMZ",nill,{"WANServlist"}))
%>
</select>
</div>
</div>
<div class="row">
<label for="InternalClient" class="cfgLabel w130">&?Dmz_007;</label>
<div class="right">
<input type="text" class="inputNorm" id="InternalClient" name="InternalClient" value=""/>
<span class="dTip" style="display: none;">&?Dmz_008;</span>
</div>
</div>
<div class="row">
<label for="TempMacAddr" class="cfgLabel w130">&nbsp;</label>
<div class="right">
<input class="mac" name="sub_TempMacAddr0" type="text" maxlength="2" id="sub_TempMacAddr0" style="display: none;" value=""/>
<input class="mac" name="sub_TempMacAddr1" type="text" maxlength="2" id="sub_TempMacAddr1" style="display: none;" value=""/>
<input class="mac" name="sub_TempMacAddr2" type="text" maxlength="2" id="sub_TempMacAddr2" style="display: none;" value=""/>
<input class="mac" name="sub_TempMacAddr3" type="text" maxlength="2" id="sub_TempMacAddr3" style="display: none;" value=""/>
<input class="mac" name="sub_TempMacAddr4" type="text" maxlength="2" id="sub_TempMacAddr4" style="display: none;" value=""/>
<input class="mac" name="sub_TempMacAddr5" type="text" maxlength="2" id="sub_TempMacAddr5" style="display: none;" value=""/>
<a class="_LuQUID_SelAccessDeviceDmz" _LuQUID_Access_Mode="ALL">&?public_143;</a>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_Ipv4Dmz" name="Btn_cancel_Ipv4Dmz" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_Ipv4Dmz" name="Btn_apply_Ipv4Dmz" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
