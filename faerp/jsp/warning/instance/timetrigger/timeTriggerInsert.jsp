<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.Iterator"%>  
<%@page import="java.util.Map,java.util.List"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="gap.warning.util.ReferenceFilter"%>
<%@ page import="gap.warning.instance.model.WarningInstance"%>
<%@ page import="gap.warning.instance.model.WarningInstanceMessageVo"%>
<%@page import="gap.warning.util.WarningConstants"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%  
        WarningInstance warningInstance=(WarningInstance)request.getAttribute("vo");
		if(warningInstance.getThreshold()==null){//
		    warningInstance.setThreshold("");
		}
        String templateName = (String)request.getAttribute("templateName");
        if(warningInstance==null) warningInstance=new WarningInstance();
        WarningInstanceMessageVo    messageVo=warningInstance.getMessageVo();
        VoHelper.null2Nothing(messageVo); 
        
        EnumRepository er = EnumRepository.getInstance();
        er.loadFromDir();
        EnumValueMap WarningNotifyTypeMap = er.getEnumValueMap("WarningNotifyType");
    %>
<title><fmt:message key="jsp.timing_warning_instance_add"/></title>
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
        
        jQuery(":checked[name='plan']").trigger('click');
        
    });
    function insert_onClick(){  //增加记录
    	if(!validateIdentifier()) return;
        if(!setNotifyType()||!setTheshold())
            return;
        if(checkAllForms()){
            form1.action = "<venus:base/>/WarningInstanceTimeTriggerAction.do?cmd=insert";
            form1.submit();
        }
    }
  
    
    function goBack(){
        location.href="<%=request.getContextPath()%>/WarningInstanceTimeTriggerAction.do?cmd=queryAll";
    }
     
   
  
function guide_onClick(){
    //取得event，firefox下通过guide_onClick.caller.arguments[0]获取。
    var event = window.event?window.event:guide_onClick.caller.arguments[0];
    var obj = window.showModalDialog('<venus:base/>/jsp/warning/quartz/createCronExpression.jsp','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:370px;dialogWidth:450px;help:no;resizable:no;scroll:no;status:0;');
    if(obj) {
        //alert("guid_onClick = "+obj);
        document.form1.cronExpression.value = obj;
    }
}

function setHHMM(textDate){
    var event = window.event?window.event:setHHMM.caller.arguments[0];
    var returnAry = window.showModalDialog("<%=request.getContextPath()%>/jsp/warning/common/HHMM.jsp",document.getElementById(textDate),"status:1;dialogHeight:20px;dialogWidth:162px;dialogTop: "+event.screenY+"px; dialogLeft: "+event.screenX+"px");
    if (typeof(returnAry) == "undefined") {
       jQuery("#"+textDate).val("");
    } else if (returnAry != null) {
        jQuery("#"+textDate).val(returnAry);
        jQuery("#"+textDate).trigger("change");
    }
}

function chkall(input1,input3,input2)
{
//alert(input3);
    var objForm = document.forms[input1];
    var objLen = objForm.length;
    for (var iCount = 0; iCount < objLen; iCount++)
    {
       if (input2.checked == true)
        {
            if (objForm.elements[iCount].name == input3)
            {
                objForm.elements[iCount].checked = true;
            }
        }
        else
        {
            if (objForm.elements[iCount].name == input3)
            {
                objForm.elements[iCount].checked = false;
            }
        }
    }
}

function checkDayOrWeek(obj){
    if(obj.value=="day"){
    document.form1.date.disabled = false;
    document.form1.dayOfWeek.disabled = true;
    document.form1.weekOfMonth.disabled = true;
    }else{
    document.form1.date.disabled = true;
    document.form1.dayOfWeek.disabled = false;
    document.form1.weekOfMonth.disabled = false;
    }
    
}

function onceClick(){
    planParent.style.display="block";
    onceChild.style.display="block";
    dayChild.style.display="none";
    weekChild.style.display="none";
    monthChild.style.display="none";
    customerChild.style.display="none";
}

function dayClick(){
    planParent.style.display="block";
    onceChild.style.display="none";
    dayChild.style.display="block";
    weekChild.style.display="none";
    monthChild.style.display="none";
    customerChild.style.display="none";
    
}
function monthClick(){
    planParent.style.display="block";
    onceChild.style.display="none";
    dayChild.style.display="none";
    weekChild.style.display="none";
    monthChild.style.display="block";
    customerChild.style.display="none";
}
function weekClick(){
    planParent.style.display="block";
    onceChild.style.display="none";
    dayChild.style.display="none";
    weekChild.style.display="block";
    monthChild.style.display="none";
    customerChild.style.display="none";
}
function customerClick(){
    planParent.style.display="none";
    onceChild.style.display="none";
    dayChild.style.display="none";
    weekChild.style.display="none";
    monthChild.style.display="none";
    customerChild.style.display="block";
}
   
</script>

</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.timing_warning_instance_add"/>','<venus:base/>/');
</script>

<form name="form1" method="post">
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:insert_onClick()">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>"  onClick="javascript:goBack()">
        </td>
    </tr>
</table>


<!-- 调度设置页面开始 -->
<div id="ccParentq">
<table class="table_div_control">
    <tr>
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChildq',this,'<venus:base/>/')">
            <fmt:message key="jsp.choose_scheduling_scheme"/>
        </td>
    </tr>
</table>
</div>

<div id="ccChildq">
<table class="table_div_content">
    <tr>
        <td><input type="radio" name="plan" value="once" onclick="onceClick()" checked><fmt:message key="jsp.one_time"/></td>
        <td><input type="radio" name="plan" value="perDay" onclick="dayClick()"><fmt:message key="jsp.daily"/></td>
        <td><input type="radio" name="plan" value="perWeek" onclick="weekClick()"><fmt:message key="jsp.weekly"/></td>
        <td><input type="radio" name="plan" value="perMonth" onclick="monthClick()"><fmt:message key="jsp.monthly"/></td>
        <td><input type="radio" name="plan" value="customer" onclick="customerClick()"><fmt:message key="jsp.custom"/></td>     
    </tr>       
</table>
</div> 

<div id="planParent">
<table class="table_div_control">
    <tr>
        <td>
       <fmt:message key="jsp.choose_date_and_time"/>
        </td>
    </tr>
</table>
</div>

<div id="onceChild" >
<table class="table_div_content" border="0">
    <tr>
        <td width="80"><fmt:message key="jsp.start_date"/></td>
        <td width="220"><input type="text" readOnly name="beginDate1" id='beginDate1' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate1','<%=request.getContextPath()%>/');" class="img_1"/>
        </td>
        <td width="100"><fmt:message key="jsp.start_time"/></td>
        <td width="220"><input type="text" readOnly name="beginTime1" id='beginTime1' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('beginTime1');"  class="img_1"/>
        </td>
    </tr>
</table>
</div> 
    
<div id="dayChild" style="display:none;">
<table class="table_div_content">
    <tr>
        <td>
            <table>
                <tr>
        <td width="100"><fmt:message key="jsp.start_date"/></td>
        <td width="220"><input type="text" name="beginDate2" id='beginDate2' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate2','<%=request.getContextPath()%>/');" class="img_1"/>
        </td>
        <td width="100"><fmt:message key="jsp.end_date"/></td>
        <td width="220"><input type="text" name="endDate2" id='endDate2' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate2','<%=request.getContextPath()%>/');" class="img_1"/>
        </td>
        </tr>
        </table>
        </td>
    </tr>
    <tr>
            <td>
            <table>
                <tr>
        <td width="100"><fmt:message key="jsp.start_time"/></td>
        <td width="220"><input type="text" name="beginTime2" id="beginTime2" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('beginTime2');"  class="img_1"/>
        </td>
        <td width="100"><fmt:message key="jsp.end_time"/></td>
        <td width="220"><input type="text" name="endTime2" id="endTime2" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('endTime2');"  class="img_1"/>
        </td>
                </tr>
        </table>
        </td>
    </tr>
    <tr>    
                <td>
            <table>
                <tr>
        <td width="100"><fmt:message key="jsp.run_task"/></td>
        <td ><input type="radio" name="dayPlan" value="perDay" checked><fmt:message key="jsp.daily"/></td>
        <td ><input type="radio" name="dayPlan" value="perWorkDay"><fmt:message key="jsp.each_working_day"/></td>
        <td ><input type="radio" name="dayPlan" value="perDays"><fmt:message key="jsp.each"/>
            <select name="days" style="width:40">
            <%
            for(int i=1;i<=31;i++){
                
                out.println("<option value="+i+" >"+i+"</option>");
            }
            %>          
            </select><fmt:message key="jsp.day"/>
        </td>
                </tr>
        </table>
        </td>
    </tr>           
</table>
</div> 

<div id="weekChild" style="display:none;">
<table class="table_div_content">
    <tr>
    <td>
        <table>
            <tr>
                <td width="100"><fmt:message key="jsp.start_date"/></td>
                <td width="220"><input type="text" name="beginDate3" id='beginDate3' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate3','<%=request.getContextPath()%>/');" class="img_1"/>
                </td>
                <td width="100"><fmt:message key="jsp.end_date"/></td>
                <td width="220"><input type="text" name="endDate3" id='endDate3' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate3','<%=request.getContextPath()%>/');" class="img_1"/>
                </td>
            </tr>
            </tr>
            <tr>    
                <td width="100"><fmt:message key="jsp.start_time"/></td>
                <td width="220"><input type="text" name="beginTime3" id="beginTime3" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('beginTime3');"  class="img_1"/>
                </td>
                <td width="100"><fmt:message key="jsp.end_time"/></td>
                <td width="220"><input type="text" name="endTime3" id="endTime3" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('endTime3');"  class="img_1"/>
                </td>
            </tr>
        </table>
    </td>
    </tr>
    <tr>
    <td>
        <table>
        <tr>    
            <td width="100"><fmt:message key="jsp.select_week"/></td>
            <td ><input type="checkbox" value='<fmt:message key="jsp.select_all"/>' onclick='chkall("form1","weekDay",this)' name=chk><fmt:message key="jsp.select_all"/></td> 
            <td >&nbsp;</td>
        </tr>
        </table>
    </td>
    </tr>
    <tr>    
    <td>
        <table>
            <tr>    
                <td><input type="checkbox" name="weekDay" value="2"><fmt:message key="jsp.monday"/></td> 
                <td><input type="checkbox" name="weekDay" value="3"><fmt:message key="jsp.tuesday"/></td> 
                <td><input type="checkbox" name="weekDay" value="4"><fmt:message key="jsp.wednesday"/></td> 
                <td><input type="checkbox" name="weekDay" value="5"><fmt:message key="jsp.thursday"/></td> 
                <td ><input type="checkbox" name="weekDay" value="6"><fmt:message key="jsp.friday"/></td> 
                <td ><input type="checkbox" name="weekDay" value="7"><fmt:message key="jsp.saturday"/></td> 
                <td ><input type="checkbox" name="weekDay" value="1"><fmt:message key="jsp.sunday"/></td> 
            </tr>
        </table>
    </td>
    </tr>
</table>
</div> 

<div id="monthChild" style="display:none;">
<table class="table_div_content">
    <tr>
        <td>
            <table>
                </tr>
        <td width="100"><fmt:message key="jsp.start_date"/></td>
        <td width="220"><input type="text" name="beginDate4" id='beginDate4' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate4','<%=request.getContextPath()%>/');" class="img_1"/>
        </td>
        <td width="100"><fmt:message key="jsp.end_date"/></td>
        <td width="220"><input type="text" name="endDate4" id='endDate4' class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate4','<%=request.getContextPath()%>/');" class="img_1"/>
        </td>
        </tr>
        </table>
        </td>
    </tr>
    <tr>    
            <td>
            <table>
                </tr>
        <td width="100"><fmt:message key="jsp.start_time"/></td>
        <td width="220"><input type="text" name="beginTime4" id="beginTime4" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('beginTime4');"  class="img_1"/>
        </td>
        <td width="100"><fmt:message key="jsp.end_time"/></td>
        <td width="220"><input type="text" name="endTime4" id="endTime4" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM('endTime4');"  class="img_1"/>
        </td>
                </tr>
        </table>
        </td>
    </tr>
    <tr>    
            <td>
            <table>
                </tr>
        <td width="100"><fmt:message key="jsp.choose_period"/></td> 
        <td width="120"><input type="radio" name="dayOrweek" value="day" onclick="checkDayOrWeek(this);" checked><fmt:message key="jsp.day"/>
            <select name="date" readOnly style="width:40">
            <%
            for(int i=1;i<=31;i++){
                
                out.println("<option value="+i+" >"+i+"</option>");
            }
            %>      
            </select>
        </td>
        <td ><input type="radio" name="dayOrweek" value="week" onclick="checkDayOrWeek(this);"><fmt:message key="jsp.week"/>
            <select name="weekOfMonth" DISABLED style="width:90">
              <option selected value="1" ><fmt:message key="jsp.first"/></option>
              <option value="2"><fmt:message key="jsp.second"/></option>
              <option value="3"><fmt:message key="jsp.third"/></option>
              <option value="4"><fmt:message key="jsp.fourth"/></option>
              <option value="L"><fmt:message key="jsp.last"/></option>
            </select>
        </td>
        <td ><select name="dayOfWeek" DISABLED style="width:90">
              <option value="2"><fmt:message key="jsp.monday"/></option>
              <option value="3"><fmt:message key="jsp.tuesday"/></option>
              <option value="4"><fmt:message key="jsp.wednesday"/></option>
              <option value="5"><fmt:message key="jsp.thursday"/></option>
              <option value="6"><fmt:message key="jsp.friday"/></option>
              <option value="7"><fmt:message key="jsp.saturday"/></option>
              <option selected value="1"><fmt:message key="jsp.sunday"/></option>
            </select>
        </td>
                </tr>
        </table>
        </td>
    </tr>
    <tr>        
                <td>
            <table>
                </tr>
        <td ><fmt:message key="jsp.choose_month"/></td> 
        <td ><input type="checkbox" value='<fmt:message key="jsp.select_all"/>' onclick='chkall("form1","month",this)' name=chk><fmt:message key="jsp.select_all"/></td> 
        <td >&nbsp;</td> 
        <td >&nbsp;</td> 
                </tr>
        </table>
        </td>
    </tr>
    <tr>    
    <tr>
        <td>
            <table>
                <tr>    
                    <td><input type="checkbox" name="month" value="1"><fmt:message key="jsp.january"/></td>
                    <td><input type="checkbox" name="month" value="2"><fmt:message key="jsp.february"/></td>
                    <td><input type="checkbox" name="month" value="3"><fmt:message key="jsp.march"/></td>
                    <td><input type="checkbox" name="month" value="4"><fmt:message key="jsp.april"/></td>
                    <td><input type="checkbox" name="month" value="5"><fmt:message key="jsp.may"/></td>
                    <td><input type="checkbox" name="month" value="6"><fmt:message key="jsp.june"/></td>
                </tr>
            </table>
        </td>
    </tr>
        <tr>
        <td>
            <table>
                <tr>    
                    <td><input type="checkbox" name="month" value="7"><fmt:message key="jsp.july"/></td>
                    <td><input type="checkbox" name="month" value="8"><fmt:message key="jsp.august"/></td>
                    <td><input type="checkbox" name="month" value="9"><fmt:message key="jsp.september"/></td>
                    <td><input type="checkbox" name="month" value="10"><fmt:message key="jsp.october"/></td>
                    <td><input type="checkbox" name="month" value="11"><fmt:message key="jsp.november"/></td>
                    <td><input type="checkbox" name="month" value="12"><fmt:message key="jsp.december"/></td>
                </tr>
            </table>
        </td>
    </tr>

</table>
</div> 

<div id="customerChild" style="display:none;">
<table class="table_div_content" border="0">
    <tr>
        <td align="left" width="15%" nowrap><fmt:message key="jsp.advanced_triggering_rules"/></td>
        <td><input name="cronExpression" type="text" class="text_field" inputName="<fmt:message key="jsp.advanced_triggering_rules"/>" readOnly>
                <input type="button" name="guide" class="button_ellipse" value="<fmt:message key="jsp.guide"/>" onClick="javascript:guide_onClick();">
        </td>
        
    </tr>
</table>
</div> 


<!-- 调度设置页面结束 -->

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.timing_warning_instance_add"/>
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
        <td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key="jsp.trigger_description"/></td>
        <td align="left">
            <input name="description" type="text" class="text_field" inputName="<fmt:message key="jsp.trigger_description"/>" validate="notNull;checkInvalidString" value="<%=warningInstance.getIdentifier() %>">         
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
            <input name="objectName" inputName="<fmt:message key="jsp.warning_object_name"/>" type="text"  class="text_field" id="objectName" value="<%=warningInstance.getWarnObject().getObjectName()%>"size="20" readOnly="true"  validate="notNull;isNormalStrOnWeb">
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
   <tr id="thresholdTr">
        <td align="right"><font color="red">*</font><fmt:message key="jsp.threshold"/></td>
        <td>
                <table>
                    <tr>
                        <td style="padding: 0px;">
                         <input name="threshold" id="threshold" type="hidden" value="<%=warningInstance.getThreshold()%>">
                <input name="threshold1"  id="threshold1" type="text" class="text_field" inputName="<fmt:message key="jsp.threshold"/>" validate="notNull;checkInvalidString" value="<%=warningInstance.getThreshold().split(WarningConstants.WARNING_SEPARATOR)[0]%>">
                        </td>
                   <td align="left"  id="thresholdTd" style="padding: 0px;"> 
                    <%
                            String[] threshold = warningInstance.getThreshold().split(WarningConstants.WARNING_SEPARATOR);
                            if(threshold.length>1){
                      %>
                                    <div id="div2">～<input name="threshold2"  id="threshold2" type="text" class="text_field temp" inputName="<fmt:message key="jsp.threshold"/>" validate="notNull;checkInvalidString"></div>
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
            <input name=sendToCn type="text" class="text_field_reference" inputName="<fmt:message key="jsp.receiver"/>"  readonly="readonly" validate="notNull" value="<%=messageVo.getSendToCn()%>"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" id="object_reference" onClick="organizationRefrenceTree(document.all('sendTo'),document.all('sendToCn'))"/>
            <input type="hidden" name="sendTo" value="<%=messageVo.getSendTo()%>">
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.notify_type"/><input type="hidden" name="notifyType"/></td>
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
                                            jQuery(':checkbox[value="<%=notifyTypes[i]%>"][name="notifyTypeTemp"]').attr("checked","true");
                                         </script>     
                                   <%
                                         }
                                %>
        </td>
    </tr>
    <tr>
           <td>
                 <input name="isRepeatable" type="hidden" value="<%=WarningConstants.WARNING_ISREPEATEABLE_YES %>">
           </td>
          <!--   
        <td align="right"><font color="red">*</font>是否重复发送</td>
        <td align="left" >
            设置是否重复发送预警，默认不开放此功能，表示会重复发送。
                      <select name="isRepeatable" value="<%=warningInstance.getIsRepeatable() %>">
                        <option value="<%=WarningConstants.WARNING_ISREPEATEABLE_NO %>"><%=WarningConstants.WARNING_ISREPEATEABLE_MAP.get(WarningConstants.WARNING_ISREPEATEABLE_NO) %></option>
                        <option value="<%=WarningConstants.WARNING_ISREPEATEABLE_YES %>"><%=WarningConstants.WARNING_ISREPEATEABLE_MAP.get(WarningConstants.WARNING_ISREPEATEABLE_YES) %></option>
                      </select>
              -->
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
