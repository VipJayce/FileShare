<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.saimportfailed.vo.SaimportfailedVo" %>
<%@ page import="rayoo.salary.saimportfailed.util.ISaimportfailedConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISaimportfailedConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISaimportfailedConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SaimportfailedVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/SaimportfailedAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/SaimportfailedAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/salary/saimportfailed/insertSaimportfailed.jsp";
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
		form.action="<%=request.getContextPath()%>/SaimportfailedAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SaimportfailedAction.do">
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
			<td align="right">import_info_id</td>
			<td align="left">
				<input type="text" class="text_field" name="import_info_id" inputName="import_info_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_name</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">account_num</td>
			<td align="left">
				<input type="text" class="text_field_half" name="account_num_from" inputName="account_num" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="account_num_to" inputName="account_num" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">remarks</td>
			<td align="left">
				<input type="text" class="text_field" name="remarks" inputName="remarks" maxLength="1000"/>
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
				
			  	<a href="/FAERP/SaimportfailedAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/SaimportfailedAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"import_info_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"import_info_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"import_info_id")%>">
           	</a>	
       
			 import_info_id</th>
			<th>
				
			  	<a href="/FAERP/SaimportfailedAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_name")%>">
           	</a>	
       
			 emp_name</th>
			<th>
				
			  	<a href="/FAERP/SaimportfailedAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"account_num")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"account_num")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"account_num")%>">
           	</a>	
       
			 account_num</th>
			<th>
				
			  	<a href="/FAERP/SaimportfailedAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remarks")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remarks")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remarks")%>">
           	</a>	
       
			 remarks</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="import_info_id"/>   </td>
			
			<td><bean:write name="data" property="emp_name"/>   </td>
			
			<td><bean:write name="data" property="account_num"/>   </td>
			
			<td><bean:write name="data" property="remarks"/>   </td>
			
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
	if(request.getAttribute(ISaimportfailedConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISaimportfailedConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
