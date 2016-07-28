<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empinfo.employee.util.IEmployeeConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IEmployeeConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IEmployeeConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    EmployeeVo resultVo = null;  //定义一个临时的vo变量
%>
<html>

<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择员工</title>
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
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "searchEmployee";
        form.submit();
    }
    function toOK_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = document.getElementById(ids+'emp_name').value;
        returnAry[2] = document.getElementById(ids+'emp_code').value;
        returnAry[3] = document.getElementById(ids+'id_card').value;
        returnAry[4] = document.getElementById(ids+'cust_name').value;
        returnAry[5] = document.getElementById(ids+'cust_code').value;
        window.returnValue=returnAry;
        window.close();

    }

</script>
    </head>
    <body>
    
    <form name="form" method="post" action="<%=request.getContextPath()%>/EpempcardAction.do">
    <input type="hidden" name="cmd" value="searchEmployee">
    <input type="hidden" name="backFlag" id="backFlag" value="true">


    <div id="right"><script language="javascript">
    writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">

 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		</tr>
		<tr>
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="10"/>			</td>
			<td align="right">唯一号</td>
			<td align="left">
			   <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="64"/>            </td>
			<td align="right">身份证号</td>
			<td align="left">
			   <input type="text" class="text_field" name="id_card" inputName="身份证号" maxLength="64"/>            </td>
		</tr>
		<tr>
			<td align="right">客户编号</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="64"/>			</td>
			<td align="right">客户名称</td>
			<td align="left">
			    <input type="text" class="text_field" name="cust_name" inputName="客户名称" maxLength="64"/>            </td>
			<td align="right">客户方编号</td>
			<td align="left">
			    <input type="text" class="text_field" name="internal_code" inputName="客户方编号" maxLength="64"/>            </td>
		</tr>
		<tr>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>
			     <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             </td>
             <td>   
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
		</tr>
</table>
</div>

<div id="ccParent1" class="button"> 
	 <div class="button_right">
		<ul>
			<li class="g">      <a onClick="javascript:toOK_onClick();">确定</a></li>
		</ul>
	</div>
    <div class="clear"></div>			
</div>
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
            <th><input type='checkbox' onClick="checkAllList_onClick(this);" pdType='control' control='checkbox_template' /></th>
            
            <th><center><a href="/FAERP/EpempcardAction.do?cmd=searchEmployee&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e.emp_name")%>">
            <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e.emp_name")%>" border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e.emp_name")%>">
            </a> 员工姓名</center></th>
            
            <th><center><a href="/FAERP/EpempcardAction.do?cmd=searchEmployee&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e.emp_code")%>">
            <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e.emp_code")%>" border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e.emp_code")%>">
            </a> 唯一号</center></th>
            
            <th><center><a href="/FAERP/EpempcardAction.do?cmd=searchEmployee&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e.id_card")%>">
            <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e.id_card")%>" border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e.id_card")%>">
            </a> 身份证号</center></th>
            
            <th><center><a href="/FAERP/EpempcardAction.do?cmd=searchEmployee&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e.cust_name")%>">
            <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e.cust_name")%>" border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e.cust_name")%>">
            </a> 客户名称</center></th>
            
            <th><center><a href="/FAERP/EpempcardAction.do?cmd=searchEmployee&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e.cust_code")%>">
            <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e.cust_code")%>" border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e.cust_code")%>">
            </a> 客户编号</center></th>
            
            <th><center><a href="/FAERP/EpempcardAction.do?cmd=searchEmployee&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e.internal_code")%>">
            <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e.internal_code")%>" border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e.internal_code")%>">
            </a> 客户方编号</center></th>
            
       </tr>
       <logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
        <tr>
            <td>
                <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/>
            </td>

            <td><center>&nbsp;<bean:write name="data" property="emp_name"/>
            <input type="hidden" id="<bean:write name="data" property="id"/>emp_name" value="<bean:write name="data" property="emp_name"/>"/>
            </center></td>
            
            <td><center>&nbsp;<bean:write name="data" property="emp_code"/>
            <input type="hidden" id="<bean:write name="data" property="id"/>emp_code" value="<bean:write name="data" property="emp_code"/>"/>
            </center></td>
            
            <td><center>&nbsp;<bean:write name="data" property="id_card"/>
            <input type="hidden" id="<bean:write name="data" property="id"/>id_card" value="<bean:write name="data" property="id_card"/>"/>
            </center></td>
            
            <td><center>&nbsp;<bean:write name="data" property="cust_name"/>
            <input type="hidden" id="<bean:write name="data" property="id"/>cust_name" value="<bean:write name="data" property="cust_name"/>"/>
            </center></td>
            
            <td><center>&nbsp;<bean:write name="data" property="cust_code"/>
            <input type="hidden" id="<bean:write name="data" property="id"/>cust_code" value="<bean:write name="data" property="cust_code"/>"/>
            </center></td>
            
            <td><center>&nbsp;<bean:write name="data" property="internal_code"/></center>   </td>
            
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
    if(request.getAttribute(IEmployeeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmployeeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   

