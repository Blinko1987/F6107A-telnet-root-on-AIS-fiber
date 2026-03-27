require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local tIgnoreDBError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local FP_OBJNAME = "OBJ_DHCPHOSTINFO_ID"
local PARA =
{
"MACAddr",
"IPAddr",
"ExpiredTime",
"HostName",
"PhyPortName"
}
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, nil,transToFilterTab(PARA))
if tError.IF_ERRORID and tError.IF_ERRORID == -8 then
tError = tIgnoreDBError
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
