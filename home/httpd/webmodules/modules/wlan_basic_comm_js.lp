function checkInst(inst,template){
if(inst == "")
{
return true;
}
if($("[id^='_InstID:']",template).val() == inst)
{
return true;
}
return false;
}
function g_CtrlWlanBasicAdConf(template){
var ctrlStr = "";
if(ssidConf.WlanBasicAdConf != undefined)
{
ctrlStr = ssidConf.WlanBasicAdConf;
}
if(ctrlStr == "")
{
return;
}
var ruleList = ctrlStr.split("+");
for(i in ruleList) {
var rule = ruleList[i].split(":");
if(checkInst(rule[1],template) == false){
continue;
}
if(rule[0] == "all"){
disable_all_templte(template);
if(rule[2] == "hideBtn"){
$("div.buttongroup",template).find(":button").showIt(false);
}
}
else{
singleElementCtrl4Multi(rule,template);
}
}
}
