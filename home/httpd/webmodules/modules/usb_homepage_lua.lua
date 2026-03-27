require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local InstXML2 = ""
local InstXML3 = ""
local OutXML = ""
local tError = nil
local PARA =
{
"DevName",
"DevID",
"ClassInfoStr",
"DevSpeed"
}
local IP_PARA =
{
"IPAddr",
"USBIfNum"
}
local FTP_PARA =
{
"FtpEnable",
"ServerPort"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "EjectDev" then
tError = cmapi.dev_action({CmdId = "cmd_usbeject"})
end
InstXML1, tError = getAllInstXML("OBJ_USBDEV_ID", "IGD", tError, nil, transToFilterTab(PARA))
InstXML2, tError = getAllInstXML("OBJ_BRGRP_ID", "IGD", tError, nil, transToFilterTab(IP_PARA))
InstXML3, tError = getAllInstXML("OBJ_FMFTPSERVERCFG_ID", "IGD", tError, nil, transToFilterTab(FTP_PARA))
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1 .. InstXML2 .. InstXML3
outputXML(OutXML)
