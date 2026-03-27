<%
cgilua_lp.include("../../webmodules/modules/wan_status_js.lp", getfenv(1))
%>
<div id="EthStateDev" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=wan_internetstatus_lua.lua&TypeUplink=2&pageType=1</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1" title="" ></span>
</div>
<h1 class="collapBarWithDataTrans" id="EthStateDevBar">&?InternetAIS_096;</h1>
<div id="EthStateDev_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<div id="template_EthStateDev" style="display:none;">
<div class="errorHint" style="display:none;">
<span class="caption1" title="" ></span>
</div>
<form class="colorTbl form_content">
<input type="hidden" id="_InstID" value="-1">
<input type="hidden" id="IF_UPLINK" value="2">
<input type="hidden" id="xDslMode" value="-1">
<input type="hidden" id="Status" value="-1">
<input type="hidden" id="linkMode" value="-1">
<input type="hidden" id="TransType" value="NULL">
<input type="hidden" id="IpMode" value="NULL">
<input type="hidden" id="mode" value="NULL">
<input type="hidden" id="IsNAT" value="NULL">
<input type="hidden" id="IPAddress" value="NULL">
<input type="hidden" id="SubnetMask" value="NULL">
<input type="hidden" id="ConnStatus" value="NULL">
<input type="hidden" id="UpTime" value="NULL">
<input type="hidden" id="LLA" value="NULL">
<input type="hidden" id="GuaNum" value="NULL">
<input type="hidden" id="Gua1" value="NULL">
<input type="hidden" id="Gua2" value="NULL">
<input type="hidden" id="Gua3" value="NULL">
<input type="hidden" id="Dns1v6" value="NULL">
<input type="hidden" id="Dns2v6" value="NULL">
<input type="hidden" id="Dns3v6" value="NULL">
<input type="hidden" id="UpTimeV6" value="NULL">
<input type="hidden" id="WorkIFMac" value="NULL">
<input type="hidden" id="ConnStatus6" value="NULL">
<input type="hidden" id="GateWay" value="NULL">
<input type="hidden" id="ConnError" value="NULL">
<input type="hidden" id="Gateway6" value="NULL">
<input type="hidden" id="RemoteLLA" value="NULL">
<input type="hidden" id="RemainLeaseTime" value="NULL">
<input type="hidden" id="Addressingtype" value="NULL">
<input type="hidden" id="DNS1" value="NULL">
<input type="hidden" id="DNS2" value="NULL">
<input type="hidden" id="DNS3" value="NULL">
<input type="hidden" id="DestAddress" value="NULL">
<input type="hidden" id="IsAuto" value="NULL">
<input type="hidden" id="GuaSrc" value="NULL">
<input type="hidden" id="Gateway6Src" value="NULL">
<input type="hidden" id="DnsSrc" value="NULL">
<input type="hidden" id="IsPD" value="NULL">
<input type="hidden" id="ConnTrigger" value="NULL">
<input type="hidden" id="LLAStatus" value="NULL">
<input type="hidden" id="StrServList" value="NULL">
<input type="hidden" id="VLANID" value="">
<input type="hidden" id="Pd" value="">
<input type="hidden" id="PdLen" value="">
<input type="hidden" id="RxPackets" value="">
<input type="hidden" id="TxPackets" value="">
<input type="hidden" id="RxBytes" value="">
<input type="hidden" id="TxBytes" value="">
<input type="hidden" id="TxErrors" value="">
<input type="hidden" id="RxErrors" value="">
<input type="hidden" id="TxUnicast" value="">
<input type="hidden" id="RxUnicast" value="">
<input type="hidden" id="TxDropped" value="">
<input type="hidden" id="RxDropped" value="">
<input type="hidden" id="TxMulticast" value="">
<input type="hidden" id="RxMulticast" value="">
<input type="hidden" id="TxBroadcast" value="">
<input type="hidden" id="RxBroadcast" value="">
<input type="hidden" id="IsSLAAC" value="">
<input type="hidden" id="IsGUA" value="">
<input type="hidden" id="IsPdAddr" value="">
<input type="hidden" id="DHCPServer" value="">
<input type="hidden" id="PortRange" value="">
<input type="hidden" id="LocalIPv6Addr" value="">
<input type="hidden" id="LocalIPv4Addr" value="">
<input type="hidden" id="LowIFID" value="">
<input type="hidden" id="MAPEStatus" value="">
<div id="EthStateDev_title" class="colorTblRow emFont titleRow">
<span class="w250 emFont" title="&?InternetAIS_003;">&?InternetAIS_003;</span>
<span class="w400 emFont" id="WANCName" title=""></span>
</div>
</form>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="EthStateDev_Btn_refresh" name="EthStateDev_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
