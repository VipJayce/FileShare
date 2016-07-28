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
<%@ page import="rayoo.workattendance.workattendanceapply.awayb.vo.AwaybVo" %>
<%@ page import="rayoo.workattendance.workattendanceapply.awayb.util.IAwaybConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IAwaybConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IAwaybConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	AwaybVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出差申请</title>
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
		form.action="<%=request.getContextPath()%>/AwaybAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/AwaybAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendanceapply/awayb/insertAwayb.jsp";
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
		form.action="<%=request.getContextPath()%>/AwaybAction.do?id=" + ids;
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
                url : "<%=request.getContextPath()%>/AwaybAction.do?cmd=submitApprove&ids="+ids,
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

<form name="form" method="post" id="datacell_formid"  action="<%=request.getContextPath()%>/AwaybAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('出差申请','<%=request.getContextPath()%>/');  //显示本页的页眉
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
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("approvestatus", -1, "APPROVE_BD", "", "", false) %> 
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
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                    <li class="a">     <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                    <li class="h_2">     <a  onClick="javascript:approveCheckbox_onClick();">提交审核</a> </li>
                </ul>
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/AwaybAction.do?cmd=simpleQuery"  width="98%" height="320px" xpath="AwaybVo" paramFormId="datacell_formid" readonly="true">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" ></r:field>
  <r:field fieldName="billname" label="申请单名称"></r:field>
  <r:field fieldName="customer_name" label="客户名称">
  <h:text />
  </r:field>
   <r:field fieldName="applier_name" label="申请人"></r:field>
     <r:field fieldName="applydept" label="申请部门"></r:field>
  <r:field fieldName="awayid" label="出差单编码"></r:field>
  <r:field fieldName="awaybeginday" label="出差开始日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
    <r:field fieldName="awayendday" label="出差结束日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="awaybegintime" label="出差开始时间"></r:field>
   <r:field fieldName="awayendtime" label="出差结束时间"></r:field>
   <r:field fieldName="awaynote" label="出差事由"></r:field>
   <r:field fieldName="awayaddress" label="出差目的地"></r:field>
   <r:field fieldName="awaysumhour" label="出差合计时数"></r:field>
   <r:field fieldName="applydate" label="申请日期" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="aheadfee" label="预支费用"></r:field>
   <r:field fieldName="censor_name" label="审核人"></r:field>
   <r:field fieldName="approveidea" label="审批意见"></r:field>
   <r:field fieldName="approvestatus" label="审批状态">
    <d:select dictTypeId="APPROVE_BD" />
   </r:field>
   <r:field fieldName="backdate" label="销差时间" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
   <r:field fieldName="workfinish" label="出差工作完成情况"></r:field>
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
	if(request.getAttribute(IAwaybConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IAwaybConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
