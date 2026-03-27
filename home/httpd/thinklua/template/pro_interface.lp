<%
if env.getenv("CountryCode") == "154" then
%>
function templateModify()
{
$("#timeArea").hide();
}
<%
end
%>
<% if CountryCode == "52" then %>
(function(){
$(document).ready(function(){
$("#logo").attr("class", "logo_Mnc");
});
})();
<%
end
%>
<% if CountryCode == "147" then %>
(function(){
$(document).ready(function(){
$("#logo").attr("class", "logo_AXS");
});
})();
<%
end
%>
<%
local curv = env.getenv("CountryCode")
%>
(function(){
$(document).ready(function(){
var curv = <%=curv%>;
if (curv == "65")
$("#languageSwitch").hide();
});
})();
(function(){
$(document).ready(function(){
$("#timeArea").remove();
<%
local sess_id = cgilua.getCurrentSessID()
local status_login = session_get(sess_id, "status_login")
if status_login ~= "logined" then
%>
$("#mainNavigator").hide();
$("#page_footer").hide();
$("#logo").hide();
<%
end
%>
$("#page_footer").empty();
$("#page_footer").append("<span><a href='http://www.ais.co.th/fibre/support.html' target='_blank'>&?pro_footer_001;</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a href='http://www.ais.co.th/fibre/contact.html' target='_blank'>&?pro_footer_002;</a></span><br><span id='copyRight'>&?public_161;<%=_G.encodeHTML(env.getenv("VerDate"))%>&?pro_footer_003;</span><br><span id='pdtVer'>&?pro_footer_004;</span>");
});
})();
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "152" || CountryCode == "163")
{
$("#logo").attr("class", "logo_Claro");
}
});
})();
<% if CountryCode == "140" then %>
(function(){
$(document).ready(function(){
$("#logo").attr("class", "logo_OJO");
$("#timeArea").remove();
});
})();
<%
end
%>
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "21")
{
$("#logo").attr("class", "logo_Antel");
}
});
})();
<% if env.getenv("CountryCode") == "21" then %>
function templateModify()
{
$("#timeArea").hide();
}
<%end%>
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "36")
{
$("#logo").addClass("logo_Tot");
$("#timeArea").addClass("timeArea_Tot");
}
});
})();
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "106")
{
$("#logo").addClass("logo_Morocco");
}
});
})();
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "138")
{
$("#logo").addClass("logo_IvoryOrange");
}
});
})();
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "174")
{
$("#logo").addClass("logo_Orange");
}
});
})();
<% if env.getenv("CountryCode") == "156" then %>
(function(){
$(document).ready(function(){
var NowStatus = "<%=_G.encodeJS(NowStatus)%>";
var CpRight="";
$("#logo").addClass("logo_CTC");
$("#timeArea").addClass("timeArea_CTC");
if (NowStatus == "showCommonPage")
{
CpRight ="&?ctc_cpRight_001;&nbsp;"+"<span id='pdtVer'><%=_G.encodeHTML(env.getenv("WEBTitle"))%>&nbsp;&nbsp;"+"&?ctc_cpRight_002;&nbsp;"+"<%=_G.encodeHTML(env.getenv("SoftwareVer"))%></span>"
}
else
{
CpRight = "&?ctc_cpRight_001;&nbsp;"+"<span id='pdtVer'><%=_G.encodeHTML(env.getenv("WEBTitle"))%></span>";
}
$("#page_footer").html(CpRight);
$("#JapaneseModify").replaceWith("<img src='img/Jap.jpg' alt='English' class='clickable' id='ctcJapaneseModify'/> &nbsp;");
$("#EnglishModify").replaceWith("<img src='img/eng.png' alt='English' class='clickable' id='ctcEnglishModify'/>");
<%
local retTable = nil
local xmlStr = ""
local UserID
retTable = cmapi.getinst("OBJ_USERID_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
end
if retTable.IF_ERRORID == 0 then
UserID = retTable["UserID"]
end
%>
if($('[id=userid]').length<=0)
{
$("#logUser").after("<div id= 'userid' class='emColor clickable'>"+"&?ctc_userid_001;:&nbsp;&nbsp;"+"<%=UserID%>"+"</div>&nbsp;&nbsp;");
}
$("[rel^='shortcut']").attr("href","/img/favicon.ico;base64,aWNv");
$("#loginWrapper").children().first().text("&?ctc_Login_001;").addClass("loginTitle_CTC");
});
})();
function customTimeStyle(CurrTimeObj, currTimeByXML, template){
var timeStr = timeTranslate(currTimeByXML);
var SecTimeLocation = currTimeByXML.lastIndexOf(":");
var currTimeNotSec = currTimeByXML.substring(0, SecTimeLocation).replace("T"," ");
CurrTimeObj.text(currTimeNotSec);
}
<%
end
%>
(function(){
$(document).ready(function(){
var CountryCode = "<%=env.getenv("CountryCode")%>";
if (CountryCode == "137")
{
$("#logo").attr("class", "logo_Tarr");
}
});
})();
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if "68" == env.getenv("CountryCode") and uRight == "2" then
%>
(function(){
$(document).ready(function(){
$("#pdtVer").empty();
$("#pdtVer").append("<%=_G.encodeHTML(env.getenv("WEBTitle"))%>");
});
})();
<%
end
%>
<% if CountryCode == "128" or CountryCode == "185" or CountryCode == "204" then %>
(function(){
$(document).ready(function(){
$("#logo").addClass("logo_OMA");
$("#timeArea").remove();
$("#logOff").addClass("color_OMA");
});
})();
<%
end
%>
<% if env.getenv("CountryCode") == "124" then %>
(function(){
$(document).ready(function(){
$("#logo").addClass("logo_OMA");
$("#timeArea").remove();
});
})();
<%
end
%>
<% if "136" == CountryCode then %>
(function(){
$(document).ready(function(){
$("#logo").attr("class","logoPTCL");
});
})();
<% end %>
<% if CountryCode == "2009" then %>
(function(){
$(document).ready(function(){
$("#logo").attr("class", "logo_digi");
$("[rel^='shortcut']").attr("href","/img/favicon.ico;base64,aWNv");
});
})();
<%
end
%>
