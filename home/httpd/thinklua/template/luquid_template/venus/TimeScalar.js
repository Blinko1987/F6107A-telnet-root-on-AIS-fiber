(function(window){
function InitScalarTimeEvent(timeObj, range)
{
timeObj.on("change", "[id^='Day:']", function(event){
var day = $(this).val();
var maxDay = Math.floor(range.max / 86400);
var maxDayRemain = range.max % 86400;
var maxHour = Math.floor(maxDayRemain / 3600);
var minDay = Math.floor(range.min / 86400);
var minDayRemain = range.min % 86400;
var minHour = Math.floor(minDayRemain / 3600);
var timeObj = $(this).parent();
var hourObj = timeObj.find("[id^='Hour:']");
if ( minDay == maxDay )
{
InitSelectByIntRange(hourObj, minHour, maxHour);
$(this).data("cursor", "MinMax");
}
else if ( day > minDay && day < maxDay )
{
InitSelectByIntRange(hourObj, 0, 23);
$(this).data("cursor", "Middle");
}
else if ( day == maxDay )
{
InitSelectByIntRange(hourObj, 0, maxHour);
$(this).data("cursor", "Max");
}
else if ( day == minDay )
{
InitSelectByIntRange(hourObj, minHour, 23);
$(this).data("cursor", "Min");
}
else
{
}
hourObj.change();
event.stopPropagation();
});
timeObj.on("change", "[id^='Hour:']", function(event){
var hour = $(this).val();
var maxDayRemain = range.max % 86400;
var maxHour = Math.floor(maxDayRemain / 3600);
var maxHourRemain = range.max % 3600;
var maxMinute = Math.floor(maxHourRemain / 60);
var minDayRemain = range.min % 86400;
var minHour = Math.floor(minDayRemain / 3600);
var minHourRemain = range.min % 3600;
var minMinute = Math.floor(minHourRemain / 60);
var timeObj = $(this).parent();
var dayObj = timeObj.find("[id^='Day:']");
var minuteObj = timeObj.find("[id^='Minute:']");
if ( dayObj.data("cursor") == "MinMax"
&& minHour == maxHour )
{
InitSelectByIntRange(minuteObj, minMinute, maxMinute);
$(this).data("cursor", "MinMax");
}
else if ( (dayObj.data("cursor") == "Max"
|| dayObj.data("cursor") == "MinMax" )
&& hour == maxHour )
{
InitSelectByIntRange(minuteObj, 0, maxMinute);
$(this).data("cursor", "Max");
}
else if ( (dayObj.data("cursor") == "Min"
|| dayObj.data("cursor") == "MinMax" )
&& hour == minHour )
{
InitSelectByIntRange(minuteObj, minMinute, 59);
$(this).data("cursor", "Min");
}
else
{
InitSelectByIntRange(minuteObj, 0, 59);
$(this).data("cursor", "Middle");
}
minuteObj.change();
event.stopPropagation();
});
timeObj.on("change", "[id^='Minute:']", function(event){
var minute = $(this).val();
var maxHourRemain = range.max % 3600;
var maxMinute = Math.floor(maxHourRemain / 60);
var maxMinuteRemain = range.max % 60;
var maxSecond = Math.floor(maxMinuteRemain / 1);
var minHourRemain = range.min % 3600;
var minMinute = Math.floor(minHourRemain / 60);
var minMinuteRemain = range.min % 60;
var minSecond = Math.floor(minMinuteRemain / 1);
var timeObj = $(this).parent();
var dayObj = timeObj.find("[id^='Day:']");
var hourObj = timeObj.find("[id^='Hour:']");
var secondObj = timeObj.find("[id^='Second:']");
if ( dayObj.data("cursor") == "MinMax"
&& hourObj.data("cursor") == "MinMax"
&& minMinute == maxMinute )
{
InitSelectByIntRange(secondObj, minSecond, maxSecond);
}
else if ( (dayObj.data("cursor") == "Max"
|| dayObj.data("cursor") == "MinMax" )
&& ( hourObj.data("cursor") == "Max"
|| hourObj.data("cursor") == "MinMax" )
&& minute == maxMinute )
{
InitSelectByIntRange(secondObj, 0, maxSecond);
}
else if ( (dayObj.data("cursor") == "Min"
|| dayObj.data("cursor") == "MinMax" )
&& ( hourObj.data("cursor") == "Min"
|| hourObj.data("cursor") == "MinMax" )
&& minute == minMinute )
{
InitSelectByIntRange(secondObj, minSecond, 59);
}
else
{
InitSelectByIntRange(secondObj, 0, 59);
}
event.stopPropagation();
});
timeObj.on("showTimeControlValue", function(){
var timeObj = $(this);
var timeParent = $(this).parent();
var dataID = timeObj.attr("dataID");
var hiddenValObj = timeParent.find("[id^='"+dataID+"']");
var dayObj = timeObj.find("[id^='Day:']");
var hourObj = timeObj.find("[id^='Hour:']");
var minuteObj = timeObj.find("[id^='Minute:']");
var secondObj = timeObj.find("[id^='Second:']");
var originVal = hiddenValObj.val();
var amplifier = timeObj.data("amplifier");
var second = originVal * amplifier;
var dhmsJson = Second2DHMS(second);
dayObj.val(dhmsJson.day);
dayObj.change();
hourObj.val(dhmsJson.hour);
hourObj.change();
minuteObj.val(dhmsJson.minute);
minuteObj.change();
secondObj.val(dhmsJson.second);
});
timeObj.on("setTimeHiddenValue", function(){
var timeObj = $(this);
var timeRow = $(this).parents(".row:first");
var dataID = timeObj.attr("dataID");
var hiddenValObj = timeRow.find("[id^='"+dataID+"']");
var dayObj = timeObj.find("[id^='Day:']");
var hourObj = timeObj.find("[id^='Hour:']");
var minuteObj = timeObj.find("[id^='Minute:']");
var secondObj = timeObj.find("[id^='Second:']");
var d = dayObj.val();
var h = hourObj.val();
var m = minuteObj.val();
var s = secondObj.val();
var pureSec = d * 86400
+ h * 3600
+ m * 60
+ s * 1;
var amplifier = timeObj.data("amplifier");
var transVal = Math.floor(pureSec / amplifier);
hiddenValObj.val(transVal);
});
}
function HandleUnitEffect(range, timeObj, controlID)
{
range.unit = range.unit || "Second";
var rangeMap = {
"Day":{amplifier:86400, lowCtl:["Hour", "Minute", "Second"]},
"Hour":{amplifier:3600, lowCtl:["Minute", "Second"]},
"Minute":{amplifier:60, lowCtl:["Second"]},
"Second":{amplifier:1, lowCtl:[]}
};
var map = rangeMap[range.unit];
var amplifier = map.amplifier;
var lowCtl = map.lowCtl;
timeObj.data("amplifier", amplifier);
range.min = range.min * amplifier;
range.max = range.max * amplifier;
for ( var i=0; i<lowCtl.length; i++ )
{
var id = lowCtl[i];
$("[id='"+id+":"+controlID+"']").hide();
$("label[for='"+id+":"+controlID+"']").hide();
}
}
function InitTimeScalarTemplate(template, controlID, range)
{
var timeSelector = "[id='"+controlID+"']";
var timeObj = $(timeSelector, template);
InitScalarTimeEvent(timeObj, range);
HandleUnitEffect(range, timeObj, controlID);
var minDay = Math.floor(range.min / 86400);
var maxDay = Math.floor(range.max / 86400);
var dayObj = $("[id='Day:"+controlID+"']", template);
var hourObj = $("[id='Hour:"+controlID+"']", template);
var minuteObj = $("[id='Minute:"+controlID+"']", template);
InitSelectByIntRange(dayObj, minDay, maxDay);
dayObj.change();
var maxDay = Math.floor(range.max / 86400);
if ( maxDay == 0 )
{
dayObj.hide();
$("label[for='Day:"+controlID+"']").hide();
var maxHour = Math.floor(range.max / 3600);
if ( maxHour == 0 )
{
hourObj.hide();
$("label[for='Hour:"+controlID+"']").hide();
var maxMinute = Math.floor(range.max / 60);
if ( maxMinute == 0 )
{
minuteObj.hide();
$("label[for='Minute:"+controlID+"']").hide();
}
}
}
else if( maxDay > 99 )
{
dayObj.removeClass("w45").addClass("w70");
}
else
{
}
}
window.InitTimeScalarTemplate = InitTimeScalarTemplate;
})(window);
