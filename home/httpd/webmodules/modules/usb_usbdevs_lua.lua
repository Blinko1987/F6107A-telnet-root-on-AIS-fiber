require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local U_PARA=
{
"DevNum",
"DiskName",
"StorBlockSize",
"StorFreeSize"
}
InstXML, tError = getAllInstXML("OBJ_USBSTORAGE_ID", "IGD", tError, nil, transToFilterTab(U_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
