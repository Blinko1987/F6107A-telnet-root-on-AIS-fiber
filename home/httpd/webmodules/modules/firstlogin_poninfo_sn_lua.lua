require "data_assemble.common_lua"
local cgilua = cgilua.cgilua
local ErrorXML = ""
local InstXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_SN_INFO_ID"
local PARA =
{
"ViewName",
"Sn",
"Pwd"
}
local FP_ACTION = cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.POST._InstID
local para_table = {}
para_table.para = PARA
if FP_ACTION == "Apply" then
tError = cmapi.nocsrf.setinst(FP_OBJNAME, FP_IDENTITY, transToPostTab(para_table))
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
