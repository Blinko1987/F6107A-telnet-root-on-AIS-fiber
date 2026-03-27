local cgilua = require("cgilua.cgilua")
local EntryURL2RouterType = function ()
local loginStatus = require("user_mgr.usermgr_logic_impl"):getLoginStatus()
if "loginAlready" == loginStatus then
return "menuViewWholePage", nil
elseif "loginTimeout" == loginStatus then
return "loginView", nil
else
return "loginView", nil
end
end
local urlPath2TypeTable = {
{urlPath="", routerType=EntryURL2RouterType},
}
return urlPath2TypeTable
