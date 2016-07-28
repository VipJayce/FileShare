<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %> 
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@page import="gap.warning.util.ReferenceFilter"%>
<%@page import="gap.warning.util.WarningUtils"%>
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script language="javascript" src="<venus:base/>/js/warning/gap-ajaxList-jquery.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-impromptu.1.8.js"></script >
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<!--提示框，选择框，确认框控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/warning/dialog/jquery-dialog.css" type="text/css">
<title><fmt:message key="jsp.timing_warning_instance_list"/></title>
<script>
    function simpleQuery_onClick(){  //简单的模糊查询
        form.submit();
    }
    
    function add_OnClick(){
        window.location="<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=addPageForwardFromWarningTemplate";
    }
    
    function modify_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);
            return ;
        }

        form.action = "<venus:base/>/WarningObjectAction.do?cmd=find&id=" + getCheckBoxValByName("checkbox_template");
        form.submit();
    }
    function delete_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);
            return ;
        }
        i18n4WarningSystem.delete_prompt(submitForm);
    }
    function submitForm(value,dom){
        if(!value)
            return false;
        form.action = "<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=delete&id=" + getCheckBoxValByName("checkbox_template");
        form.submit();
    }
 function start_OnClick(){//启动实例
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);
            return ;
        }
         form.action = "<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=startWaringInstance&id=" + getCheckBoxValByName("checkbox_template");
         form.submit();
    }
    function pause_OnClick(){//暂停实例
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);
            return ;
        }
         form.action = "<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=pauseWaringInstance&id=" + getCheckBoxValByName("checkbox_template");
         form.submit();
    }
</script>

</head>
<body align="center">
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.timing_warning_instance_list"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=queryAll">

<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
            <fmt:message bundle='${applicationResources}'  key="query_with_condition"/>
        </td>
    </tr>
</table>
</div>
<div id="ccChild0"> 
<table class="table_div_content">

<tr>
    <td align="right" width="10%" nowrap><fmt:message key="jsp.warning_instance_name"/></td>
    <td><input name="instanceName" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_instance_name"/>" validate="isSearch">
    </td>
</tr>
<tr>
    <td align="right" width="10%" nowrap><fmt:message bundle='${applicationResources}'  key="status"/></td>
    <td><select name="status">
                <option value=""><fmt:message key="jsp.all"/></option>
                <option value="0"><fmt:message key="jsp.run"/></option>
                <option value="1"><fmt:message key="jsp.pause"/></option>
                <option value="2"><fmt:message key="jsp.completed"/></option>
            </select>
            <input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onClickTo="javascript:simpleQuery_onClick();">
    </td>
</tr>

</table>

</div>


<div id="ccParent1"> 
<table class="table_div_control">
    <tr > 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="jsp.details_table"/>
        </td>
        <td> 
            <table align="right">
                <tr> 
                    <!-- td class="button_ellipse" onClick="javascript:modify_OnClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"> 修改</td-->
                    <td class="button_ellipse" onClick="javascript:delete_OnClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
                    <td class="button_ellipse" onClick="javascript:start_OnClick();"><img src="<venus:base/>/images/icon/return.gif" class="div_control_image"><fmt:message key="jsp.start"/></td>
                    <td class="button_ellipse" onClick="javascript:pause_OnClick();"><img src="<venus:base/>/images/icon/pause.gif" class="div_control_image"><fmt:message key="jsp.pause"/></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
    <tr>
        <td>
        <layout:collection name="warningInstances" id="warningInstance" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
            <layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
                <venus:sequence/>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.warning_instance_name")%>' property="instanceName" sortable="true" style="text-align:center;">
				<bean:define id="id" name="warningInstance" property="id"/>
				<input type="radio" name="checkbox_template" value="<%=id%>" style="display:none"/>
				<bean:write name="warningInstance" property="instanceName"/>
    		</layout:collectionItem>
    
    		<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.warning_instance_identifier")%>' property="identifier" sortable="true" style="text-align:center;"/>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.trigger_description")%>' property="description" sortable="true" style="text-align:center;"/>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.operator")%>' property="operator" sortable="true" style="text-align:center;">
                     <bean:define id="operator" name="warningInstance" property="operator"/>
                <%=ReferenceFilter.get("WarningOperator",String.valueOf(operator))%>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.threshold")%>' property="threshold" sortable="true" style="text-align:center;">
                    <bean:define id="threshold" name="warningInstance" property="threshold"/>
                    <%=((String)threshold).replaceAll(WarningConstants.WARNING_SEPARATOR,WarningConstants.WARNING_SEPARATOR_ON_PAGE) %>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("status")%>'  property="status" sortable="true" style="text-align:center;">
                       <bean:define id="status" name="warningInstance" property="status"/>
                <%=WarningUtils.getWarningInstanceStatus(String.valueOf(status))%>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.last_trigger_time")%>'   sortable="false" style="text-align:center;">
                <bean:define id="triggerVo" name="warningInstance" property="triggerVo" />
                <logic:notEmpty name="triggerVo">
                    <!-- 因为在trigger表中，如果没有上一此执行时间，则表中字段值为“-1”，而在jsp中则是1970年，解决此bug，添加判断 -->
                    <logic:notEqual value="-1" name="triggerVo" property="prevTime">
                        <%=WarningConstants.DATE_FORMAT.format(new Date(Long.parseLong(((WarningTriggerVo)triggerVo).getPrevTime()))) %>
                    </logic:notEqual>
                 </logic:notEmpty>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.next_trigger_time")%>'   sortable="false" style="text-align:center;">
                <bean:define id="triggerVo" name="warningInstance" property="triggerVo" />
                <logic:notEmpty name="triggerVo">
                    <logic:notEqual value="-1" name="triggerVo" property="nextTime">
                        <%=WarningConstants.DATE_FORMAT.format(new Date(Long.parseLong(((WarningTriggerVo)triggerVo).getNextTime()))) %>
                    </logic:notEqual>
                 </logic:notEmpty>
            </layout:collectionItem>
        </layout:collection>
        <jsp:include page="/jsp/include/page.jsp" />
        </td>
    </tr>
</table>
</div>
</form>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>

</body>
<%@page import="gap.warning.util.WarningConstants"%>
<%@page import="gap.warning.instance.model.WarningTriggerVo"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
</html>
</fmt:bundle>
<%  //表单回写
    if(request.getAttribute("writeBackFormValues") != null) {
        out.print("<script language=\"javascript\">\n");
        out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
        out.print("writeBackMapToForm();\n");
        out.print("</script>");
    }
%>