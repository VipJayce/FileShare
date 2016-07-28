<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.workattendanceapply.leaveh.vo.LeavehVo" %>
<%@ page import="rayoo.workattendance.workattendanceapply.leaveh.util.ILeavehConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ILeavehConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ILeavehConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	LeavehVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>休假申请</title>
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
		form.action="<%=request.getContextPath()%>/LeavehAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/LeavehAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	  $id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendanceapply/leaveh/insertLeaveh.jsp";
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
		form.action="<%=request.getContextPath()%>/LeavehAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	   //-------------------------------
     function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    
    function reset_onClick(){
        jQuery("#cust_id").val("");       
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }

    //提交审核
     function approveCheckbox_onClick() {
            var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
            if(ids == null) {  //如果ids为空
                alert('<fmt:message key="select_one_record"/>');
                return;
            }
            if(ids.length > 1) {  //如果ids有2条以上的纪录
                alert('<fmt:message key="only_can_a_record"/>');
                return;
            }
            jQuery.ajax({
                type : "post",
                url : "<%=request.getContextPath()%>/LeavehAction.do?cmd=submitApprove&ids="+ids,
                dataType : "html",
                success : function(data) {
                        alert(data);
                        $id("datacell1").loadData();
                        $id("datacell1").refresh();
                }
            });
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/LeavehAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('休假申请','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="150" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td width="70" align="center">客户名称</td>
            <td width="190">
              <input type="hidden" name="cust_id" id="cust_id">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="170px" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
            </td>
			<td width="70" align="center">申请人</td>
			<td width="180">
				<input type="text" class="text_field" name="applier_name" inputName="applier"/>
			</td>
			<td width="70" align="center">审批状态</td>
			<td>
			     <%=gap.rm.tools.helper.RmJspHelper.getSelectField("istorest", -1, "TrueOrFalse", "", "", false) %> 
			</td>
			<td width="218">
             <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             <input type="reset" class="icon_1" onclick="javascript:reset_onClick()" />
             </td>
		</tr>
</table>
</div>
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="a">     <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="h_2">     <a  onClick="javascript:approveCheckbox_onClick();">提交审核</a> </li>
				</ul>
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/LeavehAction.do?cmd=simpleQuery"  width="98%" height="320px" xpath="LeavehVo" paramFormId="datacell_formid" readonly="true">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
  <r:field fieldName="billname" label="申请单名称"></r:field>
  <r:field fieldName="customer_name" label="客户名称">
  <h:text />
  </r:field>
   <r:field fieldName="applier_name" label="申请人"></r:field>
     <r:field fieldName="applydept" label="申请部门"></r:field>
  <r:field fieldName="leavetype" label="休假假别">
    <d:select dictTypeId="LEAVE_TYPE" />
  </r:field>
  <r:field fieldName="leavebeginday" label="休假开始日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
    <r:field fieldName="leaveendday" label="休假结束日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="leavebegintime" label="休假开始时间"></r:field>
   <r:field fieldName="leaveendtime" label="休假结束时间"></r:field>
   <r:field fieldName="leavenote" label="休假事由"></r:field>
   <r:field fieldName="leavecycbegindate" label="假别周期开始日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="leavesumhour" label="休假合计工时"></r:field>
   <r:field fieldName="applydate" label="申请日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="censor_name" label="审核人"></r:field>
   <r:field fieldName="approveidea" label="审批意见"></r:field>
   <r:field fieldName="approvestatus" label="审批状态">
    <d:select dictTypeId="APPROVE_BD" />
   </r:field>
   <r:field fieldName="backdate" label="销假日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="remark" label="备注"></r:field>
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
	if(request.getAttribute(ILeavehConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ILeavehConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
