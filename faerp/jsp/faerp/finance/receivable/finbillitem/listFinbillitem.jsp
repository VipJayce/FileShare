<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.receivable.finbillitem.vo.FinbillitemVo" %>
<%@ page import="rayoo.finance.receivable.finbillitem.util.IFinbillitemConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IFinbillitemConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IFinbillitemConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	FinbillitemVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/FinbillitemAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/FinbillitemAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finbillitem/insertFinbillitem.jsp";
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
		form.action="<%=request.getContextPath()%>/FinbillitemAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/FinbillitemAction.do">
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
			<td align="right">账单号</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_id" inputName="账单号" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">产品号</td>
			<td align="left">
				<input type="text" class="text_field" name="product_id" inputName="产品号" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_post_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_post_id" inputName="emp_post_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">service_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="service_year_month" inputName="service_year_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="amount_from" inputName="amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="amount_to" inputName="amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">serial_no</td>
			<td align="left">
				<input type="text" class="text_field" name="serial_no" inputName="serial_no" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_money_from" inputName="p_money" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_money_to" inputName="p_money" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_money_from" inputName="e_money" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_money_to" inputName="e_money" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_base</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_base_from" inputName="p_base" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_base_to" inputName="p_base" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_base</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_base_from" inputName="e_base" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_base_to" inputName="e_base" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_ratio</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_ratio_from" inputName="p_ratio" value="" columnSize="" decimalDigits="5" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_ratio_to" inputName="p_ratio" value="" columnSize="" decimalDigits="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_ratio</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_ratio_from" inputName="e_ratio" value="" columnSize="" decimalDigits="5" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_ratio_to" inputName="e_ratio" value="" columnSize="" decimalDigits="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_add_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_add_money_from" inputName="p_add_money" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_add_money_to" inputName="p_add_money" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_add_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_add_money_from" inputName="e_add_money" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_add_money_to" inputName="e_add_money" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">security_product_item_id</td>
			<td align="left">
				<input type="text" class="text_field" name="security_product_item_id" inputName="security_product_item_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">security_product_id</td>
			<td align="left">
				<input type="text" class="text_field" name="security_product_id" inputName="security_product_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否核销</td>
			<td align="left">
				<input type="text" class="text_field" name="is_verification" inputName="是否核销" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">认领ID</td>
			<td align="left">
				<input type="text" class="text_field" name="claim_id" inputName="认领ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">核销ID</td>
			<td align="left">
				<input type="text" class="text_field" name="verification_id" inputName="核销ID" maxLength="9.5"/>
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
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
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
			<td align="right">employee_id</td>
			<td align="left">
				<input type="text" class="text_field" name="employee_id" inputName="employee_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_sum</td>
			<td align="left">
				<input type="text" class="text_field" name="is_sum" inputName="is_sum" maxLength="64"/>
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
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_id")%>">
           	</a>	
       
			 账单号</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_id")%>">
           	</a>	
       
			 产品号</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_post_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_post_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_post_id")%>">
           	</a>	
       
			 emp_post_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_year_month")%>">
           	</a>	
       
			 bill_year_month</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"service_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"service_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"service_year_month")%>">
           	</a>	
       
			 service_year_month</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"amount")%>">
           	</a>	
       
			 amount</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"serial_no")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"serial_no")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"serial_no")%>">
           	</a>	
       
			 serial_no</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_money")%>">
           	</a>	
       
			 p_money</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_money")%>">
           	</a>	
       
			 e_money</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_base")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_base")%>">
           	</a>	
       
			 p_base</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_base")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_base")%>">
           	</a>	
       
			 e_base</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_ratio")%>">
           	</a>	
       
			 p_ratio</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_ratio")%>">
           	</a>	
       
			 e_ratio</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_add_money")%>">
           	</a>	
       
			 p_add_money</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_add_money")%>">
           	</a>	
       
			 e_add_money</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"security_product_item_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"security_product_item_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"security_product_item_id")%>">
           	</a>	
       
			 security_product_item_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"security_product_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"security_product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"security_product_id")%>">
           	</a>	
       
			 security_product_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_verification")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_verification")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_verification")%>">
           	</a>	
       
			 是否核销</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"claim_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"claim_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"claim_id")%>">
           	</a>	
       
			 认领ID</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"verification_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"verification_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"verification_id")%>">
           	</a>	
       
			 核销ID</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"employee_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"employee_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"employee_id")%>">
           	</a>	
       
			 employee_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_sum")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_sum")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_sum")%>">
           	</a>	
       
			 is_sum</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="bill_id"/>   </td>
			
			<td><bean:write name="data" property="product_id"/>   </td>
			
			<td><bean:write name="data" property="emp_post_id"/>   </td>
			
			<td><bean:write name="data" property="bill_year_month"/>   </td>
			
			<td><bean:write name="data" property="service_year_month"/>   </td>
			
			<td><bean:write name="data" property="amount"/>   </td>
			
			<td><bean:write name="data" property="serial_no"/>   </td>
			
			<td><bean:write name="data" property="p_money"/>   </td>
			
			<td><bean:write name="data" property="e_money"/>   </td>
			
			<td><bean:write name="data" property="p_base"/>   </td>
			
			<td><bean:write name="data" property="e_base"/>   </td>
			
			<td><bean:write name="data" property="p_ratio"/>   </td>
			
			<td><bean:write name="data" property="e_ratio"/>   </td>
			
			<td><bean:write name="data" property="p_add_money"/>   </td>
			
			<td><bean:write name="data" property="e_add_money"/>   </td>
			
			<td><bean:write name="data" property="security_product_item_id"/>   </td>
			
			<td><bean:write name="data" property="security_product_id"/>   </td>
			
			<td><bean:write name="data" property="is_verification"/>   </td>
			
			<td><bean:write name="data" property="claim_id"/>   </td>
			
			<td><bean:write name="data" property="verification_id"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="employee_id"/>   </td>
			
			<td><bean:write name="data" property="is_sum"/>   </td>
			
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
	if(request.getAttribute(IFinbillitemConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinbillitemConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
