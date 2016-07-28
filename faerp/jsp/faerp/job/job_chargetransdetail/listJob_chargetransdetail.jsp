<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_chargetransdetail.vo.Job_chargetransdetailVo" %>
<%@ page import="rayoo.job.job_chargetransdetail.util.IJob_chargetransdetailConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IJob_chargetransdetailConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IJob_chargetransdetailConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Job_chargetransdetailVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/job/job_chargetransdetail/insertJob_chargetransdetail.jsp";
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
		form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
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
			<td align="right">费用划转单主表</td>
			<td align="left">
				<input type="text" class="text_field" name="chargetransferbill_id" inputName="费用划转单主表" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">职位ID</td>
			<td align="left">
				<input type="text" class="text_field" name="position_id" inputName="职位ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">客户ID</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="客户ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">PM主键</td>
			<td align="left">
				<input type="text" class="text_field" name="pm_id" inputName="PM主键" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pmteam</td>
			<td align="left">
				<input type="text" class="text_field" name="pmteam" inputName="pmteam" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">顾问ID</td>
			<td align="left">
				<input type="text" class="text_field" name="counselor_id" inputName="顾问ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">员工ID</td>
			<td align="left">
				<input type="text" class="text_field" name="employee_id" inputName="员工ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">外派开始日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="sendstartdate_from" id="sendstartdate_from" inputName="外派开始日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('sendstartdate_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="sendstartdate_to" id="sendstartdate_to" inputName="外派开始日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('sendstartdate_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">外派截止日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="sendenddate_from" id="sendenddate_from" inputName="外派截止日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('sendenddate_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="sendenddate_to" id="sendenddate_to" inputName="外派截止日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('sendenddate_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">外派期限</td>
			<td align="left">
				<input type="text" class="text_field" name="sendperiod" inputName="外派期限" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">费用项目</td>
			<td align="left">
				<input type="text" class="text_field" name="expenseitem" inputName="费用项目" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">费用金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="expenseamount_from" inputName="费用金额" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="expenseamount_to" inputName="费用金额" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">划入部门</td>
			<td align="left">
				<input type="text" class="text_field_half" name="cutindept_id_from" inputName="划入部门" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="cutindept_id_to" inputName="划入部门" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否显示</td>
			<td align="left">
				<input type="text" class="text_field" name="showed" inputName="是否显示" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">显示序号</td>
			<td align="left">
				<input type="text" class="text_field_half" name="serialno_from" inputName="显示序号" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="serialno_to" inputName="显示序号" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">客服确认人</td>
			<td align="left">
				<input type="text" class="text_field" name="serviceconfirmor" inputName="客服确认人" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">顾问确认人</td>
			<td align="left">
				<input type="text" class="text_field" name="counselconfirmor" inputName="顾问确认人" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">财务确认人</td>
			<td align="left">
				<input type="text" class="text_field" name="financeconfirmor" inputName="财务确认人" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">备注</td>
			<td align="left">
				<input type="text" class="text_field" name="description" inputName="备注" maxLength="100"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否有效</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="是否有效" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否删除</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="是否删除" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">分公司ID</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="分公司ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">创建用户名称</td>
			<td align="left">
				<input type="text" class="text_field" name="create_user_name" inputName="创建用户名称" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">最后更改用户ID</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="最后更改用户ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">最后更改用户名称</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_name" inputName="最后更改用户名称" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">最后更改日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="最后更改日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="最后更改日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
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
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"chargetransferbill_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"chargetransferbill_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"chargetransferbill_id")%>">
           	</a>	
       
			 费用划转单主表</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"position_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"position_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"position_id")%>">
           	</a>	
       
			 职位ID</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 客户ID</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pm_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pm_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pm_id")%>">
           	</a>	
       
			 PM主键</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pmteam")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pmteam")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pmteam")%>">
           	</a>	
       
			 pmteam</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"counselor_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"counselor_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"counselor_id")%>">
           	</a>	
       
			 顾问ID</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"employee_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"employee_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"employee_id")%>">
           	</a>	
       
			 员工ID</th>
			<th>
							
				 	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sendstartdate")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sendstartdate")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sendstartdate")%>">
           	</a>	
       
			外派开始日期</th>
			<th>
							
				 	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sendenddate")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sendenddate")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sendenddate")%>">
           	</a>	
       
			外派截止日期</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sendperiod")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sendperiod")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sendperiod")%>">
           	</a>	
       
			 外派期限</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"expenseitem")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"expenseitem")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"expenseitem")%>">
           	</a>	
       
			 费用项目</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"expenseamount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"expenseamount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"expenseamount")%>">
           	</a>	
       
			 费用金额</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cutindept_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cutindept_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cutindept_id")%>">
           	</a>	
       
			 划入部门</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"showed")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"showed")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"showed")%>">
           	</a>	
       
			 是否显示</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"serialno")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"serialno")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"serialno")%>">
           	</a>	
       
			 显示序号</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"serviceconfirmor")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"serviceconfirmor")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"serviceconfirmor")%>">
           	</a>	
       
			 客服确认人</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"counselconfirmor")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"counselconfirmor")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"counselconfirmor")%>">
           	</a>	
       
			 顾问确认人</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"financeconfirmor")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"financeconfirmor")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"financeconfirmor")%>">
           	</a>	
       
			 财务确认人</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"description")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"description")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"description")%>">
           	</a>	
       
			 备注</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 是否有效</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 是否删除</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 分公司ID</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_user_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_user_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_user_name")%>">
           	</a>	
       
			 创建用户名称</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 最后更改用户ID</th>
			<th>
				
			  	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_name")%>">
           	</a>	
       
			 最后更改用户名称</th>
			<th>
							
				 	<a href="/FAERP/Job_chargetransdetailAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			最后更改日期</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="chargetransferbill_id"/>   </td>
			
			<td><bean:write name="data" property="position_id"/>   </td>
			
			<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="pm_id"/>   </td>
			
			<td><bean:write name="data" property="pmteam"/>   </td>
			
			<td><bean:write name="data" property="counselor_id"/>   </td>
			
			<td><bean:write name="data" property="employee_id"/>   </td>
			
			<td><bean:write name="data" property="sendstartdate"/>   </td>
			<td><bean:write name="data" property="sendenddate"/>   </td>
			<td><bean:write name="data" property="sendperiod"/>   </td>
			
			<td><bean:write name="data" property="expenseitem"/>   </td>
			
			<td><bean:write name="data" property="expenseamount"/>   </td>
			
			<td><bean:write name="data" property="cutindept_id"/>   </td>
			
			<td><bean:write name="data" property="showed"/>   </td>
			
			<td><bean:write name="data" property="serialno"/>   </td>
			
			<td><bean:write name="data" property="serviceconfirmor"/>   </td>
			
			<td><bean:write name="data" property="counselconfirmor"/>   </td>
			
			<td><bean:write name="data" property="financeconfirmor"/>   </td>
			
			<td><bean:write name="data" property="description"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="create_user_name"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_name"/>   </td>
			
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
	if(request.getAttribute(IJob_chargetransdetailConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IJob_chargetransdetailConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
