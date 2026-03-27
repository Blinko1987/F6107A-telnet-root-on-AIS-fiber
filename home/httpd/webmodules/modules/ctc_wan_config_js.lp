<script type="text/javascript">
var CountryCode = "<%=env.getenv("CountryCode")%>";
(function(){
var storeArray = {};
jQuery.fn.fillWanDataByOBJID = function(xml, OBJIDs, Clone, suffix, splitter){
if ( undefined == splitter )
{
splitter = ":";
}
for (var i=0; i<OBJIDs.length; i++)
{
var OBJID = OBJIDs[i];
var OBJIDSplit = OBJID.split(":");
var OBJIDIndex = 0;
var isSplitterExist = 0;
if ( OBJIDSplit.length == 2 )
{
OBJID = OBJIDSplit[0];
OBJIDIndex = parseInt(OBJIDSplit[1]);
isSplitterExist = 1;
}
var OBJs = $(xml).find(OBJID);
if ( OBJs.length == 0 )
{
continue;
}
var OBJ;
if ( OBJIDIndex < OBJs.length )
{
OBJ = OBJs.get(OBJIDIndex);
}
else
{
continue;
}
var instances;
if ( 1 == isSplitterExist )
{
instances = $("Instance", OBJ);
}
else
{
instances = $("Instance", OBJs);
}
if ( instances.length <= suffix
|| suffix < 0 )
{
consoleLog("suffix off normal upper!!");
continue;
}
var InstOBJ = instances.eq(suffix);
var temp = {};
var tempkey = "";
InstOBJ.find("ParaName").each(function(){
var ParaName = $(this).text();
var ParaValue = $(this).next().text();
if (ParaName=="mode" && ParaValue=="bridge")
{
<%if "0"==env.getenv("Bridge") then%>
var Elems = $("[id^='"+ParaName+splitter+"']", Clone);
if ( Elems.length > 0 )
{
Elems.append("<option value='bridge' title='&?InternetDE_032;'>&?InternetDE_032;</option>");
}
<%end%>
}
if ("WANCName" == ParaName ||
"_InstID" == ParaName ||
"mode" == ParaName ||
"linkMode" == ParaName ||
"xdslMode" == ParaName)
{
if ("_InstID" == ParaName)
{
tempkey = ParaValue;
}
var Elems = $("[id^='"+ParaName+splitter+"']", Clone);
if ( Elems.length > 0 )
{
Elems.fillDataByType(ParaValue);
}
}
else
{
temp[ParaName] = ParaValue;
}
});
storeArray[tempkey] = temp;
}
}
jQuery.fn.createWanPageDataByClone = function(RuleNum,DataOBJID,xml,fillDataByCustom){
var Head = $(this);
var HeadID = Head.attr("id");
var TemplateOBJ = $("#template_"+HeadID);
var ContainerOBJ = $("#"+HeadID+"_container");
$("#_InstNum", Head).val(RuleNum);
for (var i=0; i<RuleNum; i++)
{
isDisplay = false;
wanIndex = i;
$.publish("/some/isDisplayWan", xml);
if(isDisplay) continue;
var clone = TemplateOBJ.cloneWithSuffix(i);
TemplateOBJ.before(clone);
clone.fillWanDataByOBJID(xml ,DataOBJID, clone, i);
if ( $.isFunction(fillDataByCustom) )
{
fillDataByCustom(i,clone);
}
else
{
clone.trigger("fillDataByCustom",[i,clone]);
}
clone.showIt(true);
}
$(xml).find("encode").each(function(){
var encodePara= $(this).text().split(",");
for(var i in encodePara)
{
$("input[id^="+encodePara[i]+"]", ContainerOBJ).attr("encode","1");
}
});
}
var ppptypeOption = [
"<option value='PPPoE' title='&?public_047;'>&?public_047;</option>",
"<option value='PPPoA' title='&?public_121;'>&?public_121;</option>"
];
function change_ppptype_option(temp)
{
var objp = $("[id^='Prefix_xdslMode']", temp);
if (objp.length <= 0)
{
return;
}
var objx = $("[id^='xdslMode']", objp);
var obj = $("[id^='TransType']" , $("[id^='Prefix_TransType']", temp));
var tempval = obj.val();
obj.hide();
obj.empty();
if ("1" == objx.val())
{
obj.append(ppptypeOption[0]);
obj.append(ppptypeOption[1]);
}
else
{
obj.append(ppptypeOption[0]);
}
if ("begin" == g_action && "NULL" != tempval )
{
obj.val(tempval);
}
obj.show();
if (obj.attr("disabled") != "disabled")
{
obj.focus().blur();
}
}
var conntriggerOption = ["<option value=\"AlwaysOn\" title=\"&?InternetDE_034;\">&?InternetDE_034;</option>",
"<option value=\"OnDemand\" title=\"&?InternetDE_035;\">&?InternetDE_035;</option>",
"<option value=\"Manual\" title=\"&?InternetAIS_071;\">&?InternetAIS_071;</option>"
];
function change_conntrigger_option(obj, value)
{
var preSelectValue = document.ConnTriggerVal ? document.ConnTriggerVal : $("[id^='ConnTrigger']").val();
obj.hide();
var temp = obj.val();
obj.empty("");
if ("IPv4" == value)
{
obj.append(conntriggerOption[0]);
obj.append(conntriggerOption[1]);
obj.append(conntriggerOption[2]);
}
else if ("IPv6" == value || "Both" == value)
{
obj.append(conntriggerOption[0]);
obj.append(conntriggerOption[1]);
obj.append(conntriggerOption[2]);
}
$("[id^='ConnTrigger:']:last option").each(function(){
if($(this).val() == preSelectValue)
{
$("[id^='ConnTrigger']").val(preSelectValue);
}
});
if ("begin" == g_action && "NULL" != temp )
{
obj.val(temp);
}
obj.show();
if (obj.attr("disabled") != "disabled")
{
obj.focus().blur();
}
}
var IPv6AcquireModeOption = ["<option value=\"Auto\" title=\"&?InternetDE_039;\">&?InternetDE_039;</option>",
"<option value=\"Manual\" title=\"&?InternetAIS_071;\">&?InternetAIS_071;</option>",
"<option value=\"IPv6CPExtension\" title=\"&?InternetDE_040;\">&?InternetDE_040;</option>"
];
function change_IPv6AcquireMode_option(obj, value)
{
obj.hide();
var temp = obj.val();
obj.empty("");
if ("PPP" == value)
{
obj.append(IPv6AcquireModeOption[0]);
obj.append(IPv6AcquireModeOption[1]);
obj.append(IPv6AcquireModeOption[2]);
}
else if ("IP" == value)
{
obj.append(IPv6AcquireModeOption[0]);
obj.append(IPv6AcquireModeOption[1]);
}
if ("begin" == g_action && "NULL" != temp)
{
obj.val(temp);
}
obj.change();
obj.show();
if (obj.attr("disabled") != "disabled")
{
obj.focus().blur();
}
}
var g_apply = "";
var wanctypeOption = [
"<option value=\"DHCP\" title=\"&?InternetDE_062;\">&?InternetDE_062;</option>",
"<option value=\"Static\" title=\"&?InternetDE_061;\">&?InternetDE_061;</option>",
"<option value=\"IPoA\" title=\"&?public_122;\">&?public_122;</option>",
"<option value=\"CIP\" title=\"&?public_123;\">&?public_123;</option>"
];
function change_wanctype_option(temp)
{
var xmlobj,obj;
var uptype, modevalue, instID, linktype, objipmode, ipmode;
xmlobj = $("[id^='Prefix_xdslMode']", temp);
if (xmlobj.length <= 0)
{
return;
}
obj = $("[id^='Addressingtype']",temp);
uptype = $("[id^='xdslMode']", xmlobj).val();
modevalue= $("[id^='mode']",temp).val();
instID = $("[id^='_InstID']", temp).val();
linktype = $("[id^='linkMode']",temp).val();
objipmode= $("[id^='IpMode']", temp);
ipmode = objipmode.val();
if ("route" == modevalue && "IP" == linktype)
{
obj.hide();
var tmp = obj.val();
obj.empty("");
if ("1" == uptype && "IPv4" == ipmode)
{
obj.append(wanctypeOption[0]);
obj.append(wanctypeOption[1]);
obj.append(wanctypeOption[2]);
obj.append(wanctypeOption[3]);
}
else
{
obj.append(wanctypeOption[0]);
obj.append(wanctypeOption[1]);
}
if (("-1" != instID) && "Static" == tmp)
{
obj.val(tmp);
}
if (("begin" == g_action || "begin" == g_apply) && "NULL" != tmp)
{
obj.val(tmp);
if ("IPoA" == tmp || "CIP" == tmp)
{
objipmode.attr("disabled", "disabled");
}
}
obj.parent().parent().removeClass("PostIgnore");
obj.change();
obj.show();
if (obj.attr("disabled") != "disabled")
{
obj.focus().blur();
}
}
}
var serverlistOption = ["<option value=\"1\" title=\"&?InternetDE_086;\">&?InternetDE_086;</option>",
"<option value=\"2\" title=\"&?InternetDE_087;\">&?InternetDE_087;</option>",
"<option value=\"3\" title=\"&?InternetDE_088;\">&?InternetDE_088;</option>",
"<option value=\"4\" title=\"&?InternetDE_089;\">&?InternetDE_089;</option>",
"<option value=\"5\" title=\"&?InternetDE_090;\">&?InternetDE_090;</option>",
"<option value=\"6\" title=\"&?InternetDE_091;\">&?InternetDE_091;</option>",
"<option value=\"7\" title=\"&?InternetDE_092;\">&?InternetDE_092;</option>",
"<option value=\"8\" title=\"&?InternetDE_093;\">&?InternetDE_093;</option>"
];
function change_serverlist_option(temp)
{
objm = $("[id^='mode']", temp);
obj = $("[id^='ServList']", temp);
var temp = obj.val();
obj.hide();
if ("route" == objm.val())
{
obj.empty("");
obj.append(serverlistOption[0]);
obj.append(serverlistOption[1]);
obj.append(serverlistOption[2]);
<% if "0" ~= env.getenv("voipSupport") then %>
obj.append(serverlistOption[3]);
obj.append(serverlistOption[4]);
obj.append(serverlistOption[5]);
obj.append(serverlistOption[6]);
<%end%>
obj.append(serverlistOption[7]);
}
else if ("bridge" == objm.val())
{
obj.empty("");
obj.append(serverlistOption[0]);
}
if ("begin" == g_action && "NULL" != temp )
{
obj.val(temp);
}
obj.change();
obj.show();
if (obj.attr("disabled") != "disabled")
{
obj.focus().blur();
}
}
function disabled_control(container)
{
var ctr = ["xdslMode", "mode", "TransType", "linkMode", "ServList", "WBDMode"];
var ob;
for (var i = 0; i < ctr.length; i++)
{
ob = $("[id^='" + ctr[i] + "']", container);
if (ob.length > 0)
{
ob.attr("disabled", "disabled");
}
}
$.publish("/some/displayWanElem", [container]);
<%
local retTable = nil
local xmlStr = ""
local changeStatus
retTable = cmapi.getinst("OBJ_CHANGESTATUS_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
return xmlStr, err
end
if retTable.IF_ERRORID == 0 then
changeStatus = retTable["changeStatus"]
end
if env.getenv("CountryCode") == "156" and changeStatus == "3" then
%>
var instIDInter = $("[id^='_InstID']", container).val()
if(instIDInter == "DEV.IP.IF4")
{
$("[id^='Prefix_UserName:'],[id^='Prefix_Password:']",container).hide();
}
<%
end
%>
}
function resolve_data_to_control(container)
{
var obj;
var reg = /[_:]/;
var id = container.attr("id").split(reg);
var index = id[id.length - 1];
container.collapsibleInstTitleChange("WANCName");
deal_dslmode_control(container, index, "get");
mtu_check_change(container);
$("[id^='IdleTime0']",container).change();
}
function deal_dslmode_control(container, index, type)
{
var temp = $("[id^='Prefix_xdslMode\\:']", container);
if ( temp.length > 0)
{
var obj = $("[id^='xdslMode\\:']", temp);
if ("get" == type)
{
obj.change();
}
else if ("set" == type)
{
}
}
else
{
deal_mode_control(container, index, type);
}
}
function deal_mode_control(container, index, type)
{
var obj = $("[id^='mode\\:']", container);
if ("get" == type)
{
obj.change();
}
else if ("set" == type)
{
}
}
function change_mtu_for_PppIP(linktype, temp)
{
if ("begin" != g_action)
{
var obj = $("[id^='MTU']", temp);
if ("PPP" == linktype)
{
obj.val(1492);
}
else if ("IP" == linktype)
{
obj.val(1500);
}
}
}
function change_mtu_for_PppType(transtype, temp)
{
if ("begin" != g_action)
{
var obj = $("[id^='MTU']", temp);
if ("PPPoE" == transtype)
{
obj.val(1492);
}
else if ("PPPoA" == transtype)
{
obj.val(1500);
}
}
}
var g_action = "";
function customize_internet(paramsOBJ)
{
g_action = "begin";
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
resolve_data_to_control(ContainerOBJ);
disabled_control(ContainerOBJ);
g_action = "end";
}
jQuery.fn.deal_relevance_control_hidden = function(obj, objvalue, template)
{
var ctrObj ;
var temp = template;
if (!objvalue)
{
return;
}
if (obj.length > objvalue.length)
{
return ;
}
var reg = /[_:]/;
var id = template.attr("id").split(reg);
var index = id[id.length - 1];
for (var i = 0; i < obj.length; i++)
{
if ("null" == objvalue[i])
{
continue;
}
ctrObj = $("[id^='" + obj[i] + "\\:']", temp);
if (ctrObj.length <= 0)
{
continue;
}
if (true === objvalue[i])
{
ctrObj.show();
ctrObj.removeClass("PostIgnore");
}
else if (false === objvalue[i])
{
ctrObj.addClass("PostIgnore");
ctrObj.hide();
}
if (ctrObj.is("select"))
{
if ("begin" == g_action && ("renew" == objvalue[i] || "click" == objvalue[i] ))
{
ctrObj.change();
}
else if ("renew" == objvalue[i] && 0 != ctrObj.get(0).selectedIndex)
{
ctrObj.get(0).selectedIndex = 0;
ctrObj.change();
}
else if ("click" == objvalue[i])
{
ctrObj.change();
}
}
else if(ctrObj.hasClass('radiobutton'))
{
var radioObj = $("input[type=radio]", ctrObj);
radioObj.each(function(){
var thisObj = $(this);
if ("click" == objvalue[i])
{
thisObj.change();
}
else if ("0" === objvalue[i] || "1" === objvalue[i])
{
if (objvalue[i] == thisObj.val())
{
thisObj.prop("checked",true);
}
else
{
thisObj.prop("checked",false);
}
}
});
}
}
}
function initial_bind_select_change(template)
{
var obj;
obj = $("[id^='xdslMode']", template);
if (obj.length > 0)
{
obj.change(function(event){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='template_']");
var value = TypeOBJ.hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
change_ppptype_option(temp);
var RelObj = [ "forAtm","ATMQoS","Prefix_mode","mode"];
var RelValue = {
"hidden" : [ false, "click","null", "click"],
"1" : [true, "click", "null","click"],
"2" : [false, "click","null", "click"]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
});
}
obj = $("[id^='ATMQoS']", template);
if (obj.length > 0)
{
obj.change(function(event){
var TypeOBJ = $(this);
var temp= TypeOBJ.parents("[id^='template_']");
var value = TypeOBJ.parent().parent().parent().hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var RelObj= ["forqos",
"Prefix_ATMPeakCellRate", "ATMPeakCellRate",
"Prefix_ATMSCR", "ATMSCR",
"Prefix_ATMMaxBurstSize", "ATMMaxBurstSize"
];
var RelValue = {
"hidden":[false,
"null", "null",
"null", "null",
"null", "null"
],
"UBR" : [true,
false, false,
false, false,
false, false
],
"CBR" : [true,
true, true,
false, false,
false, false
],
"VBR-nrt" : [true,
true, true,
true, true,
true, true
],
"VBR-rt" : [true,
true, true,
true, true,
true, true
]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
});
}
obj = $("[name^='VlanEnable']", template);
obj.change(function(){
var TypeOBJ = $(this);
var temp= TypeOBJ.parents("[id^='template_']");
if ( TypeOBJ.is(':checked'))
{
var value = TypeOBJ.parent().parent().hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var RelObj= ["forVlan","Prefix_VLANID", "Prefix_Priority"];
var RelValue = {
"hidden":[false,"null","null"],
"0" : ["null",false,false],
"1" : ["null",true,true]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value.toString()], temp);
}
});
$("[name^='DSCP']", template).val("-1");
obj = $("[id^='mode']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp= TypeOBJ.parents("[id^='template_']");
var value = TypeOBJ.val();
var isShowOpt60_mode = $("[id^='linkMode']", temp).val() != "PPP" &&
$("[id^='IpMode']", temp).val() != "IPv6" &&
$("[id^='Addressingtype']", temp).val() != "Static";
var RelObj= ["Prefix_ServList",
"Prefix_MTU",
"Prefix_linkMode",
"linkMode",
"Prefix_IpMode",
"IpMode",
"forVlan",
"VlanEnable",
"forDSCP"
];
var RelValue = {
"bridge" : [false,
false,
false,
"click",
false,
"click",
"null",
"click",
false
],
"route" : ["null",
"null",
"null",
"click",
"null",
"click",
"null",
"click",
"null"
]
};
change_serverlist_option(temp);
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
});
obj = $("[id^='linkMode']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp= TypeOBJ.parents("[id^='template_']");
var value = TypeOBJ.parent().parent().hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var o =$("[id^='IPv6AcquireMode']", temp);
var isShowOpt60_linkMode = $("[id^='IpMode']", temp).val() != "IPv6" &&
$("[id^='Addressingtype']", temp).val() != "Static";
change_IPv6AcquireMode_option(o , value);
change_wanctype_option(temp);
var RelObj= ["forPpp",
"Prefix_TransType",
"TransType",
"Prefix_Addressingtype",
"Addressingtype",
"Prefix_IPv4Label",
"Prefix_segment",
"Prefix_IpMode",
"IpMode"
];
var RelValue = {
"hidden" : [false,
false,
"click",
false,
"click",
false,
false,
"null",
"null"
],
"PPP" : [true,
"null",
"click",
false,
"click",
false,
false,
"null",
"click"
],
"IP" : [false,
false,
"click",
true,
"click",
true,
true,
"null",
"click"
]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
change_mtu_for_PppIP(value, temp);
if("begin" != g_action)
{
mtu_check_change(temp);
}
});
obj = $("[id^='ConnTrigger']", template);
obj.change(function(event){
var TypeOBJ = $(this);
document.ConnTriggerVal = TypeOBJ.val();
var temp= TypeOBJ.parents("[id^='forPpp']");
var value = temp.hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var RelObj= ["Prefix_IdleTime"];
var RelValue = {
"hidden" : [false],
"AlwaysOn" : [false],
"OnDemand" : [false],
"Manual" : [false]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
});
obj = $("[id^='IpMode']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='template_']");
change_wanctype_option(temp);
var value = TypeOBJ.parents("[id^='Prefix_IpMode']").hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var ppp = $("[id^='Prefix_TransType']",temp).hasClass("PostIgnore") ? "null" : "renew";
var ip = $("[id^='Prefix_Addressingtype']",temp).hasClass("PostIgnore") ? "null" : "renew";
var Ipvf = "null";
var Ipvs = "null";
var isShowOpt60_IpMode = $("[id^='linkMode']", temp).val() != "PPP" &&
$("[id^='Addressingtype']", temp).val() != "Static";
if ("hidden" != value )
{
Ipvf = (ppp != "null") ? "null" : true;
Ipvs = (ppp != "null") ? "null" : false;
ip = (ppp != "null") ? ip : "click" ;
}
if ("hidden" != value)
{
change_conntrigger_option($("[id^='ConnTrigger']", temp), value);
}
var RelObj = ["foripvfback",
"forIpvf",
"IsNAT",
"foripvS",
"IPv6AcquireMode",
"Prefix_Addressingtype",
"Addressingtype",
"Prefix_IPv4Label",
"Prefix_segment",
"ServList",
"forPpp",
"ConnTrigger",
"forDSCP"
];
var RelValue = {
"hidden" : ["null",
false,
false,
false,
"null",
"null",
"null",
"null",
"null",
"click",
"null",
"null",
"null"
],
"IPv4" : [true,
false,
"null",
false,
"null",
Ipvf,
ip,
Ipvf,
Ipvf,
"click",
"null",
"click",
true
],
"IPv6" : [false,
false,
false,
false,
"click",
Ipvs,
ip,
Ipvs,
Ipvs,
"click",
"null",
"click",
false
],
"Both" : [true,
false,
"null",
false,
"click",
Ipvf,
ip,
Ipvf,
Ipvf,
"click",
"null",
"click",
true
]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
if("begin" != g_action)
{
mtu_check_change(temp);
}
});
obj = $("[id^='TransType']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='template_']");
var value = TypeOBJ.parents("[id^='Prefix_TransType']").hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var RelObj = ["forVlan","forDSCP","forIpvf","EnablePassThrough"];
var RelValue = {
"hidden" : ["null","null","null","null"],
"PPPoE" : ["null",true,false,true],
"PPPoA" : [ false,false,false,false]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
change_mtu_for_PppType(value, temp);
if("begin" != g_action)
{
mtu_check_change(temp);
}
});
obj = $("[id^='Addressingtype']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='template_']");
var parents = TypeOBJ.parents("[id^='Prefix_Addressingtype']");
var value = parents.hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var IpMode= $("[id^='IpMode']", temp).val();
if ("IPv4" == IpMode || "Both" == IpMode)
{
var RelObj = ["forVlan","forIpvf","forDSCP"];
var RelValue = {
"hidden" : ["null","null","null"],
"Static" : ["null",true,true],
"DHCP" : ["null",false,true],
"IPoA" :["null",true,false],
"CIP" : ["null",true,false]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
}
else if ("IPv6" == IpMode)
{
parents.hide();
var RelObj = ["forVlan","forDSCP"];
var RelValue = {
"hidden" : ["null","null"],
"Static" : ["null",true],
"DHCP" : ["null",true]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
}
if("begin" != g_action)
{
mtu_check_change(temp);
}
});
obj = $("[id^='IPv6AcquireMode']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='foripvS']");
var value = temp.hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var linkMode = $("[id^='linkMode']", temp.parent()).val();
var Gateway = false;
if ("IP" == linkMode)
{
Gateway = true;
}
var RelObj= ["Prefix_Gua1","Prefix_Gateway6","Prefix_Pd","Prefix_Dns1v6","Prefix_Dns2v6","Prefix_Dns3v6",
"forSwitcher","Unnumbered"];
var RelValue = {
"hidden" : ["null","null","null","null","null","null","null","null"],
"Manual" : [true,Gateway,true,true,true,true,false,"null"],
"Auto" : [false,false,false,false,false,false,true,"click"],
"IPv6CPExtension" : [false,false,false,false,false,false,false,"null"]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
$.publish("/some/unnumberedModify", [temp]);
});
obj = $("[name^='Unnumbered']", template);
obj.change(function(){
var TypeOBJ = $(this);
var temp = TypeOBJ.parents("[id^='forSwitcher']");
if ( TypeOBJ.is(':checked'))
{
var value = temp.hasClass("PostIgnore") ? "hidden" : TypeOBJ.val();
var RelObj= ["div_IsSLAAC","IsSLAAC","div_IsGUA","IsGUA","div_IsPdAddr","IsPdAddr"];
var RelValue = {
"hidden":[false,false,false,false,false,false],
"1" : [false,false,false,false,false,false],
"0" : [true,true,true,true,true,true]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value.toString()], temp);
}
});
obj = $("[id^='ServList']", template);
obj.change(function(event){
var TypeOBJ = $(this);
var temp= TypeOBJ.parents("[id^='template_']");
var value = TypeOBJ.val();
var RelObj= ["IsPD","IPv6AcquireMode",
"Prefix_AuthType","Prefix_ConnTrigger"
];
var RelValue = {
"1" : ["1","click",
true,true
],
"2" : ["0","click",
true,true
],
"3" : ["1","click",
true,true
],
"4" : ["0","click",
false,false
],
"5" : ["1","click",
false,false
],
"6" : ["0","click",
false,false
],
"7" : ["1","click",
false,false
],
"8" : ["1","click",
true,true
]
};
TypeOBJ.deal_relevance_control_hidden(RelObj, RelValue[value], temp);
});
$(".addInstBar").click(function(){
document.ConnTriggerVal = "";
});
}
var g_maxmtu = 1492;
<%
local function get_max_pppoemtu()
local ret_MTU = cmapi.getinst("OBJ_PPPOE_MAX_MTU_ID", "")
if not ret_MTU.MaxPPPoEMTU then
ret_MTU.MaxPPPoEMTU = 1492
end
cgilua.put(ret_MTU.MaxPPPoEMTU)
end
%>
g_maxmtu = "<%get_max_pppoemtu()%>";
function initial_check_even(template)
{
var IPCheckRules = {
"required": true,
"integer": true,
"range":[0,255]
};
template.bind("applyPromptCheckJSON", function(event, template)
{
var checkJSONTempObj = {
"groups": {
IPAddress: "IPAddress0 IPAddress1 IPAddress2 IPAddress3",
SubnetMask: "SubnetMask0 SubnetMask1 SubnetMask2 SubnetMask3",
GateWay: "GateWay0 GateWay1 GateWay2 GateWay3",
DNS1: "DNS10 DNS11 DNS12 DNS13",
DNS2: "DNS20 DNS21 DNS22 DNS23",
DNS3: "DNS30 DNS31 DNS32 DNS33",
IdleTime: "IdleTime0 IdleTime1",
DestAddress: "sub_DestAddress0 sub_DestAddress1",
PdGroup: "Pd PdLen"
},
"rules": {
"WANCName":
{
"utf8": true,
"required": true,
"utf8LengthRange":[1,256]
},
"UserName" :
{
"required": true,
"ASCII": true,
"rangelength":[1,128]
},
"Password" :
{
"required": true,
"PasswordASCII": true,
"rangelength":[1,128]
},
"IPAddress0": IPCheckRules,
"IPAddress1": IPCheckRules,
"IPAddress2": IPCheckRules,
"IPAddress3": IPCheckRules,
"SubnetMask0": IPCheckRules,
"SubnetMask1": IPCheckRules,
"SubnetMask2": IPCheckRules,
"SubnetMask3": IPCheckRules,
"GateWay0": IPCheckRules,
"GateWay1": IPCheckRules,
"GateWay2": IPCheckRules,
"GateWay3": IPCheckRules,
"DNS10": IPCheckRules,
"DNS11": IPCheckRules,
"DNS12": IPCheckRules,
"DNS13": IPCheckRules,
"DNS20": IPCheckRules,
"DNS21": IPCheckRules,
"DNS22": IPCheckRules,
"DNS23": IPCheckRules,
"DNS30": IPCheckRules,
"DNS31": IPCheckRules,
"DNS32": IPCheckRules,
"DNS33": IPCheckRules,
"sub_DestAddress0":{
"required": true,
"integer": true,
"range":[0,255]
},
"sub_DestAddress1":{
"required": true,
"integer": true,
"range":[0,65535]
},
"ATMPeakCellRate":{
"required": true,
"integer": true,
"range":[1,20000]
},
"ATMSCR":{
"required": true,
"integer": true
},
"ATMMaxBurstSize":{
"required": true,
"integer": true
},
"VLANID" : {
"required": true,
"integer": true,
"range":[0,4094]
},
"DSCP" : {
"required": true,
"integer": true,
"range":[-1,63]
},
"MTU" :{
"required": true,
"integer": true,
"range":[128,g_maxmtu]
},
"Gua1": {
"required": true,
"IPv6Addr": true
},
"Pd": {
"banValue": ["::"],
"IPv6Addr": true,
"concurrence":["PdLen"]
},
"PdLen" :{
"integer": true,
"range":[1,64],
"concurrence":["Pd"]
},
"IdleTime0" : {
"integer": true,
"range":[0,1092]
},
"IdleTime1" : {
"integer": true,
"range":[0,59]
},
"Dns1v6": {
"IPv6Addr": true
},
"Dns2v6": {
"IPv6Addr": true
},
"Dns3v6": {
"IPv6Addr": true
},
"Gateway6": {
"required": true,
"IPv6Addr": true
}
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
}
function mtu_check_change(temp)
{
var objmode = $("[id^='mode']", $("[id^='Prefix_mode']", temp));
var min;
$.publish("/some/wanmtumaxchange", [ipmtumax]);
var max = $("#ipmtumax").val();
var values = {
"PPP" : {
"IPv4" : {
"PPPoE" : [128, g_maxmtu],
"PPPoA" : [128, 1540]
},
"IPv6" : {
"PPPoE" : [1280, g_maxmtu],
"PPPoA" : [1280, 1540]
},
"Both" : {
"PPPoE" : [1280, g_maxmtu],
"PPPoA" : [1280, 1540]
}
},
"IP" : {
"IPv4" : {
"Static" : [576, max],
"CIP" : [576, 9180],
"IPoA":[576, max],
"DHCP":[576, max]
},
"IPv6" : {
"Static" :[1280, max],
"CIP" : [1280, max],
"IPoA":[1280, max],
"DHCP":[1280, max]
},
"Both" : {
"Static" : [1280, max],
"CIP" : [1280, max],
"IPoA":[1280, max],
"DHCP":[1280, max]
}
}
}
if ("route" == objmode.val())
{
var objlikemode = $("[id^='linkMode']", temp);
var objipmode = $("[id^='IpMode']",temp);
var obj = null;
var likemode = objlikemode.val();
if ("PPP" == likemode)
{
obj = $("[id^='TransType']", $("[id^='Prefix_TransType']", temp));
}
else if ("IP" == likemode)
{
obj = $("[id^='Addressingtype']", $("[id^='Prefix_Addressingtype']", temp));
}
if (obj)
{
var value = values[likemode][objipmode.val()][obj.val()];
if (value)
{
var objmtu = $("[id^='MTU']", $("[id^='Prefix_MTU']", temp));
objmtu.rules("remove", "range");
objmtu.rules("add", {"range" : value});
objmtu.valid();
}
}
}
}
var pvcSynchro = {
action : "end",
oldv0 : "",
oldv1 : "",
curid : "",
nowv0 : "",
nowv1 : "",
fun : Synchro_pvc
};
function synchro_other_pvc(template)
{
if ("begin" == pvcSynchro['action'] )
{
pvcSynchro.fun(template);
}
pvcSynchro['action'] = "end";
}
function save_old_pvc(template, actiontype)
{
pvcSynchro['action'] = "end";
if ("Apply" == actiontype)
{
var obj = $("[id^='xdslMode']", template);
var inst = $("[id^='_InstID']", template);
if (obj.length > 0)
{
if ("1" == obj.val() && "-1" != inst.val())
{
pvcSynchro['action'] = "begin";
var tempArray = storeArray[$("[id^='_InstID']", template).val()];
if (tempArray)
{
pvcSynchro['oldv0'] = tempArray["sub_DestAddress0"];
pvcSynchro['oldv1'] = tempArray["sub_DestAddress1"];
}
pvcSynchro['curid'] = template.attr("id");
}
}
}
}
function save_new_pvc(template)
{
if ("begin" == pvcSynchro['action'])
{
pvcSynchro['nowv0'] = $("[id^='sub_DestAddress0']", template).val();
pvcSynchro['nowv1'] = $("[id^='sub_DestAddress1']", template).val();
if ((pvcSynchro['nowv0'] == pvcSynchro['oldv0']) && (pvcSynchro['nowv1'] == pvcSynchro['oldv1']))
{
pvcSynchro['action'] = "end";
}
}
}
function Synchro_pvc(head)
{
$("[id^='template_Internet']", head).each(function(){
var obj = $(this);
var tempArray = storeArray[$("[id^='_InstID']", obj).val()];
if (tempArray)
{
var sameObj = (pvcSynchro['curid'] == obj.attr("id"));
var samePVC = ((tempArray["sub_DestAddress0"] == pvcSynchro['oldv0'])
&& (tempArray["sub_DestAddress1"] == pvcSynchro['oldv1']));
var unmodify = ((tempArray["sub_DestAddress0"] == $("[id^='sub_DestAddress0']", obj).val())
&& (tempArray["sub_DestAddress1"] == $("[id^='sub_DestAddress1']", obj).val()));
if (sameObj)
{
modify_global(tempArray);
}
else
{
var loaded = $("[id^='InstHasGot']", obj).val() == 1 ? true : false;
if (loaded)
{
if (samePVC)
{
if (unmodify)
{
$("[id^='sub_DestAddress0']", obj).val(pvcSynchro['nowv0']);
$("[id^='sub_DestAddress1']", obj).val(pvcSynchro['nowv1']);
}
modify_global(tempArray);
}
}
else
{
if (samePVC)
{
modify_global(tempArray);
}
}
}
}
});
}
function modify_global(array)
{
array["sub_DestAddress0"] = pvcSynchro['nowv0'];
array["sub_DestAddress1"] = pvcSynchro['nowv1'];
}
function create_global_table(template)
{
var instID = $("[id^='_InstID']", template).val();
if (storeArray[instID] == undefined)
{
var obj = $("[id^='xdslMode']", template);
if (obj.length > 0 && "1" == obj.val())
{
storeArray[instID] = {
"sub_DestAddress0" : $("[id^='sub_DestAddress0']", template).val(),
"sub_DestAddress1" : $("[id^='sub_DestAddress1']", template).val()
}
if ($("[id^='InstHasGot']", template).val() == "0")
{
$("[id^='InstHasGot']", template).val("1");
}
}
}
}
function show_all_ConnTrigger_option(template)
{
var obj = $("[id^='ConnTrigger']", template);
if (obj.length > 0)
{
obj.hide();
obj.empty("");
obj.append(conntriggerOption[0]);
obj.append(conntriggerOption[1]);
obj.append(conntriggerOption[2]);
obj.show();
if (obj.attr("disabled") != "disabled")
{
obj.focus().blur();
}
}
}
function initial_template_Internet(templateID)
{
var template = $("#"+templateID);
$(".collapsibleInst",template).unbind("click");
$(".collapsibleInst",template).click(function(event){
var collapsibleInst = $(this);
var template = collapsibleInst.parents("[id^='template_']");
var ChangeArea = $(".ChangeArea",template);
if ( ChangeArea.is(":hidden") )
{
var objGot = $("[id^='InstHasGot']", template);
ChangeArea.showIt(true);
collapsibleInst.addClass("instNameExp");
if ("0" == objGot.val())
{
var CustomizeParams = {
"ContainerOBJ":template
};
fillArraytoHtml(template);
hideConnectionMode(template);
customize_internet(CustomizeParams);
objGot.val("1");
}
}
else
{
ChangeArea.showIt(false);
collapsibleInst.removeClass("instNameExp");
$(".Btn_cancel",ChangeArea).click();
}
});
initial_check_even(template);
$("[id^='IdleTime0']",template).change(function(event){
var IdleMin = $(this);
var template = IdleMin.parents("[id^='template_']");
var IdleSec = $("[id^='IdleTime1']", template);
var IdleMinVal = parseInt(IdleMin.val());
if ( IdleMinVal == 1092 )
{
IdleSec.rules("remove", "range");
IdleSec.rules("add", {"range" : [0,15]});
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
IdleSec.next().text("&?public_072;0 ~ 15");
}
else
{
IdleSec.rules("remove", "range");
IdleSec.rules("add", {"range" : [0,59]});
if ($(".errorLabelWraper").length != 0)
{
$(".errorLabelWraper").remove();
}
IdleSec.next().text("&?public_072;0 ~ 59");
}
});
initial_bind_select_change(template);
template.bind("fillDataByApplyResult", function(event, xml, template){
ActionByApplyResult(xml, template, "WANCName");
if (template.hasError(xml) == 0)
{
synchro_other_pvc(template.parent());
create_global_table(template);
g_apply = "begin";
change_wanctype_option(template);
disabled_control(template);
g_apply = "end";
}
});
template.unbind("fillDataByDeleteResult");
template.bind("fillDataByDeleteResult", function(event,xml, template){
if ( template.hasError(xml) == 0 )
{
var instID = $("[id^='_InstID']", template).val();
var tempArray = storeArray[instID];
if (tempArray)
{
delete storeArray[instID];
}
template.remove();
}
else
{
$(".ChangeArea",template).showIt(true);
}
});
template.bind("hiddenValueChangeByCustom", function(event,template, actiontype){
if ("Delete" == actiontype)
{
return;
}
save_old_pvc(template, actiontype);
var reg = /[_:]/;
var id = template.attr("id").split(reg);
var index = id[id.length - 1];
deal_dslmode_control(template, index, "set");
save_new_pvc(template);
});
template.bind("PostDataChangeByCustom", function(event, NameValueJson){
var ElemsMainID = NameValueJson.ElemsMainID;
var ElemsValue = NameValueJson.ElemsValue;
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["ID_WAN_COMFIG"];
show_all_ConnTrigger_option(template);
ActionByCancelResult(xml, template, OBJID);
var CustomizeParams = {
"ContainerOBJ":template
};
customize_internet(CustomizeParams);
});
}
function fillArraytoHtml(temp)
{
var instID = $("[id^='_InstID']", temp).val();
var tempArray = storeArray[instID];
if (tempArray)
{
for(var key in tempArray){
var obj = $("[id^='"+key+":']", temp);
obj.fillDataByType(tempArray[key]);
}
}
}
function hideConnectionMode(temp){
var instID = $("[id^='_InstID']", temp).val();
var prefix_ConnTrigger = $("[id^='Prefix_ConnTrigger']",temp);
if ( instID == "DEV.IP.IF4" ){
prefix_ConnTrigger.show();
}
else
{
prefix_ConnTrigger.remove();
}
}
$(document).ready(function(){
var HeadID = "Internet";
var Head = $("#"+HeadID);
var tempalteID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_Internet(tempalteID);
var isDispaly, wanIndex;
Head.fillDataByCustom = function(suffix,ContainerOBJ){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
ContainerOBJ.collapsibleInstTitleChange("WANCName");
};
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
$.publish("/some/serverlist_option4viettel", [$("[id="+tempalteID+"]")]);
$.publish("/some/softVersionModify", [$("[id="+tempalteID+"]")]);
var FWIPOBJ = $(xml).find("ID_WAN_COMFIG");
var RuleNum = $("Instance", FWIPOBJ).length;
var OBJID = ["ID_WAN_COMFIG"];
Head.createWanPageDataByClone(RuleNum,OBJID,xml,
Head.fillDataByCustom);
$("#template_Internet_0").hide();
$("#template_Internet_2").hide();
$("#template_Internet_3").hide();
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
