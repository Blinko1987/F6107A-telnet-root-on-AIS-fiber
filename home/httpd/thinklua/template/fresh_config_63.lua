local userIfTbl = cmapi.getinst("OBJ_USERIF_ID", "IGD")
if userIfTbl.IF_ERRORID == 0 then
if userIfTbl.CaptchaEnable == "1" then
_G.commConf.ValidateCode = true
else
_G.commConf.ValidateCode = false
end
end
if env.getenv("OperationMode")=="3" then
_G.commConf["elementControl"] = {
WlanBasicAdOnOff = "all::hideBtn",
MACFilterACLPolicy = "all::hideBtn",
MACFilterRule = "all::hideBtn",
WPS = "all::hideBtn",
NetSphereMAPMode = "all::hideBtn",
WlanBandSteering = "all::hideBtn",
}
_G.ssidConf["1"] = {
disableSSID = "all:hideBtn",
WlanBasicAdConf = "all::hideBtn"
}
_G.ssidConf["2"] = {
disableSSID = "all:hideBtn",
WlanBasicAdConf = "all::hideBtn"
}
end
