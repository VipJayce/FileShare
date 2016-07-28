<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo" %>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IFinpaymentConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IFinpaymentConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	FinpaymentVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
		form.action="<%=request.getContextPath()%>/FinpaymentAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/FinpaymentAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/finpayment/insertFinpayment.jsp";
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
		form.action="<%=request.getContextPath()%>/FinpaymentAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/FinpaymentAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">的说法是的</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_month" inputName="的说法是的" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="apply_amount_from" inputName="apply_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="apply_amount_to" inputName="apply_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="apply_date_from" id="apply_date_from" inputName="apply_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="apply_date_to" id="apply_date_to" inputName="apply_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">receiver_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="receiver_type_bd" inputName="receiver_type_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">receiver_name</td>
			<td align="left">
				<input type="text" class="text_field" name="receiver_name" inputName="receiver_name" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cost_center_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_id" inputName="cost_center_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id" inputName="emp_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">invoice_num</td>
			<td align="left">
				<input type="text" class="text_field_half" name="invoice_num_from" inputName="invoice_num" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="invoice_num_to" inputName="invoice_num" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payment_purpose</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_purpose" inputName="payment_purpose" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payment_reason</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_reason" inputName="payment_reason" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payment_desc</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_desc" inputName="payment_desc" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="apply_user_id" inputName="apply_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">audit_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="audit_amount_from" inputName="audit_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="audit_amount_to" inputName="audit_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">audit_opinion</td>
			<td align="left">
				<input type="text" class="text_field" name="audit_opinion" inputName="audit_opinion" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cashier_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cashier_user_id" inputName="cashier_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cashier_operate_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="cashier_operate_date_from" id="cashier_operate_date_from" inputName="cashier_operate_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('cashier_operate_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="cashier_operate_date_to" id="cashier_operate_date_to" inputName="cashier_operate_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('cashier_operate_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">audit_status</td>
			<td align="left">
				<input type="text" class="text_field" name="audit_status" inputName="audit_status" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">process_ins_id</td>
			<td align="left">
				<input type="text" class="text_field" name="process_ins_id" inputName="process_ins_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_reimburse</td>
			<td align="left">
				<input type="text" class="text_field" name="is_reimburse" inputName="is_reimburse" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">reimburse_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="reimburse_status_bd" inputName="reimburse_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">reimburse_finished_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="reimburse_finished_date_from" id="reimburse_finished_date_from" inputName="reimburse_finished_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('reimburse_finished_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="reimburse_finished_date_to" id="reimburse_finished_date_to" inputName="reimburse_finished_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('reimburse_finished_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">reimburse_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="reimburse_amount_from" inputName="reimburse_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="reimburse_amount_to" inputName="reimburse_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_have_item</td>
			<td align="left">
				<input type="text" class="text_field" name="is_have_item" inputName="is_have_item" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">创建用户ID</td>
			<td align="left">
				<input type="text" class="text_field" name="create_user_id" inputName="创建用户ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">创建日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="create_date_from" id="create_date_from" inputName="创建日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('create_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="create_date_to" id="create_date_to" inputName="创建日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('create_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_month")%>">
           	</a>	
       
			 的说法是的</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_amount")%>">
           	</a>	
       
			 apply_amount</th>
			<th>
							
				 	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_date")%>">
           	</a>	
       
			apply_date</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"receiver_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"receiver_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"receiver_type_bd")%>">
           	</a>	
       
			 receiver_type_bd</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"receiver_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"receiver_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"receiver_name")%>">
           	</a>	
       
			 receiver_name</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 cust_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_id")%>">
           	</a>	
       
			 cost_center_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id")%>">
           	</a>	
       
			 emp_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"invoice_num")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"invoice_num")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"invoice_num")%>">
           	</a>	
       
			 invoice_num</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_purpose")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_purpose")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_purpose")%>">
           	</a>	
       
			 payment_purpose</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_reason")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_reason")%>">
           	</a>	
       
			 payment_reason</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_desc")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_desc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_desc")%>">
           	</a>	
       
			 payment_desc</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_user_id")%>">
           	</a>	
       
			 apply_user_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"audit_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"audit_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"audit_amount")%>">
           	</a>	
       
			 audit_amount</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"audit_opinion")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"audit_opinion")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"audit_opinion")%>">
           	</a>	
       
			 audit_opinion</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cashier_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cashier_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cashier_user_id")%>">
           	</a>	
       
			 cashier_user_id</th>
			<th>
							
				 	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cashier_operate_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cashier_operate_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cashier_operate_date")%>">
           	</a>	
       
			cashier_operate_date</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"audit_status")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"audit_status")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"audit_status")%>">
           	</a>	
       
			 audit_status</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"process_ins_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"process_ins_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"process_ins_id")%>">
           	</a>	
       
			 process_ins_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_reimburse")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_reimburse")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_reimburse")%>">
           	</a>	
       
			 is_reimburse</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"reimburse_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"reimburse_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"reimburse_status_bd")%>">
           	</a>	
       
			 reimburse_status_bd</th>
			<th>
							
				 	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"reimburse_finished_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"reimburse_finished_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"reimburse_finished_date")%>">
           	</a>	
       
			reimburse_finished_date</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"reimburse_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"reimburse_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"reimburse_amount")%>">
           	</a>	
       
			 reimburse_amount</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_have_item")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_have_item")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_have_item")%>">
           	</a>	
       
			 is_have_item</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_user_id")%>">
           	</a>	
       
			 创建用户ID</th>
			<th>
							
				 	<a href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_date")%>">
           	</a>	
       
			创建日期</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="payment_month"/>   </td>
			
			<td><bean:write name="data" property="apply_amount"/>   </td>
			
			<td><bean:write name="data" property="apply_date"/>   </td>
			<td><bean:write name="data" property="receiver_type_bd"/>   </td>
			
			<td><bean:write name="data" property="receiver_name"/>   </td>
			
			<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="cost_center_id"/>   </td>
			
			<td><bean:write name="data" property="emp_id"/>   </td>
			
			<td><bean:write name="data" property="invoice_num"/>   </td>
			
			<td><bean:write name="data" property="payment_purpose"/>   </td>
			
			<td><bean:write name="data" property="payment_reason"/>   </td>
			
			<td><bean:write name="data" property="payment_desc"/>   </td>
			
			<td><bean:write name="data" property="apply_user_id"/>   </td>
			
			<td><bean:write name="data" property="audit_amount"/>   </td>
			
			<td><bean:write name="data" property="audit_opinion"/>   </td>
			
			<td><bean:write name="data" property="cashier_user_id"/>   </td>
			
			<td><bean:write name="data" property="cashier_operate_date"/>   </td>
			<td><bean:write name="data" property="audit_status"/>   </td>
			
			<td><bean:write name="data" property="process_ins_id"/>   </td>
			
			<td><bean:write name="data" property="is_reimburse"/>   </td>
			
			<td><bean:write name="data" property="reimburse_status_bd"/>   </td>
			
			<td><bean:write name="data" property="reimburse_finished_date"/>   </td>
			<td><bean:write name="data" property="reimburse_amount"/>   </td>
			
			<td><bean:write name="data" property="is_have_item"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="create_user_id"/>   </td>
			
			<td><bean:write name="data" property="create_date"/>   </td>
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
	if(request.getAttribute(IFinpaymentConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinpaymentConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
