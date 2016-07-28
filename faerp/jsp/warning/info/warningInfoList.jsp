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
<title><fmt:message key="jsp.warning_info_list"/></title>
<script>
    function simpleQuery_onClick(){  //简单的模糊查询
        form.submit();
    }
    function delete_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);//提示框
            return ;
        }
        i18n4WarningSystem.delete_prompt(submitForm);
    }
    function submitForm(value,dom){
        if(!value)
            return false;
        form.action = "<venus:base/>/WarningInfoAction.do?cmd=deleteWarningInfosByIds&ids=" + getCheckBoxValByName("checkbox_template");
        form.submit();
    }
    function deleteByDate_onClick(){
        if(jQuery('input[name="beginTime"]').val()==""&&jQuery('input[name="endTime"]').val()==""){
            jQuery.prompt(i18n4WarningSystem.please_select_start_or_end_time);
            hideWait();
            return false;
        }
        i18n4WarningSystem.delete_prompt(deleteByDate_callbackform);
    }
    
    function deleteByDate_callbackform(value,dom){
		if(!value){
		    hideWait();
		    return false;
		}
		form.action = "<venus:base/>/WarningInfoAction.do?cmd=deleteWarningInfosByDate";
		form.submit();
    }
    
    
    function detail_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);//提示框
            return ;
        }
        if(getCheckBoxSizeByName("checkbox_template")>1){
            jQuery.prompt(i18n.can_only_select_a_record);//提示框
            return ;
        }
        form.action = "<venus:base/>/WarningInfoAction.do?cmd=getWarningInfo&id=" + getCheckBoxValByName("checkbox_template");
        form.submit();
    }
</script>

</head>
<body align="center">
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.warning_info_list"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/WarningInfoAction.do?cmd=queryAllWarningInfos">

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
    <td align="right" width="10%" nowrap><fmt:message key="jsp.start_time"/></td>
    <td><input id="beginTime" name="beginTime" type="text" readonly="true" class="text_field_reference" inputName="<fmt:message key="jsp.start_time"/>" validate="isSearch">
    <img src="<venus:base/>/images/icon/reference.gif"  onClick="javascript:getYearMonthDay('beginTime','<venus:base/>/')" class="img_1">
    </td>
</tr>
<tr>
    <td align="right"  nowrap><fmt:message key="jsp.end_time"/></td>
    <td><input id="endTime" name="endTime" type="text" readonly="true" class="text_field_reference" inputName="<fmt:message key="jsp.end_time"/>" validate="isSearch">
    <img src="<venus:base/>/images/icon/reference.gif"  onClick="javascript:getYearMonthDay('endTime','<venus:base/>/')" class="img_1">
    </td>
</tr>
<tr>
    <td align="right"  nowrap><fmt:message bundle='${applicationResources}'  key="status"/></td>
    <td>
        <select  name="isException">
            <option value=""><fmt:message key="jsp.all"/></option>
            <option value="0"><fmt:message key="jsp.send_failed"/></option>
            <option value="1"><fmt:message key="jsp.send_successfully"/></option>
        </select>
        <input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="delete"/>" onClick="javascript:deleteByDate_onClick();">
        <input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onClick="javascript:simpleQuery_onClick();">
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
                    <td class="button_ellipse" onClick="javascript:detail_OnClick();"><img src="<venus:base/>/images/icon/view.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="view"/></td>
                    <td class="button_ellipse" onClick="javascript:delete_OnClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
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
        <layout:collection name="warningInfos" id="warningInfo" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
            <layout:collectionItem width="5%"  title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
                <bean:define id="id" name="warningInfo" property="id"/>
                <input type="checkbox" name="checkbox_template" value="<%=id%>"/>
            </layout:collectionItem>
            <layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
                <venus:sequence/>
            </layout:collectionItem>
            <layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.warning_instance_name")%>' property="instanceName" sortable="true" style="text-align:center;"/>
            
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.instance_type")%>' property="instanceType" sortable="true" style="text-align:center;">
                     <bean:define id="instanceType" name="warningInfo" property="instanceType"/>
                     <%=ReferenceFilter.get("WarningInstanceType",String.valueOf(instanceType))%>
            </layout:collectionItem>
            
            
            <layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.business_value")%>' property="businessData" sortable="true" style="text-align:center;"/>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.operator")%>' property="operator" sortable="true" style="text-align:center;">
                    <bean:define id="operator" name="warningInfo" property="operator"/>
                <%=ReferenceFilter.get("WarningOperator",String.valueOf(operator))%>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.threshold")%>' property="threshold" sortable="true" style="text-align:center;">
                    <bean:define id="threshold" name="warningInfo" property="threshold"/>
                    <%=((String)threshold).replaceAll(WarningConstants.WARNING_SEPARATOR,WarningConstants.WARNING_SEPARATOR_ON_PAGE) %>
            </layout:collectionItem>
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.notify_type")%>' property="notifyType" sortable="true" style="text-align:center;">
                     <bean:define id="notifyType" name="warningInfo" property="notifyType"/>
                <%
                String[] types = ((String)notifyType).split(WarningConstants.WARNING_SEPARATOR);
                for(int i=0;i<types.length;i++){
                    out.print(ReferenceFilter.get("WarningNotifyType",types[i])+"&nbsp;");
                }
                %>
            </layout:collectionItem>
            
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("status")%>' property="isException" sortable="true" style="text-align:center;">
                     <bean:define id="isException" name="warningInfo" property="isException"/>
                <%=WarningUtils.getSendReuslt(String.valueOf(isException))%>
            </layout:collectionItem>
            
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.create_time")%>' property="createTime" sortable="true" style="text-align:center;"/>
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