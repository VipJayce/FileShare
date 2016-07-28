<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupplyitem.vo.EmpsecuritysupplyitemVo" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupplyitem.util.IEmpsecuritysupplyitemConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IEmpsecuritysupplyitemConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IEmpsecuritysupplyitemConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	EmpsecuritysupplyitemVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecuritysupplyitem/insertEmpsecuritysupplyitem.jsp";
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
		form.action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do">
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
			<td align="right">security_supply_id</td>
			<td align="left">
				<input type="text" class="text_field" name="security_supply_id" inputName="security_supply_id" maxLength="64"/>
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
			<td align="right">base</td>
			<td align="left">
				<input type="text" class="text_field_half" name="base_from" inputName="base" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="base_to" inputName="base" value="" columnSize="" decimalDigits="4" />
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
			<td align="right">p_ratio</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_ratio_from" inputName="p_ratio" value="" columnSize="" decimalDigits="5" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_ratio_to" inputName="p_ratio" value="" columnSize="" decimalDigits="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="money_from" inputName="money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="money_to" inputName="money" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_money_from" inputName="e_money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_money_to" inputName="e_money" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_money_from" inputName="p_money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_money_to" inputName="p_money" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_add_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_add_money_from" inputName="e_add_money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_add_money_to" inputName="e_add_money" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_add_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_add_money_from" inputName="p_add_money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_add_money_to" inputName="p_add_money" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">the_month</td>
			<td align="left">
				<input type="text" class="text_field" name="the_month" inputName="the_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e_latefee</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_latefee_from" inputName="e_latefee" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_latefee_to" inputName="e_latefee" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p_latefee</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_latefee_from" inputName="p_latefee" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_latefee_to" inputName="p_latefee" value="" columnSize="" decimalDigits="4" />
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
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">exact_e_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="exact_e_money_from" inputName="exact_e_money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="exact_e_money_to" inputName="exact_e_money" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">exact_p_money</td>
			<td align="left">
				<input type="text" class="text_field_half" name="exact_p_money_from" inputName="exact_p_money" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="exact_p_money_to" inputName="exact_p_money" value="" columnSize="" decimalDigits="4" />
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
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"security_supply_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"security_supply_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"security_supply_id")%>">
           	</a>	
       
			 security_supply_id</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_id")%>">
           	</a>	
       
			 product_id</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"base")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"base")%>">
           	</a>	
       
			 base</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_ratio")%>">
           	</a>	
       
			 e_ratio</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_ratio")%>">
           	</a>	
       
			 p_ratio</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"money")%>">
           	</a>	
       
			 money</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_money")%>">
           	</a>	
       
			 e_money</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_money")%>">
           	</a>	
       
			 p_money</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_add_money")%>">
           	</a>	
       
			 e_add_money</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_add_money")%>">
           	</a>	
       
			 p_add_money</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"the_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"the_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"the_month")%>">
           	</a>	
       
			 the_month</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_latefee")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_latefee")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_latefee")%>">
           	</a>	
       
			 e_latefee</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_latefee")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_latefee")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_latefee")%>">
           	</a>	
       
			 p_latefee</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"exact_e_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"exact_e_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"exact_e_money")%>">
           	</a>	
       
			 exact_e_money</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"exact_p_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"exact_p_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"exact_p_money")%>">
           	</a>	
       
			 exact_p_money</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="security_supply_id"/>   </td>
			
			<td><bean:write name="data" property="product_id"/>   </td>
			
			<td><bean:write name="data" property="base"/>   </td>
			
			<td><bean:write name="data" property="e_ratio"/>   </td>
			
			<td><bean:write name="data" property="p_ratio"/>   </td>
			
			<td><bean:write name="data" property="money"/>   </td>
			
			<td><bean:write name="data" property="e_money"/>   </td>
			
			<td><bean:write name="data" property="p_money"/>   </td>
			
			<td><bean:write name="data" property="e_add_money"/>   </td>
			
			<td><bean:write name="data" property="p_add_money"/>   </td>
			
			<td><bean:write name="data" property="the_month"/>   </td>
			
			<td><bean:write name="data" property="e_latefee"/>   </td>
			
			<td><bean:write name="data" property="p_latefee"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="exact_e_money"/>   </td>
			
			<td><bean:write name="data" property="exact_p_money"/>   </td>
			
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
	if(request.getAttribute(IEmpsecuritysupplyitemConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmpsecuritysupplyitemConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
