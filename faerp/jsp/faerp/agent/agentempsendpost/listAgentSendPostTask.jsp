<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>任务单管理</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var belongStatus = jQuery("#belongStatus").val();
		var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=taskDetail&id=" + ids + "&belongStatus=" + belongStatus;
        window.open(url,'','height=550px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=派工单修改');
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/agent/agentsendpostorder/insertAgentSendPostOrder.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	//-------------------------------
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function insertcallBack(reg){
        if(reg=="0"){
            alert("操作成功！");
        }else if(reg=="-1"){
          $id("datacell1").loadData();
        $id("datacell1").refresh();
            return;
        }else{
            alert("操作失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

    //员工订单
    function orderInfo_onClick(belongStatus){ 
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=detailPerOrder&id=" +ids + "&belongStatus=" + belongStatus;
        window.open(url,'','height=700px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工订单');
    }
    //查看派工单
    function showSendPost_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //var belongStatus = jQuery("#belongStatus").val();
        var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=showSendPost&id=" + ids ;
        window.open(url,'','height=550px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看派工单');
    } 
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="belongStatus" id="belongStatus" value="${belongStatus}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
 
<div id="right">
<script language="javascript">
  var belong=document.getElementById("belongStatus").value;
  if(belong=='0'){
	writeTableTopFesco('入职任务单管理','<%=request.getContextPath()%>/');  //显示本页的页眉
	}
	else if(belong=='1'){
	   writeTableTopFesco('离职任务单管理','<%=request.getContextPath()%>/');  //显示本页的页眉
	   }
	 else  if(belong=='2'){
	     writeTableTopFesco('变更任务单管理','<%=request.getContextPath()%>/');  //显示本页的页眉   
	     }else{
	      writeTableTopFesco('任务单管理','<%=request.getContextPath()%>/');  //显示本页的页眉  
	     }
	     
</script>
<div class="ringht_s">
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="150" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td width="70" align="center">员工唯一号</td>
            <td width="234px">
                 <input type="text" class="text_field" name="emp_code" inputName=""/>
            </td>
            <td width="70" align="center">员工姓名</td>
            <td width="234px">
                <input type="text" class="text_field" name="emp_name" inputName=""/>
            </td>
            <td width="70" align="center">客户名称</td>
            <td width="234px">
                 <input type="text" class="text_field" name="cust_name" inputName=""/>
            </td>
            
        </tr>
        <tr>
            <td width="70" align="center">员工状态</td>
            <td width="234px">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_status", -1, "EMP_STATUS", "", "", false) %>
            </td>
            <td width="70" align="center">派工单状态</td>
            <td width="234px">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("status", -1, "AGENT_SENDPOST_BD", "", "", false) %> 
            </td>
            <td width="218" colspan="2" align="right">
                <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1" onclick="" />
            </td>
            <td></td>
        </tr>
    </table>
</div>
                    
<div id="ccParent1" class="button"> 
    <div class="button_right">
        <ul>
            <li class="h_2"><a  onClick="javascript:orderInfo_onClick(${belongStatus});">查看个人订单</a> </li>
            <li class="h_2"><a  onClick="javascript:showSendPost_onClick();">查看派工单</a> </li>
            <c:if test="${belongStatus!=-1}">
            <li class="b"><a onClick="javascript:findCheckbox_onClick();">办理</a></li>
            </c:if>
        </ul>
    </div>
    <div class="clear"></div>           
</div>
 
<div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1" queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=simpleQueryTask"  width="98%" height="320px" xpath="AgentEmpSendPostVo" paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
        <r:field fieldName="emp_code" label="唯一号" width="120px"></r:field>
        <r:field fieldName="emp_name" label="姓名" width="120px"></r:field>
        <r:field fieldName="cust_name" label="客户名称" width="200px"></r:field>
        <r:field fieldName="emp_status" label="员工状态" width="120px">
            <d:select dictTypeId="EMP_STATUS" />
        </r:field>
    </r:datacell>
</div>  
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

