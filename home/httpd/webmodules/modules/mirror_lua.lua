require "data_assemble.common_lua"
local sessmgr = require("user_mgr.session_mgr")
sessmgr.SetCurrentSessAttr("nextpage", "homePage")
local InstXML = ""
local ErrorXML = ""
local OutXML = ""
local tError = nil
local FP_OBJNAME = "OBJ_MIRROR_ID"
local PARA =
{
"MirrorEnable",
"MirrorSrc",
"MirrorDest",
};
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_IDENTITY == "-1" then
FP_IDENTITY = ""
end
InstXML, tError = ManagerOBJ(FP_OBJNAME, FP_ACTION, FP_IDENTITY, PARA, nil, {xmlType = 1})
cmapi.undoDBSave()
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
