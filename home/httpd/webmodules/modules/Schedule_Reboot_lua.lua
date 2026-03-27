require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local Cfg_OBJNAME = "OBJ_SRCFG_ID"
local Cfg_PARA =
{
"Enable"
};
local Info_OBJNAME = "OBJ_SRINFO_ID"
local Info_PARA =
{
"TimeWeek",
"TimeMin",
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML1,tError = ManagerOBJ(Cfg_OBJNAME, FP_ACTION, FP_IDENTITY, Cfg_PARA)
InstXML2,tError = ManagerOBJ(Info_OBJNAME, FP_ACTION, FP_IDENTITY, Info_PARA,tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2
outputXML(OutXML)
