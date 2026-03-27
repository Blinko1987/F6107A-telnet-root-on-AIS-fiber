require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_USBBAKRST_ID"
local PARA =
{
"RstEnable",
"SelectPath",
"StartBackup"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError)
if tError.IF_ERRORID == -992 then
tError.IF_ERRORSTR = "SUCC"
tError.IF_ERRORID = 0
end
local FP_OBJNAME_RESTORE = "OBJ_USBBACKUPSTORAGE_ID"
local PARA_RESTORE =
{
"Path",
"BakFileExist"
}
InstXML_RESTORE, tError_restore = getAllInstXML(FP_OBJNAME_RESTORE, "IGD", nil, setValueCallback,transToFilterTab(PARA_RESTORE))
if tError.IF_ERRORSTR == "SUCC" then
ErrorXML = outputErrorXML(tError_restore)
else
ErrorXML = outputErrorXML(tError)
end
OutXML = ErrorXML .. InstXML .. InstXML_RESTORE
outputXML(OutXML)
