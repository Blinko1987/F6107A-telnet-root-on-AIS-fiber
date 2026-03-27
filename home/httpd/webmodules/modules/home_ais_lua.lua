require "data_assemble.common_lua"
local sessmgr = require("user_mgr.session_mgr")
local InstXML = ""
local ErrorXML = ""
local InstXMLCPU = ""
local InstXMLFLS = ""
local InstXMLWLANBASE = ""
local InstXMLWLAN = ""
local InstXMLACCESSDEV = ""
local InstXMLINTERSTATUS = ""
local InstXMLMAC = ""
local InstXMLACCESSDEVINFO = ""
local InstXMLPONRATEINFO = ""
local InstXMLETHINFO = ""
local InstXMLEASYDIAG = ""
local InstXMLSPEEDTESTSERVER = ""
local InstXMLSPEEDTESTDIAG = ""
local INSTXML = ""
local InstXMLPON = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local GET_DATA = cgilua.QUERY.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_DiagFinish = cgilua.POST.DiagFinish
local FP_InterReFlag = cgilua.POST.InterReFlag
local FP_TarggerType = cgilua.POST.TarggerType
local FP_OBJNAME = "OBJ_DEVINFO_ID";
local PARA =
{
"SerialNumber",
"ModelName",
"HardwareVer",
"SoftwareVer"
}
local PON_OBJNAME = "OBJ_SN_INFO_ID";
local PON_PARA =
{
"Sn"
}
local MAC_OBJNAME = "OBJ_TAGPARAM_ID";
local MAC_PARA =
{
"FirstMAC"
}
local CPU_OBJNAME = "OBJ_CPUMEMUSAGE_ID";
local CPU_PARA =
{
"MemUsage",
"CpuUsage1"
}
local FLS_OBJNAME = "OBJ_FLASHINFO_ID";
local FLS_PARA =
{
"TotalFlash",
"Flash_Percent_Used"
}
local FP_OBJNAME_WLAN = "OBJ_WLANAP_ID"
PARA_WLAN =
{
"Enable",
"ESSID"
}
local FP_OBJNAME_WLAN_BASE = "OBJ_WLANSETTING_ID"
PARA_WLAN_BASE =
{
"RadioStatus"
}
local ACCESSDEV_OBJNAME = "OBJ_ACCESSDEV_NUM_ID"
ACCESSDEV_PARA =
{
"AccessDevNum"
}
local ACCESSDEVINFO_OBJNAME = "OBJ_ACCESSDEV_INFO_ID"
ACCESSDEVINFO_PARA =
{
"IPAddress",
"MACAddress",
"Interface",
"InterfaceType",
"LinkSpeed",
"BytesSent",
"BytesReceived",
"DefGWIPAddress",
"DefGWMACAddress",
"WanRxRate",
"WanTxRate",
"UpRate",
"DownRate"
}
local ETH_OBJNAME = "OBJ_PON_PORT_BASIC_STATUS_ID"
ETH_PARA =
{
"IFName",
"Speed"
}
local INTERSTATUS_OBJNAME = "OBJ_INTERNET_STATUS_ID"
INTERSTATUS_PARA =
{
"DNS",
"IPAddress",
"MacAddr"
}
local PONRATE_OBJNAME = "OBJ_HOME_PONRATE_ID"
PONRATE_PARA =
{
"RxRate",
"TxRate"
}
local EASYDIAG_OBJNAME = "OBJ_EASY_DIAG_ID"
EASYDIAG_PARA =
{
"WANIP",
"WANIPCheck",
"LANIP",
"LANIPCheck",
"DNS1IP",
"DNS2IP",
"DNSCheck",
"DefaultGWIP",
"PingCheck",
"LAN1IP",
"LAN1IPCheck",
"LAN2IP",
"LAN2IPCheck",
"LAN3IP",
"LAN3IPCheck",
"LAN4IP",
"LAN4IPCheck",
"DiagFinish"
}
local INTERRECONN_OBJNAME = "OBJ_INTERNET_RECONN_ID"
local SPEEDTEST_SERVER_OBJNAME = "OBJ_SPEEDTEST_SERVERS_ID"
SPEEDTEST_SERVER_PARA =
{
"SessionId",
"State",
"URL0",
"URL1",
"URL2",
"URL3",
"URL4",
"URL5",
"URL6",
"URL7",
"URL8",
"URL9",
"URL10",
"URL11",
"URL12",
"URL13",
"URL14"
}
local SPEEDTEST_DIAG_OBJNAME = "OBJ_SPEEDTEST_DIAGNOSE_ID"
SPEEDTEST_DIAG_PARA =
{
"SessionId",
"Url",
"State",
"UpRate",
"DownRate",
"Percntage"
}
local SPEEDTEST_SET_SERVER_OBJNAME = "OBJ_SPEEDTEST_SET_SERVERS_ID"
if GET_DATA == "PingReconnect" then
if FP_DiagFinish == "1" then
local t = transToPostTab(EASYDIAG_PARA)
tError = cmapi.setinst(EASYDIAG_OBJNAME, "", t)
end
InstXMLEASYDIAG, tError = getSpecificInstXML(EASYDIAG_OBJNAME, "IGD", tError, nil, transToFilterTab(EASYDIAG_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLEASYDIAG
elseif GET_DATA == "SetSpeedtestServer" then
tError = cmapi.getinst(SPEEDTEST_SET_SERVER_OBJNAME,"")
local INSTID = tError.SetServers
INSTXML = table.concat({"<SESSION_IDKEY>session_id</SESSION_IDKEY>", "<SESSION_IDVALUE>", INSTID, "</SESSION_IDVALUE>"})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. INSTXML
elseif GET_DATA == "GetSpeedtestServer" then
local INSTID = cgilua.QUERY.sessionId
InstXMLSPEEDTESTSERVER, tError = getSpecificInstXML(SPEEDTEST_SERVER_OBJNAME, INSTID, tError, nil,transToFilterTab(SPEEDTEST_SERVER_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLSPEEDTESTSERVER
elseif GET_DATA == "SpeedtestDIAG" then
local t = transToPostTab(SPEEDTEST_DIAG_PARA)
tError = cmapi.setinst(SPEEDTEST_DIAG_OBJNAME,"",t)
local INSTID = tError.INSTIDENTITY
INSTXML = table.concat({"<SESSION_IDKEY>session_id</SESSION_IDKEY>", "<SESSION_IDVALUE>", INSTID, "</SESSION_IDVALUE>"})
InstXMLSPEEDTESTDIAG, tError = getAllInstXML(SPEEDTEST_DIAG_OBJNAME, INSTID, nil, nil,t)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. INSTXML
elseif GET_DATA == "SpeedtestGetDIAG" then
local INSTID = cgilua.QUERY.sessionId
InstXMLSPEEDTESTDIAG, tError = getSpecificInstXML(SPEEDTEST_DIAG_OBJNAME, INSTID, tError, nil,transToFilterTab(SPEEDTEST_DIAG_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLSPEEDTESTDIAG
elseif GET_DATA == "InterReconnect" then
if FP_InterReFlag == "1" then
local t = transToPostTab(INTERSTATUS_PARA)
tError = cmapi.setinst(INTERRECONN_OBJNAME, "", t)
else
InstXMLINTERSTATUS, tError = getAllInstXML(INTERSTATUS_OBJNAME, "IGD", nil, nil, transToFilterTab(INTERSTATUS_PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLINTERSTATUS
elseif GET_DATA == "DevRefresh" then
InstXMLACCESSDEV, tError = getAllInstXML(ACCESSDEV_OBJNAME, "IGD", tError, nil, transToFilterTab(ACCESSDEV_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLACCESSDEV
elseif FP_ACTION == "Restart" then
tError = cmapi.dev_action({CmdId = "cmd_devrestart"})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML
elseif GET_DATA == "GetInterStatus" then
InstXMLINTERSTATUS, tError = getAllInstXML(INTERSTATUS_OBJNAME, "IGD", tError, nil, transToFilterTab(INTERSTATUS_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLINTERSTATUS
elseif GET_DATA == "DevInfoRefresh" then
InstXMLCPU, tError = getSpecificInstXML(CPU_OBJNAME, "IGD", tError, nil,transToFilterTab(CPU_PARA))
InstXMLFLS, tError = getSpecificInstXML(FLS_OBJNAME, "IGD", tError, nil,transToFilterTab(FLS_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXMLCPU .. InstXMLFLS
else
if FP_ACTION == "Apply" then
tError = applyOrNewOrDelInst(FP_OBJNAME_WLAN_BASE, FP_ACTION, FP_IDENTITY, transToPostTab(PARA_WLAN_BASE))
end
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, nil,transToFilterTab(PARA))
InstXMLPON, tError = getAllInstXML(PON_OBJNAME, "IGD", nil, nil,transToFilterTab(PON_PARA))
InstXMLMAC, tError = getAllInstXML(MAC_OBJNAME, "IGD", nil, nil,transToFilterTab(MAC_PARA))
InstXMLCPU, tError = getSpecificInstXML(CPU_OBJNAME, "IGD", tError, nil,transToFilterTab(CPU_PARA))
InstXMLFLS, tError = getSpecificInstXML(FLS_OBJNAME, "IGD", tError, nil,transToFilterTab(FLS_PARA))
InstXMLWLANBASE, tError = getAllInstXML(FP_OBJNAME_WLAN_BASE, "IGD", tError, nil, transToFilterTab(PARA_WLAN_BASE))
InstXMLWLAN, tError = getAllInstXML(FP_OBJNAME_WLAN, "IGD", tError, nil, transToFilterTab(PARA_WLAN))
InstXMLACCESSDEV, tError = getAllInstXML(ACCESSDEV_OBJNAME, "IGD", tError, nil, transToFilterTab(ACCESSDEV_PARA))
InstXMLACCESSDEVINFO, tError = getAllInstXML(ACCESSDEVINFO_OBJNAME, "IGD", tError, nil, transToFilterTab(ACCESSDEVINFO_PARA))
InstXMLETHINFO, tError = getAllInstXML(ETH_OBJNAME, "DEV", tError, nil, transToFilterTab(ETH_PARA))
InstXMLINTERSTATUS, tError = getAllInstXML(INTERSTATUS_OBJNAME, "IGD", tError, nil, transToFilterTab(INTERSTATUS_PARA))
InstXMLPONRATEINFO, tError = getAllInstXML(PONRATE_OBJNAME, "IGD", tError, nil, transToFilterTab(PONRATE_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXMLPON .. InstXMLMAC .. InstXMLCPU .. InstXMLFLS .. InstXMLWLANBASE .. InstXMLWLAN .. InstXMLACCESSDEV .. InstXMLETHINFO .. InstXMLACCESSDEVINFO .. InstXMLINTERSTATUS .. InstXMLPONRATEINFO
end
outputXML(OutXML)
