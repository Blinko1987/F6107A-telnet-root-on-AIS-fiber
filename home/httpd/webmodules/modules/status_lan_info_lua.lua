require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML1 = ""
local OutXML = ""
local tError = nil
local PARA_ETH =
{
"InBytes",
"InPkts",
"InUnicast",
"InMulticast",
"InError",
"InDiscard",
"OutBytes",
"OutPkts",
"OutUnicast",
"OutMulticast",
"OutError",
"OutDiscard",
"Status",
"Speed",
"Duplex"
}
local FP_ACTION = cgilua.POST.IF_ACTION
if FP_ACTION == "LAN_CLEAR" then
tError = cmapi.dev_action({CmdId = "cmd_clear_lanstate"})
else
InstXML1 , tError = getAllInstXML("OBJ_PON_PORT_BASIC_STATUS_ID", "DEV", tError, nil, transToFilterTab(PARA_ETH))
end
ErrorXML = ErrorXML .. outputErrorXML(tError)
OutXML = ErrorXML .. InstXML1
outputXML(OutXML)
