local hiddenPageLogic = require("page_mgr.hidden_page_logic")
local loginPageLogic = require("page_mgr.login_page_logic")
local menuPageLogic = require("page_mgr.menu_page_logic")
local routerTable = {
{type="menuView", basicType="view", URL2FileFunc= menuPageLogic.getFuncAreaFiles },
{type="menuViewWholePage", basicType="view", URL2FileFunc= menuPageLogic.getFramePageFiles },
{type="menuData", basicType="data", URL2FileFunc= menuPageLogic.getFuncAreaData },
{type="loginView", basicType="view", URL2FileFunc=loginPageLogic.getViewFiles },
{type="loginData", basicType="data", URL2FileFunc=loginPageLogic.getDataFiles },
{type="hiddenView", basicType="view", URL2FileFunc=hiddenPageLogic.getViewFile },
{type="hiddenData", basicType="data", URL2FileFunc=hiddenPageLogic.getDataFile }
}
return routerTable
