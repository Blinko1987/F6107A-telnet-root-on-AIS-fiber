if 4 == 8 then
_G.ssidConf["2"]={
hidden = "DEV.WIFI.AP5,DEV.WIFI.AP6,DEV.WIFI.AP7,DEV.WIFI.AP11,DEV.WIFI.AP14,DEV.WIFI.AP15,"
}
else
_G.ssidConf["2"]={
hidden = "DEV.WIFI.AP7,"
}
end
_G.wanConf["2"]={
hidden = {
WANCName = "THSi"
}
}
_G.wanConf["Bridge"] = true
