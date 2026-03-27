require "data_assemble.common_lua"
local sessmgr = require("user_mgr.session_mgr")
sessmgr.SetCurrentSessAttr("nextpage", "homePage")
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_OBJNAME = "OBJ_CHANGEDOCSISSTATUS_ID"
local PARA =
{
"EthBasedOnRegEn"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = "IGD"
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
