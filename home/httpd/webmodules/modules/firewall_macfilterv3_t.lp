<%
cgilua_lp.include("../../webmodules/modules/firewall_macfilterv3_js.lp", getfenv(1))
%>
<div id="MACFilter" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=firewall_macfilterv3_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="MACFilterBar">&?Security_046;</h1>
<div id="MACFilter_container">
<input type="hidden" id="_InstNum" value="0">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_MACFilter" style="display:none;">
<form class="form_content">
<div id="topLine_MACFilter" class="formTblCtrlBar">
<span id="instName_MACFilter" class="instName collapsibleInst">&?public_041;</span>
<span id="instDelete_MACFilter" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_MACFilter" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="SrcMacAddr" value="">
<input type="hidden" id="DstMacAddr" value="">
<input type="hidden" id="Protocol" value="">
<div class="row">
<label for="Name:MACFilter" class="cfgLabel w180">&?public_016;</label>
<div class="right">
<input type="text" class="inputNorm" id="Name:MACFilter" name="Name:MACFilter" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="Type" class="cfgLabel w180">&?Security_017;</label>
<div class="right">
<select class="w150" id="Type" name="Type">
<option value="Bridge" title='&?public_048;'>&?public_048;</option>
<option value="Route" title='&?public_049;' selected="selected">&?public_049;</option>
<option value="Bridge+Route" title='&?public_050;'>&?public_050;</option>
</select>
</div>
</div>
<div class="row">
<label for="select_protocol" class="cfgLabel w180">&?public_053;</label>
<div class="right" id="div_Protocol">
<select class="w150" id='select_protocol' name='select_protocol' class="PostIgnore">
<option value='ALL' title='&?public_039;' selected="selected">&?public_039;</option>
<option value='IP' title='&?public_044;'>&?public_044;</option>
<option value='ARP' title='&?public_045;'>&?public_045;</option>
<option value='RARP' title='&?public_046;'>&?public_046;</option>
<option value='PPPoE' title='&?public_047;'>&?public_047;</option>
</select>
</div>
</div>
<div class="row">
<label for="SrcMacAddr" class="cfgLabel w180">&?Security_015;</label>
<div class="right">
<input class="mac" name="sub_SrcMacAddr0" type="text" maxlength="2" id="sub_SrcMacAddr0" value=""/>:
<input class="mac" name="sub_SrcMacAddr1" type="text" maxlength="2" id="sub_SrcMacAddr1" value=""/>:
<input class="mac" name="sub_SrcMacAddr2" type="text" maxlength="2" id="sub_SrcMacAddr2" value=""/>:
<input class="mac" name="sub_SrcMacAddr3" type="text" maxlength="2" id="sub_SrcMacAddr3" value=""/>:
<input class="mac" name="sub_SrcMacAddr4" type="text" maxlength="2" id="sub_SrcMacAddr4" value=""/>:
<input class="mac" name="sub_SrcMacAddr5" type="text" maxlength="2" id="sub_SrcMacAddr5" value=""/>
<a class="_LuQUID_SelAccessDevice" _LuQUID_Access_Mode="ALL">&?public_143;</a>
</div>
</div>
<div class="row" id="div_DstMacAddr" style="display: none;">
<label for="DstMacAddr" class="cfgLabel w180">&?Security_016;</label>
<div class="right">
<input class="mac" name="sub_DstMacAddr0" type="text" maxlength="2" id="sub_DstMacAddr0" value=""/>:
<input class="mac" name="sub_DstMacAddr1" type="text" maxlength="2" id="sub_DstMacAddr1" value=""/>:
<input class="mac" name="sub_DstMacAddr2" type="text" maxlength="2" id="sub_DstMacAddr2" value=""/>:
<input class="mac" name="sub_DstMacAddr3" type="text" maxlength="2" id="sub_DstMacAddr3" value=""/>:
<input class="mac" name="sub_DstMacAddr4" type="text" maxlength="2" id="sub_DstMacAddr4" value=""/>:
<input class="mac" name="sub_DstMacAddr5" type="text" maxlength="2" id="sub_DstMacAddr5" value=""/>
<a class="_LuQUID_SelAccessDevice" _LuQUID_Access_Mode="ALL">&?public_143;</a>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_MACFilter" name="Btn_cancel_MACFilter" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_MACFilter" name="Btn_apply_MACFilter" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<span id="addInstBar_MACFilter" class="instNew addInst">&?public_098;</span>
</div>
</div>
</div>
