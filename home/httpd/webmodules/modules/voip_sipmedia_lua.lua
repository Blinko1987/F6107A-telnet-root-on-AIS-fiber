require "data_assemble.common_lua"
local ErrorXML = ""
local InstXML = ""
local InstXMLTMP = ""
local OutXML = ""
local need2Get = 1
local tError = nil
local FP_OBJNAME = "OBJ_VOIPLINEVMEDAI_ID";
local t_PARA =
{
"MediaVEnable",
"MediaVType",
"MediaVCodec",
"MediaVPV",
"MediaVPT",
"MediaVCR",
"MediaVPri",
"MediaSSuprs",
"MediaRSSuprs"
};
local LINE_OBJNAME = "OBJ_VOIPVPLINE_ID";
local FP_ACTION = cgilua.cgilua.POST.IF_ACTION
local FP_IDENTITY = cgilua.cgilua.POST._InstID
if FP_ACTION == "Apply" then
need2Get = 0
local codecType =
{
"G711U",
"G711A",
"G729",
"G726",
"G723",
"G722",
"G726_24k",
"G726_32k",
"Other"
}
for i, v in pairs(codecType) do
local codec_ID_Name = "_InstID_" .. v
local codec_ID = cgilua.cgilua.POST[codec_ID_Name]
if codec_ID ~= nil and codec_ID ~= "" then
local t_Data = {}
for j, k in pairs(t_PARA) do
t_Data[k] = cgilua.cgilua.POST[k .. "_" .. v]
end
tError = applyOrNewOrDelInst(FP_OBJNAME, FP_ACTION, codec_ID, t_Data, tError)
end
end
end
if FP_ACTION == "Cancel" then
need2Get = 0;
InstXML, tError = getAllInstXML(FP_OBJNAME, FP_IDENTITY, tError)
end
if need2Get == 1 then
InstXML, tError = getAllInstXML(LINE_OBJNAME, "IGD", tError, nil, {_instID = ""})
local tQuery = cmapi.querylist(LINE_OBJNAME, "IGD")
for i, v in ipairs(tQuery) do
InstXMLTMP, tError = getAllInstXML(FP_OBJNAME, v, tError)
InstXML = InstXML .. InstXMLTMP
end
end
ErrorXML = outputErrorXML(tError)
OutXML = ErrorXML .. InstXML
outputXML(OutXML)
