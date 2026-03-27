$.validator.setDefaults({
errorPlacement: function (error, element) {
var tipHTML = "<div class=\"errorLabelWraper\"></div>";
var tipObj = $(tipHTML);
error.appendTo(tipObj);
var rowObj = element.closest(".row");
if ( rowObj.length == 0 )
{
consoleLog("element id=["+element.attr("id")+"] is not in row div.");
return ;
}
var rowWidth = rowObj.width();
var usedWidth = 0;
var rightObj = undefined;
rowObj.children().each(function(){
if (!($(this).hasClass("_LuQUID_AccessDeviceList")||
$(this).hasClass("clear"))){
usedWidth += $(this).outerWidth(true);
}
if ($(this).hasClass("right")){
rightObj = $(this);
}
});
var errWidth = rowWidth - usedWidth;
var widthtmp = errWidth-5-23-10;
if(widthtmp < 1)
{
tipObj.removeAttr("style","");
}
else
{
tipObj.width(widthtmp);
}
if (rightObj != undefined)
{
tipObj.insertAfter(rightObj);
}
else
{
tipObj.appendTo(rowObj);
}
}
});
jQuery.extend(jQuery.validator.messages, {
required: "&?public_error001;",
remote: "&?public_error002;",
email: "&?public_error003;",
url: "&?public_error004;",
date: "&?public_error005;",
dateISO: "&?public_error006;",
number: "&?public_error007;",
digits: "&?public_error024;",
creditcard: "&?public_error009;",
equalTo: "&?public_error010;",
maxlength: jQuery.validator.format("&?public_error011;"),
minlength: jQuery.validator.format("&?public_error012;"),
rangelength: jQuery.validator.format("&?public_error013;"),
range: jQuery.validator.format("&?public_error014;"),
max: jQuery.validator.format("&?public_error015;"),
min: jQuery.validator.format("&?public_error016;")
});
function AsciiPasswordCheck(Key)
{
for (var j = 0 ;j < Key.length; j++)
{
var ch = Key.charCodeAt(j);
if(ch == 9)
{
return false;
}
}
return true;
}
function AsciiCheck(Key)
{
for (var j = 0 ;j < Key.length; j++)
{
var ch = Key.charCodeAt(j);
if(ch<32 || ch>126)
{
return false;
}
}
return true;
}
function AsciiCheckWithLen(Key, LenLimit)
{
if (Key.length != LenLimit)
{
return false;
}
if ( false == AsciiCheck(Key) )
{
return false;
}
return true;
}
function HexCheck(Key)
{
for (var j = 0 ;j < Key.length; j++)
{
var ch = Key.charCodeAt(j);
if (!((ch >= 65 && ch <= 70)
||(ch >= 97 && ch <= 102)
||(ch >= 48 && ch <= 57)))
{
return false;
}
}
return true;
}
function HexCheckWithLen(Key, LenLimit)
{
if (Key.length != LenLimit)
{
return false;
}
if ( false == HexCheck(Key) )
{
return false;
}
return true;
}
function checkDomain(value)
{
var len = value.length;
var firstChar = value.substr(0,1);
var lastChar = value.substr(len-1,1);
var maxlen = 64;
if(len>64||len<1)
{
return false;
}
if (value.match("[^0-9a-zA-Z.-]") != null)
{
return false;
}
if(firstChar.match("[^0-9a-zA-Z]") != null)
{
return false;
}
if(lastChar.match("[^0-9a-zA-Z]") != null)
{
return false;
}
var pos = value.lastIndexOf(".");
if(pos == -1)
{
var str = value;
var templen = value.length;
for(var i=0;i<len;i++)
{
var tempvalue = str.substring(i,i+1);
if(isNaN(parseInt(tempvalue)))
{
return true;
}
}
return false;
}
else
{
var str = value.substr(pos+1);
var tmplen = value.length - (pos + 1);
for(var i=0;i<tmplen;i++)
{
var tmpvalue = str.substring(i,i+1);
if(isNaN(parseInt(tmpvalue)))
{
return true;
}
}
return false;
}
}
function checkIPv4Addr(ipaddr)
{
var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
if(re.test(ipaddr) == true)
{
var parts = ipaddr.split(".");
for(var i=0; i<parts.length; i++)
{
if(parts[i].indexOf("0") == 0 && parts[i].length > 1)
return false;
if (parseInt((parts[i]),10) > 255 || parseInt((parts[i]),10) < 0)
{
return false;
}
}
return true;
}
return false;
}
function checkIPv6Addr(ipaddr)
{
if (ipaddr.match("[^0-9a-fA-F:.]") != null)
return false;
var addrParts = ipaddr.split(':');
var Doublecolon = ipaddr.split('::');
var ipv4Parts = ipaddr.split('.');
if(addrParts.length<3||addrParts.length>8)
{
return false;
}
else if(Doublecolon.length==1&&ipv4Parts.length==1&&addrParts.length!=8)
{
return false;
}
else if(Doublecolon.length==1&&ipv4Parts.length>1&&addrParts.length!=6)
{
return false;
}
else if(Doublecolon.length>1&&ipv4Parts.length>1&&addrParts.length>6)
{
return false;
}
else if(Doublecolon.length>2||ipaddr.split(':::').length>1)
{
return false;
}
else
{
if(addrParts[0]==""&&addrParts[1]!="")
{
return false;
}
for(var i=0;i<addrParts.length;i++)
{
if(i==addrParts.length-1&&addrParts[i]==""&&addrParts[i-1]!="")
{
return false;
}
if(addrParts[i].length>4 && addrParts[i].split('.').length<2)
{
return false;
}
}
}
var pos = ipaddr.lastIndexOf(":");
var ipv4Parts = ipaddr.split('.');
if(ipv4Parts.length>1)
{
var ipv4=ipaddr.substring(pos+1,ipaddr.length);
if( false == checkIPv4Addr(ipv4) )
{
return false;
}
}
return true;
}
function checkMacAddr(macaddr)
{
var regSingleByte = new RegExp(":","g");
var regexp = /^([A-Fa-f0-9]{2}-){5}[A-Fa-f0-9]{2}$/;
macaddr = macaddr.replace(regSingleByte,"-");
if (!regexp.test(macaddr)) {
return false;
}
return true;
}
jQuery.validator.addMethod(
"macAddr",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if(checkMacAddr(value) == true)
{
return true;
}
return false;
},
"&?public_error059;"
);
jQuery.validator.addMethod(
"IPv4Addr",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if(checkIPv4Addr(value) == true)
{
return true;
}
return false;
},
"&?public_error017;"
);
jQuery.validator.addMethod(
"IPv6Addr",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
return checkIPv6Addr(value);
},
"&?public_error025;"
);
jQuery.validator.addMethod(
"DomainName",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
return checkDomain(value);
},
"&?public_error019;"
);
jQuery.validator.addMethod(
"HostName",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var len = value.length;
var firstChar = value.substr(0,1);
var lastChar = value.substr(len-1,1);
if (value.match("[^0-9a-zA-Z.-]") != null)
{
return false;
}
if(firstChar.match("[^0-9a-zA-Z]") != null)
{
return false;
}
if(lastChar.match("[^0-9a-zA-Z]") != null)
{
return false;
}
var pos = value.lastIndexOf(".");
if(pos == -1)
{
var str = value;
var templen = value.length;
for(var i=0;i<len;i++)
{
var tempvalue = str.substring(i,i+1);
if(isNaN(parseInt(tempvalue)))
{
return true;
}
}
return false;
}
else
{
var str = value.substr(pos+1);
var tmplen = value.length - (pos + 1);
for(var i=0;i<tmplen;i++)
{
var tmpvalue = str.substring(i,i+1);
if(isNaN(parseInt(tmpvalue)))
{
return true;
}
}
return false;
}
},
"&?public_error044;"
);
jQuery.validator.addMethod(
"url",
function(value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var len = value.length;
if( (len < 1) || (len > 256) )
{
return false;
}
if (value.match("[^0-9a-zA-Z.:;,!@%#?_/&=+*'$()\\[\\]-]") != null)
{
return false;
}
return true;
},
"&?public_error004;"
);
jQuery.validator.addMethod(
"ChkPass",
function(val, element)
{
if ( !(/[0-9]+/).test(val) ||
!(/[a-zA-Z]+/).test(val) ||
!(/[!"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]+/).test(val) )
{
return false;
}
if (val.length < 8)
{
return false;
}
return true;
},
$.validator.format("&?public_error067;")
);
jQuery.validator.addMethod(
"PasswordASCII",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (value == "						")
{
return true;
}
if ( false == AsciiPasswordCheck(value) )
{
params = 0;
return false;
}
if ( false == AsciiCheck(value) )
{
params = 1;
return false;
}
return true;
},
function(param, element)
{
var error = ["&?public_error038;", "&?public_error018;"];
var value = $(element).val();
var ret = 0;
if ( false == AsciiPasswordCheck(value) )
{
ret = 0;
}
else if( false == AsciiCheck(value) )
{
ret = 1;
}
else
{
}
if ( ret <= error.length )
{
return error[ret];
}
}
);
jQuery.validator.addMethod(
"ASCII",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if ( false == AsciiCheck(value) )
{
return false;
}
return true;
},
"&?public_error018;"
);
jQuery.validator.addMethod(
"PassStrong",
function(value, element, params)
{
var num = 0;
for (var j = 0 ;j < value.length; j++)
{
var ch = value.charCodeAt(j);
if(ch<32 || ch>126)
{
return false;
}
}
if (value.length < 8)
return false;
if((/[0-9]+/).test(value))
num = num+1;
if((/[a-z]+/).test(value))
num = num+1;
if((/[A-Z]+/).test(value))
num = num+1;
if((/[!"#$%&'()*+,-./:;<=>?@\[\\\]^_`{|}~]+/).test(value))
num = num+1;
if(num < 3)
return false;
return true;
},
"&?public_error061;"
);
jQuery.validator.addMethod(
"utf8",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
return true;
},
"&?public_error018;"
);
jQuery.validator.addMethod(
"WEPKey128Bit",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var AsciiLenLimit = 13;
var HexLenLimit = 26;
if ( AsciiCheckWithLen(value, AsciiLenLimit) == false
&& HexCheckWithLen(value, HexLenLimit) == false )
{
return false;
}
return true;
},
"&?public_error020;"
);
jQuery.validator.addMethod(
"WEPAsciiOrHexLen",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var AsciiLenLimit = 5;
var HexLenLimit = 10;
var AsciiLenLimit13 = 13;
var HexLenLimit26 =26;
if (AsciiCheckWithLen(value, AsciiLenLimit) == false
&& HexCheckWithLen(value, HexLenLimit) == false
&& AsciiCheckWithLen(value, AsciiLenLimit13) == false
&& HexCheckWithLen(value, HexLenLimit26) == false)
{
return false;
}
return true;
},
"&?public_error047;"
);
jQuery.validator.addMethod(
"HEX",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if ( HexCheck(value) == false )
{
return false;
}
return true;
},
"&?public_error021;"
);
jQuery.validator.addMethod(
"fixedlength",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (value.length != param)
{
return false;
}
return true;
},
jQuery.validator.format("&?public_error022;")
);
jQuery.validator.addMethod(
"fixedValue",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (value != param)
{
return false;
}
return true;
},
jQuery.validator.format("&?public_error046;")
);
function hexCompare(hexNum, hexRefer)
{
var num = parseInt(hexNum, 16);
var refer = parseInt(hexRefer, 16);
if (num < refer)
{
return -1;
}
else if (num > refer)
{
return 1;
}
else
{
return 0;
}
}
jQuery.validator.addMethod(
"hexRange",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (typeof(params[0]) == "object")
{
for (var i=0; i<params.length; i++)
{
var range = params[i];
if (typeof(range) == "object")
{
if (hexCompare(value, range[0]) != -1 && hexCompare(value, range[1]) != 1 )
{
return true;
}
}
}
}
else
{
if (hexCompare(value, params[0]) != -1 && hexCompare(value, params[1]) != 1 )
{
return true;
}
}
return false;
},
function(params, element){
var rangesStr = "";
if (typeof(params[0]) == "object")
{
var rangesLen = params.length;
for (var i=0; i<rangesLen; i++)
{
var range = params[i];
if (hexCompare(range[0], range[1]) != 0)
{
rangesStr += range[0] + "~" + range[1];
}
else
{
rangesStr += range[0];
}
if ( i < rangesLen-1 )
{
rangesStr += ", ";
}
}
}
else
{
rangesStr = params[0] + "~" + params[1];
}
return $.validator.format("&?public_error049;", rangesStr);
}
);
jQuery.validator.addMethod(
"ranges",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var rangesLen = param.length;
for (var i=0; i<rangesLen; i++)
{
var range = param[i];
if ( typeof range === 'number' )
{
if ( value == range )
{
return true;
}
}
else
{
if ( value >= range[0] && value <= range[1] )
{
return true;
}
}
}
return false;
},
function(param, element){
var rangesStr = "";
var rangesLen = param.length;
for (var i=0; i<rangesLen; i++)
{
var range = param[i];
if ( typeof range === 'number' )
{
rangesStr += range;
}
else
{
rangesStr += range[0] + "~" + range[1];
}
if ( i < rangesLen-1 )
{
rangesStr += ",";
}
}
return $.validator.format("&?public_error023;", rangesStr);
}
);
jQuery.validator.addMethod(
"integer",
function(value, element, params)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
return /^-?\d+$/.test(value);
},
"&?public_error024;"
);
jQuery.validator.addMethod(
"concurrence",
function(value, element, param)
{
if (1 > param.length)
{
return true;
}
var obj = get_element_obj($(element), param[0]);
if (obj.is(":hidden"))
{
return true;
}
if ("" == value && "" == obj.val())
{
return true;
}
if ("" != value && "" != obj.val())
{
return true;
}
return false;
},
"&?public_error048;"
);
function get_element_obj(obj, id)
{
var instTplt = obj.closest("[id^=template_]");
var elementID = obj.attr("id");
var arr = elementID.split(':');
var strId = id;
if (arr.length > 1)
{
var exNum = arr[arr.length-1];
strId = id + ":" + exNum;
}
return $("[id^='"+strId+"']", instTplt);
};
function test_greatThan(obj, value, param, type)
{
if ("errstring" == type )
{
var tempstring = {
"1" : param[2].separate ? "&?public_error026;" : "&?public_error031;" ,
"2" : param[2].separate ? "&?public_error028;" : "&?public_error033;" ,
"3" : param[2].separate ? "&?public_error042;" : "&?public_error043;"
};
return $.validator.format(tempstring[param[2].ret], param[2].idtext, param[2].discrepantMode);
}
else
{
var tmpvalue = obj.val();
var ret = true;
if (param[2].equal)
{
ret = Number(value) >= Number(tmpvalue);
if (!ret)
{
param[2].ret = "2";
return false;
}
}
else
{
ret = Number(value) > Number(tmpvalue);
if (!ret)
{
param[2].ret = "1";
return false;
}
}
if (param[2].discrepantMode)
{
ret = Number(value) - Number(tmpvalue) <= Number(param[2].discrepantMode);
if (!ret)
{
param[2].ret = "3";
return false;
}
}
obj.parent().next().children().hide();
return true;
}
};
function test_lessThan(obj, value, param, type)
{
if ("errstring" == type )
{
var tempstring = {
"1" : param[2].separate ? "&?public_error027;" : "&?public_error032;" ,
"2" : param[2].separate ? "&?public_error029;" : "&?public_error034;" ,
"3" : param[2].separate ? "&?public_error043;" : "&?public_error042;"
};
return $.validator.format(tempstring[param[2].ret], param[2].idtext, param[2].discrepantMode);
}
else
{
var tmpvalue = obj.val();
var ret = true;
if (param[2].equal)
{
ret = Number(value) <= Number(tmpvalue);
if (!ret)
{
param[2].ret = "2";
return false;
}
}
else
{
ret = Number(value) < Number(tmpvalue);
if (!ret)
{
param[2].ret = "1";
return false;
}
}
if (param[2].discrepantMode)
{
ret = Number(tmpvalue) - Number(value) <= Number(param[2].discrepantMode)
if (!ret)
{
param[2].ret = "3";
return false;
}
}
obj.parent().next().children().hide();
return true;
}
};
jQuery.validator.addMethod(
"extremumRange",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (2 > param.length)
{
return true;
}
var obj = get_element_obj($(element), param[1]);
if (3 > param.length)
{
param[2] = {};
}
param[2]["idtext"] = obj.parent().prev().text();
if (obj.is(":hidden") || "" == obj.val())
{
return true;
}
var selectMode = {
"greatThan" : test_greatThan,
"lessThan" : test_lessThan
};
return selectMode[param[0]](obj, value, param);
},
function(param,element)
{
var selectMode = {
"greatThan" : test_greatThan,
"lessThan" : test_lessThan
};
return selectMode[param[0]]("", "", param, "errstring");
}
);
function range_greatThan(obj, value, param, type)
{
if ("errstring" == type )
{
var tempstring = {
"1" : param[2].separate ? "&?public_error026;" : ( param[2].objPosition =="first" ? "&?public_error031;" : "&?public_error051;" ),
"2" : param[2].separate ? "&?public_error028;" : ( param[2].objPosition =="first" ? "&?public_error033;" : "&?public_error053;" ) ,
"3" : param[2].separate ? "&?public_error035;" : ( param[2].objPosition =="first" ? "&?public_error043;" : "&?public_error042;")
};
return $.validator.format(tempstring[param[2].ret], param[2].idtext, param[2].discrepantMode);
}
else
{
obj.parent().next().children().hide();
var tmpvalue = obj.val();
var ret = true;
if (param[2].equal)
{
ret = Number(value) >= Number(tmpvalue);
if (!ret)
{
param[2].ret = "2";
return false;
}
}
else
{
ret = Number(value) > Number(tmpvalue);
if (!ret)
{
param[2].ret = "1";
return false;
}
}
if (param[2].discrepantMode)
{
ret = Number(value) - Number(tmpvalue) <= Number(param[2].discrepantMode);
if (!ret)
{
param[2].ret = "3";
return false;
}
}
return true;
}
};
function range_lessThan(obj, value, param, type)
{
if ("errstring" == type )
{
var tempstring = {
"1" : param[2].separate ? "&?public_error027;" : ( param[2].objPosition == "first" ? "&?public_error050;" : "&?public_error032;" ),
"2" : param[2].separate ? "&?public_error029;" : ( param[2].objPosition == "first" ? "&?public_error052;" : "&?public_error034;" ),
"3" : param[2].separate ? "&?public_error035;" : ( param[2].objPosition == "first" ? "&?public_error043;" : "&?public_error042;" )
};
return $.validator.format(tempstring[param[2].ret], param[2].idtext, param[2].discrepantMode);
}
else
{
obj.parent().next().children().hide();
var tmpvalue = obj.val();
var ret = true;
if (param[2].equal)
{
ret = Number(value) <= Number(tmpvalue);
if (!ret)
{
param[2].ret = "2";
return false;
}
}
else
{
ret = Number(value) < Number(tmpvalue);
if (!ret)
{
param[2].ret = "1";
return false;
}
}
if (param[2].discrepantMode)
{
ret = Number(tmpvalue) - Number(value) <= Number(param[2].discrepantMode)
if (!ret)
{
param[2].ret = "3";
return false;
}
}
return true;
}
};
jQuery.validator.addMethod(
"compareRange",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (2 > param.length)
{
return true;
}
var obj = get_element_obj($(element), param[1]);
if (3 > param.length)
{
param[2] = {};
}
param[2]["idtext"] = obj.parent().prev().text();
var selectMode = {
"greatThan" : range_greatThan,
"lessThan" : range_lessThan
};
return selectMode[param[0]](obj, value, param);
},
function(param,element)
{
var selectMode = {
"greatThan" : range_greatThan,
"lessThan" : range_lessThan
};
return selectMode[param[0]]("", "", param, "errstring");
}
);
jQuery.validator.addMethod(
"banValue",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var paramLen = param.length;
for (var i = 0;i < paramLen;i++)
{
var range = param[i];
if (typeof range === 'string' )
{
if (value == range)
{
return false;
}
}
else
{
if (value >= range[0] && value <= range[1])
{
return false;
}
}
}
return true;
},
function(param, element){
var rangesStr = "";
var paramLen = param.length;
for (var i=0; i<paramLen; i++)
{
var paraVal = param[i];
if ( "object" === typeof paraVal )
{
rangesStr += paraVal[0] + "~" + paraVal[1];
}
else
{
rangesStr += paraVal;
}
if ( i < paramLen-1 )
{
rangesStr += ", ";
}
}
if (paramLen > 1)
{
return $.validator.format("&?public_error036;", rangesStr);
}
else
{
return $.validator.format("&?public_error037;", rangesStr);
}
}
);
jQuery.validator.addClassRules({
ipSepCheck: {
"required": true,
"integer": true,
"range":[0,255]
},
macSepCheck:{
"required": true,
"HEX": true,
"fixedlength": 2
}
});
function checkTimeHMS(timestr) {
var re = /^([0-1]{1}[0-9]{1}|[2]{1}[0-3]{1}):[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}$/;
if (re.test(timestr) == true) {
return true;
}
return false;
}
jQuery.validator.addMethod(
"checkTimeHMS",
function (value, element, params) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (checkTimeHMS(value) == true) {
return true;
}
return false;
},
"&?public_error064;"
);
function time_earlierThan(obj, value, param, type)
{
var tmpvalue = obj.val();
var ret = true;
var valuearr = value.split(":")
var tmpvaluearr = tmpvalue.split(":")
if (valuearr[0] < tmpvaluearr[0])
{
return true;
}
else
{
if (valuearr[0] === tmpvaluearr[0] && valuearr[1] < tmpvaluearr[1])
{
return true;
}
else
{
if (valuearr[1] === tmpvaluearr[1] && valuearr[2] < tmpvaluearr[2])
{
return true;
}
}
return false;
}
};
function time_laterThan(obj, value, param, type)
{
var tmpvalue = obj.val();
var ret = true;
var valuearr = value.split(":")
var tmpvaluearr = tmpvalue.split(":")
if (valuearr[0] > tmpvaluearr[0])
{
return true;
}
else
{
if (valuearr[0] === tmpvaluearr[0] && valuearr[1] > tmpvaluearr[1])
{
return true;
}
else
{
if (valuearr[1] === tmpvaluearr[1] && valuearr[2] > tmpvaluearr[2])
{
return true;
}
}
return false;
}
};
jQuery.validator.addMethod(
"timeComparison",
function (value, element, param) {
if ( this.optional(element) )
{
return "dependency-mismatch";
}
if (2 > param.length) {
return true;
}
var obj = get_element_obj($(element), param[1]);
if (3 > param.length) {
param[2] = {};
}
param[2]["idtext"] = obj.parent().prev().text();
if (obj.is(":hidden") || "" == obj.val()) {
return true;
}
var selectMode = {
"laterThan": time_laterThan,
"earlierThan": time_earlierThan
};
return selectMode[param[0]](obj, value, param);
},
"&?public_error065;"
);
function compareIPv4(firstIP, secondIP)
{
var fIP;
var sIP;
fIP = firstIP.split(".");
sIP = secondIP.split(".");
for (var i = 0; i < 4; i++)
{
if (fIP[i] != "" && sIP[i] != "")
{
fIP[i] = parseInt(fIP[i],10);
sIP[i] = parseInt(sIP[i],10);
}
if (fIP[i] > sIP[i])
{
return 1;
}
else if (fIP[i] < sIP[i])
{
return -1;
}
}
return 0;
}
function checkWholeIPv4(k, v, ipValue,template)
{
var vLen = v.length;
var retMsg = "";
for (var j = 0; j < vLen; j++)
{
if (retMsg != "")
{
retMsg += ", ";
}
var range = v[j];
if (typeof range === 'string')
{
retMsg += range;
}
else
{
retMsg += range[0]+" ~ "+range[1];
}
}
if (k == "banValue")
{
retMsg = "&?public_error039;".format(retMsg);
for (var i = 0; i < vLen; i++)
{
var range = v[i];
if (typeof range === 'string')
{
if (ipValue == range)
{
return [false, k, retMsg];
}
}
else
{
if ("-1" != compareIPv4(ipValue, range[0]) &&
"1" != compareIPv4(ipValue, range[1]))
{
return [false, k, retMsg];
}
}
}
}
else if (k == "allowRange")
{
retMsg = "&?public_error040;".format(retMsg);
for (var i = 0; i < vLen; i++)
{
var range = v[i];
if ("-1" != compareIPv4(ipValue, range[0]) &&
"1" != compareIPv4(ipValue, range[1]))
{
return [true, "", ""];
}
}
return [false, k, retMsg];
}
else if (k == "notLessThan")
{
retMsg = "";
var IPObj = $("[id^='"+v+"']",template);
IPObj.FillIPorMacDataCombination("sub_"+v, ".", 4);
var minValue = IPObj.val();
if (-1 == compareIPv4(ipValue, minValue)){
return [false, k, retMsg];
}
}
else if (k == "notMoreThan")
{
retMsg = "";
var IPObj = $("[id^='"+v+"']",template);
IPObj.FillIPorMacDataCombination("sub_"+v, ".", 4);
var maxValue = IPObj.val();
if (1 == compareIPv4(ipValue, maxValue)){
return [false, k, retMsg];
}
}
else
{
}
return [true, "", ""];
}
function checkWholeMac(k, v, macValue)
{
var vLen = v.length;
var retMsg = "";
for (var j = 0; j < vLen; j++)
{
if (retMsg != "")
{
retMsg += ", ";
}
var range = v[j];
if (typeof range === 'string')
{
retMsg += range;
}
else
{
retMsg += range[0]+" ~ "+range[1];
}
}
if (k == "banValue")
{
retMsg = "&?public_error039;".format(retMsg);
for (var i = 0; i < vLen; i++)
{
var range = v[i];
if (typeof range === 'string')
{
if (macValue.toLowerCase() == range.toLowerCase())
{
return [false, k, retMsg];
}
}
}
}
else
{
}
return [true, "", ""];
}
function getMsgofWholeMACIPCheck(checkRetArray, ruleObj, checkValue, checkParaName)
{
var errMsg = "";
var ruleName = checkRetArray[1];
if(ruleObj.messages[ruleName] != undefined){
return ruleObj.messages[ruleName];
}
switch (ruleName){
case "banValue":{
if (checkParaName != "")
{
errMsg = checkParaName + checkRetArray[2];
}
else{
errMsg = "&?cmret_001;"+"["+"&?public_error041;"+checkValue+"]";
}
break;
}
case "allowRange":{
if (checkParaName != ""){
errMsg = checkParaName + checkRetArray[2];
}
else{
errMsg = "&?cmret_001;"+"["+"&?public_error041;"+checkValue+"]";
}
break;
}
default:{
errMsg = "error msg undefined!"
}
}
return errMsg;
}
jQuery.validator.addMethod(
"utf8LengthRange",
function(value, element, param)
{
if ( this.optional(element) )
{
return "dependency-mismatch";
}
var valLength = value.length;
var param1 = param[0];
var param2 = param[1];
if (param2 < 3)
{
alert("utf8LengthRange is invalid!["+param2+"<"+3 +"]");
}
else
{
param1 = Math.ceil(parseInt(param[0])/ 3);
param2 = Math.floor(parseInt(param[1]) / 3);
if (param1 < param2)
{
if (valLength >= param1 && valLength <= param2 )
{
return true;
}
}
else if (param1 == param2)
{
if (valLength == param2)
{
return true;
}
}
else
{
alert("utf8LengthRange ["+param1+","+param2+"] is invalid!");
}
}
return false;
},
function(param, element){
var lengthStr = "";
var param1 = param[0];
var param2 = param[1];
if (param2 < 3)
{
lengthStr = " Range Error!!!!!![param2<WEB_UTF8_REALBYTE]";
}
else
{
param1 = Math.ceil(parseInt(param[0])/ 3);
param2 = Math.floor(parseInt(param[1]) / 3);
if (param1 < param2)
{
lengthStr = param1 + " ~ " + param2;
}
else if (param1 == param2)
{
lengthStr = param2;
}
else
{
lengthStr = " Range Error!!!!!!["+param1+","+param2+"]";
}
}
return $.validator.format("&?public_error045;", lengthStr);
}
);
jQuery.validator.addMethod(
"notEqualTo",
function(value, element, param)
{
var obj = $("[id^='"+param+"']");
if ( value == obj.val())
{
return false;
}
return true;
},
function(param, element){
var paramName = "";
var obj = $("[id^='"+param+"']");
paramName = $("label[for='"+param+"']").text();
return $.validator.format("&?public_error070;", paramName);
}
);
