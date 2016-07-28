<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@ page import="com.use.tools.helper.VoHelperTools" %>
<%@ page import="com.alexander.workflow.extend.util.DynamicRelevantData" %>
<%@ page import="gap.wf.wapi.restrict.OvertimeState" %>
<%@ page import="java.util.List" %>
<%@page import="gap.wf.bizcommon.data.RelevantDataDTO;"%>

<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%
    boolean done = false;
    if("true".equals(request.getParameter("done")))
        done = true;
    List rdList = (List)request.getAttribute("relevantDataList");
    String procName = (String)request.getAttribute("procName");
    if(procName==null)
    	procName=request.getParameter("procName");
    if(procName==null)
    	procName="";
    String registerRelevantData = request.getParameter("registerRelevantData");
%>

<jsp:include page="/workflowForm/globalForm.jsp" flush="true"/>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
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
                var array1 = arrayAll[1];
 
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
                var array2 = arrayAll[2];
 
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
        //if(!window.confirm(i18n_wf.whether_to_accept_this_task))return;
        var form = document.all["form"];
        form.action = "<%=request.getContextPath()%>/accepttask.do?taskuid="+theid+"&done=<%=done%>";
        form.submit();
    }

    function queryHistoryTask(){
        var theid=findSelTaskUid();
        if(theid==null)return;
        var form = document.all["form"];
        form.action = "<%=request.getContextPath()%>/queryHistoryTask.do?taskuid="+theid+"&done=<%=done%>";
        form.submit();
    }

    //需要与 globalForm.jsp 同步
    function rollback(){
        var theid=findSelTaskUid();
        if(theid==null)return;
        if(!window.confirm(i18n_wf.whether_to_rollback_this_task))return;
        /*马啸注释
        var form = document.all["form"];
        var stateReason = window.prompt("退回任务的原因/备注？","");
        if(stateReason!=null && ""!=stateReason){
            var oNewItem1 = document.createElement("input");
            oNewItem1.type = "hidden";
            oNewItem1.name = "stateReason";
            oNewItem1.value = stateReason;
            form.insertAdjacentElement("afterBegin",oNewItem1);
        }*/
        var obj =window.showModalDialog('<venus:base/>/EditRollbackReasonAction.do','','dialogHeight:300px;dialogWidth:480px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(obj==null)return;
        var oNewItem1 = document.createElement("input");
        oNewItem1.type = "hidden";
        oNewItem1.name = "stateReason";
        oNewItem1.value = obj[0];
        form.insertAdjacentElement("afterBegin",oNewItem1);
        //window.open('<venus:base/>/EditRollbackReasonAction.do');
        form.action = "<%=request.getContextPath()%>/rollbacktask.do?taskuid="+theid;
        form.submit();
        //alert("'"+obj[0]+"'")
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
    
    
    function viewinfo(){
        var procID=findSelProcID();
        if(procID==null)return;
        var procInstID=findSelProcInstID();
        if(procInstID==null)return;
        var theid=findSelTaskUid();
        //alert("procInstID="+procInstID);
        //alert("theid="+theid+"procID="+procID+"procInstID="+procInstID);
        //    +"?procDefID="+procID
        //    +"&procInstID="+procInstID;
       
        //var url="/FAERP/SalcontractAction.do?cmd=getApprovalDetailsPage&processinstanceid=" + procInstID;
        //url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        //showModalCenter(url, window, "", screen.width-300, screen.height-350, "审批详细信息");  
        
       var w = screen.width-300;
       var h = screen.height-450;
       var l = (screen.width - w) / 2;
       var t = (screen.height - h) / 2;
       var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
       s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
       var url="/FAERP/SalcontractAction.do?cmd=getApprovalDetailsPage&processinstanceid=" + procInstID;
       url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
       window.open(url, '审批详细信息', s);
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
        if (checkAllForms()) {
            var form = document.all["form"];
            form.query.value = "true";      
    
            if(form.workitemData!=undefined){       
                var isDone = <%=request.getParameter("done")%> ;
                
                if(isDone == "" || isDone == "null" || isDone == null){
                    isDone = "${done}";
                }
                alert(isDone);
                if(form.taskName.value=="" && form.procName.value=="" && form.workitemData.value=="")
                {
                    //alert("done = "+isDone);
                    if(isDone){
                        if(form.endTime_pre.value=="" && form.endTime_after.value==""){
                            alert('请输入查询条件！');
                            form.query.value = "false";     
                            return;
                        }
                    }else{
                        alert('请输入查询条件！');
                        form.query.value = "false";     
                        return;
                    }
                }
                
                if (isDone == null) {
                    form.action = "<%=request.getContextPath()%>/queryOverTimeTaskByPersonIDAction.do";
                } else {
                    form.action = "<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=<%=done%>";
                }
            }else{
                form.action = "<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=<%=done%>";
            }
    
            form.submit();
        }
    }
    function showRollBackReason(taskItemId){//马啸添加  查看退回理由
        window.showModalDialog('<venus:base/>/ShowRollbackReasonAction.do?taskuid='+taskItemId,'','dialogHeight:300px;dialogWidth:480px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        //window.open('<venus:base/>/ShowRollbackReasonAction.do?taskuid='+taskItemId);
    }
</script>
 
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

</head>
<body>

<form name="form" method="post" id="form">
 
 <input type="hidden" name="id" value="">
<input type="hidden" name="isPrint" value="">
<input type="hidden" name="queryCondition" value="">
<input name="query" type="hidden" value="false"/>

<%
if(done)
    out.println(" <input name=\"isLook\" type=\"hidden\" value=\"true\"/> ");
%>

<div id="right">
<script language="javascript">
	  if(<%=done%>)
           writeTableTopFesco('已办任务','<venus:base/>/');
     else
       writeTableTopFesco('待办任务','<venus:base/>/');
</script>
<div class="ringht_s">

<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="150" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
	<tr>
			<td width="120" >任务名</td>
			<td >
			      <input name="taskName"    type="text" class="text_field" id="taskName" maxlength="30" inputName='任务名' validate="isSearch" />
		 
		 <%if(null==registerRelevantData||"".equals(registerRelevantData)){%>
 
    
         流程名称
      <input name="procName" type="text"  class="text_field" id="procName" maxlength="30" inputName='流程名称' validate="isSearch">
   </td>
 <td> </td>
 <td> </td>
<%}%>
		 
	<%if(done){%>
</tr>
<tr>
    <td>
      完成时间
    </td>
    <td>
    <w:date  format="yyyy-MM-dd" name="endTime_pre" width="188px" property="endTime_pre" />
       <!--   <input name="endTime_pre" id="endTime_pre" type="text"  class="text_field_reference"  inputName='完成时间' maxlength="30" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endTime_pre','<%=request.getContextPath()%>/')" class="img_1">   -->
      &nbsp;到&nbsp;
      <w:date  format="yyyy-MM-dd" name="endTime_after" width="188px" property="endTime_after" />
      <!--   <input name="endTime_after" id="endTime_after" type="text" class="text_field_reference"  inputName='完成时间' maxlength="30" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endTime_after','<%=request.getContextPath()%>/')" class="img_1">   -->
    </td>
 
<%}%>	 
		</tr>
	<%if(rdList==null||rdList.size()==0){%>
<tr>
    <td></td>
    <td>      
      <input name="querytask" type="button" id="querytask" value='查询' onClick="queryTaskByCondition()" class="button_ellipse" />
    </td>
 <%}else{%>
      <data:dynamicQuery  maxLength="30"/>
     <td align="left"> <input name="querytask" type="button" id="querytask" value='查询' onClick="queryTaskByCondition()" class="button_ellipse" />
      <input name="del" type="reset" id="del" value='重置' class="button_ellipse" />
      </td> 
      <%}%>
		 </tr>
</table>
</div>



 

					
<div id="ccParent1" class="button"> 
 <div class="button_right" >
				<ul>
				
		
					<table>
					<tr>
					  <%if(done){%>
                    <td nowrap class="button_ellipse" onClick = "javascript:queryHistoryTask();">
                    <img src="<%=request.getContextPath()%>/images/icon/view.gif" class="div_control_image">查看</td>
                    <td nowrap class="button_ellipse" onClick = "javascript:withdraw();">
                    <img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image">取回</td>
                    <td nowrap class="button_ellipse" onClick = "javascript:history();">
                    <img src="<%=request.getContextPath()%>/images/icon/history.gif" class="div_control_image">历史</td>
                    <td nowrap class="button_ellipse" onClick = "javascript:monitor();">
                    <img src="<%=request.getContextPath()%>/images/icon/monitor.gif" class="div_control_image">监视</td>
                    <%}else{%>
                    <td nowrap class="button_ellipse" onClick = "javascript:accept();">
                    <img src="<%=request.getContextPath()%>/images/icon/confirm.gif" class="div_control_image">查看</td>
                    <td nowrap class="button_ellipse" onClick = "javascript:rollback();">
                    <img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image">退回</td>
                    <td nowrap class="button_ellipse" onClick = "javascript:history();">
                    <img src="<%=request.getContextPath()%>/images/icon/history.gif" class="div_control_image">历史</td>
                    <%}%>
                    <td nowrap class="button_ellipse" onClick = "javascript:viewinfo();">
                    <img src="<%=request.getContextPath()%>/images/icon/view.gif" class="div_control_image">审批详细</td>
                    </tr>
					 </table>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" style="overflow-y:scroll;" class="box"  > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th ><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<!--     <th> 代理/超时</th> -->
<th> 任务名</th>
<th> 处理标志</th>
<th> 流程名</th>
<th> 任务发起时间</th>
<th> 任务截止时间</th>
<th> 当前状态</th>			 
</tr>

<logic:iterate     name="tasklist"  id="taskItem" scope="request" indexId="indexs">
		<tr>
      <td>
             <bean:define id="wy3" name="taskItem" property="taskUid"/>
                <bean:define id="wy4" name="taskItem" property="procInstID"/>
                <bean:define id="wy5" name="taskItem" property="procID"/>
                <input title="<%=LocaleHolder.getMessage("gap.wf.task")+wy3%>" type="checkbox" name="checkbox_template" value="<%=wy3+","+wy4+","+wy5%>"/>
    </td>
<!-- 
                <td>    
                <bean:define id="byagent" name="taskItem" property="isByagentTask"/>
                <bean:define id="agent" name="taskItem" property="isAgentTask"/>
                <bean:define id="stateCode" name="taskItem" property="overtimeState.code"/>
                <bean:define id="stateDesc" name="taskItem" property="overtimeState.desc"/>
                <bean:define id="performerName" name="taskItem" property="performerName"/>
                <bean:define id="agentPersonName" name="taskItem" property="agentPersonName"/>
                <%
                if (((Boolean)byagent).booleanValue()) {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/proxy003.gif' title='");
                    %>
                     被代理
                    <%  
                    out.write(agentPersonName+"'>");
                } else if (((Boolean)agent).booleanValue()) {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/proxy002.gif' title='");
                    %>
                     代理
                    <%
                    out.write(performerName+"'>");
                } else {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/proxy004.gif' title='");
                    %>
                     未代理
                    <%
                    out.write("'>");
                }

                out.write("&nbsp;&nbsp;&nbsp;");

                if(OvertimeState.STATE_FALSE.getCode().equals(stateCode)) {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/alert001.gif' title='" + stateDesc + "'>");
                } else if(OvertimeState.STATE_TRUE.getCode().equals(stateCode)) {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/alert003.gif' title='" + stateDesc + "'>");
                } else {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/alert004.gif' title='" + stateDesc + "'>");
                }
                %>  
                
                </td>
                 -->
<td>  <bean:write name="taskItem" property="taskName"/> </td>
 <bean:define id="tempRelavantData" name="taskItem" property="relevantData"/>
<td>  <%RelevantDataDTO[] a = (RelevantDataDTO[])tempRelavantData;
            for(RelevantDataDTO temp:a){
                if(temp.getCode()!=null&&temp.getCode().equals("showmsg")){
                %>
                <%=temp.getValue() %>
                <%
                }
            }
     %> </td>
<td>  <bean:write name="taskItem" property="processName"/>   </td>
	<td>  <bean:write name="taskItem" property="startTime"/>   </td>
<td>  
  <%if(!done){    %>
<bean:write name="taskItem" property="deadLine"/>
    <%}%>
    <%if(done){ %>
<bean:write name="taskItem" property="endTime"/>
       <%}%> &nbsp;
       
  </td>		
<td> 
 <bean:define id="taskItemId" name="taskItem" property="taskUid"/>
                <bean:define id="taskItemState" name="taskItem" property="state"/>
                <%
                if (taskItemState != null && taskItemState.toString().indexOf(LocaleHolder.getMessage("gap.wf.rollbacked")) != -1) {
                    out.println("<a onclick=showRollBackReason('"+taskItemId+"') title='");
                   %>
                                       查看退回原因
                   <%
                    out.println("'>" + taskItemState + "</a>");
                } else {
                    out.println(taskItemState);
                }
                %>
            
            <%
            if(rdList!=null)
            {
                for(int i=0; i<rdList.size(); i++)
                {               
                    if(!((DynamicRelevantData)rdList.get(i)).isInTable()) continue;
                    if(((DynamicRelevantData)rdList.get(i)).getDataDesc()==null||"".equals(((DynamicRelevantData)rdList.get(i)).getDataDesc())) continue;
            %>
    <%
                }
            }%>
</td>			
			
			</tr>
</logic:iterate>

    
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

</div>
</div>
 
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>



 
<%
    //表单回写
    if(request.getAttribute("writeBackFormValues") != null) {  //如果request中取出的bean不为空
        out.print("<script language=\"javascript\">\n");  //输出script的声明开始
        out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));  //输出表单回写方法的脚本
        out.print("writeBackMapToForm();\n");  //输出执行回写方法
        out.print("</script>");  //输出script的声明结束
    }
%>
 


 
