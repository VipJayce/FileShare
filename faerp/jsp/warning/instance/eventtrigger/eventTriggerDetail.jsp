<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="java.util.Map"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="gap.warning.util.ReferenceFilter"%>
<%@ page import="gap.warning.instance.model.WarningInstance"%>
<%@ page import="gap.warning.instance.model.WarningInstanceMessageVo"%>
<%@page import="gap.warning.util.WarningConstants"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%   
        WarningInstance warningInstance=(WarningInstance)request.getAttribute("vo");
        String templateName = (String)request.getAttribute("templateName");
        WarningInstanceMessageVo    messageVo=warningInstance.getMessageVo();
        VoHelper.null2Nothing(messageVo); 
        if(warningInstance.getThreshold()==null){//
            warningInstance.setThreshold("");
        }
    %>
<title><fmt:message key="jsp.realtime_warning_instance_view"/></title>
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script>
    var contextpath="<venus:base/>";//声明环境路径
    jQuery(function(){
        <%if(!StringUtils.isEmpty(templateName)){%>
            jQuery('#templateName').text('<%=templateName%>');
        <%}%>
    });

</script>

</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.realtime_warning_instance_view"/>','<venus:base/>/');
</script>

<form name="form" method="post">
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="return"/>"  onClick="javascript:history.go(-1);">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.realtime_warning_instance_view"/>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content"><tr><td>
<table class="viewlistCss" cellspacing="1" cellpadding="0" border="0" align="center">
    <tr> 
        <th align="right"  width="8%" nowrap>&nbsp;<fmt:message key="jsp.warning_instance_name"/></th>
        <td align="left">
            <%=warningInstance.getInstanceName() %>
        </td>
    </tr>
    <tr>
        <th align="right"   nowrap> &nbsp;<fmt:message key="jsp.warning_instance_identifier"/></th>
        <td align="left">
           <%=warningInstance.getIdentifier() %>
        </td>
    </tr>
    <tr> 
        <th align="right"   nowrap> &nbsp;<fmt:message key="jsp.warning_template_name"/></th>
        <td align="left" id="templateName">
        </td>
    </tr>
    <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.warning_object_name"/></th>    
        <td align="left">
            <%=warningInstance.getWarnObject().getObjectName()%>
            <input id="returnType" type="hidden" value="<%=warningInstance.getWarnObject().getReturnType()%>"/>
        </td>
    </tr>
    <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.operator"/></th>
        <td>
                     <%=ReferenceFilter.get("WarningOperator",warningInstance.getOperator()) %>
              </select>
               
        </td>
   </tr>
   <tr>
        <th align="right"> &nbsp;<fmt:message key="jsp.threshold"/></th>
        <td>
                <%=warningInstance.getThreshold().replaceAll(WarningConstants.WARNING_SEPARATOR,WarningConstants.WARNING_SEPARATOR_ON_PAGE)  %>
        </td>
   </tr>
   <tr>
        <th align="right"> &nbsp;<fmt:message key="jsp.message_title"/></th>
        <td>
            <%=messageVo.getTitle() %>
        </td>
   </tr>
   <tr>
        <th align="right" valign="top"> &nbsp;<fmt:message key="jsp.message_content"/></th>
        <td valign="top">
           <%=messageVo.getMsgTemplate()%>
        </td>
   </tr>
    <tr>
        <th align="right">&nbsp;<fmt:message key="jsp.receiver"/></th>
        <td align="left">
           <%=messageVo.getSendToCn()%>
        </td>
    </tr>
    <tr>
        <th align="right"> &nbsp;<fmt:message key="jsp.notify_type"/></th>
        <td align="left">
                 <%
                           String[] notifyTypes = messageVo.getNotifyType().split("#");
                           for(int i=0;i<notifyTypes.length;i++){
                  %>    
                              <%=ReferenceFilter.get("WarningNotifyType",notifyTypes[i])%>&nbsp;
                  <%             
                           }
                %>
        </td>
    </tr>
</table>
</td></tr></table>
</div>


</form>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
<%@page import="org.apache.commons.lang.StringUtils"%>
</html>
</fmt:bundle>