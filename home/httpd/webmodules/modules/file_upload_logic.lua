local json = require("common_lib.json")
local cgilua = require("cgilua.cgilua")
local callUploadDownloadProc = cmapi.nocsrf.callUploadDownloadProc
local function UploadFile( fileCtrlID )
cgilua.contentheader ("text", "html; charset="..lang.CHARSET)
local serverFD = REQUEST.SERVER_FD
local execOut = REQUEST.EXEC_OUT
local ret = callUploadDownloadProc(fileCtrlID, serverFD, execOut)
if ret.IF_ERRORID ~= 0 then
g_logger:warn("uploading file(".. fileCtrlID .. ") failed!")
end
cgilua.put( json.encode(ret) )
return ret
end
return {
UploadFile = UploadFile,
}
