require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJNAME = "OBJ_DHCPBINDONPORT_ID";
local PARA =
{
"VendorClassID",
"ProcFlag",
}
local function transData(num)
if num == nil then
return
end
num = tonumber(num)
if num ~= nil then
num = (num + 1) % 2
end
return num
end
local function transProcFlag(t)
if type(t) == "table" then
t.ProcFlag = transData(t.ProcFlag)
end
return true
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
if FP_ACTION == "Apply" then
need2Get = 0
local instNum = cgilua.cgilua.POST._InstNum
for i = 0, instNum - 1 do
local identityName = "_InstID_" .. i
local identity = cgilua.cgilua.POST[identityName]
if identity ~= nil then
local t_Data = {}
for j, k in pairs(PARA) do
t_Data[k] = cgilua.cgilua.POST[k .. "_" .. i]
if k == "ProcFlag" then
t_Data[k] = transData(t_Data[k])
end
end
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, identity, t_Data, tError)
end
end
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(FP_OBJNAME, "IGD", tError, transProcFlag, transToFilterTab(PARA))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
