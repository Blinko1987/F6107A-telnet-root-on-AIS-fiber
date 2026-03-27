require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXML2 = ""
local OutXML = ""
local tError = nil
local need2Get = 1
local FP_OBJNAME = "OBJ_DDNSCLIENT_ID"
local PARA =
{
"Enable",
"Status",
"DomainName",
"Service",
"Username",
"Password",
"UserType"
}
local para_table = {}
para_table.para = PARA
para_table.encrypt = {"Password"}
local DDNSHostname_OBJNAME = "OBJ_DDNSHOSTNAME_ID"
local DDNSHostname_PARA =
{
"Name",
"Status"
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
local FP_SERVICE = cgilua.cgilua.POST.Service
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
if strpass == cgilua.cgilua.POST.Password then
cgilua.cgilua.POST.Password = nil
end
local function callback(t)
t.Password = nil
FP_SERVICE = t.Service
return true
end
local DDNSService_IDENTITY = cgilua.cgilua.POST.serviceInst
local ReturnIdentity = ""
if FP_ACTION == "Cancel" and FP_SERVICE == "phddns" then
FP_ACTION = "Apply"
end
if FP_ACTION == "Apply" or FP_ACTION == "Delete" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(para_table))
ReturnIdentity = tError.INSTIDENTITY or ""
InstXML = getXMLNodeEntity("_InstID",encodeXML(ReturnIdentity))
if FP_SERVICE == "phddns" and tError.IF_ERRORID == 0 then
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(para_table))
end
end
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, callback, transToFilterTab(para_table))
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, callback, transToFilterTab(para_table))
end
if FP_SERVICE == "phddns" then
InstXML2, tError = getAllInstXML(DDNSHostname_OBJNAME, "IGD", tError, nil,transToFilterTab(DDNSHostname_PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML .. InstXML2
outputXML(OutXML)
