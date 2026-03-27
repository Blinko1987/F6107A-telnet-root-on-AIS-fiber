require "data_assemble.common_lua"
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_PARENT_CONTROL_ID"
local PARA =
{
"Name",
"Enable",
"ChildId",
"FilterMode",
"Week",
"StartHour",
"EndHour",
"StartMin",
"EndMin",
"URLCnt"
}
local iMax = 5;
local iIdx = 0;
for iIdx=0,(iMax-1) do
table.insert(PARA, "URL"..iIdx);
end
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = "";
end
InstXML,tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, tError, {xmlType = 1})
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
