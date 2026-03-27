function StatusOfLRBtnOf3MenuHandle(nowScrollLocation)
{
if (nowScrollLocation == "")
{
nowScrollLocation = 0;
}
var class3MenuContainerWidth = $("#class3MenuMainContent").width();
var totalTabWidth = $("#_totalTabWidth").val();
if ( nowScrollLocation >= (totalTabWidth - class3MenuContainerWidth) )
{
$("#scrollRightBtn").attr("class","scrollRightBtnDisable");
$("#scrollLeftBtn").attr("class", "scrollLeftBtn EnableScrollBtn");
}
else if ( nowScrollLocation == 0 )
{
$("#scrollLeftBtn").attr("class", "scrollLeftBtnDisable");
$("#scrollRightBtn").attr("class","scrollRightBtn EnableScrollBtn");
}
else
{
$("#scrollRightBtn").attr("class","scrollRightBtn EnableScrollBtn");
$("#scrollLeftBtn").attr("class", "scrollLeftBtn EnableScrollBtn");
}
}
function Menu3TabStyleHandle()
{
var class3MenuContainer = $("#class3MenuMainContent");
var ContainerWidth = $("#commRight").width()- $("#scrollLeftBtn").width()
- $("#scrollRightBtn").width();
class3MenuContainer.width(ContainerWidth);
var tabTotalWidth = 0;
var tab = $("li",class3MenuContainer);
for (var i=0; i< tab.length; i++)
{
var LiWidth = parseInt(tab[i].offsetWidth);
tabTotalWidth = tabTotalWidth + LiWidth;
}
$("#_totalTabWidth").val(tabTotalWidth);
var class3MenuUl = $("ul",class3MenuContainer);
if ( tabTotalWidth > ContainerWidth )
{
class3MenuUl.css("width", 5000);
$("#scrollLeftBtn,#scrollRightBtn").addClass("EnableScrollBtn");
var nowScrollLocation = $("#_Menu3Location").text();
if ((tabTotalWidth-ContainerWidth) < nowScrollLocation)
{
nowScrollLocation = tabTotalWidth-ContainerWidth;
}
class3MenuContainer.scrollLeft(nowScrollLocation);
StatusOfLRBtnOf3MenuHandle(nowScrollLocation);
}
else
{
$("#scrollLeftBtn").removeClass("scrollLeftBtn");
$("#scrollRightBtn").removeClass("scrollRightBtn");
}
}
function MenuItemClass(menuItemJSON) {
this.menuItemJSON = menuItemJSON;
}
MenuItemClass.prototype.findMenu = function (menuid) {
var menuItemJSON = this.menuItemJSON;
var menuItemId = menuItemJSON.id;
if (menuItemId == menuid)
{
return menuItemJSON;
}
var children = menuItemJSON.children;
if ( !children )
{
return null;
}
for (var i = 0; i < children.length; i++) {
var childItem = children[i];
var childID = childItem.id;
if ( menuid == childID )
{
return childItem;
}
if ( childItem.children )
{
var childObj = new MenuItemClass(childItem);
var targetMenu = childObj.findMenu(menuid);
if (targetMenu)
{
return targetMenu;
}
}
}
return null
}
MenuItemClass.prototype.getLeftMostPageJSON = function () {
var menuItemJSON = this.menuItemJSON;
var menuItemId = menuItemJSON;
var children = menuItemJSON.children;
if ( !children )
{
return menuItemJSON;
}
var leftMostSon = children[0];
var menuObj = new MenuItemClass(leftMostSon);
return menuObj.getLeftMostPageJSON();
}
function MenuTreeClass(menuTreeJSON)
{
this.menuTreeJSON = menuTreeJSON
}
MenuTreeClass.prototype.findMenu = function(menuid) {
var menuTreeJSON = this.menuTreeJSON
for (var i = 0; i < menuTreeJSON.length; i++) {
var menu1table = menuTreeJSON[i];
var menu1Obj = new MenuItemClass(menu1table);
var targetMenu = menu1Obj.findMenu(menuid);
if ( targetMenu )
{
return targetMenu;
}
}
return null
};
function GetLeftMostPageID(menuid)
{
var menuTable = menuTreeObj.findMenu(menuid);
var menuObj = new MenuItemClass(menuTable);
var pageJSON = menuObj.getLeftMostPageJSON();
return pageJSON.id;
}
function Class3MenuShow(selectPageID, selectSupId, selectMidId, selectThdId)
{
if ( selectThdId == "" )
{
$("#class3Menu").css("display", "none");
return;
}
var class2MenuNode = menuTreeObj.findMenu(selectMidId);
var class3MenuJSON = class2MenuNode.children;
var class3MenuContent = "";
for (var index in class3MenuJSON)
{
var menu = class3MenuJSON[index]
var class3MenuID = menu.id
var class3MenuName = menu.name
if ( class3MenuID == selectThdId )
{
AEleMenu3Class = "AEleMenu3Selected";
}
else
{
AEleMenu3Class = "AEleMenu3";
}
class3MenuContent = class3MenuContent
+ "<li><p class='" + AEleMenu3Class + "'"
+ "MenuClass='3'"
+ "id='"+ class3MenuID + "'"
+ "MenuPage='"+ GetLeftMostPageID(class3MenuID) +"'"
+ "href='#" + class3MenuID + "'>"
+ class3MenuName
+ "</p></li>";
}
$("#class3MenuMainContent ul").html(class3MenuContent);
$("#class3MenuMainContent ul li p").click(function(){
var MenuOBJ = $(this);
if ( !checkDisClickAttr(MenuOBJ) )
{
return;
}
AjaxQuery_ClassMenuClick(MenuOBJ);
});
Menu3TabStyleHandle();
$(window).resize(function(){
Menu3TabStyleHandle();
});
$("#scrollRightBtn,#scrollLeftBtn").click(function () {
if ( ! $(this).hasClass("EnableScrollBtn"))
{
consoleLog("no scroll button!!");
return;
}
var scrollTarget = $("#class3MenuMainContent");
var tabWidth = $("#_totalTabWidth").val();
var srcollTotalLen = tabWidth - scrollTarget.width();
if ( $(this).attr("id") == "scrollLeftBtn" )
{
scrollTarget.scrollLeft(0);
}
else
{
scrollTarget.scrollLeft(srcollTotalLen);
}
var afterPosition = scrollTarget.scrollLeft();
StatusOfLRBtnOf3MenuHandle(afterPosition);
});
}
function Class2MenuShow(selectPageID, selectSupId, selectMidId)
{
if ( selectMidId == "" )
{
return;
}
var class1MenuNode = menuTreeObj.findMenu(selectSupId);
var class2MenuJSON = class1MenuNode.children;
var class2MenuContent = "";
var class2MenuClass = "";
for (var index in class2MenuJSON)
{
var menu = class2MenuJSON[index]
var class2MenuID = menu.id
var class2MenuName = menu.name
if ( class2MenuID == selectMidId )
{
class2MenuClass = "selectClass2Menu";
}
else
{
class2MenuClass = "";
}
class2MenuContent = class2MenuContent
+ "<li>"
+ "<a class='" + class2MenuClass + "' "
+ "href='javascript:void(0);' "
+ "MenuClass='2' "
+ "id='"+ class2MenuID + "' "
+ "MenuPage='"+ GetLeftMostPageID(class2MenuID)
+ "' title='" + class2MenuName
+ "'>"
+ class2MenuName
+ "</a></li>";
}
$("#class2MenuItem").html(class2MenuContent);
$("#class2MenuItem li a").click(function(){
var MenuOBJ = $(this);
if ( !checkDisClickAttr(MenuOBJ) )
{
return;
}
AjaxQuery_ClassMenuClick(MenuOBJ);
});
}
function Class1MenuShow(selectPageID, selectSupId)
{
var FirstMenuContent = "<ul>";
var SupClass = "";
var SupLiID = "";
var FirstOne = "yes";
var navBarWidth = $("#mainNavigator").width();
var leftPadWidth = $("#mn_first").width();
var rightPadWidth = $("#mn_last").width();
var menuAreaWidth = navBarWidth - leftPadWidth - rightPadWidth;
menuAreaWidth -= 7;
var menuWidth = menuAreaWidth/(menuTreeJSON.length);
menuWidth = Math.floor(menuWidth);
for (var index in menuTreeJSON)
{
var menu = menuTreeJSON[index]
var supId = menu.id
var supName = menu.name
if ( supId == selectSupId )
{
SupClass = "SelectMenuItem";
}
else
{
SupClass = "MenuItem";
}
if ( FirstOne == "yes" )
{
SupLiID = "homeLi";
FirstOne = "no";
}
else
{
SupLiID = "";
}
FirstMenuContent = FirstMenuContent
+ "<li id=\"" + SupLiID + "\">"
+ "<a href=\"javascript:void(0);\" class=\"" + SupClass
+ "\" "
+ "style='width:" + menuWidth + "px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;' "
+ "MenuClass='1' "
+ "id='"+ supId + "' "
+ "MenuPage='"+ GetLeftMostPageID(supId) +"'"
+ " title='" + supName +"'>"
+ supName
+ "</a></li>";
}
FirstMenuContent = FirstMenuContent + "</ul>";
$("#mn_li").html(FirstMenuContent);
$("#mn_li li a").click(function(){
var MenuOBJ = $(this);
if ( !checkDisClickAttr(MenuOBJ) )
{
return;
}
AjaxQuery_ClassMenuClick(MenuOBJ);
});
}
function checkDisClickAttr(obj)
{
if ("off" == obj.attr("EnableClick"))
{
return false;
}
handleDisClickAttr("off");
return true;
}
function handleDisClickAttr(ret)
{
var selectSupId = $("#_NowSupIdInfo",_MenuInfo).text();
var selectMidId = $("#_NowMidIdInfo",_MenuInfo).text();
var selectThdId = $("#_NowThdIdInfo",_MenuInfo).text();
if(selectThdId)
{
var objs = [$("#" + selectSupId),$("#" + selectMidId),$("#" + selectThdId)];
}
else
{
if(selectMidId)
{
var objs = [$("#" + selectSupId),$("#" + selectMidId)];
}
else
{
var objs = [$("#" + selectSupId)];
}
}
for (var i = 0; i < objs.length; i++)
{
if (objs[i].length > 0)
{
objs[i].attr("EnableClick", ret);
}
}
}
function AjaxPageGet(PageName, MenuClass)
{
var pageContainer = $("#commPageContainer");
pageContainer.succfunction = function(html){
pageContainer.html(html);
var _MenuInfo = $("#_MenuInfo");
var selectPageID = $("#_NextPageInfo",_MenuInfo).text();
var selectSupId = $("#_NowSupIdInfo",_MenuInfo).text();
var selectMidId = $("#_NowMidIdInfo",_MenuInfo).text();
var selectThdId = $("#_NowThdIdInfo",_MenuInfo).text();
if ( "mmHome" == selectPageID )
{
$(document).scrollTop(0);
return;
}
if (MenuClass == '1')
{
Class1MenuShow(selectPageID, selectSupId);
}
Class2MenuShow(selectPageID, selectSupId, selectMidId);
Class3MenuShow(selectPageID, selectSupId, selectMidId, selectThdId);
$(document).scrollTop(0);
handleDisClickAttr("on");
};
pageContainer.errorfunction = function(){
consoleLog("page get fail");
showWaitTip(false);
pageContainer.html("&?public_097;");
handleDisClickAttr("on");
};
showWaitTip(true);
pageContainer.dataTransfer( PageName, "GET", pageContainer.succfunction,
pageContainer.errorfunction, false,
undefined, 'html'
);
}
function AjaxQuery_ClassMenuClick(MenuOBJ)
{
var MenuClass = MenuOBJ.attr("MenuClass");
var page = MenuOBJ.attr("MenuPage");
var scrollTarget = $("#class3MenuMainContent");
var Menu3Location = scrollTarget.scrollLeft();
var pageFile = "/?_type=menuView&_tag="
+ page + "&Menu3Location=0";
if ( MenuClass == 3 )
{
pageFile = "/?_type=menuView&_tag="
+ page + "&Menu3Location=" + Menu3Location;
}
AjaxPageGet(pageFile, MenuClass);
}
function openLink(pageurl)
{
var PageName = "/?_type=menuView&_tag=" + pageurl;
AjaxPageGet(PageName, 1);
}
function MenuShow(Menuclass, selectPageID, selectSupId, selectMidId, selectThdId)
{
if (Menuclass == "ClassAll")
{
Class1MenuShow(selectPageID, selectSupId);
Class2MenuShow(selectPageID, selectSupId, selectMidId);
Class3MenuShow(selectPageID, selectSupId, selectMidId, selectThdId);
}
else if (Menuclass == "ClassOne")
{
Class1MenuShow(selectPageID, selectSupId);
}
else if (Menuclass == "ClassTwo")
{
Class2MenuShow(selectPageID, selectSupId);
}
else
{
consoleLog("[menu_api.lp][MenuShow]    Menuclass("+ Menuclass + "filling is not right!!");
}
}
function FakeClass1MenuShow()
{
var FirstMenuContent = "<ul>";
var SupClass = "MenuItem";
var SupLiID = "";
var FirstOne = "yes";
var navBarWidth = $("#mainNavigator").width();
var leftPadWidth = $("#mn_first").width();
var rightPadWidth = $("#mn_last").width();
var menuAreaWidth = navBarWidth - leftPadWidth - rightPadWidth;
menuAreaWidth -= 7;
var menuWidth = menuAreaWidth/(menuTreeJSON.length);
menuWidth = Math.floor(menuWidth);
for (var index in menuTreeJSON)
{
var menu = menuTreeJSON[index]
var supId = menu.id
var supName = menu.name
if ( FirstOne == "yes" )
{
SupLiID = "homeLi";
FirstOne = "no";
}
else
{
SupLiID = "";
}
FirstMenuContent = FirstMenuContent
+ "<li id=\"" + SupLiID + "\">"
+ "<a href=\"javascript:void(0);\" class=\"" + SupClass
+ "\" "
+ "style='width:" + menuWidth + "px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; "
+ "color:#BFBDBE; cursor:default;'"
+ " hidefocus=\"true\" onclick=\" \" title=\"" + supName + "\">"
+ supName
+ "</a></li>";
}
FirstMenuContent = FirstMenuContent + "</ul>";
$("#mn_li").html(FirstMenuContent);
}
