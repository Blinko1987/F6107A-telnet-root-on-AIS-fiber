require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_VOIPVPPHYINTERFACE_ID"
local PARA =
{
"LanPortStatus"
}
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, nil, transToFilterTab(PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
