local cgilua = cgilua.cgilua
function ListAllWanLanIF()
local WanLanIFTbl = cmapi.ListIFByApp("ALLWANLAN")
return WanLanIFTbl
end
function FindNameBaseID(Identity)
local IFName = ""
local IFFind = 0
local AllWANLANTbl = ListAllWanLanIF()
for k,v in ipairs(AllWANLANTbl) do
if Identity == v.InstID then
IFFind = 1
IFName = v.InstName
break;
end
end
return IFFind,IFName
end
function CreateIFOpStr(APPID, callback, OptAttrTbl)
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
local wanConf = _G.wanConf[uRight]
local wanHidden = nil
if wanConf ~= nil then
wanHidden = wanConf.hidden
end
local callret = true
local IFOpStr = ""
local IFTbl = cmapi.ListIFByApp(APPID)
for i,v in ipairs(IFTbl) do
local flag = true
if wanHidden == nil then
flag = true
else
if wanHidden.inst ~= nil then
if wanHidden.inst == v.InstID then
flag = false
end
end
if wanHidden.WANCName ~= nil then
if wanHidden.WANCName == v.InstName then
flag = false
end
end
if wanHidden.Servlist ~= nil then
if string.find(wanHidden.Servlist,v.WANServlist) ~= nil then
flag = false
end
end
end
if callback and type(callback) == "function" then
callret = callback(v)
end
if callret and flag then
local IFOpStrHead = "<option value='" .. encodeHTML(v.InstID)
.. "' title='" .. encodeHTML(ChangePortName(v.InstName))
.. "' "
local OptAttrStr = ""
if OptAttrTbl and type(OptAttrTbl) == "table" then
for j,AttrName in ipairs(OptAttrTbl) do
OptAttrStr = OptAttrStr .. AttrName .. "='" .. v[AttrName] .. "' "
end
end
local IFOpStrTail = ">"
.. encodeHTML(ChangePortName(v.InstName))
.. "</option>"
local wlanCommFunc = require "modules.wlan_common_func"
local FilterBySSIDName = wlanCommFunc.getSSIDNameFilter()
if string.sub(v.InstName,1,4) =="SSID" then
if FilterBySSIDName(v.InstName) == false then
IFOpStrHead = ""
OptAttrStr = ""
IFOpStrTail = ""
end
end
IFOpStr = IFOpStr .. IFOpStrHead .. OptAttrStr .. IFOpStrTail
end
end
return IFOpStr
end
function GetWebMgrIP()
local t = cmapi.getinst("OBJ_BRGRP_ID", "IGD.LD1")
local WebMgrIP = ""
for k, v in pairs(t) do
if k == "IPAddr" then
WebMgrIP = v
break
end
end
return WebMgrIP
end
function sec2HrMinSec( seconds )
if type(seconds) ~= "number" then
error("[sec2HrMinSec]seconds is not number")
end
local secPart = 0
local minPart = 0
local hourPart = 0
secPart = seconds % 60
minutes = math.floor(seconds/60)
minPart = minutes % 60
hourPart = math.floor(minutes/60)
local hrMinSec = hourPart.._G.lang.public_011.." "
.. minPart.._G.lang.public_012.." "
.. secPart.._G.lang.public_013
return hrMinSec
end
local utilModule = require("data_assemble.util")
utilModule.sec2HrMinSec = sec2HrMinSec
