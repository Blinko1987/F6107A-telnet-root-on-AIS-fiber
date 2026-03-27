<%
cgilua_lp.include("../../webmodules/modules/wan_3gLTE_config_js.lp", getfenv(1))
%>
<div id="WAN3GDev" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wan_3gLTE_config_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="WAN3GDevBar">&?Internet3G_003_LTE;</h1>
<div id="WAN3GDev_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div class="noDataHint" id="InsertCardBefore" style="display:none;">
<span>&?Pinpublic_018_LTE;</span>
</div>
<div class="noDataHint" id="RouterOnly" style="display:none;">
<span>&?Pinpublic_019_LTE;</span>
</div>
<input type="hidden" class="PostIgnore" id="DongleTypeSwitch">
<input type="hidden" id="_InstNum" value="0">
<div id="ModemOnly">
<div id="template_WAN3GDev" style="display:none;">
<form class="form_content">
<div id="topLine_WAN3GDev" class="formTblCtrlBar">
<a id="instName_WAN3GDev" class="instName collapsibleInst" hidefocus="true" href="javascript:void(0);">&?public_041;</a>
<span id="instDelete_WAN3GDev" class="instDelete Btn_delete"><img src="img/del.png" alt="delete" /></span>
</div>
<div id="changeArea_WAN3GDev" class="ChangeArea formTblWrap" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="IdleTime" value="">
<input type="hidden" id="Enable" value="1">
<div class="row 3G_LTE">
<label for="WANCName" class="cfgLabel w200">&?InternetDE_005;</label>
<div class="right">
<input type="text" class="inputNorm" id="WANCName" name="WANCName" value=""/>
<span class="utf8Compatible" style="display: none;">&?public_073;1 ~ 768</span>
</div>
</div>
<input type="hidden" id="StrServList" value="INTERNET">
<div class="row 3G_LTE">
<label for="ServList" class="cfgLabel w200">&?InternetDE_007;</label>
<div class="right">
<select id="ServList" name="ServList" class="selectNorm">
<option value="1" title='&?InternetDE_086;'>&?InternetDE_086;</option>
</select>
</div>
</div>
<div class="row 3G">
<label class="cfgLabel w200">&?Internet3G_006;</label>
<div class="right" id="TtyPDPType">
<input type="radio" id="TtyPDPType0" name="TtyPDPType" value="PDP_IP" checked="checked">
<label for="TtyPDPType0">&?public_044;</label>
&nbsp;&nbsp;
<input type="radio" id="TtyPDPType1" name="TtyPDPType" value="PDP_PPP">
<label for="TtyPDPType1">&?public_102;</label>
</div>
</div>
<div class="row 3G">
<label for="TtyAPN" class="cfgLabel w200">&?Internet3G_007;</label>
<div class="right">
<input type="text" class="inputNorm" id="TtyAPN" name="TtyAPN" value=""/>
<span style="display: none;">&?public_073;0 ~ 31</span>
</div>
</div>
<div class="row 3G">
<label for="TtyDialNum" class="cfgLabel w200">&?Internet3G_008;</label>
<div class="right">
<input type="text" class="inputNorm" id="TtyDialNum" name="TtyDialNum" value=""/>
<span style="display: none;">&?public_073;1 ~ 31</span>
</div>
</div>
<div class="row 3G">
<label for="MTU" class="cfgLabel w200">&?public_104;</label>
<div class="right">
<input type="text" class="inputNorm" id="MTU" name="MTU" value="1500"/>
<span style="display: none;">&?public_072;128 ~ 1540</span>
</div>
</div>
<div class="row 3G" id="Prefix_UserName">
<label for="UserName" class="cfgLabel w200">&?public_026;</label>
<div class="right">
<input type="text" class="inputNorm" id="UserName" name="UserName" value=""/>
<span style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row 3G" id="Prefix_Password">
<label for="Password" class="cfgLabel w200">&?public_027;</label>
<div class="right">
<input type="password" class="w150 SpecialPassword" id="Password" name="Password" value="						"/>
<span style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row 3G">
<label for="AuthType" class="cfgLabel w200">&?InternetDE_016;</label>
<div class="right">
<select id="AuthType" name="AuthType" class="selectNorm">
<option value="PAP,CHAP,MS-CHAP" title='&?public_071;'>&?public_071;</option>
<option value="PAP" title='&?public_124;'>&?public_124;</option>
<option value="CHAP" title='&?public_125;'>&?public_125;</option>
</select>
</div>
</div>
<div class="row 3G">
<label for="ConnTrigger" class="cfgLabel w200">&?InternetDE_017;</label>
<div class="right">
<select id="ConnTrigger" name="ConnTrigger" class="selectNorm">
<option value="AlwaysOn" title='&?InternetDE_034;' selected>&?InternetDE_034;</option>
<option value="OnDemand" title='&?InternetDE_035;'>&?InternetDE_035;</option>
</select>
</div>
</div>
<div class="row" id="Prefix_IdleTime" style="display: none;">
<label for="C_IdleTime0" class="cfgLabel w200">&?InternetDE_018;</label>
<div class="right">
<input type="text" class="w80 PostIgnore" id="C_IdleTime0" name="C_IdleTime0" value="20"/>&?public_012;
<span style="display:none;">&?public_072;0 ~ 1092</span>
<input type="text" class="w40 PostIgnore" id="C_IdleTime1" name="C_IdleTime1" value="0"/>&?public_013;
<span style="display:none;">&?public_072;0 ~ 59</span>
</div>
</div>
<input type="text" id="IsNAT" name="IsNAT" value="1" style="display:none">
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel_WAN3GDev" name="Btn_cancel_WAN3GDev" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply_WAN3GDev" name="Btn_apply_WAN3GDev" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
<div class="addInstBar AddContentContainer">
<a id="addInstBar_WAN3GDev" class="instNew addInst" hidefocus="true" href="javascript:void(0);">&?public_098;</a>
</div>
</div>
</div>
</div>
