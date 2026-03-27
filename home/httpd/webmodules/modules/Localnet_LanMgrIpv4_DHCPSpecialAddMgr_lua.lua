require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_DHCPPOOL_ID";
local PARA =
{
"PoolName",
"Enable",
"MinAddress",
"MaxAddress",
}
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
local tDevice = {
hgw = lang.LanMgrIpv4_028,
stb = lang.LanMgrIpv4_029,
phone = lang.LanMgrIpv4_030,
camera = lang.LanMgrIpv4_031,
pc = lang.LanMgrIpv4_032,
}
local function callbackTag(t)
local poolname = ""
if t.VendorClassID == "" or t.VendorClassID == "*" then
poolname = tDevice[t.PoolName]
if poolname == nil then
poolname = lang.LanMgrIpv4_033
end
t.PoolName = poolname
end
return true
end
local need2Get = 1
if type(tError) == "table" then
if tError.IF_ERRORID ~= 0 then
return "", tError
end
end
local ReturnIdentity = "";
if FP_ACTION == "Apply" or FP_ACTION == "Delete" then
need2Get = 0
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, FP_IDENTITY, transToPostTab(PARA))
ReturnIdentity = tError.INSTIDENTITY or ""
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, tError, callbackTag, transToFilterTab(PARA))
end
if FP_ACTION == "Cancel" then
need2Get = 0
InstXML, tError = getSpecificInstXML(FP_OBJNAME, FP_IDENTITY, nil, callbackTag, transToFilterTab(PARA))
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", nil, callbackTag,transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
