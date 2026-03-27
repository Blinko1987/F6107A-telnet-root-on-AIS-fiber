local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function getOnuMode()
if "108" == env.getenv("CountryCode") then
local FP_OBJNAME = "OBJ_ONU_MODE_CFG_ID";
local listTbl = cmapi.querylist(FP_OBJNAME, "IGD");
if listTbl.IF_ERRORID ~= 0 then
g_logger:warn("[OBJ_ONU_MODE_CFG_ID] querylist error")
return "1"
end
local getTbl = cmapi.getinst(FP_OBJNAME, listTbl[1])
if getTbl.IF_ERRORID == 0 then
return getTbl.DhcpSourceFlag
end
end
return "1"
end
envTableMgr:addItem({envName="OnuMode", envValFunc=getOnuMode})
end)
local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function getDevInfomation(InfoWanted)
local InfoTmp = ""
local t = cmapi.getinst("OBJ_DEVINFO_ID", "")
if t.IF_ERRORID == 0 then
InfoTmp = t[InfoWanted]
end
return InfoTmp
end
local function getWEBTitle()
return getDevInfomation("ModelName")
end
local function getSoftwareVer()
return getDevInfomation("SoftwareVer")
end
local function getVerDate()
local VerDate = getDevInfomation("VerDate")
VerDate = string.sub(VerDate,0,4)
return VerDate
end
envTableMgr:addItem({envName="WEBTitle", envValFunc=getWEBTitle})
envTableMgr:addItem({envName="SoftwareVer", envValFunc=getSoftwareVer})
envTableMgr:addItem({envName="VerDate", envValFunc=getVerDate})
end)
local envTableMgr = require("cgilua.globalenv_table_mgr")
if env.getenv("CountryCode") == "124" then
envTableMgr:addModifier(function ()
local function getIsFirstLogin()
local IsFirstLogin = ""
local getTbl = cmapi.getinst("OBJ_USERIF_ID", "IGD")
if type(getTbl) ~= "table" then
g_logger:warn("getTbl is not a table!")
end
if getTbl.IF_ERRORID == 0 then
IsFirstLogin = getTbl["RestoreFlag"]
return IsFirstLogin
end
return "1"
end
local function AlwaysGet()
return true
end
envTableMgr:addItem({envName="IsFirstLogin", envValFunc=getIsFirstLogin,conditionFunc=AlwaysGet})
end)
end
if env.getenv("CountryCode") == "63" then
local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function get_env_lancurrtype()
local tDate = cmapi.getinst("OBJ_NETSPHERE_MAP_SETMODE_ID", "")
local re = tDate.CurrentMode
return re
end
local conditionFunc = function ()
return true
end
envTableMgr:addItem({envName="OperationMode", envValFunc=get_env_lancurrtype, conditionFunc=conditionFunc})
local function get_env_subversion()
local RCVersion = cmapi.getinst("OBJ_SSUBVERSION_ID", "")
local rc = RCVersion.ReuseCPE_status
return rc
end
local SSVersionFunc = function ()
return true
end
envTableMgr:addItem({envName="RCPE_status", envValFunc=get_env_subversion, conditionFunc=SSVersionFunc})
end)
end
if env.getenv("CountryCode") == "79" then
local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function get_env_lancurrtype()
local tDate = cmapi.getinst("OBJ_NETSPHERE_MAP_ID", "")
local re = tDate.Enable
return re
end
local conditionFunc = function ()
return true
end
envTableMgr:addItem({envName="NetSphereMAPMode", envValFunc=get_env_lancurrtype, conditionFunc=conditionFunc})
end)
end
local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function getMultiAPMode()
local t = cmapi.getinst("OBJ_NETSPHERE_MAP_ID", "DEV.MULTIAPCFG")
if t.IF_ERRORID == 0 then
return t["Mode"]
end
return "0"
end
local conditionFunc = function ()
return true
end
envTableMgr:addItem({envName="Mode", envValFunc=getMultiAPMode, conditionFunc=conditionFunc})
local function getMultiAPEnable()
local t = cmapi.getinst("OBJ_NETSPHERE_MAP_ID", "DEV.MULTIAPCFG")
if t.IF_ERRORID == 0 then
return t["Enable"]
end
return "0"
end
envTableMgr:addItem({envName="MeshEnable", envValFunc=getMultiAPEnable, conditionFunc=conditionFunc})
local function getTopoPageVer()
local t = cmapi.getinst("OBJ_TOPOPAGEVERSION_ID", "")
if t.IF_ERRORID == 0 then
return t["TopoPageVer"]
end
return "v1"
end
local function envtopover(envname)
if env.getenv(envname) == "N/A" or env.getenv(envname) == "" then
return true
else
return false
end
end
envTableMgr:addItem({
envName="TopoPageVer",
envValFunc=getTopoPageVer,
conditionFunc= function() return envtopover("TopoPageVer") end
})
end)
local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function getBridge()
local bridgeShow = "0"
if (_G.wanConf["Bridge"] == true) then
bridgeShow = "1"
end
return bridgeShow
end
envTableMgr:addItem({envName="Bridge", envValFunc=getBridge})
end)
local envTableMgr = require("cgilua.globalenv_table_mgr")
envTableMgr:addModifier(function ()
local function getVoIPProtocol()
local ProtocolSet = ""
local FP_OBJNAME = "OBJ_VOIPEXT_ID";
local listTbl = cmapi.querylist(FP_OBJNAME, "IGD");
if listTbl.IF_ERRORID ~= 0 then
g_logger:warn("[OBJ_VOIPEXT_ID] querylist error")
return "N/A"
end
local getTbl = cmapi.getinst(FP_OBJNAME, listTbl[1])
if getTbl.IF_ERRORID == 0 then
ProtocolSet = getTbl.ProtocolSet
end
if "1" == ProtocolSet then
ProtocolSet = "H248"
elseif "2" == ProtocolSet then
ProtocolSet = "MGCP"
elseif "4" == ProtocolSet then
ProtocolSet = "SIP"
else
ProtocolSet = "N/A";
end
return ProtocolSet
end
local function getVoIPTR104V2()
local VoipDataModule = ""
local FP_OBJNAME = "OBJ_VOIPEXT_ID";
local listTbl = cmapi.querylist(FP_OBJNAME, "IGD");
if listTbl.IF_ERRORID ~= 0 then
g_logger:warn("[OBJ_VOIPEXT_ID] querylist error")
return "N/A"
end
local getTbl = cmapi.getinst(FP_OBJNAME, listTbl[1])
if getTbl.IF_ERRORID == 0 then
VoipDataModule = getTbl.VoipDataModule
end
return VoipDataModule
end
envTableMgr:addItem({envName="VoIPProtocal", envValFunc=getVoIPProtocol})
end)
