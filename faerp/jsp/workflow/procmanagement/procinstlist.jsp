<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<%@ page import="com.use.tools.helper.VoHelperTools" %>
<%@ page import="com.alexander.workflow.extend.util.DynamicRelevantData" %>
<%@ page import="com.alexander.workflow.monitor.vo.DynamicQueryProcessInstanceVo" %>
<%@ page import="java.util.List" %>

<%
    List rdList = (List)request.getAttribute("relevantDataList");
    String procName = (String)request.getAttribute("procName");
%>

<jsp:include page="/workflowForm/globalForm.jsp" flush="true"/>
<fmt:bundle basename="gap.wf.wapi.wf_wapi_resource" prefix="gap.workflow.wapi.">
<script language="javascript">
    var checkboxName="checkbox_template";

    //find taskUid
    function findSelTaskUid(){
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array0 = arrayAll[0];
 
                ids.push(array0);  //加入选中的checkbox
            }
        }

        if(ids == null) {  //如果ids为空
            alert(i18n.please_select_a_record);
            return;
        }
        if(ids.length > 1) {
            alert(i18n.can_only_select_a_record);
            return;
        }

        return ids;
    }

    //find procInstID
    function findSelProcInstID(){
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array1 = arrayAll[0];
 
                ids.push(array1);  //加入选中的checkbox
            }
        }

        if(ids == null) {  //如果ids为空
            alert(i18n.please_select_a_record);
            return;
        }
        if(ids.length > 1) {
            alert(i18n.can_only_select_a_record);
            return;
        }

        return ids;
    }

    //find ProcDefID
    function findSelProcID(){
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array2 = arrayAll[1];
 
                ids.push(array2);  //加入选中的checkbox
            }
        }

        if(ids == null) {  //如果ids为空
            alert(i18n.please_select_a_record);
            return;
        }
        if(ids.length > 1) {
            alert(i18n.can_only_select_a_record);
            return;
        }

        return ids;
    }

    function accept(){
        var theid=findSelTaskUid();
        if(theid==null)return;
        if(!window.confirm(i18n_wf.whether_to_accept_this_task))return;
        var form = document.all["form"];
        form.action = "<%=request.getContextPath()%>/accepttask.do?taskuid="+theid;
        form.submit();
    }
    
    function monitor_onClick(thisId){  //实现转到详细页面
        var ids = findSelProcInstID();  //取得多选框的选择项
        if(ids==null)return;
        window.location.href= '<%=request.getContextPath()%>/taskList4FormAction.do?processInsId='+ids;
    }
    //需要与 globalForm.jsp 同步
    function rollback(){
        var theid=findSelTaskUid();
        if(theid==null)return;
        if(!window.confirm(i18n_wf.whether_to_rollback_this_task))return;
        var form = document.all["form"];
        var stateReason = window.prompt(i18n_wf.reason_for_rollback_this_task,"");
        if(stateReason!=null && ""!=stateReason){
            var oNewItem1 = document.createElement("input");
            oNewItem1.type = "hidden";
            oNewItem1.name = "stateReason";
            oNewItem1.value = stateReason;
            form.insertAdjacentElement("afterBegin",oNewItem1);
        }
        form.action = "<%=request.getContextPath()%>/rollbacktask.do?taskuid="+theid;
        form.submit();
    }
    
    function history(){
        var theid=findSelProcInstID();
        if(theid==null)return;
        window.location.href = "queryhistory.do?flag=query&procInstID="+theid;
    }
    
    function monitor(){
        var procID=findSelProcID();
        if(procID==null)return;
        var procInstID=findSelProcInstID();
        if(procInstID==null)return;
        window.location.href = "<%=request.getContextPath()%>/MonitorByProcInstIdAction.do"
            +"?procDefID="+procID
            +"&procInstID="+procInstID;
    }

    function withdraw(){
        var theid=findSelTaskUid();
        if(theid==null)return;
        if(!window.confirm(i18n_wf.whether_to_withdraw_this_task))return;
        var form = document.all["form"];
        form.action = "<%=request.getContextPath()%>/withdrawtask.do?flag=delete&taskuid="+theid;
        form.submit();
    }

    function queryTaskByCondition(){
        var form = document.all["form"];
        //基于陕西电信业务的校验
        var validate_over_time_task=document.all.over_time_task.options[document.all.over_time_task.selectedIndex].value;
        var validate_task_state=document.all.task_state.options[document.all.task_state.selectedIndex].value;
        form.query.value = "true";      
        form.action = "<%=request.getContextPath()%>/dynamicQueryProcessInstanceAction.do?";
        form.submit();
    }
    
    function findSelectState() {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);
        var number = 0;  //定义游标
        var section = null;  //定义状态值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(section == null) {
                    section = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array3 = arrayAll[2];
                section.push(array3);  //加入选中的checkbox
            }
        }
        return section;
    }
    
    var mainDefId = "";//监控功能历史遗留，目前没有作用
    
    function endFlow() {
        var _procInstID =findSelProcInstID();
        if(_procInstID == null){
            return;
        }
        var _states = findSelectState();
        if(_states ==  '<fmt:message key="completed" />'  || _states == '<fmt:message key="aborted" />' ){
            alert(i18n_wf.end_process_instance_error);
            return false;
        }
        if(window.confirm(i18n_wf.confirm_to_terminate_the_process_instance)){
            window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
                +"?procInstId="+_procInstID
                +"&mainDefId="+mainDefId
                +"&operationType=terminate";
        }
    }
    function handupFlow() {
        var _procInstID =findSelProcInstID();
        if(_procInstID == null){
            return;
        }
        var _states = findSelectState();
        if(_states != '<fmt:message key="excuting" />' && _states != '<fmt:message key="initialization" />' && _states != '<fmt:message key="resume" />' ){
            alert(i18n_wf.suspend_process_instance_error);
            return false;
        }
        
        window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
                +"?procInstId="+_procInstID
                +"&mainDefId="+mainDefId
                +"&operationType=handup";
        
    }
    function resumeFlow() {
        var _procInstID =findSelProcInstID();
        if(_procInstID == null){
            return;
        }
        var _states = findSelectState();
        if(_states != '<fmt:message key="handup" />'  ){
            alert(i18n_wf.resume_process_instance_error);
            return false;
        }
  
         window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
                +"?procInstId="+_procInstID
                +"&mainDefId="+mainDefId
                +"&operationType=resume";
        
    }
    
    function findParentInstID() {
        var elementCheckbox = document.getElementsByName(checkboxName);
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                return elementCheckbox[i].value.split(",")[3];
            }
        }
    }
    
    function clearFlow() {
        var _procInstID = findSelProcInstID();
        var _parentInstID = findParentInstID();
        if(_procInstID == null){
            return;
        }
        var clearParent=false;
        if(_parentInstID!=null && _parentInstID.length>10){
            clearParent = window.confirm(i18n_wf.need_to_clear_parent_process_instance);
        }
        if(window.confirm(i18n_wf.confirm_to_clear_all_data)){
            var hrefstr = "<%=request.getContextPath()%>/RubbishClearAction.do"
                +"?mainDefId="+mainDefId
                +"&procInstId="+_procInstID
                +"&cmd=clearProcessInstanceDataByID";
            if(clearParent)
                hrefstr = hrefstr+"&parentInstId="+_parentInstID;
            window.location.href=hrefstr;
        }
    }
</script>
</fmt:bundle>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">

<script language="javascript">
    writeTableTop('<%=LocaleHolder.getMessage("gap.wf.supervision")%>','<%=request.getContextPath()%>/');
</script>

<form name="form" method="post" id="form">

<div id="ccParentq"> 
<table class="table_div_control">
    <tr>
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChildq',this,'<%=request.getContextPath()%>/')">
            <%=LocaleHolder.getMessage("gap.wf.supervision_query")%>
        </td>
    </tr>
</table>
</div>

<div id="ccChildq">
<table class="table_div_content2">
<input name="query" type="hidden" value="false">
     <tr><td width="15%" align='right'><fmt:message key="whether_timeout_task"/></td><td width="30%" align="left">
      <select name="over_time_task">
        <option value="0"><fmt:message key="both"/></option>
        <option value="1"><fmt:message key="have_timeout_task"/></option>
        <option value="2"><fmt:message key="no_timeout_task"/></option>
      </select>
       </td> </tr>
       <tr><td width="15%" align='right'><fmt:message key="task_item_state"/></td><td width="30%" align="left">
      <select name="task_state">
        <option value="0"><fmt:message key="all"/></option>
        <option value="1"><fmt:message key="task_state_actived"/></option>
        <option value="2"><fmt:message key="task_state_running"/></option>
        <option value="3"><fmt:message key="task_state_completed"/></option>
      </select>
       </td> </tr>
       <tr><td width="15%" align='right'><fmt:message key="process_activity_time"/></td><td width="30%" align="left">
      <input id='pross_start_time' type="text" class="text_field_reference" name='pross_start_time' readonly="true" /><img src='<%=request.getContextPath()%>/images/icon/reference.gif' onClick="javascript:getYearMonthDay('pross_start_time','<%=request.getContextPath()%>/');"  title="Calendar" class="img_1" style="cursor:hand;"/>&nbsp;<fmt:message key="to"/>&nbsp;<input id='pross_end_time' type="text" class="text_field_reference"  name='pross_end_time' readonly="true" /><img src='<%=request.getContextPath()%>/images/icon/reference.gif' onClick="javascript:getYearMonthDay('pross_end_time','<%=request.getContextPath()%>/');"  title="Calendar" class="img_1" style="cursor:hand;"/>
       </td> </tr>
      <data:dynamicQuery  maxLength="30"/>
      <tr><td align='right'>
      
      <input name="querytask" type="button" id="querytask" value='<fmt:message key="query" bundle="${applicationResources}" />' onclick="queryTaskByCondition()" class="button_ellipse">
      <input name="del" type="reset" id="del" value='<fmt:message key="clear" bundle="${applicationResources}" />' class="button_ellipse">
      </td><td></td></tr>

       
</table>
</div>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr>
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
            <%=LocaleHolder.getMessage("gap.wf.process_instance_list")%>
        </td>
        <td>
        <table align="right">
                <tr>
        <td nowrap class="button_ellipse" onClick = "javascript:monitor();">
        <img src="<%=request.getContextPath()%>/images/icon/monitor.gif" class="div_control_image"><fmt:message key="monitor"/></td>
        <td nowrap class="button_ellipse" onClick = "javascript:handupFlow();">
        <img src="<%=request.getContextPath()%>/images/icon/monitor.gif" class="div_control_image"><fmt:message key="suspend"/></td>
        <td nowrap class="button_ellipse" onClick = "javascript:resumeFlow();">
        <img src="<%=request.getContextPath()%>/images/icon/monitor.gif" class="div_control_image"><fmt:message key="resume"/></td>
        <td nowrap class="button_ellipse" onClick = "javascript:endFlow();">
        <img src="<%=request.getContextPath()%>/images/icon/stop.gif" class="div_control_image"><fmt:message key="terminate"/></td>
        <td nowrap class="button_ellipse" onClick = "javascript:clearFlow();">
        <img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="remove"/></td>
        <td nowrap class="button_ellipse" onClick = "javascript:monitor_onClick();">
        <img src="<%=request.getContextPath()%>/images/icon/search1.gif" class="div_control_image"><fmt:message key="detail"/></td>
        </tr>
        </table>
        </td>
    </tr>
</table>
</div>

<!-- 列表开始 -->
<div id="ccChild1">
<table class="table_div_content2">
    <tr>
        <td>
        
        <layout:collection name="tasklist" id="taskItem" styleClass="listCss" width="99%" indexId="orderNumber" align="center" sortAction="0">
            
            <data:collectionItemAlexander width="3%" title="" style="text-align:center;">
                <bean:define id="wy4" name="taskItem" property="processinstanceid"/>
                <bean:define id="wy5" name="taskItem" property="processid"/>
                <bean:define id="wy6" name="taskItem" property="state" />
                <bean:define id="parentInstId" name="taskItem" property="parentinstanceid" />
                <input title="<%=LocaleHolder.getMessage("process")+wy4%>" type="radio" name="checkbox_template" value="<%=wy4+","+wy5+","+wy6+","+parentInstId%>"/>
            </data:collectionItemAlexander>
            
            <data:collectionItemAlexander width="3%" title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
                <venus:sequence/>
                <bean:define id="wy4" name="taskItem" property="processinstanceid"/>
                <input type="hidden" signName="hiddenId" value="<%=wy4%>"/>
            </data:collectionItemAlexander>
            
            <data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.process_name")%>' property="wf_name" sortable="false"/>
            
            <%
            if(rdList!=null)
            {
                for(int i=0; i<rdList.size(); i++)
                {               
                    if(!((DynamicRelevantData)rdList.get(i)).isInTable()) continue;
                    if(((DynamicRelevantData)rdList.get(i)).getDataDesc()==null||"".equals(((DynamicRelevantData)rdList.get(i)).getDataDesc())) continue;
            %>
            <data:collectionItemAlexander width="10%" title="<%=((DynamicRelevantData)rdList.get(i)).getDataDesc()%>" titleCode ="<%=((DynamicRelevantData)rdList.get(i)).getDataCode()%>" property="relevantData" nestProperty1="code" nestProperty2="value" sortable="false"/>
            <%
                }
            }%>
            <data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.launch_time")%>' property="createddate" sortable="false"/>
            <data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.implementation_state")%>' property="state" sortable="false"/>
            <!--data:collectionItemAlexander width="10%" title="发起人" property="startor" sortable="false"/-->
        </layout:collection>        
        <jsp:include page="/jsp/include/page.jsp" />
        
        </td>
    </tr>
</table>
</div>
<!-- 列表结束 -->

<input type="hidden" name="id" value="">
<input type="hidden" name="isPrint" value="">
<input type="hidden" name="queryCondition" value="">
</form>

</fmt:bundle>

<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');
</script>

</body>
</html>

<%  
    //表单回写
    if(request.getAttribute("writeBackFormValues") != null) {  //如果request中取出的bean不为空
        out.print("<script language=\"javascript\">\n");  //输出script的声明开始
        out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));  //输出表单回写方法的脚本
        out.print("writeBackMapToForm();\n");  //输出执行回写方法
        out.print("</script>");  //输出script的声明结束
    }
%>