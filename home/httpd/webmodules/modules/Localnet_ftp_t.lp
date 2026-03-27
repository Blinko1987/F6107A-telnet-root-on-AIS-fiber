<%
cgilua_lp.include("../../webmodules/modules/Localnet_ftp_js.lp", getfenv(1))
%>
<div id="LocalFtp" class="instCfgArea HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=Localnet_ftp_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="LocalFtp">&?FTP_001;</h1>
<div id="template_LocalFtp">
<div id="LocalFtp_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<form class="form_content">
<input type="hidden" id="_InstID" value="">
<div class="row" id="Prefix_FtpEnable">
<label for="FtpEnable" class="left w150">&?FTP_003;</label>
<div id="FtpEnable" class="right">
<input type="radio" id="FtpEnable0" name="FtpEnable" value="1"/>
<label for="FtpEnable0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="FtpEnable1" name="FtpEnable" value="0"/>
<label for="FtpEnable1">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="FtpAnon" class="left w150">&?FTP_007;</label>
<div id="FtpAnon" class="right">
<input type="radio" id="FtpAnon0" name="FtpAnon" value="0"/>
<label for="FtpAnon0">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="FtpAnon1" name="FtpAnon" value="1"/>
<label for="FtpAnon1">&?public_034;</label>
</div>
</div>
<div class="row" id="div_FTPUsername">
<label for="Username" class="cfgLabel w150">&?FTP_004;</label>
<div class="right">
<input class="inputNorm" type="text" id="Username" name="Username" value=""/>
<span class="dTip" style="display: none;">&?public_073;1 ~ 256</span>
</div>
</div>
<div class="row" id="div_FTPPassword">
<label for="Password" class="cfgLabel w150">&?FTP_005;</label>
<div class="right">
<input class="inputNorm SpecialPassword" type="password" id="Password" name="Password" value="						"/>
<span class="dTip" style="display: none;">&?public_073;1 ~ 256</span>
</div>
</div>
</form>
<div class="buttongroup">
<input type="button" class="Button Btn_cancel" id="Btn_cancel" name="Btn_cancel" value="&?public_019;" />
<input type="button" class="Button Btn_apply" id="Btn_apply" name="Btn_apply" value="&?public_018;" />
</div>
</div>
</div>
</div>
</div>
</div>
