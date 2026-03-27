require"data_assemble.common_lua"
local cgilua = cgilua.cgilua
local xmlError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local sess_id = cgilua.getCurrentSessID()
local sessClinet = cgilua.QUERY.sessToken
local sessServer = session_get(sess_id, "sess_token")
if sessClinet == nil then
sessClinet = cgilua.POST.sessToken
end
if sessClinet ~= sessServer then
xmlError.IF_ERRORID = -1452
xmlError.IF_ERRORSTR = "1452"
end
local ErrorXML = ""
local OutXML = ""
ErrorXML = outputErrorXML(xmlError)
OutXML = ErrorXML
outputXML(OutXML)
