<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %> 
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="gap.warning.util.ReferenceFilter"%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/warning/gap-ajaxList-jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/plugin/jquery-impromptu.1.8.js"></script>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<link rel="stylesheet" href="<venus:base/>/css/warning/dialog/jquery-dialog.css" type="text/css">
<title><fmt:message key="jsp.warning_template_list"/></title>
<script>
    function simpleQuery_onClick(){  //简单的模糊查询
        form.submit();
    }
    function add_OnClick(){
        window.location="<venus:base/>/jsp/warning/template/warningTemplateInsert.jsp";
    }
    function modify_OnClick(){
             var id = getCheckBoxValByName("checkbox_template");
             if(!id){
                 jQuery.prompt(i18n.please_select_a_record);//提示框
                 return;
             }
            window.location="<venus:base/>/WarningTemplateAction.do?cmd=initModifyTemplate&isModify=true&id=" + id;
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
        window.location="<venus:base/>/WarningTemplateAction.do?cmd=deleteWarningTemplate&id=" + getCheckBoxValByName("checkbox_template");
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
        window.location = "<venus:base/>/WarningTemplateAction.do?cmd=getWarningTemplate&id=" + getCheckBoxValByName("checkbox_template");
    }
    function toggleCheckAttr(id){
        if(jQuery('#realtime').val())
            jQuery('#realtime').val(id);
        else
            jQuery('#realtime').val();
    }
     function release_OnClick(){
         var id = getCheckBoxValByName("checkbox_template");
         if(!id){
                  jQuery.prompt(i18n.please_select_a_record);
                 return;
         }
       var txt = '<input type="radio" id="realtime" checked="true" value="'+id+'" name="target"/>'+i18n4WarningSystem.real_time_warning+'&nbsp;<input type="radio" id="timeInstance" name="target" value="fixtime"/>'+i18n4WarningSystem.timing_warning;
       i18n4WarningSystem.deploy_warning_instance_prompt(txt);
       jQuery("#realtime").attr("tmd","true");
       jQuery('#timeInstance').click(function(){jQuery("#realtime").removeAttr("tmd");});
       jQuery("#realtime").click(function(){ jQuery("#realtime").attr("tmd","true");});
    }
    function mycallbackform(value,innerDiv){
        if(value=='cancle')return;
        var id = jQuery('#realtime',innerDiv).val(); 
       if( jQuery('#realtime',innerDiv).attr("tmd")=='true'){
           window.location="<venus:base/>/WarningInstanceEventTriggerAction.do?cmd=addPageForwardFromWarningTemplate&templateId=" + id;
      }else{
            window.location="<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=addPageForwardFromWarningTemplate&templateId=" + id;
      }
    }
</script>

</head>
<body align="center">
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.warning_template_list"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/WarningTemplateAction.do?cmd=queryAllWarningTemplates">

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
    <td align="right" width="10%" nowrap><fmt:message key="jsp.warning_template_name"/></td>
    <td>
        <input name="templateName" type="text" class="text_field" inputName="<fmt:message key="jsp.object.warning_template_name"/>" validate="isSearch" >
    </td>
</tr>
<tr>
    <td align="right" width="10%" nowrap><fmt:message key="jsp.warning_object_name"/></td>
    <td>
        <input name="warnObjectName" type="text" class="text_field" inputName="<fmt:message key="jsp.object.warning_object_name"/>" validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onClickTo="javascript:simpleQuery_onClick();">
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
                    <td class="button_ellipse" onClick="javascript:add_OnClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
                    <td class="button_ellipse" onClick="javascript:modify_OnClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
                    <td class="button_ellipse" onClick="javascript:delete_OnClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
                    <td class="button_ellipse" onClick="javascript:detail_OnClick();"><img src="<venus:base/>/images/icon/view.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="view"/></td>
                    <td class="button_ellipse" onClick="javascript:release_OnClick();"><img src="<venus:base/>/images/icon/publish.gif" class="div_control_image"><fmt:message key="jsp.deploy"/></td>
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
        <layout:collection name="warningTemplates" id="warningTemplate" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
            <layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
                <venus:sequence/>
            </layout:collectionItem>
            <layout:collectionItem width="20%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_name")%>' property="templateName" sortable="true" style="text-align:center;">
                <bean:define id="objId" name="warningTemplate" property="id"/>
                <input type="radio" name="checkbox_template" value="<%=objId%>" style="display:none"/>
				<bean:write name="warningTemplate" property="templateName"/>
            </layout:collectionItem>
            <layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.warning_object_name")%>' sortable="true" style="text-align:center;">
                 <bean:define id="warnObj" name="warningTemplate" property="warnObject"/>
                 <bean:write name="warnObj" property="objectName"/>
            </layout:collectionItem>
            <layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.operator")%>' property="operator" sortable="true" style="text-align:center;">
                 <bean:define id="operator" name="warningTemplate" property="operator"/>
                <%=ReferenceFilter.get("WarningOperator",String.valueOf(operator))%>
            </layout:collectionItem>
            <layout:collectionItem width="20%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.threshold")%>' property="threshold" sortable="true" style="text-align:center;">
                    <bean:define id="threshold" name="warningTemplate" property="threshold"/>
                    <%=((String)threshold).replaceAll(WarningConstants.WARNING_SEPARATOR,WarningConstants.WARNING_SEPARATOR_ON_PAGE) %>
            </layout:collectionItem>
            <layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.notify_type")%>' property="notifyType" sortable="true" style="text-align:center;">
                 <bean:define id="notifyType" name="warningTemplate" property="notifyType"/>
                <%
                String[] types = ((String)notifyType).split(WarningConstants.WARNING_SEPARATOR);
                for(int i=0;i<types.length;i++){
                    out.print(ReferenceFilter.get("WarningNotifyType",String.valueOf(types[i]))+"&nbsp;");
                }
                %>
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