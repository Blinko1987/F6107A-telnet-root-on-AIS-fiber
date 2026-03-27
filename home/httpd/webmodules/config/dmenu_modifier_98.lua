dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "98" then
dmenu:findMenu("dns"):remove()
dmenu:findMenu("firmwareUpgr"):remove()
dmenu:findMenu("logMgr"):findArea("log_seclogmgr_t.lp"):remove()
end
end)
