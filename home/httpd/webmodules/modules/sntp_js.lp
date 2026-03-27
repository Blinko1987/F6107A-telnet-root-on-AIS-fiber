<script type="text/javascript">
(function(){
function custom_control(template)
{
var TimeValue = $('#CurrentLocalTime', template).val();
var custobj = $('#CCurrentLocalTime', template);
var prmissionValue = $('#NtpConfigPermission', template).val();
var sntpPrmission = prmissionValue & 12;
var serverPrmission = prmissionValue & 3;
var sntpobj = $('#LocalTimeZoneandName', template);
var serverobj1 = $('#NtpServer1', template);
var serverobj2 = $('#NtpServer2', template);
var serverobj3 = $('#NtpServer3', template);
var serverobj4 = $('#NtpServer4', template);
var serverobj5 = $('#NtpServer5', template);
if(sntpPrmission != 0)
{
sntpobj.attr("disabled","disabled");
}
else
{
sntpobj.disableIt(false);
}
if(serverPrmission != 0)
{
serverobj1.attr("disabled","disabled");
serverobj2.attr("disabled","disabled");
serverobj3.attr("disabled","disabled");
serverobj4.attr("disabled","disabled");
serverobj5.attr("disabled","disabled");
}
else
{
serverobj1.disableIt(false);
serverobj2.disableIt(false);
serverobj3.disableIt(false);
serverobj4.disableIt(false);
serverobj5.disableIt(false);
}
custobj.text(TimeValue);
if ( TimeValue != "")
{
var SecTimeLocation = TimeValue.lastIndexOf(":");
currTimeNotSec = TimeValue.substring(0, SecTimeLocation);
$("#_DevCurrTime").text(currTimeNotSec);
$.publish("/some/SNTPModify", [template]);
}
var custobj = $('#Dscp', template);
if ("-1" == custobj.val())
{
custobj.val("");
}
time_zone();
var objltz = $('#LocalTimeZoneandName',template);
var value = objltz.val();
control_daylight(value);
if (!isDaylightSavingsUsed(value))
{
var objtmp = $('#DaylightSavingsUsed0', template);
objtmp.prop('checked', true);
}
var data = {};
data.template = template;
$.callModifier("LocalSntp/disableParams", data);
}
function initial_template(templateID)
{
var template = $("#"+templateID);
template.bind("hiddenValueChangeByCustom", function(event,template){
var obj = $('#ZoneIndex');
obj.val($('#LocalTimeZoneandName').val());
$('#AutoSetTzname').val("1");
});
var instForm = template.find("form");
instForm.validate({
"rules": {
"NtpServer1": {
"rangelength": [0,64]
},
"NtpServer2": {
"rangelength": [0,64]
},
"NtpServer3": {
"rangelength": [0,64]
},
"NtpServer4": {
"rangelength": [0,64]
},
"NtpServer5": {
"rangelength": [0,64]
},
"PollTimeInterval": {
"required":true,
"integer": true,
"range":[3600,86400]
},
"Dscp": {
"required":false,
"integer": true,
"range":[0,63]
}
},
"messages": {
}
});
template.bind("fillDataByApplyResult", function(event,xml, template){
if ( ActionByApplyResult(xml, template) == 0 )
{
var OBJID = ["OBJ_SNTP_ID"];
template.fillDataByOBJID(xml ,OBJID, template, 0);
custom_control(template);
}
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_SNTP_ID"];
ActionByCancelResult(xml, template, OBJID);
custom_control(template);
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
var prefixNameValue = {
"Dscp" : ""
};
if ( prefixNameValue[ElemsMainID] == ElemsValue)
{
NameValueJson.ElemsValue = "-1";
}
});
var obj = $('#LocalTimeZoneandName',template);
obj.change(function(event){
var TypeOBJ = $(this);
var value = TypeOBJ.val();
control_daylight(value);
});
}
var timeZoneArrayOriginal =
[
[ "TZ_ENEWETAK_KWAJALEIN", 0, false, "+12:00", "&?SNTP_010;", "Kwajalein" ],
[ "TZ_MIDWAY_ISLAND", 1, false, "-11:00", "&?SNTP_011;", "Midway Island, Samoa" ],
[ "TZ_HAWAII", 2, false, "-10:00", "&?SNTP_012;", "Hawaii" ],
[ "TZ_ALASKA", 3, true, "-09:00", "&?SNTP_013;", "Alaska,Anchorage" ],
[ "TZ_PACIFIC", 4, true, "-08:00", "&?SNTP_014;", "Pacific Time (US, Canada), Tijuana" ],
[ "TZ_ARIZONA", 5, false, "-07:00", "&?SNTP_015;", "Arizona, Mountain Time (US)" ],
[ "TZ_CENTRAL_AMERICA", 6, true, "-06:00", "&?SNTP_016;", "Central America, Central Canada" ],
[ "TZ_EST", 7, true, "-05:00", "&?SNTP_017;", "Eastern Time (US, Canada), Indiana" ],
[ "TZ_ATLANTIC", 8, true, "-04:00", "&?SNTP_018;", "Atlantic Time (Canada)" ],
[ "TZ_NEWFOUNDLAND", 9, true, "-03:30", "&?SNTP_019;", "Newfoundland" ],
[ "TZ_BRASILIA", 10, true, "-03:00", "&?SNTP_020;", "Brasilia" ],
[ "TZ_MID_ATLANTIC", 11, true, "-02:00", "&?SNTP_021;", "Mid-Atlantic" ],
[ "TZ_AZORES", 12, true, "-01:00", "&?SNTP_022;", "Azores" ],
[ "TZ_CASABLANCA", 13, true, "+00:00", "&?SNTP_023;", "Casablanca" ],
[ "TZ_AMSTERDAM", 14, true, "+01:00", "&?SNTP_024;", "Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna" ],
[ "TZ_BAGHDAD", 15, false, "+03:00", "&?SNTP_026;", "Baghdad" ],
[ "TZ_TEHRAN", 16, true, "+03:30", "&?SNTP_027;", "Tehran" ],
[ "TZ_ABU_DHABI", 17, false, "+04:00", "&?SNTP_028;", "Abu Dhabi, Muscat, Tbilisi" ],
[ "TZ_KABUL", 18, false, "+04:30", "&?SNTP_029;", "Kabul" ],
[ "TZ_EKATERINBURG", 19, false, "+05:00", "&?SNTP_030;", "Ekaterinburg" ],
[ "TZ_CALCUTTA", 20, false, "+05:30", "&?SNTP_031;", "Calcutta, Mumbai, New Delhi, Madras, Sri Jayawardenepura" ],
[ "TZ_KATHMANDU", 21, false, "+05:45", "&?SNTP_032;", "Kathmandu" ],
[ "TZ_ALMATY", 22, false, "+06:00", "&?SNTP_033;", "Almaty" ],
[ "TZ_RANGOON", 23, false, "+06:30", "&?SNTP_034;", "Rangoon" ],
[ "TZ_BANGKOK", 24, false, "+07:00", "&?SNTP_035;", "Bangkok, Hanoi" ],
[ "TZ_BEIJING", 25, false, "+08:00", "&?SNTP_036;", "Beijing, Chongqing, Hong Kong, Urumqi" ],
[ "TZ_TOKYO", 26, false, "+09:00", "&?SNTP_037;", "Osaka, Sapporo, Tokyo" ],
[ "TZ_ADELAIDE", 27, true, "+09:30", "&?SNTP_038;", "Adelaide" ],
[ "TZ_BRISBANE", 28, false, "+10:00", "&?SNTP_039;", "Brisbane" ],
[ "TZ_MAGADAN", 29, false, "+11:00", "&?SNTP_040;", "Magadan, Solamon" ],
[ "TZ_AUCKLAND", 30, true, "+12:00", "&?SNTP_041;", "Auckland, Wellington" ],
[ "TZ_NUKUALOFA", 31, false, "+13:00", "&?SNTP_042;", "Nukualofa" ],
[ "TZ_MOUNTAIN", 32, true, "-07:00", "&?SNTP_043;", "Mountain Standard Time(US, Canada)" ],
[ "TZ_CHIHUAHAR", 33, true, "-07:00", "&?SNTP_044;", "Chihuahau, La Paz,Mazatlan" ],
[ "TZ_CENTRAL_TIME", 34, true, "-06:00", "&?SNTP_045;", "Central Time (US, Canada)" ],
[ "TZ_GUADALAJARA", 35, true, "-06:00", "&?SNTP_046;", "Guadalajara, Mexico City, Monterrey" ],
[ "TZ_BOGOTA", 36, false, "-05:00", "&?SNTP_047;", "Bogota" ],
[ "TZ_CARACAS", 37, false, "-04:30", "&?SNTP_048;", "Caracas" ],
[ "TZ_SANTIAGO", 38, true, "-04:00", "&?SNTP_049;", "Santiago" ],
[ "TZ_BUENOS", 39, false, "-03:00", "&?SNTP_050;", "Buenos Aires" ],
[ "TZ_GREENLAND", 40, true, "-03:00", "&?SNTP_051;", "Greenland" ],
[ "TZ_CAPE", 41, false, "-01:00", "&?SNTP_052;", "Cape Verde Islands" ],
[ "TZ_GREENWICH", 42, true, "+00:00", "&?SNTP_053;", "Greenwich Mean Time: Dublin" ],
[ "TZ_BELGRADE", 43, true, "+01:00", "&?SNTP_054;", "Belgrade, Bratislava, Budapest, Ljubljana" ],
[ "TZ_SARAJEVO", 44, true, "+01:00", "&?SNTP_055;", "Sarajevo, Skopje, Warsaw, Zagreb" ],
[ "TZ_W_CENTRAL_AFRICA", 45, false, "+01:00", "&?SNTP_056;", "W.Central Africa" ],
[ "TZ_BRUSSEL", 46, true, "+01:00", "&?SNTP_057;", "Brussel, Copenhagen, Madrid, Paris" ],
[ "TZ_HARARE", 47, false, "+02:00", "&?SNTP_058;", "Harare" ],
[ "TZ_HELSINKI", 48, true, "+02:00", "&?SNTP_059;", "Helsinki, kiev, Riga, Sofia, Tallinn, Vilnius, Athens, Bucharest" ],
[ "TZ_MINSK", 49, false, "+03:00", "&?SNTP_060;", "Minsk" ],
[ "TZ_KUWAIT", 50, false, "+03:00", "&?SNTP_061;", "Kuwait, Riyadh, Nairobi" ],
[ "TZ_MOSCOW", 51, false, "+03:00", "&?SNTP_062;", "Moscow, Volgograd" ],
[ "TZ_BAKU", 52, true, "+04:00", "&?SNTP_063;", "Baku" ],
[ "TZ_ISLAMABAD", 53, false, "+05:00", "&?SNTP_064;", "Islamabad, Karachi" ],
[ "TZ_ASTANA", 54, false, "+06:00", "&?SNTP_065;", "Astana" ],
[ "TZ_KRASNOYARSK", 55, false, "+07:00", "&?SNTP_066;", "Krasnoyarsk" ],
[ "TZ_YAKUTSK", 56, false, "+09:00", "&?SNTP_068;", "Yakutsk" ],
[ "TZ_DARWIN", 57, false, "+09:30", "&?SNTP_069;", "Darwin" ],
[ "TZ_CANBERRA", 58, true, "+10:00", "&?SNTP_070;", "Canberra, Melbourne, Sydney,Hobart" ],
[ "TZ_VLADIVOSTOK", 59, false, "+10:00", "&?SNTP_072;", "Vladivostok" ],
[ "TZ_FIJI", 60, true, "+12:00", "&?SNTP_073;", "Fiji, Kamchatka" ],
[ "TZ_MONROVIA", 61, false, "+00:00", "&?SNTP_075;", "Monrovia"],
[ "TZ_JERUSALEM", 62, true, "+02:00", "&?SNTP_076;", "Jerusalem"],
[ "TZ_ISTANBUL", 63, false, "+03:00", "&?SNTP_077;", "Istanbul"],
[ "TZ_ABU_YEREVAN", 64, false, "+04:00", "&?SNTP_078;", "Yerevan"],
[ "TZ_NOVOSIBIRSK", 65, false, "+06:00", "&?SNTP_080;", "Novosibirsk"],
[ "TZ_JAKARTA", 66, false, "+07:00", "&?SNTP_081;", "Jakarta"],
[ "TZ_IRKUTSK", 67, false, "+08:00", "&?SNTP_082;", "Irkutsk"],
[ "TZ_SEOUL", 68, false, "+09:00", "&?SNTP_083;", "Seoul"],
[ "TZ_PORT_MORESBY", 69, false, "+10:00", "&?SNTP_084;", "Port Moresby"],
[ "TZ_GUAM", 70, false, "+10:00", "&?SNTP_085;", "Guam"],
[ "TZ_NEW_CALEDONIA", 71, false, "+11:00", "&?SNTP_086;", "New Caledonia"],
[ "TZ_QUITO", 72, false, "-05:00", "&?SNTP_087;", "Quito"],
[ "TZ_LIMA", 73, false, "-05:00", "&?SNTP_088;", "Lima"],
[ "TZ_LA_PAZ", 74, false, "-04:00", "&?SNTP_089;", "La Paz"],
[ "TZ_ST_PETERSBURG", 75, false, "+03:00", "&?SNTP_090;", "St.Petersburg"],
[ "TZ_GEORGETOWN", 76, false, "-04:00", "&?SNTP_091;", "Georgetown"],
[ "TZ_EDINBURGH", 77, true, "+00:00", "&?SNTP_092;", "Edinburgh,London"],
[ "TZ_PRETORIA", 78, false, "+02:00", "&?SNTP_093;", "Pretoria"],
[ "TZ_TASHKENT", 79, false, "+05:00", "&?SNTP_094;", "Tashkent"],
[ "TZ_DHAKA", 80, false, "+06:00", "&?SNTP_095;", "Dhaka"],
[ "TZ_MARSHALL_IS", 81, false, "+12:00", "&?SNTP_096;", "Marshall Is."],
[ "TZ_CAIRO", 82, true, "+02:00", "&?SNTP_097;", "Cairo"],
[ "TZ_MONTEVIDEO", 83, false, "-03:00", "&?SNTP_118;", "Montevideo" ],
[ "TZ_KALININGRAD", 84, false, "+02:00", "&?SNTP_120;", "Kaliningrad" ],
[ "TZ_SINGAPORE,", 85, false, "+08:00", "&?SNTP_121;", "Singapore, Kuala Lumpur" ]
];
<%
function TimeZoneIndexOutput()
local SNTPTbl = cmapi.getinst("OBJ_SNTP_ID", "")
local TimeZoneIndex = SNTPTbl.TimeZoneIndex
if not TimeZoneIndex then
TimeZoneIndex = ""
end
cgilua.put(TimeZoneIndex)
end
%>
var TimeZoneFilterStr = "<%_G.encodeJS(TimeZoneIndexOutput())%>";
var TimeZoneFilter = TimeZoneFilterStr.split(',');
var timeZoneArray = new Array;
function isDaylightSavingsUsed(timeZoneIndex)
{
for ( var i=0; i<timeZoneArray.length; i++ )
{
var moduleIndex = timeZoneArray[i][1];
if ( moduleIndex == timeZoneIndex )
{
return timeZoneArray[i][2];
}
}
return false;
}
function timeZoneArrayOrderFunc(ab, ac)
{
var abtime = ab[3];
var actime = ac[3];
abtime = abtime.replace(":", ".");
actime = actime.replace(":", ".");
abtime = parseFloat(abtime);
actime = parseFloat(actime);
if ( abtime - actime < 0 )
{
return -1;
}
else if ( abtime - actime > 0 )
{
return 1;
}
else
{
if ( ab[2] - ac[2] < 0 )
{
return -1;
}
else if ( ab[2] - ac[2] > 0 )
{
return 1;
}
else
{
return 0;
}
}
}
function control_daylight(value)
{
var objdiv = $('#Prefix_DaylightSavingsUsed');
var objtmp0 = $('#DaylightSavingsUsed0');
var objtmp1 = $('#DaylightSavingsUsed1');
if (!isDaylightSavingsUsed(value))
{
objdiv.hide();
objtmp0.addClass('PostIgnore');
objtmp1.addClass('PostIgnore');
}
else
{
objdiv.show();
objtmp0.removeClass("PostIgnore");
objtmp1.removeClass("PostIgnore");
}
}
function CreateTimeZoneOption()
{
var obj = $('#LocalTimeZoneandName');
timeZoneArray.sort( timeZoneArrayOrderFunc );
for ( var i=0; i<timeZoneArray.length; i++ )
{
var timeZoneTxt = "";
if ( "+00:00" == timeZoneArray[i][3] )
{
timeZoneTxt = "(&?public_120;) ";
}
else
{
timeZoneTxt = "(&?public_120;" + timeZoneArray[i][3] + ") ";
}
timeZoneTxt += timeZoneArray[i][4];
var strtemp = "<option value= '" + timeZoneArray[i][1]
+ "' title='"+ timeZoneTxt + "'>" + timeZoneTxt + '</option>';
obj.append(strtemp);
}
}
function time_zone()
{
var obj = $('#LocalTimeZoneandName');
var value = $('#ZoneIndex').val();
obj.val(value);
}
$(document).ready(function(){
var HeadID = "LocalSntp";
var Head = $("#"+HeadID);
var ServerAddr = $("address span", Head).text();
initial_template("template_"+HeadID);
var data = {};
data.timeZoneArray = timeZoneArrayOriginal;
$.callModifier("LocalSntp/chgTimeZone",data);
timeZoneArray = $.grep(data.timeZoneArray, function(val,key){
for( var i=0; i<TimeZoneFilter.length; i++ )
{
if (TimeZoneFilter[i] == val[1])
{
return true;
}
}
return false;
});
CreateTimeZoneOption();
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var OBJ = $(xml).find("OBJ_SNTP_ID");
var tempobj = $("#template_LocalSntp");
var OBJID = ["OBJ_SNTP_ID"];
Head.fillDataByOBJID(xml, OBJID, tempobj, 0);
custom_control(tempobj);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
});
})();
</script>
