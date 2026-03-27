require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_PON_Port_sta"
local PARA =
{
"RxBytes",
"RxPackets",
"RxError1",
"RxError2",
"Rxdis",
"TxBytes",
"TxPackets"
}
local function callback(t)
t.RxError1 = t.RxError1+t.RxError2
return true
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, nil, callback)
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
