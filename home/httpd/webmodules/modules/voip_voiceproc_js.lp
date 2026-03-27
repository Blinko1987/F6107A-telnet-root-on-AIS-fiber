<script type="text/javascript">
(function(){
function initial_template_VOICEPROC(templateID)
{
var template = $("#"+templateID);
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template);
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_VOIPVOICEPROC_ID"];
ActionByCancelResult(xml, template, OBJID);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var lineIndex = parseInt(suffix, 10)+1;
var isTR104v2 = "<%=env.getenv("VoIPTR104V2") %>";
var languageTag = (isTR104v2 == 1)? "&?public_017;" : "&?SipAdvanced_019;";
$("[id^='instName_VOICEPROC:']", ContainerOBJ).text(languageTag+lineIndex);
});
}
$(document).ready(function(){
var VOICEPROCHeadID = "VOICEPROC";
var VOICEPROCHead = $("#"+VOICEPROCHeadID);
var ServerAddr = $("address span", VOICEPROCHead).text();
initial_template_VOICEPROC("template_"+VOICEPROCHeadID);
VOICEPROCHead.succfunction = function(xml){
VOICEPROCHead.hasError(xml);
var VOICEPROCOBJ = $(xml).find("OBJ_VOIPVOICEPROC_ID");
var RuleNum = $("Instance", VOICEPROCOBJ).length;
var OBJID = ["OBJ_VOIPVOICEPROC_ID"];
VOICEPROCHead.createPageDataByClone(RuleNum, OBJID, xml);
};
if ( $(".collapBarWithDataTrans",VOICEPROCHead).length <= 0 )
{
VOICEPROCHead.dataTransfer(ServerAddr, "GET", VOICEPROCHead.succfunction);
}
else
{
initial_collapBarWithDataTrans(VOICEPROCHead);
}
});
})();
</script>
