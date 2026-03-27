local IndiaHathayHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
IndiaHathayHiddenTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "125" then
IndiaHathayHiddenTableMgr:addItem(
{
basicType="view",
urlPath="fastway.ghtml",
fileName=modulesPath.."Fastway_t.lp",
needLogin=true,
right=nil,
}
)
IndiaHathayHiddenTableMgr:addItem(
{
basicType="data",
urlPath="fastway",
fileName=modulesPath.."Fastway_lua.lua",
needLogin=true,
right=nil,
}
)
end
end)
local IndiaHathayHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
IndiaHathayHiddenTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "98" then
IndiaHathayHiddenTableMgr:addItem(
{
basicType="view",
urlPath="hathway_upgrade.ghtml",
fileName=modulesPath.."IndiaHathway_upgrade_t.lp",
needLogin=true,
right=nil,
}
)
IndiaHathayHiddenTableMgr:addItem(
{
basicType="data",
urlPath="firmware_upgrade",
fileName=modulesPath.."do_firmware_upgrade.lua",
needLogin=true,
right=nil,
}
)
IndiaHathayHiddenTableMgr:addItem(
{
basicType="data",
urlPath="updownload_prevent",
fileName=modulesPath.."updownload_prevent_ctl.lua",
needLogin=true,
right=nil,
}
)
IndiaHathayHiddenTableMgr:addItem(
{
basicType="data",
urlPath="upgrade_firmware",
fileName=modulesPath.."upgrade_firmware_query_lua.lua",
needLogin=true,
right=nil,
}
)
end
end)
local SNOrangeHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
SNOrangeHiddenTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "124" then
SNOrangeHiddenTableMgr:addItem({basicType="data", urlPath="poninfo_sn", fileName=modulesPath.."firstlogin_poninfo_sn_lua.lua", needLogin=false, right=nil})
end
end)
local thailand_aisHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
thailand_aisHiddenTableMgr:addModifier(function ()
thailand_aisHiddenTableMgr:addItem(
{
basicType="view",
urlPath="redirect.html",
fileName=modulesPath.."Wizard_t.lp",
needLogin=false,
right=nil,
}
)
thailand_aisHiddenTableMgr:addItem(
{
basicType="view",
urlPath="DnsLandingPage.html",
fileName=modulesPath.."Dns_Landing_Page_t.lp",
needLogin=false,
right=nil,
}
)
thailand_aisHiddenTableMgr:addItem(
{
basicType="data",
urlPath="enable/CPE/ZeroTouch",
fileName=modulesPath.."hw_telnet.lua",
needLogin=false,
right=nil,
}
)
thailand_aisHiddenTableMgr:addItem(
{
basicType="data",
urlPath="disable/CPE/ZeroTouch",
fileName=modulesPath.."hw_telnet.lua",
needLogin=false,
right=nil,
}
)
end)local awnlHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
awnlHiddenTableMgr:addModifier(function ()
awnlHiddenTableMgr:addItem(
{
basicType="data",
urlPath="verinfo",
fileName=modulesPath.."awn_verinfo_check_lua.lua",
needLogin=false,
right=nil,
}
)
awnlHiddenTableMgr:addItem(
{
basicType="data",
urlPath="reqSubMod",
fileName=modulesPath.."awn_sub_model_request.lua",
needLogin=false,
right=nil,
}
)
awnlHiddenTableMgr:addItem(
{
basicType="data",
urlPath="SpecialBackhaulCon",
fileName=modulesPath.."awn_special_backhaul.lua",
needLogin=false,
right=nil,
}
)
awnlHiddenTableMgr:addItem(
{
basicType="data",
urlPath="UpdateClientInfo",
fileName=modulesPath.."awn_wifi_update.lua",
needLogin=false,
right=nil,
}
)
end)
local ctcHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
ctcHiddenTableMgr:addModifier(function ()
ctcHiddenTableMgr:addItem(
{
basicType="view",
urlPath="autoconfig/command.cgi",
fileName=modulesPath.."rcm_t.lp",
needLogin=false,
right=nil,
}
)
ctcHiddenTableMgr:addItem(
{
basicType="view",
urlPath="information/getinfo.cgi/sys_info",
fileName=modulesPath.."sys_info_t.lp",
needLogin=false,
right=nil,
}
)
ctcHiddenTableMgr:addItem(
{
basicType="view",
urlPath="information/getinfo.cgi/sys_loginfo",
fileName=modulesPath.."syslog_info_t.lp",
needLogin=false,
right=nil,
}
)
ctcHiddenTableMgr:addItem(
{
basicType="view",
urlPath="information/getinfo.cgi/wifi_info",
fileName=modulesPath.."wifi_info_t.lp",
needLogin=false,
right=nil,
}
)
ctcHiddenTableMgr:addItem(
{
basicType="data",
urlPath="information/getinfo.cgi/hgw_dbuglog",
fileName=modulesPath.."filedown.lua",
needLogin=false,
right=nil,
}
)
end)
local ektHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
ektHiddenTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "79" then
ektHiddenTableMgr:addItem(
{
basicType="view",
urlPath="mirrorcfg.html",
fileName=modulesPath.."mirror_t.lp",
needLogin=true,
right=nil,
}
)
ektHiddenTableMgr:addItem(
{
basicType="data",
urlPath="mirrorcfg_data",
fileName=modulesPath.."mirror_lua.lua",
needLogin=true,
right=nil,
}
)
ektHiddenTableMgr:addItem(
{
basicType="view",
urlPath="Register",
fileName=modulesPath.."dnscheat_nolos_t.lp",
needLogin=false,
right=nil,
}
)
ektHiddenTableMgr:addItem(
{
basicType="data",
urlPath="Register_data",
fileName=modulesPath.."dnscheat_nolos_lua.lua",
needLogin=false,
right=nil,
}
)
end
end)
local ektHiddenTableMgr = require("page_mgr.hidden_table_mgr")
local modulesPath = "../../webmodules/modules/"
ektHiddenTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "77" then
ektHiddenTableMgr:addItem(
{
basicType="view",
urlPath="mirrorcfg.html",
fileName=modulesPath.."mirror_t.lp",
needLogin=true,
right=nil,
}
)
ektHiddenTableMgr:addItem(
{
basicType="data",
urlPath="mirrorcfg_data",
fileName=modulesPath.."mirror_lua.lua",
needLogin=true,
right=nil,
}
)
ektHiddenTableMgr:addItem(
{
basicType="view",
urlPath="TR069settings",
fileName=modulesPath.."masmv_tr069_remotemgr_t.lp",
needLogin=true,
right=1,
}
)
ektHiddenTableMgr:addItem(
{
basicType="data",
urlPath="TR069settings_data",
fileName=modulesPath.."masmv_tr069_remotemgr_lua.lua",
needLogin=true,
right=1,
}
)
end
end)
