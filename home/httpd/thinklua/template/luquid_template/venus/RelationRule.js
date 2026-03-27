(function(window){
function GetComparedRule(typeRules, searchDom)
{
var comparedRule = null;
$.each(typeRules, function(index, onerule){
var event = onerule.event;
if ( event == "others" )
{
return true;
}
var isOK = true
$.each(event, function(ID, vals){
var masterid = ID;
var masterObj = $("[id^='"+masterid+"']", searchDom);
var masterVal = "";
if ( masterObj.is("div") )
{
masterVal = $("input[type=radio]:checked", masterObj).val();
}
else if ( masterObj.is("select") )
{
masterVal = masterObj.val();
}
else if ( masterObj.is("span") )
{
masterVal = masterObj.text();
}
else
{
consoleLog("masterObj type is not support yet! masterid="+masterid);
isOK = false;
return false;
}
var valmatched = false;
$.each(vals, function(k,v){
if ( masterVal == v )
{
valmatched = true;
return false;
}
});
if ( !valmatched )
{
isOK = false;
return false;
}
});
if ( isOK == true )
{
comparedRule = onerule;
return false;
}
});
return comparedRule;
}
function GetOthersEventRule(typeRules)
{
var comparedRule = null;
$.each(typeRules, function(index, onerule){
var event = onerule.event;
if ( event == "others" )
{
comparedRule = onerule;
return false;
}
});
return comparedRule;
}
function DoRightActionByRule(typeRules, subTemplate, DoTypeAction, upperEventType, NotComparedHandler)
{
var comparedRule = GetComparedRule(typeRules, subTemplate);
if ( comparedRule != null )
{
var actionJSON = comparedRule.action;
DoTypeAction(actionJSON, subTemplate, upperEventType);
}
else
{
var othersRule = GetOthersEventRule(typeRules);
if ( othersRule != null )
{
var actionJSON = othersRule.action;
DoTypeAction(actionJSON, subTemplate, upperEventType);
}
else if ( "function" == typeof(NotComparedHandler) )
{
NotComparedHandler(typeRules, subTemplate, upperEventType);
}
else
{
}
}
}
function DoSetOptionsAction(actionJSON, searchDom, upperEventType)
{
$.each(actionJSON, function(ID, options){
var slaveid = ID;
var slaveObj = $("[id^='"+slaveid+"']", searchDom);
if ( slaveObj.is("select") )
{
var oldVal = "";
if ( upperEventType == "fillDataByCustom" )
{
oldVal = slaveObj.val();
}
slaveObj.empty();
$.each(options, function(k,v){
var opstr = "<option id=\""+v.value+"\" value=\""+v.value+"\" title=\""+v.text+"\">"+v.text+"</option>";
slaveObj.append(opstr);
});
if ( upperEventType == "fillDataByCustom" )
{
SetSelectValue(slaveObj, oldVal);
}
slaveObj.change();
}
else
{
consoleLog("slaveObj("+slaveid+") type is not supported yet.");
}
});
}
function DoSetValueAction(actionJSON, searchDom, upperEventType)
{
if ( "fillDataByCustom" == upperEventType )
{
return;
}
$.each(actionJSON, function(ID, vals){
var slaveid = ID;
var slaveObj = $("[id^='"+slaveid+"']", searchDom);
if( slaveObj.is("input") )
{
switch (slaveObj.attr("type"))
{
case "text":
{
slaveObj.val(vals[0]);
break;
}
default:
{
break;
}
}
}
else if ( slaveObj.is("select") )
{
slaveObj.val(vals[0]);
slaveObj.change();
}
else
{
consoleLog("slaveObj("+slaveid+") type is not supported yet.");
}
});
}
function GetActionObjs_ByShowAttr(actionJSON, isShow, searchDom)
{
var selector = [];
$.each(actionJSON, function(domid, result){
if (result.show == isShow)
{
selector.push("[id^='"+domid+"']");
}
});
selector = selector.join(",");
return $(selector, searchDom);
}
function HideAllSlavesRecursively(masterObj, subTemplate)
{
var events = masterObj.data("events");
var slaveIDs = masterObj.data("slaveIDsCache");
if( events && events["change"] && slaveIDs )
{
var slaveIDSelector = [];
$.each(slaveIDs, function(index, ID){
slaveIDSelector.push("[id^='"+ID+"']");
});
var slaveIDSelector = slaveIDSelector.join(",");
slaveObjs = $(slaveIDSelector, subTemplate);
HideSlaveObjs(slaveObjs);
}
}
function ShowOrHideRowDiv_HideComponet(action, rowDiv)
{
var subWidget = rowDiv.find("*[id!='']")
if ( action == "show" )
{
rowDiv.showIt(true);
subWidget.each(function(){
var widget = $(this);
if ( widget.hasClass("ControlByHideRule") )
{
widget.removeClass("PostIgnore");
}
});
}
else
{
rowDiv.showIt(false);
subWidget.each(function(){
var widget = $(this);
if ( widget.hasClass("PostIgnore") )
{
}
else
{
widget.addClass("ControlByHideRule");
widget.addClass("PostIgnore");
}
});
}
}
function ShowSlaveObjs(slaveObjs)
{
var slaveWrappers = slaveObjs.parents(".ControlWrapper");
ShowOrHideRowDiv_HideComponet("show", slaveWrappers);
slaveObjs.change();
}
function HideSlaveObjs(slaveObjs)
{
var subTemplate = slaveObjs.eq(0).parents("[id^='template_']");
var slaveWrappers = slaveObjs.parents(".ControlWrapper");
ShowOrHideRowDiv_HideComponet("hide", slaveWrappers);
slaveObjs.each(function(){
var slaveObj = $(this);
HideAllSlavesRecursively(slaveObj, subTemplate);
});
}
function DoDisplayAction(actionJSON, subTemplate, upperEventType)
{
var slaveObjs = GetActionObjs_ByShowAttr(actionJSON, true, subTemplate);
ShowSlaveObjs(slaveObjs);
var slaveObjs = GetActionObjs_ByShowAttr(actionJSON, false, subTemplate);
HideSlaveObjs(slaveObjs);
}
function DoDisplayAction_Reversely(actionJSON, subTemplate, upperEventType)
{
var slaveObjs = GetActionObjs_ByShowAttr(actionJSON, true, subTemplate);
HideSlaveObjs(slaveObjs);
var slaveObjs = GetActionObjs_ByShowAttr(actionJSON, false, subTemplate);
ShowSlaveObjs(slaveObjs);
}
function NotComparedHandler_DisplayRule(displayRuleJSON, subTemplate, upperEventType)
{
if ( displayRuleJSON.length == 1 )
{
var actionJSON = displayRuleJSON[0].action;
DoDisplayAction_Reversely(actionJSON, subTemplate, upperEventType);
}
}
function TriggerMasterSlaveRelation(masterIDs, template, upperEventType)
{
$.each(masterIDs, function(index, ID){
var masterid = ID;
var masterObj = $("[id^='"+masterid+"']", template);
masterObj.trigger("change", [upperEventType]);
return false;
});
}
function BindMasterSlaveRelation(masterIDs, ruleCollection, template)
{
var masterSelector = [];
$.each(masterIDs, function(index, ID){
masterSelector.push("[id^='"+ID+"']");
});
var masterSelector = masterSelector.join(",");
masterObjs = $(masterSelector, template);
var slaveIDs = ruleCollection.display.slaveIDs
masterObjs.each(function(){
var masterObj = $(this);
var slaveIDsCache = masterObj.data("slaveIDsCache");
if (!slaveIDsCache)
{
masterObj.data("slaveIDsCache", slaveIDs);
}
else
{
consoleLog(" masterObj with id("+masterObj.attr("id")+") must not participate two display rule.");
}
});
var eventData = {"ruleCollection":ruleCollection};
masterObjs.bind("change", eventData, function(event, upperEventType){
var subTemplate = $(this).parents("[id^='template_']");
var setOptionsRuleJSON = event.data.ruleCollection.setOptions.rules;
DoRightActionByRule(setOptionsRuleJSON, subTemplate, DoSetOptionsAction, upperEventType);
var setValueJSON = event.data.ruleCollection.setValue.rules;
DoRightActionByRule(setValueJSON, subTemplate, DoSetValueAction, upperEventType);
var displayRuleJSON = event.data.ruleCollection.display.rules;
DoRightActionByRule(displayRuleJSON, subTemplate, DoDisplayAction, upperEventType, NotComparedHandler_DisplayRule);
});
}
window.BindMasterSlaveRelation = BindMasterSlaveRelation;
window.TriggerMasterSlaveRelation = TriggerMasterSlaveRelation;
})(window);
