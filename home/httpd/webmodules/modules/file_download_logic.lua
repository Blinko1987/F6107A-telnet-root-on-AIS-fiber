local cgilua = cgilua.cgilua
local callUploadDownloadProc = cmapi.nocsrf.callUploadDownloadProc
local function DownloadFile( fileCtrlID )
cgilua.contentheader ("application", "octet-stream;")
local serverFD = REQUEST.SERVER_FD
local execOut = REQUEST.EXEC_OUT
local ret = callUploadDownloadProc(fileCtrlID, serverFD, execOut)
if ret.IF_ERRORID ~= 0 then
g_logger:warn("downloading file(".. fileCtrlID .. ") failed!")
elseif fileCtrlID == "downloadlog" then
g_logger:custom("download log.", "ERROR", "SECURITY")
else
end
return ret
end
return {
DownloadFile = DownloadFile,
}
