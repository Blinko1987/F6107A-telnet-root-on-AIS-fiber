require "data_assemble.common_lua"
local vender = cgilua.cgilua.POST["vender"] or ""
local model = cgilua.cgilua.POST["model"] or ""
local ver = cgilua.cgilua.POST["ver"] or ""
local verext = cgilua.cgilua.POST["verext"] or ""
local outData = "FAIL"
local getTbl = cmapi.getinst("OBJ_DEVINFO_ID", "IGD")
if getTbl.IF_ERRORID == 0 then
if getTbl["ManuFacturer"] == vender and getTbl["ModelName"] == model then
if getTbl["SoftwareVer"] == ver and getTbl["SoftwareVerExtent"] == verext then
outData = "NONEED"
else
outData = "OK+firmware"
end
end
end
sapi.Response.sethc("linger","1")
sapi.Response.write(outData)
