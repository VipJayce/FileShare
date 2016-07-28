<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<%@ page import="venus.pub.util.VoHelper" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="gap.bnLog.extend.LogType"%>
<%@ page import="gap.bnLog.util.BaseLogType"%>
<%@ page import="java.lang.reflect.Field"%>
<%@ taglib uri="/WEB-INF/gap-bnLog.tld" prefix="bnLog" %>
<html>
<fmt:bundle basename="gap.bnLog.bnLog_resource" prefix="gap.bnLog.">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<venus:base/>/js/jquery/ui.core.js"></script>
<script src="<venus:base/>/js/jquery/ui.dialog.js"></script>
<script src="<venus:base/>/js/jquery/ui.draggable.js"></script>
<script src="<venus:base/>/js/jquery/ui.resizable.js"></script>
<script src="<venus:base/>/js/reference/reference.jsp"></script>
<link rel="stylesheet" href="<venus:base/>/css/jquery/flora.all.css" type="text/css">
<style>
    .viewMessage{
        display:none;
        z-index:100;
        position:absolute;
        top:5%;
        left:5%;
        width:80%;
    }
</style>
<SCRIPT>
    function simpleQuery_onClick(){  //简单的模糊查询
    var log_date_from = document.getElementById("log_date_from").value; 
    var log_date_to = document.getElementById("log_date_to").value;  
    //转换为日期格式   
    log_date_from=log_date_from.replace(/-/g,"/");    
    log_date_to=log_date_to.replace(/-/g,"/");   
    //如果起始日期大于结束日期   
    if(Date.parse(log_date_from)-Date.parse(log_date_to)>0){   
        alert('<fmt:message key="validate_date"/>');
        return false;   
    } else {
        form.cmd.value = "simpleQuery";
        form.submit();
        }
    }
	
	jQuery(function(){
   //滑过表格
   jQuery("table.listCss tr").hover(function(){
       jQuery(this).addClass("over");
     },
     function(){
       jQuery(this).removeClass("over");
    }).dblclick(
    function(event){
         //找到id值 1.2.6版本 @不支持： var baseId = jQuery(this).find('input[@signName=hiddenId]').val();
        var baseId = jQuery(this).find('input[signName=hiddenId]').val();
        //如果baseId为空则返回，避免点击表头也弹出层
        if(!baseId) 
            return false;
        //打开窗口
        jQuery("#viewMessage").dialog("open"); 
        //提交请求
        jQuery("#viewMessage").load('<venus:base/>/BnLogAction.do?cmd=detail',{baseId:baseId}); 
        //阻止事件冒泡
        event.stopPropagation(); 
        });
  });

  jQuery(document).ready(function(){
         jQuery("#viewMessage").dialog({ modal: true, height:400,autoOpen:false,resizable:false,width:500,overlay: { opacity: 0.4, background: "black" }});
         jQuery("#image1").toggle(
          function () {
            jQuery('#ccChild1').slideUp('slow');
          },
          function () {
           jQuery('#ccChild1').slideDown("slow"); 
          }
        );
    });

    function detail(baseId){
        jQuery("#viewMessage").dialog("open"); 
        jQuery("#viewMessage").load('<venus:base/>/BnLogAction.do?cmd=detail',{baseId:baseId}); 
    }
    
    function detail_onClick(){
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var number = 0;
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                number += 1;
                ids = elementCheckbox[i].value;
            }
        }
        if(number == 0) {
            alert(i18n.please_select_a_record)
            return;
        }
        if(number > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        //打开窗口
        jQuery("#viewMessage").dialog("open"); 
        //提交请求
        jQuery("#viewMessage").load('<venus:base/>/BnLogAction.do?cmd=detail',{baseId:ids});
    }
    
</SCRIPT>

<!-- </head> -->
<body>

<script language="javascript">
    writeTableTop('<fmt:message key="query_list"/>','<venus:base/>/');
</script>

<div id="viewMessage" title='<fmt:message key="detail_page"/>' style="overflow:auto"></div>

<form name="form" method="post" action="<venus:base/>/BnLogAction.do">
<input type="hidden" name="cmd" value="queryAll">
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
            <fmt:message key="query_with_condition" bundle="${applicationResources}" />
        </td>
    </tr>
</table>
</div>

<div id="ccChild0">
<table class="table_div_content">
<tr><td>
    <table class="table_noFrame" width="100%">
        <tr>
	       <td align="right"  ><fmt:message key="log_type"/></td>
	       <td align="left">
	                <select name="msgType" >
	                    <option value=""><fmt:message key="select_log_type"/></option>
						<%
						Field[] fields = LogType.class.getFields();
						try {
							for(int i = 0 , len = fields.length; i < len; i++) {
								BaseLogType obj = (BaseLogType)(fields[i].get(LogType.class));
								out.println("<option value='" + obj + "'>" + obj + "</option>");
							}
						} catch (IllegalAccessException e) { 
							e.printStackTrace();
						}
						%>
	                </select>
	        </td>
	        
            <td width="15%" align="right"><fmt:message key="start_date"/></td>
            <td width="35%" align="left">
                <input type="text" class="text_field_half_reference_readonly" name="log_date_from" id="log_date_from" />
                    <img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('log_date_from','<venus:base/>/');"/>
                    <fmt:message key="end_date"/>
                <input type="text" class="text_field_half_reference_readonly" name="log_date_to" id="log_date_to"/>
                    <img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('log_date_to','<venus:base/>/');"/>
            </td>
        </tr>
        
        <tr>
            <td width="15%" align="right"><fmt:message key="user"/></td>
            <td width="35%" align="left">
                <input name="userName" type="text" class="text_field_reference_readonly" validate="isSearch"><input type="hidden" name="hiddenUserId" id="hiddenUserId"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" id="object_reference" onClick="organizationRefrenceTree(document.all('hiddenUserId'),document.all('userName'))"/> 
            </td>
            
             <td align="right"  ><fmt:message key="summary"/></td>
                <td align="left">
                <input name="summary" type="text" class="text_field" />
             </td>   
        </tr>

         <tr>
            <td align="right"  ><fmt:message key="ip_address"/></td>
            <td align="left">
                <input name="ipAddress" type="text" class="text_field" />
            </td>
    
            <td align="right"  ><fmt:message key="host_name"/></td>
            <td align="left">
                <input name="hostName" type="text" class="text_field" />
             </td>   
        </tr>
        
         <tr>
            <td align="right"  ><fmt:message key="class_name"/></td>
            <td align="left">
                <input name="className" type="text" class="text_field" />
            </td>
    
            <td align="right"  ><fmt:message key="method_name"/></td>
                <td align="left">
                <input name="methodName" type="text" class="text_field" validate="isSearch"/>
             </td>   
         </tr>
         <!-- 扩展表标签 动态显示扩展查询条件 -->
        <bnLog:dynamicQuery />
        <tr>
            <td>&nbsp;</td>
            <td>
                <input name="button_ok" class="button_ellipse" type="button" value='<fmt:message key="query" bundle="${applicationResources}" />' onClickTo="javascript:simpleQuery_onClick()" />
                <input name="button_clear" class="button_ellipse" type="reset"  value='<fmt:message key="clear" bundle="${applicationResources}" />' /> 
            </td>
        </tr>
    </table>

</td></tr>
</table>
</div>
<!-- 查询结束 -->

<div id="ccParent1"> 
<table class="table_div_control">
<tr>
    <td>
        <img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
        <fmt:message key="detail_table"/>
    </td>

    <td>                                                                                                                                                        
        <table align="right">
            <tr> 
                <td class="button_ellipse" onClick="javascript:detail_onClick();"><img src="<venus:base/>/images/icon/search.gif" class="div_control_image"><fmt:message key="view" bundle="${applicationResources}" /></td>
            </tr>
        </table>
    </td>
</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content" style="TABLE-LAYOUT: fixed">
    <tr>
        <td>
            <layout:collection name="beans" id="loglist" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
            
            <layout:collectionItem width="3%" title="" style="text-align:center;">
                <bean:define id="beans0" name="loglist" property="baseId"/>
                <input type="radio" name="checkbox_template" value="<%=beans0%>"/>
            </layout:collectionItem>
            <layout:collectionItem width="3%" title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
                <venus:sequence/>
                <input type="hidden" signName="hiddenId" value="<bean:write name="loglist" property="baseId"/>"/>
            </layout:collectionItem>
            
            <layout:collectionItem width="7%" title='<%=LocaleHolder.getMessage("gap.bnLog.log_type")%>' property="msgType" sortable="true" />
             <layout:collectionItem width="13%" title='<%=LocaleHolder.getMessage("gap.bnLog.log_date")%>' property="logDate" sortable="true">
             
                <bean:define id="beans1" name="loglist" property="logDate"/>
                <%
                    out.print(DateFormatUtils.ISO_DATE_FORMAT.format(beans1) + " " + DateFormatUtils.ISO_TIME_NO_T_FORMAT.format(beans1));
                %>
            </layout:collectionItem>
            <layout:collectionItem width="7%" title='<%=LocaleHolder.getMessage("gap.bnLog.user")%>'  property="userName" sortable="true"/>
            <layout:collectionItem width="8%" title='<%=LocaleHolder.getMessage("gap.bnLog.ip_address")%>'  property="ipAddress" sortable="true" />
            <layout:collectionItem width="8%" title='<%=LocaleHolder.getMessage("gap.bnLog.host_name")%>' property="hostName" sortable="true" />
            <layout:collectionItem width="23%" title='<%=LocaleHolder.getMessage("gap.bnLog.class_name")%>'  property="className" sortable="true"/> 
            <layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.bnLog.method_name")%>'  property="methodName" sortable="true"/>
            <layout:collectionItem width="18%" title='<%=LocaleHolder.getMessage("gap.bnLog.summary")%>'  property="summary" sortable="true">
                <bean:define id="beans2" name="loglist" property="summary"/>
                <bean:define id="beans3" name="loglist" property="baseId"/>
                    <a href="#" onclick="detail('<%=beans3%>')">
                    <%
		                if("".equals(beans2)) {
		                    out.print("<img src='" + request.getContextPath() +  "/images/icon/search.gif' class='div_control_image'>");
		                }else {
		                    out.print(beans2);
		                } %>
                    </a>
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
</fmt:bundle>
</html>
<%  //表单回写
    if(request.getAttribute("writeBackFormValues") != null) {
        out.print("<script language=\"javascript\">\n");
        out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
        out.print("writeBackMapToForm();\n");
        out.print("</script>");
    }
%>