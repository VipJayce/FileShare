<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<%@ page import="rayoo.sales.costcenter.util.ICostcenterConstants" %>
<jsp:useBean id="costcenterAction" class="rayoo.sales.costcenter.action.CostcenterAction" scope="page" />
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ICostcenterConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ICostcenterConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	CostcenterVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript"><!--
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
		form.action="<%=request.getContextPath()%>/CostcenterAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/CostcenterAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/CostcenterAction.do?ids=" + ids;
        form.cmd.value = "findToAdd";
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
		form.action="<%=request.getContextPath()%>/CostcenterAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
    function exportExcel_onClick(){  //导出Excel
        oldCmd = form.cmd.value;
        form.cmd.value = "exportExcel";
        form.submit();
    }  
 </script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/CostcenterAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('成本中心','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		   </tr>
			<tr>
			<td align="left">客户编号</td>
			<td align="left">
				<input type="text" class="text_field" name="customer_code" value="" inputName="客户编号" maxLength="25"/>
			</td>
			<td align="left">客户名称</td>
			<td align="left"> 
			    <input type="text" class="text_field" id="customer_name" value="" name="customer_name"  inputName="客户名称" maxLength="25"/>
		   </td>
		   <td align="left">发票抬头</td>
            <td align="left">
                <input type="text" class="text_field" name="receipt_title" value="" inputName="发票抬头" maxLength="64"/>
            </td>
		</tr>
		
		<tr>
		    <td align="left">联系人</td>
            <td align="left">
                <input type="text" class="text_field" name="contact_person" value="" inputName="联系人" maxLength="50"/>
            </td>
            <td align="left">是否财务快递</td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_finance_send", -1,"TrueOrFalse","","",false) %>
            </td>
			 <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">            
            </td>   
            <td align="left"></td>        	
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					  <li class="e">   <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
        <th> <a href="/FAERP/CustomerAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_code")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_code")%>"> </a>    
    客户编号</th> 
    
         <th><a href="/FAERP/CustomerAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_name")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_name")%>"></a>    
    客户名称</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_name")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_name")%>"></a>    
      成本中心名称</th>
      
         <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"receipt_title")%>">
         <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"receipt_title")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"receipt_title")%>"></a>    
    发票抬头</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_account_limit")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_account_limit")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_account_limit")%>"></a>    
    是否有账期</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_finance_send")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_finance_send")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_finance_send")%>"></a>    
    是否财务快递</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"agree_receive_money_date")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"agree_receive_money_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"agree_receive_money_date")%>"></a>    
    约定到款日</th>
    
        <th> <a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"receive_money_month")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"receive_money_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"receive_money_month")%>"></a>    
    到款日所属月</th>
      
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"contact_person")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"contact_person")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"contact_person")%>"></a>    
    联系人</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"contact_address")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"contact_address")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"contact_address")%>"></a>    
    联系人地址</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"contact_tel1")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"contact_tel1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"contact_tel1")%>"></a>    
    联系电话1</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"contact_tel2")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"contact_tel2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"contact_tel2")%>"></a>    
    联系电话2</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fax")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fax")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fax")%>"></a>    
    传真</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email")%>"></a>    
    电子邮件</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"voucher_rule")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"voucher_rule")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"voucher_rule")%>"></a>    
    开票规则</th>
    
        <th><a href="/FAERP/CostcenterAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remarks")%>">
        <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remarks")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remarks")%>"></a>    
    备注</th>
    
</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>       
        <td><bean:write name="data" property="customer_code"/></td>
        <td><bean:write name="data" property="customer_name"/></td>
        <td>&nbsp;<bean:write name="data" property="cost_center_name"/></td>
        <td>&nbsp;<bean:write name="data" property="receipt_title"/></td>
        <td>&nbsp;
        <bean:define name="data" property="is_account_limit" id="is_account_limit"/>
        <%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_account_limit)) %>
        </td>
        <td>&nbsp;
        <bean:define name="data" property="is_finance_send" id="is_finance_send"/>
        <%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(is_finance_send)) %>
        </td>
        <td>&nbsp;<bean:write name="data" property="agree_receive_money_date" format="yyyy-MM-dd"/></td>
        <td>&nbsp;
        <bean:define name="data" property="receive_money_month" id="receive_money_month"/>
        <%=BaseDataHelper.getNameByCode("RECEIVE_MONEY_DATE",String.valueOf(receive_money_month)) %>
        </td>
        <td>&nbsp;<bean:write name="data" property="contact_person"/></td>
        <td>&nbsp;<bean:write name="data" property="contact_address"/></td>
        <td>&nbsp;<bean:write name="data" property="contact_tel1"/></td>
        <td>&nbsp;<bean:write name="data" property="contact_tel2"/></td>
        <td>&nbsp;<bean:write name="data" property="fax"/>   </td>
        <td>&nbsp;<bean:write name="data" property="email"/>   </td>
        <td>&nbsp;<bean:write name="data" property="voucher_rule"/>   </td>
        <td>&nbsp;<bean:write name="data" property="remarks"/>   </td>

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
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ICostcenterConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICostcenterConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
