<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<%@ page import="com.use.tools.helper.VoHelperTools" %>
<%@ page import="com.alexander.workflow.extend.util.DynamicRelevantData" %>
<%@ page import="gap.wf.wapi.restrict.OvertimeState" %>
<%@ page import="java.util.List" %>
<%@page import="gap.wf.bizcommon.data.RelevantDataDTO;"%>

<jsp:include page="/workflowForm/globalForm.jsp" flush="true"/>

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
		if(!window.confirm(i18n_wf.whether_to_accept_this_task))return;
		var form = document.all["form"];
		form.action = "<%=request.getContextPath()%>/accepttask.do?taskuid="+theid;
		form.submit();
	}

	function queryHistoryTask(){
		var theid=findSelTaskUid();
	    if(theid==null)return;
		var form = document.all["form"];
		form.action = "<%=request.getContextPath()%>/queryTaskForm.do?taskuid="+theid;
		form.submit();
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
	
	//function history(){
//		var theid=findSelProcInstID();
//	    if(theid==null)return;
//		window.location.href = "queryhistory.do?flag=query&procInstID="+theid;
//	}
	
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

	function gofesco_back(){
       var query = location.search.substring(1);
       var values= query.split("&");
       var pos = values[values.length-1].indexOf('=');
       var value = values[values.length-1].substring(pos+1);
	   if(value){
	       window.close();
	   }else{
	       window.history.go(-1);
	   }

	}
</script>

<%
   
    List rdList = (List)request.getAttribute("relevantDataList");
   
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">

<form name="form" method="post" id="form">
 
<input type="hidden" name="id" value="">
<input type="hidden" name="isPrint" value="">
<input type="hidden" name="queryCondition" value="">

<div id="right">
<script language="javascript">
	  
     
       writeTableTopFesco('任务列表','<venus:base/>/');
</script>
<div class="ringht_s">
 
		
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
	 
		 
		       <li class="appro"><a  onClick="javascript:gofesco_back();">返回 </a> </li>
		 
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th ><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th> 任务名</th>
<th> 任务处理人</th>
<th> 审批意见</th>
<th>任务发起时间</th>
<th>任务完成时间</th>
<th>任务截止时间</th>
<th>当前状态</th>	
<th>是否超时</th>			 
</tr>

<logic:iterate     name="tasklist"  id="taskItem" scope="request" indexId="indexs">
		<tr>
      <td>
             <bean:define id="wy3" name="taskItem" property="taskUid"/>
                <bean:define id="wy4" name="taskItem" property="procInstID"/>
                <bean:define id="wy5" name="taskItem" property="procID"/>
                <input title="<%=LocaleHolder.getMessage("gap.wf.task")+wy3%>" type="radio" name="checkbox_template" value="<%=wy3+","+wy4+","+wy5%>"/>
    </td>
<td>  <bean:write name="taskItem" property="taskName"/> </td>
<td>    <bean:write name="taskItem" property="executorName"/>   </td>


<td>  <bean:write name="taskItem" property="stateReason"/> </td>

	<td>  <bean:write name="taskItem" property="startTime"/>   </td>
	<td>  <bean:write name="taskItem" property="endTime"/>   </td>
		<td>  <bean:write name="taskItem" property="deadLine"/>   </td>	
			<td>  <bean:write name="taskItem" property="state"/>   </td>	
				<td>  <bean:write name="taskItem" property="overtimeState.desc"/>   </td>	
 
			
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
	writeTableBottom('<%=request.getContextPath()%>/');
</script>

</body>
</html>

<%  
	//表单回写
	if(request.getAttribute("writeBackFormValues") != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print("</script>");  //输出script的声明结束
	}
%>