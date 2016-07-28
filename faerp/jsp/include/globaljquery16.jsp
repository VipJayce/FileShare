<%@ page errorPage="/jsp/include/errorpage.jsp" %>
<%@ page import="royoo.common.TagSortUitl" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
 <%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ taglib uri="/WEB-INF/gap-i18n.tld" prefix="i18n" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/gap-authority.tld" prefix="au" %>
<%@ taglib uri="/WEB-INF/gap-bnLog.tld" prefix="bnLog" %>
<%@ taglib uri="/WEB-INF/gap-data.tld" prefix="data" %>
<%@ taglib uri="/WEB-INF/gap-faerp.tld" prefix="faerp" %>

<%System.out.println("jsp-----------"+request.getRequestURI()); %>
<html>
<head>


<script language="javascript">
	var dir_base = "<venus:base/>";
</script>

<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.6.1.min.js"></script>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<link href="<venus:base/>/css/alex-css" type="text/css" rel="stylesheet">
<!-- liuping add -->
<link href="<venus:base/>/css/common.css" type="text/css" rel="stylesheet">

<link href="<venus:base/>/css/index.css" type="text/css" rel="stylesheet">

<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>

<script language="javascript" src="<venus:base/>/js/common/gap-mainframe.js"></script>
<script language="javascript" src="<venus:base/>/js/common/gap-validate.js"></script>
<script language="javascript" src="<venus:base/>/js/common/gap-waiting.js"></script>
<script language="javascript" src="<venus:base/>/js/common/gap-collection.js"></script>
<script language="javascript" src="<venus:base/>/js/common/gap-status.js"></script>
<script language="javascript" src="<venus:base/>/js/au/gap-authority.js"></script>
<script language="javascript" src="<venus:base/>/js/gap-alex.js"></script>
<script language="javascript" src="<venus:base/>/js/faerp/searchselectvalidate.js"></script>

<script language="javascript" src="<venus:base/>/js/rm-tools.js"></script>
<script language="javascript" src="<venus:base/>/js/common.js"></script>


<script language="javascript" src="<venus:base/>/js/common/gap4htc.js"></script>
<script for=document event="oncontextmenu()" language="javascript">
	/*disable the right key*/
	//return false;

</script>

<script STYLE="behavior:url(#default#savehistory)" ID="oVenusPersistElement" onsave="fnSave()" onload="fnLoad()">
	function fnSave(){
		if(venus_Msg_Status != null)
			oVenusPersistElement.setAttribute("sVenusPersistState",venus_Msg_Status);
	}
	function fnLoad(){
		var tmpvenus_Msg_Status = oVenusPersistElement.getAttribute("sVenusPersistState");
		if(!(typeof tmpvenus_Msg_Status== "undefined") && tmpvenus_Msg_Status != null)
		{
			venus_Msg_Status = tmpvenus_Msg_Status;
		}
	}
</script>

 <SCRIPT LANGUAGE="JavaScript">
    document.onkeydown=function(event) {
        var event = (event) ? event : ((window.event) ? window.event : "") 
        var key = event.keyCode ? event.keyCode:event.which;
        if((event.altKey) && (key == 37 || key == 39)){
            alert("'ALT'+'<-' and 'ALT'+'->' is disabled.");
            event.cancelBubble = true;
            return false;
        }
        var srcElement = event.srcElement?event.srcElement:event.target;
        if ((key == 8) && (srcElement.tagName == "TEXTAREA" || srcElement.tagName == "INPUT"))
        {
            return;
        }
        if ((!(event.altKey)) && (key == 37 || key == 39) && (srcElement.tagName == "TEXTAREA" || srcElement.tagName == "INPUT"))
        {
            return;
        }
        if ((key == 38 || key == 40) && (srcElement.tagName == "TEXTAREA"))
        {
            return;
        }
        if ((key==116) || (key==13 && srcElement.type != "textarea")
            || ((event.ctrlKey)&&(key==78)) //disable Ctrl+n
            || ((event.shiftKey)&&(key==121)) //disable shift+F10
            || ((event.ctrlKey)&&(key==115)) //disable Ctrl+F4
            || (key== 8) //disable Back Space
        ){
            event.cancelBubble = true;
            return false;
        }
    }
</SCRIPT>

<!--msg start-->
<venus:message kind="script"/>
<!--msg end-->