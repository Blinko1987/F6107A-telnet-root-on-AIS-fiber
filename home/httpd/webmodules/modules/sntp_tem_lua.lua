require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_OBJNAME = "OBJ_TEMPLATESNTP_ID"
local PARA =
{
"CurrentLocalTime"
}
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, nil,transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
