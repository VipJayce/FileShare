<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %> 
<%@ page import="gap.warning.template.model.WarningTemplate"%>
<%@ page import="gap.warning.util.ReferenceFilter" %>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%
       WarningTemplate warningTemplate = (WarningTemplate)request.getAttribute("template");
		if(warningTemplate.getThreshold()==null){//
		    warningTemplate.setThreshold("");
}
%>

<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/plugin/jquery-impromptu.1.8.js"></script>
<link rel="stylesheet" href="<venus:base/>/css/warning/dialog/jquery-dialog.css" type="text/css">
<title><fmt:message key="jsp.warning_template_view"/></title>
<script>
    var contextpath="<venus:base/>";//声明环境路径
    function goBack(){
        location.href="<%=request.getContextPath()%>/WarningTemplateAction.do?cmd=queryAllWarningTemplates";
    }
    function view_nstance(){
      var txt = '<input type="radio" id="realtime" checked="true" name="target"/>'+i18n4WarningSystem.real_time_warning+'&nbsp;<input type="radio" id="timeInstance" name="target" value="fixtime"/>'+i18n4WarningSystem.timing_warning;
       i18n4WarningSystem.deploy_warning_instance_prompt(txt);
       jQuery("#realtime").attr("tmd","true");
       jQuery('#timeInstance').click(function(){jQuery("#realtime").removeAttr("tmd");});
       jQuery("#realtime").click(function(){ jQuery("#realtime").attr("tmd","true");});
    }
    function mycallbackform(value,innerDiv){
        if(value=='cancle')return;
        var templateiId = jQuery('#warnTemplateId').val(); 
        if( jQuery('#realtime',innerDiv).attr("tmd")=='true')
            window.location="<venus:base/>/WarningInstanceEventTriggerAction.do?cmd=queryAll&templateId=" + templateiId;
        else
            window.location="<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=queryAll&templateId=" + templateiId;
    }
    jQuery(function(){
        jQuery('input[type="text"]').attr("disabled","true");
        jQuery('input[type="checkbox"]').attr("disabled","true");
    });
</script>
</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.warning_template_view"/>','<venus:base/>/');
</script>
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message key="jsp.view_related_warning_instance"/>"  onClick="javascript:view_nstance()">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="return"/>" onClick="javascript:history.go(-1)">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.warning_template_view"/>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content"><tr><td>
<table class="viewlistCss" cellspacing="1" cellpadding="0" border="0" align="center">
    <tr> 
        <th align="right" width="8%" nowrap>&nbsp;<fmt:message key="jsp.warning_template_name"/></th>
        <td align="left">
           &nbsp;<bean:write name="template" property="templateName"/>
           <input type="hidden" id="warnTemplateId" value="<bean:write name="template" property="id"/>" /> 
        </td>
    </tr>
    <tr>
        <th align="right"> &nbsp;<fmt:message key="jsp.warning_object_name"/></th>    
        <td align="left">
           &nbsp;<bean:write name="template" property="warnObject.objectName"/>
        </td>
    </tr>
    <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.operator"/></th>
        <td>
            &nbsp;<%=ReferenceFilter.get("WarningOperator",warningTemplate.getOperator()) %>
        </td>
   </tr>
   <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.threshold"/></th>
        <td id="thresholdTd">
        
               <%=warningTemplate.getThreshold().replaceAll(WarningConstants.WARNING_SEPARATOR,WarningConstants.WARNING_SEPARATOR_ON_PAGE) %>
        </td>
   </tr>
   <tr>
        <th align="right" valign="top">&nbsp;<fmt:message key="jsp.message_title"/></th>
        <td valign="top">
            &nbsp;<bean:write name="template" property="title"/> 
        </td>
   </tr>
   <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.message_content"/></th>
        <td>
            &nbsp;<bean:write name="template" property="msgTemplate"/>
        </td>
   </tr>
    <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.receiver"/></th>
        <td align="left">
            &nbsp;<bean:write name="template" property="sendToCn"/>
        </td>
    </tr>
    <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.notify_type"/></th>
        <td align="left" id ="notifyTd" >
                <%
                           String[] notifyTypes = warningTemplate.getNotifyType().split("#");
                           for(int i=0;i<notifyTypes.length;i++){
                  %>    
                              &nbsp;<%=ReferenceFilter.get("WarningNotifyType",notifyTypes[i])%>
                  <%             
                           }
                %>
        </td>
    </tr>
</table>
</td></tr></table></div>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
<%@page import="gap.warning.util.WarningConstants"%>
</html>
</fmt:bundle>