<%
cgilua_lp.include("../../webmodules/modules/ftp_test_js.lp", getfenv(1))
%>
<div id="FtpTest" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=ftp_test_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="FtpTestBar">Ftp Test</h1>
<div id="FtpTest_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div id="template_FtpTest">
<form class="form_content">
<div id="changeArea_FtpTest" class="ChangeArea formTblWrap">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="formTbl">
<input type="hidden" id="_InstID" value="">
<div class="staticInfoHint">
<p>&?ftp_test_003;</p>
</div>
<div id="forFtpTestConfig">
<div class="row" >
<label for="IPAddress" class="cfgLabel w150">&?public_007;</label>
<div class="right">
<input class="inputNorm" type="text" id="IPAddress" name="IPAddress" value=""/>
</div>
</div>
<div class="row">
<label for="Port" class="cfgLabel w150">&?public_135;</label>
<div class="right">
<input class="inputNorm" type="text" id="Port" name="Port" value=""/>
<span style="display:none;">&?public_073;1 ~ 65535</span>
</div>
</div>
<div class="row" id="Prefix_UserName">
<label for="UserName" class="cfgLabel w150">&?public_026;</label>
<div class="right">
<input class="inputNorm" type="text" id="UserName" name="UserName" value=""/>
<span id = "RangeLenUsername" style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row" id="Prefix_Password">
<label for="Password" class="cfgLabel w150">&?public_027;</label>
<div class="right">
<input type="password" class="w150" id="Password" name="Password" autocomplete="new-password"/>
<span style="display:none;">&?public_073;1 ~ 64</span>
</div>
</div>
<div class="row">
<label for="FilePath" class="cfgLabel w150">&?ftp_test_006;</label>
<div class="right">
<input class="inputNorm" type="text" id="FilePath" name="FilePath" value=""/>
<span style="display:none;">&?public_073;1 ~ 256</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button" id="Btn_go_testlink" name="Btn_go_testlink" value="&?ftp_test_007;" />
</div>
</div>
<div id="forftptestResults" style="display:none;">
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_014;">&?ftp_test_014;</span>
<span class="w250" id="Curfile" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_008;">&?ftp_test_008;</span>
<span class="w250" id="Ratio" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_009;">&?ftp_test_009;</span>
<span class="w250" id="Abbrevsize" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_010;">&?ftp_test_010;</span>
<span class="w250" id="Remaining" title=""></span>
</div>
<div id="ResultIfSucess" style="display:none;">
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_011;">&?ftp_test_011;</span>
<span class="w250" id="ReceivedBytes" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_012;">&?ftp_test_012;</span>
<span class="w250" id="Pastseconds" title=""></span>
</div>
<div id="" class="colorTblRow">
<span class="w330 emFont" title="&?ftp_test_013;">&?ftp_test_013;</span>
<span class="w250" id="ByteSec" title=""></span>
</div>
</div>
</div>
</div>
</div>
</form>
</div>
</div>
</div>
