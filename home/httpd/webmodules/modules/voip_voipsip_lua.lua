require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJNAME = "OBJ_VOIPSIP_ID"
local PARA =
{
"UserAgentPort",
"RegisterExpires",
"LinkTest",
"LinkTestInterval",
"DeRegister",
"DNSMode",
"UserAgentDoimain",
"EventSubscription",
"V100rel",
"Timer",
"InviteExpires"
}
if env.getenv("VoIPTR104V2") == "1" then
table.insert(PARA, "CodecList")
end
local FP_OBJNAME_SERVER = "OBJ_VOIPSIPSERVER_ID"
local PARA_SERVER =
{
"ProxyServer1",
"ProxyServer2",
"OutboundProxy1",
"OutboundProxy2",
"ProxyServerPort1",
"ProxyServerPort2",
"RegistrarServer1",
"RegistrarServer2",
"OutboundProxyPort1",
"OutboundProxyPort2",
"SipServer"
}
local FP_OBJNAME_DMTTIMER = "OBJ_VOIPDMTIMER_ID"
local PARA_DMTTIMER =
{
"StartTimer"
}
local FP_OBJNAME_BEARINFO = "OBJ_VOIPBEARINFO_ID"
local PARA_BEARINFO =
{
"Opt120FlagControl"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local FP_IDENTITYTIMER = cgilua.cgilua.POST._InstIDTIMER
local FP_IDENTITYBEARINFO = cgilua.cgilua.POST._InstIDBEARINFO
function ActionOneOBJ(OBJNAME, PARA_TAB, err, ActionType, FP_IDENTITY)
if type(err) == "table" and err.IF_ERRORID ~= 0 then
return err
end
local t_Data = {}
for j, k in pairs(PARA_TAB) do
t_Data[k] = cgilua.cgilua.POST[k]
end
err = applyOrNewOrDelInst(OBJNAME, ActionType, FP_IDENTITY, t_Data, err)
return err
end
if FP_ACTION == "Apply" then
need2Get = 0
tError = ActionOneOBJ(FP_OBJNAME, PARA, tError, FP_ACTION, FP_IDENTITY)
tError = ActionOneOBJ(FP_OBJNAME_SERVER, PARA_SERVER, tError, FP_ACTION, FP_IDENTITY)
tError = ActionOneOBJ(FP_OBJNAME_DMTTIMER, PARA_DMTTIMER, tError, FP_ACTION, FP_IDENTITYTIMER)
tError = ActionOneOBJ(FP_OBJNAME_BEARINFO, PARA_BEARINFO, tError, FP_ACTION, FP_IDENTITYBEARINFO)
end
local InstXML1 = ""
local InstXML2 = ""
local InstXML3 = ""
local InstXML4 = ""
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML1, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(PARA))
InstXML2, tError = getSpecificInstXML(FP_OBJNAME_SERVER, FP_IDENTITY, nil, callback, transToFilterTab(PARA_SERVER))
InstXML3, tError = getSpecificInstXML(FP_OBJNAME_DMTTIMER, FP_IDENTITYTIMER, nil, nil, transToFilterTab(PARA_DMTTIMER))
InstXML4, tError = getSpecificInstXML(FP_OBJNAME_BEARINFO, FP_IDENTITYBEARINFO, nil, nil, transToFilterTab(PARA_BEARINFO))
InstXML = InstXML1 .. InstXML2 .. InstXML3 .. InstXML4
end
local InstXMLTIMER = ""
local InstXMLBEARINFO = ""
if need2Get == 1 then
InstXMLTMP, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, nil, transToFilterTab(PARA))
InstXML = InstXML .. InstXMLTMP
InstXMLTMP, tError = getAllInstXML(FP_OBJNAME_SERVER, "IGD", tError, nil, transToFilterTab(PARA_SERVER))
InstXML = InstXML .. InstXMLTMP
InstXMLTIMER, tError = getAllInstXML(FP_OBJNAME_DMTTIMER, "IGD", tError, callbacktimer, transToFilterTab(PARA_DMTTIMER))
InstXML = InstXML .. InstXMLTIMER
InstXMLBEARINFO, tError = getAllInstXML(FP_OBJNAME_BEARINFO, "IGD", tError, callbacktimer, transToFilterTab(PARA_BEARINFO))
InstXML = InstXML .. InstXMLBEARINFO
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
