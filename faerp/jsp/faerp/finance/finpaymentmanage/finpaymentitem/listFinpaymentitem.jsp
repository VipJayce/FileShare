<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.payment.finpaymentitem.vo.FinpaymentitemVo" %>
<%@ page import="rayoo.finance.payment.finpaymentitem.util.IFinpaymentitemConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IFinpaymentitemConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IFinpaymentitemConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	FinpaymentitemVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/FinpaymentitemAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/FinpaymentitemAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/finpaymentmanage/finpaymentitem/insertFinpaymentitem.jsp";
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
		form.action="<%=request.getContextPath()%>/FinpaymentitemAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/FinpaymentitemAction.do">
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
			<td align="right">payment_id</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_id" inputName="payment_id" maxLength="9.5"/>
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
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cost_center_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_name" inputName="cost_center_name" maxLength="5"/>
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
			<td align="right">emp_post_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_post_id" inputName="emp_post_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">product_id</td>
			<td align="left">
				<input type="text" class="text_field" name="product_id" inputName="product_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payment_month</td>
			<td align="left">
				<input type="text" class="text_field" name="payment_month" inputName="payment_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payment_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="payment_amount_from" inputName="payment_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="payment_amount_to" inputName="payment_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">received_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="received_amount_from" inputName="received_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="received_amount_to" inputName="received_amount" value="" columnSize="" decimalDigits="2" />
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
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_id")%>">
           	</a>	
       
			 payment_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 cust_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
           	</a>	
       
			 cust_code</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
           	</a>	
       
			 cust_name</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_name")%>">
           	</a>	
       
			 cost_center_name</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_id")%>">
           	</a>	
       
			 cost_center_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id")%>">
           	</a>	
       
			 emp_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_post_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_post_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_post_id")%>">
           	</a>	
       
			 emp_post_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_id")%>">
           	</a>	
       
			 product_id</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_month")%>">
           	</a>	
       
			 payment_month</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_amount")%>">
           	</a>	
       
			 payment_amount</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"received_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"received_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"received_amount")%>">
           	</a>	
       
			 received_amount</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"reimburse_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"reimburse_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"reimburse_amount")%>">
           	</a>	
       
			 reimburse_amount</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/FinpaymentitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="payment_id"/>   </td>
			
			<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="cust_code"/>   </td>
			
			<td><bean:write name="data" property="cust_name"/>   </td>
			
			<td><bean:write name="data" property="cost_center_name"/>   </td>
			
			<td><bean:write name="data" property="cost_center_id"/>   </td>
			
			<td><bean:write name="data" property="emp_id"/>   </td>
			
			<td><bean:write name="data" property="emp_post_id"/>   </td>
			
			<td><bean:write name="data" property="product_id"/>   </td>
			
			<td><bean:write name="data" property="payment_month"/>   </td>
			
			<td><bean:write name="data" property="payment_amount"/>   </td>
			
			<td><bean:write name="data" property="received_amount"/>   </td>
			
			<td><bean:write name="data" property="reimburse_amount"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
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
	if(request.getAttribute(IFinpaymentitemConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinpaymentitemConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
