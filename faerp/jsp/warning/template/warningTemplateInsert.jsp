<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ page import="gap.warning.template.model.WarningTemplate"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@ page import="java.util.Map" %>
<%@ page import="gap.warning.util.ReferenceFilter" %>
<%@page import="gap.warning.util.WarningConstants"%>
<%@page import="gap.warning.object.model.WarningObject"%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%  //判断是否为修改页面
        boolean isModify = false;
        if(request.getParameter("isModify") != null) {
            isModify = true;
        }
        WarningTemplate warningTemplate=(WarningTemplate)request.getAttribute("vo");
        
        if(warningTemplate==null){
            warningTemplate=new WarningTemplate();
            WarningObject warnObj = new WarningObject();
            VoHelper.null2Nothing(warnObj);
            warningTemplate.setWarnObject(warnObj);
        }
        VoHelper.null2Nothing(warningTemplate);
        
        EnumRepository er = EnumRepository.getInstance();
        er.loadFromDir();
        EnumValueMap warningTypeMap = er.getEnumValueMap("WarningNotifyType");
    %>
<!--参照控件显示的样式-->
<link rel="stylesheet" href="<venus:base/>/css/jquery/flora.dialog.css" type="text/css">

<script type='text/javascript' src='<%=request.getContextPath()%>/dwrwarning/interface/WarningAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrwarning/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrwarning/util.js'></script>
<!--jquery的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.dialog.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.draggable.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.resizable.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/warning/reference/gap-ajaxList-jquery-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/warning/reference/gap-ajaxList-jquery-reference.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/warning/warning-common.jsp"></script>
<!-- gap api用到的js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/reference/reference.jsp"></script>
<title><%=isModify?LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_modify"):LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_add")%></title>
<script>
    var contextpath="<venus:base/>";//声明环境路径
    jQuery(function() {
        setThesholdType();
        <%if(isModify){%>
            jQuery('#object_reference').css('visibility','hidden');
        <%}%> 
        jQuery("#referenceDetail").dialog({ modal: true, height:410,autoOpen:false,resizable:false,width:550,overlay: { opacity: 0.5, background: "black" }});
    });
  
  function save_onClick(){  //保存记录
        if(!setNotifyType()||!setTheshold())
            return;
        if(!checkAllForms())
            return;
        <%
            if(isModify){
        %>
                form.action = "<venus:base/>/WarningTemplateAction.do?cmd=modifyWarningTemplate";
        <%
            }
        %>
         form.submit();
    }
    function goBack(){
        location.href="<%=request.getContextPath()%>/WarningTemplateAction.do?cmd=queryAllWarningTemplates";
    }
   
</script>
</head>
<body>
<script language="javascript">
    writeTableTop('<%=isModify?LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_modify"):LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_add")%>','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/WarningTemplateAction.do?cmd=addWarningTemplate">
<input type="hidden" name="id" value="<%=warningTemplate.getId() %>">
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:save_onClick()">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>"  onClick="javascript:goBack()">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><%=isModify?LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_modify"):LocaleHolder.getMessage("gap.warningsystem.jsp.warning_template_add")%>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
    <tr> 
        <td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key="jsp.warning_template_name"/></td>
        <td align="left">
            <input name="templateName" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_template_name"/>" validate="notNull;checkInvalidString" value="<%=warningTemplate.getTemplateName() %>">           
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.warning_object_name"/></td>    
        <td align="left">
            <input name="objectName" inputName="<fmt:message key="jsp.warning_object_name"/>" type="text"  class="text_field_reference" id="objectName" value="<%=warningTemplate.getWarnObject().getObjectName()%>"size="20" readOnly="true"  validate="notNull;isNormalStrOnWeb"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" id="object_reference" onClick="reference('referenceDetail','objectTableBody');"/>
            <input name="warnObjectId" type="hidden" id="objectId" value="<%=warningTemplate.getWarnObject().getId()%>"/>
            <input id="returnType" type="hidden" value="<%=warningTemplate.getWarnObject().getReturnType()%>"/>
            <input name="tableBody" type="hidden" value="" class="text_field">
             <div id="referenceDetail" title="<fmt:message bundle='${applicationResources}'  key="reference_page"/>"></div>
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.operator"/></td>
        <td>
              <select name="operator" id="operator" onchange="changeThreshold(this)" value="<%=warningTemplate.getOperator()%>">
                   <% 
                         if(isModify){
                            List operatorList = (List)request.getAttribute("operator");
                                for(int i=0;i<operatorList.size();i++){
                      %>
                                    <option value="<%=operatorList.get(i) %>"><%=ReferenceFilter.get("WarningOperator",String.valueOf(operatorList.get(i)))%></option>
                       <%         
                                 }
                         %>
                        <script type="text/javascript">
                                jQuery("option[value='<%=warningTemplate.getOperator()%>']").attr('selected','true');
                        </script>
                       <%
                        }
                    %>
              </select>
               
        </td>
   </tr>
   <tr id="thresholdTr">
        <td align="right"><font color="red">*</font><fmt:message key="jsp.threshold"/></td>
        <td>
                <table >
                    <tr>
                        <td style="padding: 0px;">
                            <input name="threshold" id="threshold" type="hidden" value="<%=warningTemplate.getThreshold()%>">
                            <input name="threshold1"  id="threshold1" type="text" class="text_field" inputName="<fmt:message key="jsp.threshold"/>" validate="notNull;checkInvalidString" value="<%=warningTemplate.getThreshold().split(WarningConstants.WARNING_SEPARATOR)[0]%>">
                        </td>
	                   <td align="left"  id="thresholdTd" style="padding: 0px;"> 
		                    <%
		                        if(isModify){
		                            String[] threshold = warningTemplate.getThreshold().split(WarningConstants.WARNING_SEPARATOR);
		                            if(threshold.length>1){
		                      %>
		                                    <div id="div2">～<input name="threshold2"  id="threshold2" type="text" class="text_field temp" inputName="<fmt:message key="jsp.warning_template_threshold"/>" validate="notNull;checkInvalidString"></div>
		                                    <script type="text/javascript">
		                                             jQuery("#threshold2").val('<%=threshold[1]%>');
		                                     </script>
		                      <%          
		                            }
		                        }
		                    %>
	                </td>
                   </tr>
                </table>
         <td/>
   </tr>
   <tr> 
        <td align="right"><font color="red">*</font><fmt:message key="jsp.message_title"/></td>
        <td>
            <input name="title" type="text" class="text_field" inputName="<fmt:message key="jsp.message_title"/>" validate="notNull;checkInvalidString" value="<%=warningTemplate.getTitle() %>"> 
        </td>
   </tr>
   <tr>
        <td align="right" valign="top"><font color="red">*</font><fmt:message key="jsp.message_content"/></td>
        <td valign="top">
            <textarea name="msgTemplate"    cols="60" rows="5" maxLength="600"  inputName="<fmt:message key="jsp.message_content"/>" validate="notNull;checkInvalidString" ><%=warningTemplate.getMsgTemplate()%></textarea> 
        </td>
   </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.receiver"/></td>
        <td align="left">
            <input name=sendToCn type="text" class="text_field_reference" inputName="<fmt:message key="jsp.receiver"/>" readonly="readonly" validate="notNull" value="<%=warningTemplate.getSendToCn()%>"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" id="object_reference" onClick="organizationRefrenceTree(document.all('sendTo'),document.all('sendToCn'))"/>
            <input type="hidden" name="sendTo" value="<%=warningTemplate.getSendTo()%>">
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.notify_type"/>&nbsp;<input type="hidden" name="notifyType"/></td>
        <td align="left" id ="notifyTd" >
							     <%
							         List al = warningTypeMap.getEnumList();
							         for(int i=0;i<al.size();i++){
							      %>
							            <input name='notifyTypeTemp'  type='checkbox'  value='<%=warningTypeMap.getValue(al.get(i).toString())%>'/><%=al.get(i)%>&nbsp;
							      <%
							         }
							       //设置哪个通知类型被选中
							         if(isModify){//修改时
							             String[] notifyTypes = warningTemplate.getNotifyType().split(WarningConstants.WARNING_SEPARATOR);
							             for(int i=0;i<notifyTypes.length;i++){
							       %>
							               <script>
                                            jQuery(':checkbox[value="<%=notifyTypes[i]%>"]').attr("checked","true");
                                         </script>     
							       <%
							             }
							         }else{//新增时默认选择第一个checkbox
							     %>
							            <script>
							                jQuery(jQuery(':checkbox').get(0)).attr("checked","true");
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
</html>
</fmt:bundle>
