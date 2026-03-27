<%
cgilua_lp.include("../../webmodules/modules/sntp_js.lp", getfenv(1))
%>
<div id="LocalSntp" class="instCfgArea HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=sntp_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalSntp">&?SNTP_074;</h1>
<div id="LocalSntp_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_LocalSntp">
<form class="form_content">
<div id="changeArea_LocalSntp" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<input type="hidden" class="PostIgnore" id="CurrentLocalTime" value="">
<input type="hidden" class="PostIgnore" id="NtpConfigPermission" value="">
<input type="hidden" id="ZoneIndex" value="">
<input type="hidden" id="AutoSetTzname" value="1">
<div class="row" id="div_SntpEnable" style="display: none;">
<label class="cfgLabel w200">&?SNTP_001;</label>
<div class="right" id="Enable">
<input type="radio" id="Enable1" name="Enable" class="PostIgnore" value="1"/><label for="Enable1">&?public_033;</label>&nbsp;&nbsp;
<input type="radio" id="Enable0" name="Enable" class="PostIgnore" value="0"/><label for="Enable0" >&?public_034;</label>
</div>
</div>
<div class="row" id="div_SntpWan" style="display: none;">
<label class="cfgLabel w200" for="SntpBindWanName">&?public_015;</label>
<div class="right">
<select name="SntpBindWanName" id="SntpBindWanName" class="selectLong PostIgnore">
<option value="" title='&?public_039;'>&?public_039;</option>
<%
cgilua.put(_G.CreateIFOpStr("SNTPWAN",nil,{"WANServlist"}))
%>
</select>
</div>
</div>
<div class="row">
<label class="cfgLabel w200" id="TipSntp">&?SNTP_003;</label>
<div class="right w200">
<label id="CCurrentLocalTime" class="cfgLabel w250"></label>
</div>
</div>
<div class="row">
<label for="LocalTimeZoneandName" class="cfgLabel w200">&?SNTP_004;</label>
<div class="right">
<select class="selectLong" name="LocalTimeZoneandName" id="LocalTimeZoneandName">
</select>
</div>
</div>
<div class="row">
<label for="NtpServer1" class="cfgLabel w200">&?SNTP_005;</label>
<div class="right">
<input class="inputLong" type="text" id="NtpServer1" name="NtpServer1" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row">
<label for="NtpServer2" class="cfgLabel w200">&?SNTP_006;</label>
<div class="right">
<input class="inputLong" type="text" id="NtpServer2" name="NtpServer2" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row" id="div_NtpServer3" style="display:none">
<label for="NtpServer3" class="cfgLabel w200">&?SNTP_119;3</label>
<div class="right">
<input class="inputLong" type="text" id="NtpServer3" name="NtpServer3" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row" id="div_NtpServer4" style="display:none">
<label for="NtpServer4" class="cfgLabel w200">&?SNTP_119;4</label>
<div class="right">
<input class="inputLong" type="text" id="NtpServer4" name="NtpServer4" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row" id="div_NtpServer5" style="display:none">
<label for="NtpServer5" class="cfgLabel w200">&?SNTP_119;5</label>
<div class="right">
<input class="inputLong" type="text" id="NtpServer5" name="NtpServer5" value=""/>
<span class="dTip" style="display: none;">&?public_073;0 ~ 64</span>
</div>
</div>
<div class="row">
<label for="PollTimeInterval" class="cfgLabel w200">&?SNTP_007;</label>
<div class="right">
<input class="inputLong" type="text" id="PollTimeInterval" name="PollTimeInterval" value=""/>&?public_013;
<span class="dTip" style="display: none;">&?public_072;3600 ~ 86400</span>
</div>
</div>
<div class="row" id="Prefix_DaylightSavingsUsed">
<label for="DaylightSavingsUsed" class="left w200">&?SNTP_008;</label>
<div id="DaylightSavingsUsed" class="right">
<input type="radio" id="DaylightSavingsUsed0" name="DaylightSavingsUsed" value="1"/>
<label for="DaylightSavingsUsed0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="DaylightSavingsUsed1" name="DaylightSavingsUsed" value="0"/>
<label for="DaylightSavingsUsed1">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="Dscp" class="cfgLabel w200">&?SNTP_009;</label>
<div class="right">
<input class="inputLong" type="text" id="Dscp" name="Dscp" value=""/>
<span class="dTip" style="display: none;">&?public_072;0 ~ 63</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</form>
</div>
</div>
</div>
