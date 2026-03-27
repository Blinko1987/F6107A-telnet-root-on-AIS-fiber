<%
%>
<div id="master-area">
<div id="master" class="topo-border topo-border-radius">
<input type="hidden" id="master_InstID" class="DeviceMac" value="">
<div id="master-router" class="topo-left">
<div id="master-logo"></div>
<div class="router_big"></div>
</div>
<div id="master-device-all" class="topo-left">
<div id="master-device-lan">
<ul>
<input type="hidden" id="master-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:3px 0 0 20px;"><span>LAN</span></li>
<li class="topo-left master-device-lan-icon"> <div id="master-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left master-device-lan-dev"> <div id="master-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left master-device-lan-dev"> <div id="master-device-lan-dev2" class="lan-dev"></div></li>
<li class="topo-left master-device-lan-dev"> <div id="master-device-lan-dev3" class="lan-dev"></div></li>
<li class="topo-left master-device-lan-dev"> <div id="master-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'master-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 22px;"></hr>
<div id="master-device-2G">
<ul>
<input type="hidden" id="master-device-2G-count" value="">
<li class="topo-left" style="width:38px;margin:2px 0 0 20px;"><span>2.4G</span></li>
<li class="topo-left master-device-2G-icon"> <div id="master-device-2G-icon" class="wlan-icon"></div></li>
<li class="topo-left master-device-2G-dev"> <div id="master-device-2G-dev1" class="wlan-dev"></div></li>
<li class="topo-left master-device-2G-dev"> <div id="master-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left master-device-2G-dev"> <div id="master-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left master-device-2G-dev"> <div id="master-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'master-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 22px;"></hr>
<div id="master-device-5G">
<ul>
<input type="hidden" id="master-device-5G-count" value="">
<li class="topo-left" style="width:40px;margin:-1px 0 0 16px;"><span>5G</span></li>
<li class="topo-left master-device-5G-icon"> <div id="master-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left master-device-5G-dev"> <div id="master-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left master-device-5G-dev"> <div id="master-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left master-device-5G-dev"> <div id="master-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left master-device-5G-dev"> <div id="master-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'master-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
<div style="clear:both;"></div>
</div>
<div id="slave1-line-top"></div>
<div id="slave1">
<div id="slave1-line">
<div id="slave1-line-left-1" class="topo-left"></div>
<div id="slave1-line-left-2" class="topo-left"></div>
<div id="slave1-line-middle"></div>
<div id="slave1-line-right-1" class="topo-left"></div>
<div id="slave1-line-right-2" class="topo-left"></div>
</div>
<div style="clear:both;"></div>
<div style="clear:both;"></div>
<div id="slave1-left" class="topo-left topo-border topo-border-radius">
<input type="hidden" id="slave1_left_InstID" class="DeviceMac" value="">
<div id="slave1-left-router" class="topo-left">
<div id="slave1-left-logo"></div>
<div class="router_small clickable"></div>
</div>
<div id="slave1-left-device-all" class="topo-left">
<div id="slave1-left-device-lan">
<ul>
<input type="hidden" id="slave1-left-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:5px 2px 0 3px;"><span>LAN</span></li>
<li class="topo-left slave1-left-device-lan-icon"> <div id="slave1-left-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left slave1-left-device-lan-dev"> <div id="slave1-left-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left slave1-left-device-lan-dev"> <div id="slave1-left-device-lan-dev2" class="lan-dev"></div></li>
<li class="topo-left slave1-left-device-lan-dev"> <div id="slave1-left-device-lan-dev3" class="lan-dev"></div></li>
<li class="topo-left slave1-left-device-lan-dev"> <div id="slave1-left-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'slave1-left-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 12px;"></hr>
<div id="slave1-left-device-2G">
<ul>
<input type="hidden" id="slave1-left-device-2G-count" value="">
<li class="topo-left" style="width:38px;margin:2px 0 0 5px;"><span>2.4G</span></li>
<li class="topo-left slave1-left-device-2G-icon"> <div id="slave1-left-device-2G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave1-left-device-2G-dev"> <div id="slave1-left-device-2G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave1-left-device-2G-dev"> <div id="slave1-left-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave1-left-device-2G-dev"> <div id="slave1-left-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave1-left-device-2G-dev"> <div id="slave1-left-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'slave1-left-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 12px;"></hr>
<div id="slave1-left-device-5G">
<ul>
<input type="hidden" id="slave1-left-device-5G-count" value="">
<li class="topo-left" style="width:40px;margin:-1px 0 0 0;"><span>5G</span></li>
<li class="topo-left slave1-left-device-5G-icon"> <div id="slave1-left-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave1-left-device-5G-dev"> <div id="slave1-left-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave1-left-device-5G-dev"> <div id="slave1-left-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave1-left-device-5G-dev"> <div id="slave1-left-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave1-left-device-5G-dev"> <div id="slave1-left-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'slave1-left-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
<div id="slave1-middle" class="topo-left topo-border topo-border-radius">
<input type="hidden" id="slave1_middle_InstID" class="DeviceMac" value="">
<div id="slave1-middle-router" class="topo-left">
<div id="slave1-middle-logo" style=""></div>
<div class="router_small clickable"></div>
</div>
<div id="slave1-middle-device-all" class="topo-left">
<div id="slave1-middle-device-lan">
<ul>
<input type="hidden" id="slave1-middle-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:5px 2px 0 3px;"><span>LAN</span></li>
<li class="topo-left slave1-middle-device-lan-icon"> <div id="slave1-middle-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left slave1-middle-device-lan-dev"> <div id="slave1-middle-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left slave1-middle-device-lan-dev"> <div id="slave1-middle-device-lan-dev2" class="lan-dev"></div></li>
<li class="topo-left slave1-middle-device-lan-dev"> <div id="slave1-middle-device-lan-dev3" class="lan-dev"></div></li>
<li class="topo-left slave1-middle-device-lan-dev"> <div id="slave1-middle-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'slave1-middle-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 12px;"></hr>
<div id="slave1-middle-device-2G">
<ul>
<input type="hidden" id="slave1-middle-device-2G-count" value="">
<li class="topo-left" style="float:left;width:38px;margin:2px 0 0 5px;"><span>2.4G</span></li>
<li class="topo-left slave1-middle-device-2G-icon"> <div id="slave1-middle-device-2G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave1-middle-device-2G-dev"> <div id="slave1-middle-device-2G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave1-middle-device-2G-dev"> <div id="slave1-middle-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave1-middle-device-2G-dev"> <div id="slave1-middle-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave1-middle-device-2G-dev"> <div id="slave1-middle-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'slave1-middle-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 12px;"></hr>
<div id="slave1-middle-device-5G">
<ul>
<input type="hidden" id="slave1-middle-device-5G-count" value="">
<li class="topo-left" style="width:40px;margin:-1px 0 0 0;"><span>5G</span></li>
<li class="topo-left slave1-middle-device-5G-icon"> <div id="slave1-middle-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave1-middle-device-5G-dev"> <div id="slave1-middle-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave1-middle-device-5G-dev"> <div id="slave1-middle-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave1-middle-device-5G-dev"> <div id="slave1-middle-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave1-middle-device-5G-dev"> <div id="slave1-middle-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'slave1-middle-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
<div id="slave1-right" class="topo-left topo-border topo-border-radius">
<input type="hidden" id="slave1_right_InstID" class="DeviceMac" value="">
<div id="slave1-right-router" class="topo-left">
<div id="slave1-right-logo"></div>
<div class="router_small clickable"></div>
</div>
<div id="slave1-right-device-all" class="topo-left">
<div id="slave1-right-device-lan">
<ul>
<input type="hidden" id="slave1-right-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:5px 2px 0 3px;"><span>LAN</span></li>
<li class="topo-left slave1-right-device-lan-icon"> <div id="slave1-right-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left slave1-right-device-lan-dev"> <div id="slave1-right-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left slave1-right-device-lan-dev"> <div id="slave1-right-device-lan-dev2" class="lan-dev"></div></li>
<li class="topo-left slave1-right-device-lan-dev"> <div id="slave1-right-device-lan-dev3" class="lan-dev"></div></li>
<li class="topo-left slave1-right-device-lan-dev"> <div id="slave1-right-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'slave1-right-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 12px;"></hr>
<div id="slave1-right-device-2G">
<ul>
<input type="hidden" id="slave1-right-device-2G-count" value="">
<li class="topo-left" style="width:38px;margin:2px 0 0 5px;"><span>2.4G</span></li>
<li class="topo-left slave1-right-device-2G-icon"> <div id="slave1-right-device-2G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave1-right-device-2G-dev"> <div id="slave1-right-device-2G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave1-right-device-2G-dev"> <div id="slave1-right-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave1-right-device-2G-dev"> <div id="slave1-right-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave1-right-device-2G-dev"> <div id="slave1-right-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'slave1-right-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 12px;"></hr>
<div id="slave1-right-device-5G">
<ul>
<input type="hidden" id="slave1-right-device-5G-count" value="">
<li class="topo-left" style="float:left;width:40px;margin:-1px 0 0 0;"><span>5G</span></li>
<li class="topo-left slave1-right-device-5G-icon"> <div id="slave1-right-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave1-right-device-5G-dev"> <div id="slave1-right-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave1-right-device-5G-dev"> <div id="slave1-right-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave1-right-device-5G-dev"> <div id="slave1-right-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave1-right-device-5G-dev"> <div id="slave1-right-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'slave1-right-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
<div style="clear:both;"></div>
</div>
<div id="slave2">
<div id="slave2-line">
<div id="slave2-line-left" class="topo-left"></div>
<div id="slave2-line-middle" class="topo-left"></div>
<div id="slave2-line-right" class="topo-left"></div>
</div>
<div style="clear:both;"></div>
<div id="slave2-left" class="topo-left topo-border-radius topo-border">
<input type="hidden" id="slave2_left_InstID" class="DeviceMac" value="">
<div id="slave2-left-router" class="topo-left">
<div id="slave2-left-logo"></div>
<div class="router_small clickable"></div>
</div>
<div id="slave2-left-device-all" class="topo-left">
<div id="slave2-left-device-lan">
<ul>
<input type="hidden" id="slave2-left-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:5px 2px 0 3px;"><span>LAN</span></li>
<li class="topo-left slave2-left-device-lan-icon"> <div id="slave2-left-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left slave2-left-device-lan-dev"> <div id="slave2-left-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left slave2-left-device-lan-dev"> <div id="slave2-left-device-lan-dev2" class="lan-dev"></div></li>
<li class="topo-left slave2-left-device-lan-dev"> <div id="slave2-left-device-lan-dev3" class="lan-dev"></div></li>
<li class="topo-left slave2-left-device-lan-dev"> <div id="slave2-left-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'slave2-left-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 12px;"></hr>
<div id="slave2-left-device-2G">
<ul>
<input type="hidden" id="slave2-left-device-2G-count" value="">
<li class="topo-left" style="width:38px;margin:2px 0 0 5px;"><span>2.4G</span></li>
<li class="topo-left slave2-left-device-2G-icon"> <div id="slave2-left-device-2G-icon" class="wlan-icon" ></div></li>
<li class="topo-left slave2-left-device-2G-dev"> <div id="slave2-left-device-2G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave2-left-device-2G-dev"> <div id="slave2-left-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave2-left-device-2G-dev"> <div id="slave2-left-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave2-left-device-2G-dev"> <div id="slave2-left-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'slave2-left-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 12px;"></hr>
<div id="slave2-left-device-5G">
<ul>
<input type="hidden" id="slave2-left-device-5G-count" value="">
<li class="topo-left" style="width:40px;margin:-1px 0 0 0;"><span>5G</span></li>
<li class="topo-left slave2-left-device-5G-icon"> <div id="slave2-left-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave2-left-device-5G-dev"> <div id="slave2-left-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave2-left-device-5G-dev"> <div id="slave2-left-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave2-left-device-5G-dev"> <div id="slave2-left-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave2-left-device-5G-dev"> <div id="slave2-left-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'slave2-left-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
<div id="slave2-middle" class="topo-left topo-border topo-border-radius">
<input type="hidden" id="slave2_middle_InstID" class="DeviceMac" value="">
<div id="slave2-middle-router" class="topo-left">
<div id="slave2-middle-logo"></div>
<div class="router_small clickable"></div>
</div>
<div id="slave2-middle-device-all" class="topo-left">
<div id="slave2-middle-device-lan">
<ul>
<input type="hidden" id="slave2-middle-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:5px 2px 0 3px;"><span>LAN</span></li>
<li class="topo-left slave2-middle-device-lan-icon"> <div id="slave2-middle-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left slave2-middle-device-lan-dev"> <div id="slave2-middle-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left slave2-middle-device-lan-dev"> <div id="slave2-middle-device-lan-dev2" class="lan-dev"></div></li>
<li class="topo-left slave2-middle-device-lan-dev"> <div id="slave2-middle-device-lan-dev3" class="lan-dev" ></div></li>
<li class="topo-left slave2-middle-device-lan-dev"> <div id="slave2-middle-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'slave2-middle-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 12px;"></hr>
<div id="slave2-middle-device-2G">
<ul>
<input type="hidden" id="slave2-middle-device-2G-count" value="">
<li class="topo-left" style="width:38px;margin:2px 0 0 5px;"><span>2.4G</span></li>
<li class="topo-left slave2-middle-device-2G-icon"> <div id="slave2-middle-device-2G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave2-middle-device-2G-dev"> <div id="slave2-middle-device-2G-dev1" class="wlan-dev" ></div></li>
<li class="topo-left slave2-middle-device-2G-dev"> <div id="slave2-middle-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave2-middle-device-2G-dev"> <div id="slave2-middle-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave2-middle-device-2G-dev"> <div id="slave2-middle-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'slave2-middle-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 12px;"></hr>
<div id="slave2-middle-device-5G">
<ul>
<input type="hidden" id="slave2-middle-device-5G-count" value="">
<li class="topo-left" style="width:40px;margin:-1px 0 0 0;"><span>5G</span></li>
<li class="topo-left slave2-middle-device-5G-icon"> <div id="slave2-middle-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave2-middle-device-5G-dev"> <div id="slave2-middle-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave2-middle-device-5G-dev"> <div id="slave2-middle-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave2-middle-device-5G-dev"> <div id="slave2-middle-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave2-middle-device-5G-dev"> <div id="slave2-middle-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'slave2-middle-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
<div id="slave2-right" class="topo-left topo-border topo-border-radius">
<input type="hidden" id="slave2_right_InstID" class="DeviceMac" value="">
<div id="slave2-right-router" class="topo-left">
<div id="slave2-right-logo"></div>
<div class="router_small clickable"></div>
</div>
<div id="slave2-right-device-all" class="topo-left">
<div id="slave2-right-device-lan">
<ul>
<input type="hidden" id="slave2-right-device-lan-count" value="">
<li class="topo-left" style="width:40px;margin:5px 2px 0 3px;"><span>LAN</span></li>
<li class="topo-left slave2-right-device-lan-icon"> <div id="slave2-right-device-lan-icon" class="lan-icon"></div></li>
<li class="topo-left slave2-right-device-lan-dev"> <div id="slave2-right-device-lan-dev1" class="lan-dev"></div></li>
<li class="topo-left slave2-right-device-lan-dev"> <div id="slave2-right-device-lan-dev2" class="lan-dev" ></div></li>
<li class="topo-left slave2-right-device-lan-dev"> <div id="slave2-right-device-lan-dev3" class="lan-dev" ></div></li>
<li class="topo-left slave2-right-device-lan-dev"> <div id="slave2-right-device-lan-dev4" class="more-lan-dev" onclick="TopoShowAccessDev('LAN', 'slave2-right-device-lan')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:218px;margin:0 12px;"></hr>
<div id="slave2-right-device-2G">
<ul>
<input type="hidden" id="slave2-right-device-2G-count" value="">
<li class="topo-left" style="width:38px;margin:2px 0 0 5px;"><span>2.4G</span></li>
<li class="topo-left slave2-right-device-2G-icon"> <div id="slave2-right-device-2G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave2-right-device-2G-dev"> <div id="slave2-right-device-2G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave2-right-device-2G-dev"> <div id="slave2-right-device-2G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave2-right-device-2G-dev"> <div id="slave2-right-device-2G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave2-right-device-2G-dev"> <div id="slave2-right-device-2G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('2G', 'slave2-right-device-2G')"></div></li>
</ul>
</div>
<div style="clear:both;"></div>
<hr style="width:220px;margin:0 12px;"></hr>
<div id="slave2-right-device-5G">
<ul>
<input type="hidden" id="slave2-right-device-5G-count" value="">
<li class="topo-left" style="float:left;width:40px;margin:-1px 0 0 0;"><span>5G</span></li>
<li class="topo-left slave2-right-device-5G-icon"> <div id="slave2-right-device-5G-icon" class="wlan-icon"></div></li>
<li class="topo-left slave2-right-device-5G-dev"> <div id="slave2-right-device-5G-dev1" class="wlan-dev"></div></li>
<li class="topo-left slave2-right-device-5G-dev"> <div id="slave2-right-device-5G-dev2" class="wlan-dev"></div></li>
<li class="topo-left slave2-right-device-5G-dev"> <div id="slave2-right-device-5G-dev3" class="wlan-dev"></div></li>
<li class="topo-left slave2-right-device-5G-dev"> <div id="slave2-right-device-5G-dev4" class="more-wlan-dev" onclick="TopoShowAccessDev('5G', 'slave2-right-device-5G')"></div></li>
</ul>
</div>
</div>
</div>
</div>
<div id="Non1905AccessDevDiv" class="white_content_AccessDev">
<div id="AccessDevDisplay" class="HeadDIV divAccessDevDisplay">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=topo_lua.lua</span>
</address>
<h1 class="fakeBar" id="AccessDevBar">&?pro_topo_009;</h1>
<div id="AccessDev_container">
<span id="instDelete_AccessDev" class="closePopLayer">
<img src="img/close.png" alt="close" />
</span>
<div class="colorTbl form_content alignCenter" id="template_AccessDevDisplay">
<div id="Statistics_title" class="colorTblRow emFont titleRow">
<span class="w100" title="&?pro_topo_005;">&?pro_topo_005;</span>
<span class="w100" title="&?pro_topo_006;">&?pro_topo_006;</span>
<span class="w100" title="&?pro_topo_007;">&?pro_topo_007;</span>
<span class="w80" title="&?pro_topo_002;">&?pro_topo_002;</span>
<span class="w100 wlan_only" title="&?pro_topo_003;" id="UpstreamTitle">&?pro_topo_003;</span>
<span class="w100 wlan_only" title="&?pro_topo_004;" id="DownstreamTitle">&?pro_topo_004;</span>
<span class="w50 wlan_only" title="&?pro_topo_008;">&?pro_topo_008;</span>
<span class="w40 wlan_only" title="BTM">BTM</span>
<span class="w40 wlan_only" title="RRM">RRM</span>
<span class="w80 wlan_only" title="&?pro_topo_010;">&?pro_topo_010;</span>
</div>
<input type="hidden" id="_InstNum" value="0">
<form class="colorRowforAccessDev">
<div class="colorTblRow" id="data_AccessDev" style="display:none;">
<input id="_InstID" type="hidden" value="">
<span class="w100" id="HostName" title=""></span>
<span class="w100" id="MAC" title=""></span>
<span class="w100" id="IP" title=""></span>
<span class="w80" id="OnlineDuration" title=""></span>
<span class="w100 wlan_only" id="RealTimeUpstream" title=""></span>
<span class="w100 wlan_only" id="RealTimeDownstream" title=""></span>
<span class="w50 wlan_only" id="Rssi" title=""></span>
<span class="w40 wlan_only" id="Btm" title=""></span>
<span class="w40 wlan_only" id="Rrm" title=""></span>
<span class="w80 wlan_only" id="WirelessMode" title=""></span>
</div>
</form>
</div>
</div>
</div>
</div>
