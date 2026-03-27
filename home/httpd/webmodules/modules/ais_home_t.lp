<%
cgilua.lp.include("../../webmodules/modules/ais_home_js.lp", getfenv(1))
%>
<link rel="stylesheet" type="text/css" href="css/helvetica.css" />
<style type="text/css">
<%
cgilua.lp.include("../../public/css/home.css")
if require"common_lib.file_utils".isFileExist("../../public/css/pro_style.css") then
cgilua_lp.include("../../public/css/pro_style.css")
end
cgilua.lp.include("../../public/css/bootstrap.min.css")
cgilua.lp.include("../../public/css/header.css")
cgilua.lp.include("../../public/css/ais_home.css")
%>
</style>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AIS - FIBER - Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
</head>
<div id="homeWrapper">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=home_ais_lua.lua</span>
</address>
<div class="container-fluid">
<div class="row">
<div class="col-md-4 col-sm-12 col-xs-12">
<div class="card-panel">
<div class="card-body">
<h4> Device Information </h4>
<div class="form-group">
<p class="title-label text-gray">Model Name:</p>
<span id="ModelName" title=""></span>
</div>
<div class="form-group">
<p class="title-label text-gray">GPON SN:</p>
<span id="Sn" title=""></span>
</div>
<div class="form-group">
<p class="title-label text-gray">D-SN:</p>
<span id="SerialNumber" title=""></span>
</div>
<div class="form-group">
<p class="title-label text-gray">Mac-Address:</p>
<span id="FirstMAC" title=""></span>
</div>
<div class="form-group">
<p class="title-label text-gray">Hardware Version:</p>
<span id="HardwareVer" title=""></span>
</div>
<div class="form-group">
<p class="title-label text-gray">Firmware Version:</p>
<span id="SoftwareVer" title=""></span>
</div>
<div class="form-group">
<p class="title-label text-gray">Flash Usage:</p>
<span id="FlashSizeUsage" title=""></span>
<div class="progress progress-striped active clear small">
<div id="LedFlash" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="form-group">
<p class="title-label text-gray">CPU Usage :</p>
<div class="progress progress-striped active clear small">
<div id="LedCPU" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="form-group">
<p class="text-gray">Memory Usage :</p>
<div class="progress progress-striped active clear small">
<div id="LedMemory" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
</div>
<div id="Btn_restart" name="Btn_restart" class="card-footer border-top"><button class="card-btn green">Reboot</button></div>
</div>
<div class="card-panel">
<div class="card-body">
<h4> Attached Devices </h4>
<div class="text-center">
<img src="img/img_home_attached_devices.png"></div>
<div class="form-group text-center">
&nbsp;
</div>
<div class="form-group text-center">
<p>Link to DHCP client</p>
</div>
<div id="AttachedDevsContent" class="form-group text-center">
<div id="template_AttachedDevs">
<p class="click-topo">Number of devices : <span id="AccessDevNum" class="text-green-highlight">0</span></p>
</div>
</div>
</div>
<div id="Btn_Refresh" name="Btn_Refresh" class="card-footer  border-top"><button class="card-btn gray">Refresh</button></div>
</div>
</div>
<div class="col-md-4 col-sm-12 col-xs-12">
<div class="card-panel">
<div id="speedTest" class="card-body">
<h4>Speed Test</h4>
<div class="line-header"></div>
<div class="SpeedLeft text-gray">
<div>Upload</div>
<div id="UpRate" name="UpRate" class="SpeedItem">0.00</div>
<div>Mbps</div>
</div>
<div class="SpeedRight text-gray">
<div>Download</div>
<div id="DownRate" name="DownRate" class="SpeedItem">0.00</div>
<div>Mbps</div>
</div>
<div id="SpeedtestUrl" class="SpeedServer ">
<select name="Url" id="Url" class="SpeedSelect">
</select>
</div>
<div id="SpeedtestBar" style="display:none" class="SpeedServer progress progress-striped active clear small">
<div id="myProgressBar" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
</div>
</div>
</div>
<div id="Btn_SpeedTest" name="Btn_SpeedTest" class="card-footer border-top">
<div class="BeginTest">
<button class="card-btn green" id="speedTestStatus">Speed Test</button>
</div>
<div id="myProgress" style="display:none">
<span id="myProgressLabel" class="gray">0% Complete</span>
</div>
</div>
</div>
<div class="card-panel">
<div class="card-body">
<h4>Internet Status</h4>
<div class="warp-internet-status">
<div class="pull-left">
<img src="img/Group_24.png">
</div>
<div class="pull-left" style="position:relative;">
<img src="img/Path_231.png">
</div>
<div class="pull-left">
<img src="img/Group_34.png">
</div>
<div class="pull-left">
<img id="InternetStatus" src="img/ico_home_no.png">
</div>
<div class="pull-left">
<img src="img/Group_35.png">
</div>
</div>
<div class="form-group text-center">
<p>IP Address : <span id="IPAddress" class="text-green-highlight">0.0.0.0</span></p>
</div>
<div class="form-group text-center">
<p>DNS IP Address : <span id="DNS" class="text-green-highlight">0.0.0.0</span></p>
</div>
</div>
<div id="Btn_InterReconnect" name="Btn_InterReconnect" class="card-footer border-top"><button class="card-btn gray">Re-Connect</button></div>
</div>
<div class="card-panel">
<div class="card-body">
<h4>Wireless</h4>
<div class="line-header"></div>
<div class="row form-group boder-bottom">
<div class="col-xs-3">
<div class="wifi">
<div class="level-1"></div>
<div class="level-2"></div>
<div class="level-3"></div>
</div>
</div>
<div class="col-xs-6">
<p class="wifi-title">2.4 GHz</p>
<p id="ESSID24G" class="wifi-info">AIS-FIBRE-FB_2.4GHz</p>
<p id="WLAN24GUrl" class="wifi-action"><a href="javascript:void(0)">CHANGE</a></p>
</div>
<div class="col-xs-3">
<div id="Switch_1">
<input type="hidden" id="InstID_1" value="DEV.WIFI.RD1">
<div class="InstSwitch">
<input id="cmn-toggle-1" class="cmn-toggle cmn-toggle-round" name="RadioStatus" type="checkbox">
<label for="cmn-toggle-1"></label>
</div>
</div>
</div>
</div>
<div class="row form-group boder-bottom">
<div class="col-xs-3">
<div class="wifi">
<div class="level-1"></div>
<div class="level-2"></div>
<div class="level-3"></div>
</div>
</div>
<div class="col-xs-6">
<p class="wifi-title">5 GHz</p>
<p id="ESSID5G" class="wifi-info">AIS-FIBRE-FB_5GHz</p>
<p id="WLAN5GUrl" class="wifi-action"><a href="javascript:void(0)">CHANGE</a></p>
</div>
<div class="col-xs-3">
<div id="Switch_2">
<input type="hidden" id="InstID_2" value="DEV.WIFI.RD2">
<div class="InstSwitch">
<input id="cmn-toggle-2" class="cmn-toggle cmn-toggle-round" name="RadioStatus" type="checkbox">
<label for="cmn-toggle-2"></label>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="col-md-4 col-sm-12 col-xs-12" id="easyDiag">
<div class="card-panel">
<div class="card-body">
<h4> Easy Diagnostic </h4>
<input type="hidden" id="LANIP" value=""/>
<input type="hidden" id="WANIP" value=""/>
<input type="hidden" id="DNS1IP" value=""/>
<input type="hidden" id="DNS2IP" value=""/>
<input type="hidden" id="DefaultGWIP" value=""/>
<input type="hidden" id="LAN1IP" value=""/>
<input type="hidden" id="LAN2IP" value=""/>
<input type="hidden" id="LAN3IP" value=""/>
<input type="hidden" id="LAN4IP" value=""/>
<input type="hidden" id="DiagFinish" value="1"/>
<div class="line-header"></div>
<div class="form-group">
<p>LAN IP Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="LANIPCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="LANIPCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span class="text-gray label-below">LAN IP Address :
<span id="LANIP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>WAN IP Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="WANIPCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="WANIPCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span class="text-gray label-below">WAN IP Address :
<span id="WANIP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>DNS Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="DNSCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="DNSCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span class="text-gray label-below">DNS1 IP Address :
<span id="DNS1IP_Data">0.0.0.0</span>
</span>
<span class="text-gray label-below">DNS2 IP Address :
<span id="DNS2IP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>Ping Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="PingCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="PingCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span class="text-gray label-below">Ping IP Address :
<span id="DefaultGWIP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>LAN1 IP Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="LAN1IPCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="LAN1IPCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span id="LAN1IP_row" class="text-gray label-below">LAN1 IP Address :
<span id="LAN1IP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>LAN2 IP Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="LAN2IPCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="LAN2IPCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span id="LAN2IP_row" class="text-gray label-below">LAN2 IP Address :
<span id="LAN2IP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>LAN3 IP Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="LAN3IPCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="LAN3IPCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span id="LAN3IP_row" class="text-gray label-below">LAN3 IP Address :
<span id="LAN3IP_Data">0.0.0.0</span>
</span>
</div>
<div class="form-group">
<p>LAN4 IP Check</p>
<div class="row">
<div class="col-xs-10">
<div class="progress progress-striped active small no-margin">
<div id="LAN4IPCheck" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
<span class="sr-only">0% Complete</span>
</div>
</div>
</div>
<div class="col-xs-2 text-center">
<img id="LAN4IPCheck_Pic" src="img/ico_home_no.png">
</div>
</div>
<span id="LAN4IP_row" class="text-gray label-below">LAN4 IP Address :
<span id="LAN4IP_Data">0.0.0.0</span>
</span>
</div>
</div>
<div id="Btn_PingReconnect" name="Btn_PingReconnect" class="card-footer border-top"><button class="card-btn gray">Re-Connect</button></div>
</div>
</div>
</div>
</div>
</div>
<div id="AttachedDevsDiv" class="white_content_Qos">
<div id="AttachedDevsCfg" class="HeadDIV divHomePopCfg">
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="Fakebar" id="AttachedDevsCfgBar">&?pro_AISHOME_001;</h1>
<div id="AttachedDevCfg_container">
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<span id="instDelete_AttachedDevs" class="closePopLayer">
<img src="img/Group_43.png" alt="close" />
</span>
<input type="hidden" id="_InstNum" value="0"/>
<input type="hidden" id="DataHasBeenGot" value="0"/>
<div class="topo-head">
<h4 class="topo-title">&?pro_AISHOME_005;</h4>
<h5 class="sub-count">&?pro_AISHOME_006;(<span>0</span>)</h5>
</div>
<div class="online-sub-router">
<ul class="main-router-lists">
</ul>
</div>
<% if env.getenv("OperationMode") ~= "0" then %>
<p id="RouterUrl"><a href="javascript:void(0)">&?pro_AISHOME_002;</a></p>
<% end %>
<div class="topo-head">
<h4 class="topo-title">&?pro_AISHOME_003;</h4>
<h5 class="device-count">&?pro_AISHOME_004;(<span>1</span>)</h5>
</div>
<div class="online-device">
<ul class="device-lists">
</ul>
</div>
</div>
</div>
</div>
<script type="text/javascript">
MenuShow("ClassOne", "Home_t.lp", "mmHome");
</script>
