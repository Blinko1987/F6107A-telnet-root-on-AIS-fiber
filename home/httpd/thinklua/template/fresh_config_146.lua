if env.getenv("OperationMode")=="6" then
_G.commConf["elementControl"] = {
WlanBasicAdOnOff = "all::hideBtn",
MACFilterACLPolicy = "all::hideBtn",
WPS = "all::hideBtn",
NetSphereMAPMode = "all::hideBtn",
BandSteer = "all::hideBtn",
}
_G.ssidConf["MACFilterRule"] = "all::hideBtn+instDelete_MACFilterRule::hide+addInstBar::hide"
_G.ssidConf["1"] = {
disableSSID = "all:hideBtn",
WlanBasicAdConf = "all::hideBtn"
}
_G.ssidConf["2"] = {
disableSSID = "all:hideBtn",
WlanBasicAdConf = "all::hideBtn"
}
end
