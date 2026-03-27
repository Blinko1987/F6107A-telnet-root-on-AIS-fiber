local para = {
atm = {
"Enable",
"WANCName",
"VLANID",
"Priority",
"VlanEnable",
"LANDViewName",
"DestAddress",
"ATMLinkType",
"ATMEncapsulation",
"ATMQoS",
"ATMPeakCellRate",
"ATMMaxBurstSize",
"ATMMinCellRate",
"ATMSCR",
"ATMCDV",
"RxPackets",
"TxPackets",
"RxBytes",
"TxBytes",
"DSCP"
},
ptm = {
"Enable",
"WANCName",
"VLANID",
"Priority",
"VlanEnable",
"LANDViewName",
"RxPackets",
"TxPackets",
"RxBytes",
"TxBytes",
"DSCP",
"PTMLinkType"
},
eth = {
"Enable",
"WANCName",
"VLANID",
"Priority",
"VlanEnable",
"LANDViewName",
"DSCP",
"WBDMode",
}
}
function get_bridge_array()
return para
end
