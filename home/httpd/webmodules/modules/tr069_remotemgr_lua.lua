require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local InstXML1 = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_IDENTITY= ""
local FP_OBJNAME = "OBJ_MANAGESERVER_ID"
local PARA =
{
"URL",
"UserName",
"UserPassword",
"PeriodicInformEnable",
"PeriodicInformInterval",
"ConnectionRequestURL",
"ConnectionRequestUsername",
"ConnectionRequestPassword",
"DefaultWan",
"SupportCertAuth",
"CertID",
"CertList",
"RemoteUpgradeCertAuth",
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"UserPassword","ConnectionRequestPassword"}
local QUEUE_OBJNAME = "OBJ_TR069QUEUECONF_ID"
local QUEUE_PARA =
{
"DSCPRemark",
"VLanPrioRemark"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == cgilua.POST.UserPassword then
cgilua.POST.UserPassword = nil
end
if strpass == cgilua.POST.ConnectionRequestPassword then
cgilua.POST.ConnectionRequestPassword = nil
end
local function callback(t)
if string.find(_G.commConf.passCanSee,"Tr069") == nil then
t.UserPassword = nil
t.ConnectionRequestPassword = nil
end
return true
end
if FP_ACTION == "Apply" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(para_table),tError)
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, tError, callback, transToFilterTab(para_table))
elseif FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(para_table))
else
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, callback,transToFilterTab(para_table))
end
InstXML1, tError = ManagerOBJ(QUEUE_OBJNAME, FP_ACTION, "IGD", QUEUE_PARA, tError, {xmlType= 2, retCheck = 2})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML1 .. InstXML2
outputXML(OutXML)
