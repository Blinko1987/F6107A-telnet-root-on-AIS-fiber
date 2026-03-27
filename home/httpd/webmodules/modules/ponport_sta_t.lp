<%
cgilua_lp.include("../../webmodules/modules/ponport_sta_js.lp", getfenv(1))
%>
<div id="PON_Port" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=ponport_sta_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PON_Port_Sta">&?Pon_PortSta001;</h1>
<div id="PON_Port_container">
<input id="DataHasBeenGot" type="hidden" value="0">
<div id="template_PON_Port" class="colorTbl" style="">
<div id="PON_Port_title" class="colorTblRow emFont titleRow">
<span class="w200 emFont" id="" title=""></span>
<span class="w220 emFont" id="tx" title="&?Pon_PortSta002;">&?Pon_PortSta002;</span>
<span class="w220 emFont" id="rx" title="&?Pon_PortSta003;">&?Pon_PortSta003;</span>
</div>
<div class="colorTblRow">
<span class="w200 emFont" id="bytes" title="">&?Pon_PortSta004;</span>
<span class="w220" id="TxBytes" title="">0</span>
<span class="w220" id="RxBytes" title="">0</span>
</div>
<div class="colorTblRow">
<span class="w200 emFont" id="packets" title="">&?Pon_PortSta005;</span>
<span class="w220" id="TxPackets" title="">0</span>
<span class="w220" id="RxPackets" title="">0</span>
</div>
<div class="colorTblRow">
<span class="w200 emFont" id="error" title="">&?Pon_PortSta006;</span>
<span class="w220" id="TxError1" title="">0</span>
<span class="w220" id="RxError1" title="">0</span>
</div>
<div class="colorTblRow">
<span class="w200 emFont" id="discarded" title="">&?Pon_PortSta007;</span>
<span class="w220" id="Txdis" title="">0</span>
<span class="w220" id="Rxdis" title="">0</span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="Btn_refresh_PonPortSta" name="Btn_refresh_PonPortSta" value=&?public_003; />
</div>
</div>
</div>
