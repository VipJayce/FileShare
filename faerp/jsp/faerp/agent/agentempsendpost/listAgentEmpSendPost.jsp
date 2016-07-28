<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agentempsendpost.util.IAgentEmpSendPostConstants" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>派工单维护</title>
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
//		form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?id=" + ids;
//		form.cmd.value = "find";
//		form.submit();
        var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=find&id=" + ids;
        window.open(url,'','height=700px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=派工单修改');
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
//		form.action="<%=request.getContextPath()%>/jsp/faerp/agent/agentempsendpost/insertAgentEmpSendPost.jsp";
//		form.submit();
        var url="<%=request.getContextPath()%>/jsp/faerp/agent/agentempsendpost/insertAgentEmpSendPost.jsp";
        window.open(url,'','height=700px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=派工单新增');
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
            return;
        }else{
            alert("操作失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //员工订单
    function orderInfo_onClick(){ 
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=detailPerOrder&id=" +ids;
        window.open(url,'','height=700px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工订单');
    }
    
    function exportExcel_onClick()
	{
	  if(confirm('是否确定要导出数据？')) {
	      document.form.action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=exportAgentEmpSendPost";
	      document.form.submit();
      }
	}
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/AgentEmpSendPostAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('派工单维护','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
<div id="ccChild0" class="search"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
			<td width="150" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
			<td width="70" align="center">员工姓名</td>
            <td width="234px">
                 <input type="text" class="text_field" name="emp_name" inputName=""/>
            </td>
            <td width="70" align="center">员工编号</td>
            <td width="234px">
                 <input type="text" class="text_field" name="emp_code" inputName=""/>
            </td>
            <td width="70" align="center">性别</td>
            <td width="234px">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_sex", -1, "SEX_BD", "", "", false) %>
            </td>
		</tr>
		<tr>
            <td width="70" align="center">证件类型</td>
            <td width="234px">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_id_card_type", -1, "ID_CARD_TYPE_BD", "", "", false) %>
            </td>
            <td width="70" align="center">证件号码</td>
            <td width="234px">
                 <input type="text" class="text_field" name="emp_idCard" inputName=""/>
            </td>
            <td width="70" align="center">员工状态</td>
            <td width="234px">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_status", -1, "EMP_STATUS", "", "", false) %>
            </td>
        </tr>
		<tr>
            <td width="70" align="center">派工单状态</td>
            <td width="234px">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("status", -1, "AGENT_SENDPOST_BD", "", "", false) %> 
            </td>
            <td width="218" colspan="3" align="right">
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
            <li class="h_2"><a  onClick="javascript:orderInfo_onClick();">查看个人订单</a> </li>
          <!--    <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/></a></li>-->
            <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/></a></li>
            <li class="e"><a onClick="javascript:exportExcel_onClick();">导出</a></li>
            <!-- 
            <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/></a></li>
            -->
        </ul>
    </div>
    <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1" queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=simpleQuery"  width="98%" height="320px" xpath="AgentEmpSendPostVo" paramFormId="datacell_formid" readonly="true">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
        <r:field fieldName="emp_code" label="唯一号"></r:field>
        <r:field fieldName="emp_name" label="员工姓名"></r:field>
        <r:field fieldName="cust_name" label="所在公司"></r:field>
        <r:field fieldName="user_name" label="客服"></r:field>
        <r:field fieldName="city_name" label="派住地区"></r:field>
        <r:field fieldName="entry_date" label="派入日期">
            <w:date allowInput="true" id="entry_date" name="entry_date" format="YYYY-MM-DD" property="bean/entry_date" width="190px" readonly="true"/>
        </r:field>
        <r:field fieldName="" label="撤出日期"></r:field>
        <r:field fieldName="emp_status" label="人员状态">
            <d:select dictTypeId="EMP_STATUS" />
        </r:field>
        <r:field fieldName="status" label="派工单状态">
            <d:select dictTypeId="AGENT_SENDPOST_BD" />
        </r:field>
        <r:field fieldName="agent_name" label="供应商"></r:field>
        <r:field fieldName="projectbook_name" label="项目书名称"></r:field>
        <r:field fieldName="" label="供应商确认日期" allowModify="false">
            <w:date format="YYYY-MM-DD"/>
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

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IAgentEmpSendPostConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IAgentEmpSendPostConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
