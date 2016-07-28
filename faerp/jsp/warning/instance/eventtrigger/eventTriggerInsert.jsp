<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.Iterator"%>
<%@page import="java.util.Map,java.util.List"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ page import="gap.warning.instance.model.WarningInstance"%>
<%@ page import="gap.warning.instance.model.WarningInstanceMessageVo"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@page import="gap.warning.util.ReferenceFilter"%>
<%@page import="gap.warning.util.WarningConstants"%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%  
        WarningInstance warningInstance=(WarningInstance)request.getAttribute("vo");

		if(warningInstance.getThreshold()==null){//
		    warningInstance.setThreshold("");
		}
        String templateName = (String)request.getAttribute("templateName");
        boolean isModify = false,isView = false;
		if(request.getParameter("isModify") != null) {
		    isModify = true;
		}
        if(warningInstance==null) warningInstance=new WarningInstance();
        WarningInstanceMessageVo    messageVo=warningInstance.getMessageVo();
        VoHelper.null2Nothing(messageVo); 
        
        EnumRepository er = EnumRepository.getInstance();
        er.loadFromDir();
        EnumValueMap WarningNotifyTypeMap = er.getEnumValueMap("WarningNotifyType");
    %>
<title><%=isModify?LocaleHolder.getMessage("gap.warningsystem.jsp.realtime_warning_instance_modify"):LocaleHolder.getMessage("gap.warningsystem.jsp.realtime_warning_instance_add")%></title>
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/warning/warning-common.jsp"></script>
<!-- gap api用到的js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/reference/reference.jsp"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrwarning/interface/WarningAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrwarning/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrwarning/util.js'></script>
<script>
    var contextpath="<venus:base/>";//声明环境路径
    jQuery(function(){
        setThesholdType();
        <%if(!StringUtils.isEmpty(templateName)){%>
            jQuery('input[name="templateName"]').val('<%=templateName%>');
        <%}%>
        
    });
    function insert_onClick(){  //增加记录
    	if(!validateIdentifier()) return;
        if(!setNotifyType()||!setTheshold())
            return;
        if(checkAllForms()){
            form.action = "<venus:base/>/WarningInstanceEventTriggerAction.do?cmd=insert";
            form.submit();
        }
    }
     function modify_onClick(){  //修改记录
    	if(!validateIdentifier()) return;
        if(!setNotifyType())
            return;
        setTheshold();
        if(checkAllForms()){
            form.action = "<venus:base/>/WarningInstanceEventTriggerAction.do?cmd=update";
            form.submit();
        }
    }
   
    function goBack(){
        location.href="<%=request.getContextPath()%>/WarningInstanceEventTriggerAction.do?cmd=queryAll";
    }
    
</script>

</head>
<body>
<script language="javascript">
    writeTableTop('<%=isModify?LocaleHolder.getMessage("gap.warningsystem.jsp.realtime_warning_instance_modify"):LocaleHolder.getMessage("gap.warningsystem.jsp.realtime_warning_instance_add")%>','<venus:base/>/');
</script>

<form name="form" method="post">
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="<%=isModify?"javascript:modify_onClick()":"javascript:insert_onClick()" %>">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>"  onClick="javascript:goBack()">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><%=isModify?LocaleHolder.getMessage("gap.warningsystem.jsp.realtime_warning_instance_modify"):LocaleHolder.getMessage("gap.warningsystem.jsp.realtime_warning_instance_add")%>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
    <tr> 
        <td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key="jsp.warning_instance_name"/></td>
        <td align="left">
            <input name="instanceName" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_instance_name"/>" validate="notNull;checkInvalidString" value="<%=warningInstance.getInstanceName() %>">   
            <input name="id" type="hidden" value="<%=warningInstance.getId() %>"/>      
        </td>
    </tr>
    <tr>
        <td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key="jsp.warning_instance_identifier"/></td>
        <td align="left">
            <input name="identifier" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_instance_identifier"/>" validate="notNull;checkInvalidString" value="<%=warningInstance.getIdentifier() %>">         
        </td>
    </tr>
    <tr> 
        <td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key="jsp.warning_template_name"/></td>
        <td align="left">
            <input type="hidden" name="templateId"  value="<%=warningInstance.getTemplateId()%>"/>
            <input name="templateName" readonly="true" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_template_name"/>" validate="notNull;checkInvalidString" value="<%=warningInstance.getTemplateName() %>">           
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.warning_object_name"/></td>    
        <td align="left">
            <input name="objectName" inputName="<fmt:message key="jsp.warning_object_name"/>" type="text"  class="text_field" id="objectName" value="<%=warningInstance.getWarnObject().getObjectName()%>"size="20" readOnly="true"  validate=" isNormalStrOnWeb">
            <input name="warnObjectId" type="hidden" id="objectId" value="<%=warningInstance.getWarnObject().getId()%>"/>
            <input id="returnType" type="hidden" value="<%=warningInstance.getWarnObject().getReturnType()%>"/>
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.operator"/></td>
        <td>
              <select name="operator" id="operator" onchange="changeThreshold(this)" value="<%=warningInstance.getOperator()%>">
                   <% 
                            List operatorList = (List)request.getAttribute("operator");
                            for(int i=0;i<operatorList.size();i++){
                      %>
                                    <option value="<%=operatorList.get(i) %>"><%=ReferenceFilter.get("WarningOperator",(String)operatorList.get(i)) %></option>
                       <%         
                                 }
                         %>
                        <script type="text/javascript">
                                jQuery("option[value='<%=warningInstance.getOperator()%>']").attr('selected','true');
                        </script>

              </select>
               
        </td>
   </tr>
   <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.threshold"/></td>
        <td id="thresholdTr">
                <table>
                    <tr>
                        <td style="padding: 0px;">
                         <input name="threshold" id="threshold" type="hidden" value="<%=warningInstance.getThreshold()%>">
                <input name="threshold1"  id="threshold1" type="text" class="text_field" inputName="<fmt:message key="jsp.threshold"/>" validate="notNull" value="<%=warningInstance.getThreshold().split(WarningConstants.WARNING_SEPARATOR)[0]%>">
                        </td>
                   <td align="left"  id="thresholdTd" style="padding: 0px;"> 
                    <%
                            String[] threshold = warningInstance.getThreshold().split(WarningConstants.WARNING_SEPARATOR);
                            if(threshold.length>1){
                      %>
                                    <div id="div2">～<input name="threshold2"  id="threshold2" type="text" class="text_field temp" inputName="<fmt:message key="jsp.threshold"/>" validate="notNull"></div>
                                    <script type="text/javascript">
                                             jQuery("#threshold2").val('<%=threshold[1]%>');
                                     </script>
                      <%          
                            }
                    %>
        </td>
                    </tr>
                </table>
        </td>
   </tr>
   <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.message_title"/></td>
        <td>
            <input name="title" type="text" class="text_field" inputName="<fmt:message key="jsp.message_title"/>" validate="notNull;checkInvalidString" value="<%=messageVo.getTitle() %>"> 
        </td>
   </tr>
   <tr>
        <td align="right" valign="top"><font color="red">*</font><fmt:message key="jsp.message_content"/></td>
        <td valign="top">
            <textarea name="msgTemplate"  class="textarea_limit_words" cols="60" rows="5" maxLength="600" inputName="<fmt:message key="jsp.message_content"/>" validate="notNull;checkInvalidString" ><%=messageVo.getMsgTemplate()%></textarea> 
        </td>
   </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.receiver"/></td>
        <td align="left">
             <input name=sendToCn type="text" class="text_field_reference" inputName="<fmt:message key="jsp.receiver"/>" readonly="readonly"  validate="notNull" value="<%=messageVo.getSendToCn()%>"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" id="object_reference" onClick="organizationRefrenceTree(document.all('sendTo'),document.all('sendToCn'))"/>
            <input type="hidden" name="sendTo" value="<%=messageVo.getSendTo()%>">
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.notify_type"/>&nbsp;<input type="hidden" name="notifyType"/></td>
        <td align="left" id ="notifyTd" >
                                 <%
                                 List al = WarningNotifyTypeMap.getEnumList();
                                 for(int i=0;i<al.size();i++){

                                  %>
                                        <input name='notifyTypeTemp'  type='checkbox'  value='<%=WarningNotifyTypeMap.getValue(al.get(i).toString())%>'/><%=al.get(i)%>&nbsp;
                                  <%
                                     }
                                   //设置哪个通知类型被选中
                                         String[] notifyTypes = messageVo.getNotifyType().split(WarningConstants.WARNING_SEPARATOR);
                                         for(int i=0;i<notifyTypes.length;i++){
                                   %>
                                           <script>
                                            jQuery(':checkbox[value="<%=notifyTypes[i]%>"]').attr("checked","true");
                                         </script>     
                                   <%
                                         }
                                %>
        </td>
    </tr>
</table>
</div>


</form>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
<%@page import="org.apache.commons.lang.StringUtils"%>
</html>
</fmt:bundle>