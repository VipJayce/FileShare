<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.ppssasalarytempletitem.vo.PpssasalarytempletitemVo" %>
<%@ page import="rayoo.pps.ppssasalarytempletitem.util.IPpssasalarytempletitemConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PpssasalarytempletitemVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/pps/ppssasalarytempletitem/insertPpssasalarytempletitem.jsp";
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
		form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do">
<input type="hidden" name="cmd" value="">
 
 
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
			<td align="right">salary_temp_id</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_temp_id" inputName="salary_temp_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">salary_class_id</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_class_id" inputName="salary_class_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_item_code</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_item_code" inputName="sa_item_code" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_item_name</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_item_name" inputName="sa_item_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_item_ename</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_item_ename" inputName="sa_item_ename" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">item_cost_group</td>
			<td align="left">
				<input type="text" class="text_field" name="item_cost_group" inputName="item_cost_group" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">compute_level</td>
			<td align="left">
				<input type="text" class="text_field_half" name="compute_level_from" inputName="compute_level" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="compute_level_to" inputName="compute_level" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">item_type</td>
			<td align="left">
				<input type="text" class="text_field" name="item_type" inputName="item_type" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ishide</td>
			<td align="left">
				<input type="text" class="text_field" name="ishide" inputName="ishide" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_system</td>
			<td align="left">
				<input type="text" class="text_field" name="is_system" inputName="is_system" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payroll_name</td>
			<td align="left">
				<input type="text" class="text_field" name="payroll_name" inputName="payroll_name" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_tax</td>
			<td align="left">
				<input type="text" class="text_field" name="is_tax" inputName="is_tax" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">data_source</td>
			<td align="left">
				<input type="text" class="text_field" name="data_source" inputName="data_source" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">source_item</td>
			<td align="left">
				<input type="text" class="text_field" name="source_item" inputName="source_item" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">compute_order</td>
			<td align="left">
				<input type="text" class="text_field_half" name="compute_order_from" inputName="compute_order" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="compute_order_to" inputName="compute_order" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_display</td>
			<td align="left">
				<input type="text" class="text_field" name="is_display" inputName="is_display" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">display_order</td>
			<td align="left">
				<input type="text" class="text_field_half" name="display_order_from" inputName="display_order" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="display_order_to" inputName="display_order" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_bonus</td>
			<td align="left">
				<input type="text" class="text_field" name="is_bonus" inputName="is_bonus" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_labor</td>
			<td align="left">
				<input type="text" class="text_field" name="is_labor" inputName="is_labor" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bonus_months_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bonus_months_bd" inputName="bonus_months_bd" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">property</td>
			<td align="left">
				<input type="text" class="text_field" name="property" inputName="property" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">item_serial_id</td>
			<td align="left">
				<input type="text" class="text_field_half" name="item_serial_id_from" inputName="item_serial_id" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="item_serial_id_to" inputName="item_serial_id" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">item_serial_new_id</td>
			<td align="left">
				<input type="text" class="text_field_half" name="item_serial_new_id_from" inputName="item_serial_new_id" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="item_serial_new_id_to" inputName="item_serial_new_id" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field_half" name="old_id_from" inputName="old_id" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="old_id_to" inputName="old_id" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">decimal_num</td>
			<td align="left">
				<input type="text" class="text_field_half" name="decimal_num_from" inputName="decimal_num" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="decimal_num_to" inputName="decimal_num" value="" columnSize="" decimalDigits="0" />
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
			<td align="right">welfare_display_order</td>
			<td align="left">
				<input type="text" class="text_field_half" name="welfare_display_order_from" inputName="welfare_display_order" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="welfare_display_order_to" inputName="welfare_display_order" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">salary_type</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_type" inputName="salary_type" maxLength="5"/>
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
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
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
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"salary_temp_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"salary_temp_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"salary_temp_id")%>">
           	</a>	
       
			 salary_temp_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"salary_class_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"salary_class_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"salary_class_id")%>">
           	</a>	
       
			 salary_class_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_item_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_item_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_item_code")%>">
           	</a>	
       
			 sa_item_code</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_item_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_item_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_item_name")%>">
           	</a>	
       
			 sa_item_name</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_item_ename")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_item_ename")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_item_ename")%>">
           	</a>	
       
			 sa_item_ename</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"item_cost_group")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"item_cost_group")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"item_cost_group")%>">
           	</a>	
       
			 item_cost_group</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"compute_level")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"compute_level")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"compute_level")%>">
           	</a>	
       
			 compute_level</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"item_type")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"item_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"item_type")%>">
           	</a>	
       
			 item_type</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ishide")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ishide")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ishide")%>">
           	</a>	
       
			 ishide</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_system")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_system")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_system")%>">
           	</a>	
       
			 is_system</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payroll_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payroll_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payroll_name")%>">
           	</a>	
       
			 payroll_name</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_tax")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_tax")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_tax")%>">
           	</a>	
       
			 is_tax</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"data_source")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"data_source")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"data_source")%>">
           	</a>	
       
			 data_source</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"source_item")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"source_item")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"source_item")%>">
           	</a>	
       
			 source_item</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"compute_order")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"compute_order")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"compute_order")%>">
           	</a>	
       
			 compute_order</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_display")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_display")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_display")%>">
           	</a>	
       
			 is_display</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"display_order")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"display_order")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"display_order")%>">
           	</a>	
       
			 display_order</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_bonus")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_bonus")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_bonus")%>">
           	</a>	
       
			 is_bonus</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_labor")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_labor")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_labor")%>">
           	</a>	
       
			 is_labor</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bonus_months_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bonus_months_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bonus_months_bd")%>">
           	</a>	
       
			 bonus_months_bd</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"property")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"property")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"property")%>">
           	</a>	
       
			 property</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"item_serial_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"item_serial_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"item_serial_id")%>">
           	</a>	
       
			 item_serial_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"item_serial_new_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"item_serial_new_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"item_serial_new_id")%>">
           	</a>	
       
			 item_serial_new_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"old_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"old_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"old_id")%>">
           	</a>	
       
			 old_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"decimal_num")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"decimal_num")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"decimal_num")%>">
           	</a>	
       
			 decimal_num</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"welfare_display_order")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"welfare_display_order")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"welfare_display_order")%>">
           	</a>	
       
			 welfare_display_order</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarytempletitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"salary_type")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"salary_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"salary_type")%>">
           	</a>	
       
			 salary_type</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="salary_temp_id"/>   </td>
			
			<td><bean:write name="data" property="salary_class_id"/>   </td>
			
			<td><bean:write name="data" property="sa_item_code"/>   </td>
			
			<td><bean:write name="data" property="sa_item_name"/>   </td>
			
			<td><bean:write name="data" property="sa_item_ename"/>   </td>
			
			<td><bean:write name="data" property="item_cost_group"/>   </td>
			
			<td><bean:write name="data" property="compute_level"/>   </td>
			
			<td><bean:write name="data" property="item_type"/>   </td>
			
			<td><bean:write name="data" property="ishide"/>   </td>
			
			<td><bean:write name="data" property="is_system"/>   </td>
			
			<td><bean:write name="data" property="payroll_name"/>   </td>
			
			<td><bean:write name="data" property="is_tax"/>   </td>
			
			<td><bean:write name="data" property="data_source"/>   </td>
			
			<td><bean:write name="data" property="source_item"/>   </td>
			
			<td><bean:write name="data" property="compute_order"/>   </td>
			
			<td><bean:write name="data" property="is_display"/>   </td>
			
			<td><bean:write name="data" property="display_order"/>   </td>
			
			<td><bean:write name="data" property="is_bonus"/>   </td>
			
			<td><bean:write name="data" property="is_labor"/>   </td>
			
			<td><bean:write name="data" property="bonus_months_bd"/>   </td>
			
			<td><bean:write name="data" property="property"/>   </td>
			
			<td><bean:write name="data" property="item_serial_id"/>   </td>
			
			<td><bean:write name="data" property="item_serial_new_id"/>   </td>
			
			<td><bean:write name="data" property="old_id"/>   </td>
			
			<td><bean:write name="data" property="decimal_num"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="welfare_display_order"/>   </td>
			
			<td><bean:write name="data" property="salary_type"/>   </td>
			
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
	if(request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
