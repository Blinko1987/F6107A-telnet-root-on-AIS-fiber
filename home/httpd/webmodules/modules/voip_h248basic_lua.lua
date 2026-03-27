require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = ""
local need2Get = 1
local FP_OBJNAME = "OBJ_VOIPH248MAIN_ID"
local PARA =
{
"MGMIDType",
"MGMID",
"LocalPort",
"MGCAddr1",
"MGCPort1",
"MGCAddr2",
"MGCPort2",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML2, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2
outputXML(OutXML)
