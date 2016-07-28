<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %> 
<%@page import="gap.warning.util.ReferenceFilter"%>
<%@page import="gap.warning.util.WarningConstants"%> 
<%@page import="gap.warning.info.vo.WarningInfoVo"%>
<%@page import="gap.warning.util.WarningUtils"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%
WarningInfoVo warningInfo = (WarningInfoVo)request.getAttribute("warnInfo");
if(warningInfo.getThreshold()==null){//
    warningInfo.setThreshold("");
}
%>

<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<title><fmt:message key="jsp.warning_info_view"/></title>
<script> 
    var contextpath="<venus:base/>";//声明环境路径
    function goBack(){
        //location.href="<%=request.getContextPath()%>/WarningTemplateAction.do?cmd=queryAllWarningTemplates";
        history.go(-1);
    }
    jQuery(function(){
        jQuery('input[type="text"]').attr("disabled","true");
        jQuery('input[type="checkbox"]').attr("disabled","true");
    });
</script>
</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.warning_info_view"/>','<venus:base/>/');
</script>
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="return"/>" onClick="javascript:goBack()">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.warning_info_view"/>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content"><tr><td>
<table class="viewlistCss" cellspacing="1" cellpadding="0" border="0" align="center">
    <tr>
        <th align="right" width="7%"><fmt:message key="jsp.warning_instance_identifier"/></th>
        <td>
            &nbsp;<bean:write name="warnInfo" property="instanceName"/>
        </td>
   </tr>
    <tr>
        <th align="right"><fmt:message key="jsp.operator"/></th>
        <td>
            &nbsp;<%=ReferenceFilter.get("WarningOperator",warningInfo.getOperator()) %>
        </td>
   </tr>
   <tr>
        <th align="right"><fmt:message key="jsp.threshold"/></th>
        <td id="thresholdTd">
               &nbsp;   <%=warningInfo.getThreshold().replaceAll(WarningConstants.WARNING_SEPARATOR,WarningConstants.WARNING_SEPARATOR_ON_PAGE)%>
        </td>
   </tr>
    <tr>
        <th align="right"><fmt:message key="jsp.business_value"/></th>
        <td id="thresholdTd">
                &nbsp;<bean:write name="warnInfo" property="businessData"/>
        </td>
   </tr>
   <tr>
        <th align="right"><fmt:message key="jsp.message_title"/></th>
        <td>
            &nbsp;<bean:write name="warnInfo" property="title"/> 
        </td>
   </tr>
   <tr>
        <th align="right" valign="top"><fmt:message key="jsp.message_content"/></th>
        <td valign="top">
            &nbsp;<bean:write name="warnInfo" property="content"/>
        </td>
   </tr>
    <tr>
        <th align="right"><fmt:message key="jsp.receiver"/></th>
        <td align="left">
            &nbsp;<bean:write name="warnInfo" property="sendToCn"/>
        </td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="jsp.notify_type"/></th>
        <td align="left" id ="notifyTd">  
                <%
                           String[] notifyTypes = warningInfo.getNotifyType().split("#");
                           for(int i=0;i<notifyTypes.length;i++){
                  %>    
                                &nbsp;<%=ReferenceFilter.get("WarningNotifyType",notifyTypes[i])%>
                  <%             
                           }
                %>
        </td>
    </tr>
    
    <tr>
        <th align="right"><fmt:message bundle='${applicationResources}'  key="status"/></th>
        <td align="left" id ="notifyTd">  
                &nbsp;<%=
                    WarningUtils.getSendReuslt(warningInfo.getIsException())
                %>
        </td>
    </tr>
    
    
    <tr>
        <th align="right"><fmt:message key="jsp.detailed_report"/></th>
        <td align="left" id ="notifyTd">  
                &nbsp;<%=
                           warningInfo.getExceptionInfoOnPage()
                %>
        </td>
    </tr>
    
</table>
</td></tr></table>
</div>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>