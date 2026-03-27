require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local InstXML_LAN = ""
local need2Get = 1
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_PORT_BINDING_ID"
local PARA_Bind =
{
"WANViewName",
"LANViewName",
}
local function FindBindRelation(WANViewName)
local IFFind = 0
local BindView = ""
local LANViewName = ""
local BindList = cmapi.querylist(FP_OBJNAME, "DEV")
local count = BindList.Count
if count >= 1 and count ~= 888 then
for i=1, count do
local InstName = BindList[i].InstName or BindList[i]
local BIndRelation = cmapi.getinst(FP_OBJNAME, InstName)
if BIndRelation.WANViewName == WANViewName then
IFFind = 1
BindView = InstName
LANViewName = BIndRelation.LANViewName
break
end
end
end
return IFFind, BindView, LANViewName
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local WAN_IDENTITY = cgilua.cgilua.POST.WANViewName
if FP_ACTION == "Apply" then
need2Get = 0
local BindFind, BindInst
_, BindInst= FindBindRelation(WAN_IDENTITY)
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, BindInst, transToPostTab(PARA_Bind), tError)
end
if FP_ACTION == "Cancel" then
need2Get = 0
local BindFind, BindInst, BindLAN
_, BindInst, BindLAN = FindBindRelation(WAN_IDENTITY)
InstStr = getParaXMLNodeEntity("LANViewName", BindLAN)
InstXML = InstXML .. getXMLNodeEntity("Instance",InstStr)
InstXML = getXMLNodeEntity(FP_OBJNAME, InstXML)
end
if need2Get == 1 then
local BindWanTbl = cmapi.ListIFByApp("PortBindingWAN")
local BindLanTbl = cmapi.ListIFByApp("PortBindingLAN")
local InstLanStr = ""
for j,k in ipairs(BindLanTbl) do
local LAN_identity = k.InstID
local LAN_name = encodeXML(k.InstName)
local wlanCommFunc = require "modules.wlan_common_func"
local FilterBySSIDName = wlanCommFunc.getSSIDNameFilter()
if string.sub(LAN_name,1,4) =="SSID" then
if FilterBySSIDName(LAN_name) then
InstLanStr = getParaXMLNodeEntity("_InstID_LAN", LAN_identity)
InstLanStr = InstLanStr .. getParaXMLNodeEntity("LAN_name", LAN_name)
InstXML_LAN = InstXML_LAN .. getXMLNodeEntity("Instance",InstLanStr)
end
else
InstLanStr = getParaXMLNodeEntity("_InstID_LAN", LAN_identity)
InstLanStr = InstLanStr .. getParaXMLNodeEntity("LAN_name", LAN_name)
InstXML_LAN = InstXML_LAN .. getXMLNodeEntity("Instance",InstLanStr)
end
end
InstXML_LAN = getXMLNodeEntity("OBJ_WANLAN_ID", InstXML_LAN)
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
local wanConf = _G.wanConf[uRight]
local wanHidden = nil
if wanConf ~= nil then
wanHidden = wanConf.hidden
end
for i, v in ipairs(BindWanTbl) do
local BindLAN
local WAN_name = encodeXML(v.InstName)
local WAN_servlist = encodeXML(v.WANServlist)
local WANViewName = v.InstID
local flag = true
if wanHidden == nil then
flag = true
else
if wanHidden.inst ~= nil then
if wanHidden.inst == WANViewName then
flag = false
end
end
if wanHidden.WANCName ~= nil then
if wanHidden.WANCName == WAN_name then
flag = false
end
end
if wanHidden.Servlist ~= nil then
if wanHidden.Servlist == WAN_servlist then
flag = false
end
end
end
if flag then
_,_,BindLAN = FindBindRelation(WANViewName)
InstStr = getParaXMLNodeEntity("WANViewName", WANViewName)
.. getParaXMLNodeEntity("WAN_servlist", WAN_servlist)
.. getParaXMLNodeEntity("WAN_name", WAN_name)
.. getParaXMLNodeEntity("LANViewName", BindLAN)
InstXML = InstXML .. getXMLNodeEntity("Instance",InstStr)
end
end
InstXML = getXMLNodeEntity(FP_OBJNAME, InstXML)
InstXML = InstXML .. InstXML_LAN
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
