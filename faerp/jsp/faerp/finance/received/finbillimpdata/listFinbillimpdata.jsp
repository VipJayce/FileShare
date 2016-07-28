<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.received.finbillimpdata.vo.FinbillimpdataVo" %>
<%@ page import="rayoo.finance.received.finbillimpdata.util.IFinbillimpdataConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IFinbillimpdataConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IFinbillimpdataConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	FinbillimpdataVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/received/finbillimpdata/insertFinbillimpdata.jsp";
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
		form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/FinbillimpdataAction.do">
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
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_imp_batch_id</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_imp_batch_id" inputName="bill_imp_batch_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否错误</td>
			<td align="left">
				<input type="text" class="text_field" name="is_failure" inputName="是否错误" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">错误原因</td>
			<td align="left">
				<input type="text" class="text_field" name="failure_reason" inputName="错误原因" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">员工ID</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id" inputName="员工ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">员工唯一号</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" inputName="员工唯一号" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">身份证</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id_card_no" inputName="身份证" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a1</td>
			<td align="left">
				<input type="text" class="text_field" name="a1" inputName="a1" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a2</td>
			<td align="left">
				<input type="text" class="text_field" name="a2" inputName="a2" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" maxLength="64"/>
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
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a3</td>
			<td align="left">
				<input type="text" class="text_field" name="a3" inputName="a3" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a4</td>
			<td align="left">
				<input type="text" class="text_field" name="a4" inputName="a4" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a5</td>
			<td align="left">
				<input type="text" class="text_field" name="a5" inputName="a5" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a6</td>
			<td align="left">
				<input type="text" class="text_field" name="a6" inputName="a6" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a7</td>
			<td align="left">
				<input type="text" class="text_field" name="a7" inputName="a7" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a8</td>
			<td align="left">
				<input type="text" class="text_field" name="a8" inputName="a8" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a9</td>
			<td align="left">
				<input type="text" class="text_field" name="a9" inputName="a9" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a10</td>
			<td align="left">
				<input type="text" class="text_field" name="a10" inputName="a10" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a11</td>
			<td align="left">
				<input type="text" class="text_field" name="a11" inputName="a11" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a12</td>
			<td align="left">
				<input type="text" class="text_field" name="a12" inputName="a12" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a13</td>
			<td align="left">
				<input type="text" class="text_field" name="a13" inputName="a13" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a14</td>
			<td align="left">
				<input type="text" class="text_field" name="a14" inputName="a14" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a15</td>
			<td align="left">
				<input type="text" class="text_field" name="a15" inputName="a15" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a16</td>
			<td align="left">
				<input type="text" class="text_field" name="a16" inputName="a16" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a17</td>
			<td align="left">
				<input type="text" class="text_field" name="a17" inputName="a17" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a18</td>
			<td align="left">
				<input type="text" class="text_field" name="a18" inputName="a18" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a19</td>
			<td align="left">
				<input type="text" class="text_field" name="a19" inputName="a19" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a20</td>
			<td align="left">
				<input type="text" class="text_field" name="a20" inputName="a20" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a21</td>
			<td align="left">
				<input type="text" class="text_field" name="a21" inputName="a21" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a22</td>
			<td align="left">
				<input type="text" class="text_field" name="a22" inputName="a22" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a23</td>
			<td align="left">
				<input type="text" class="text_field" name="a23" inputName="a23" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a24</td>
			<td align="left">
				<input type="text" class="text_field" name="a24" inputName="a24" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a25</td>
			<td align="left">
				<input type="text" class="text_field" name="a25" inputName="a25" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a26</td>
			<td align="left">
				<input type="text" class="text_field" name="a26" inputName="a26" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a27</td>
			<td align="left">
				<input type="text" class="text_field" name="a27" inputName="a27" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a28</td>
			<td align="left">
				<input type="text" class="text_field" name="a28" inputName="a28" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a29</td>
			<td align="left">
				<input type="text" class="text_field" name="a29" inputName="a29" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a30</td>
			<td align="left">
				<input type="text" class="text_field" name="a30" inputName="a30" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">a31</td>
			<td align="left">
				<input type="text" class="text_field" name="a31" inputName="a31" maxLength="64"/>
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
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_imp_batch_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_imp_batch_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_imp_batch_id")%>">
           	</a>	
       
			 bill_imp_batch_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_failure")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_failure")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_failure")%>">
           	</a>	
       
			 是否错误</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"failure_reason")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"failure_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"failure_reason")%>">
           	</a>	
       
			 错误原因</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id")%>">
           	</a>	
       
			 员工ID</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_code")%>">
           	</a>	
       
			 员工唯一号</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id_card_no")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id_card_no")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id_card_no")%>">
           	</a>	
       
			 身份证</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_name")%>">
           	</a>	
       
			 员工姓名</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a1")%>">
           	</a>	
       
			 a1</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a2")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a2")%>">
           	</a>	
       
			 a2</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
           	</a>	
       
			 cust_name</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 cust_id</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
           	</a>	
       
			 cust_code</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a3")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a3")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a3")%>">
           	</a>	
       
			 a3</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a4")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a4")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a4")%>">
           	</a>	
       
			 a4</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a5")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a5")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a5")%>">
           	</a>	
       
			 a5</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a6")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a6")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a6")%>">
           	</a>	
       
			 a6</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a7")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a7")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a7")%>">
           	</a>	
       
			 a7</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a8")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a8")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a8")%>">
           	</a>	
       
			 a8</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a9")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a9")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a9")%>">
           	</a>	
       
			 a9</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a10")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a10")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a10")%>">
           	</a>	
       
			 a10</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a11")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a11")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a11")%>">
           	</a>	
       
			 a11</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a12")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a12")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a12")%>">
           	</a>	
       
			 a12</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a13")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a13")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a13")%>">
           	</a>	
       
			 a13</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a14")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a14")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a14")%>">
           	</a>	
       
			 a14</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a15")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a15")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a15")%>">
           	</a>	
       
			 a15</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a16")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a16")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a16")%>">
           	</a>	
       
			 a16</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a17")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a17")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a17")%>">
           	</a>	
       
			 a17</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a18")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a18")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a18")%>">
           	</a>	
       
			 a18</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a19")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a19")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a19")%>">
           	</a>	
       
			 a19</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a20")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a20")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a20")%>">
           	</a>	
       
			 a20</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a21")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a21")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a21")%>">
           	</a>	
       
			 a21</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a22")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a22")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a22")%>">
           	</a>	
       
			 a22</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a23")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a23")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a23")%>">
           	</a>	
       
			 a23</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a24")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a24")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a24")%>">
           	</a>	
       
			 a24</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a25")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a25")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a25")%>">
           	</a>	
       
			 a25</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a26")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a26")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a26")%>">
           	</a>	
       
			 a26</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a27")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a27")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a27")%>">
           	</a>	
       
			 a27</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a28")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a28")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a28")%>">
           	</a>	
       
			 a28</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a29")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a29")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a29")%>">
           	</a>	
       
			 a29</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a30")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a30")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a30")%>">
           	</a>	
       
			 a30</th>
			<th>
				
			  	<a href="/FAERP/FinbillimpdataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"a31")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"a31")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"a31")%>">
           	</a>	
       
			 a31</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="bill_imp_batch_id"/>   </td>
			
			<td><bean:write name="data" property="is_failure"/>   </td>
			
			<td><bean:write name="data" property="failure_reason"/>   </td>
			
			<td><bean:write name="data" property="emp_id"/>   </td>
			
			<td><bean:write name="data" property="emp_code"/>   </td>
			
			<td><bean:write name="data" property="emp_id_card_no"/>   </td>
			
			<td><bean:write name="data" property="emp_name"/>   </td>
			
			<td><bean:write name="data" property="a1"/>   </td>
			
			<td><bean:write name="data" property="a2"/>   </td>
			
			<td><bean:write name="data" property="cust_name"/>   </td>
			
			<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="cust_code"/>   </td>
			
			<td><bean:write name="data" property="a3"/>   </td>
			
			<td><bean:write name="data" property="a4"/>   </td>
			
			<td><bean:write name="data" property="a5"/>   </td>
			
			<td><bean:write name="data" property="a6"/>   </td>
			
			<td><bean:write name="data" property="a7"/>   </td>
			
			<td><bean:write name="data" property="a8"/>   </td>
			
			<td><bean:write name="data" property="a9"/>   </td>
			
			<td><bean:write name="data" property="a10"/>   </td>
			
			<td><bean:write name="data" property="a11"/>   </td>
			
			<td><bean:write name="data" property="a12"/>   </td>
			
			<td><bean:write name="data" property="a13"/>   </td>
			
			<td><bean:write name="data" property="a14"/>   </td>
			
			<td><bean:write name="data" property="a15"/>   </td>
			
			<td><bean:write name="data" property="a16"/>   </td>
			
			<td><bean:write name="data" property="a17"/>   </td>
			
			<td><bean:write name="data" property="a18"/>   </td>
			
			<td><bean:write name="data" property="a19"/>   </td>
			
			<td><bean:write name="data" property="a20"/>   </td>
			
			<td><bean:write name="data" property="a21"/>   </td>
			
			<td><bean:write name="data" property="a22"/>   </td>
			
			<td><bean:write name="data" property="a23"/>   </td>
			
			<td><bean:write name="data" property="a24"/>   </td>
			
			<td><bean:write name="data" property="a25"/>   </td>
			
			<td><bean:write name="data" property="a26"/>   </td>
			
			<td><bean:write name="data" property="a27"/>   </td>
			
			<td><bean:write name="data" property="a28"/>   </td>
			
			<td><bean:write name="data" property="a29"/>   </td>
			
			<td><bean:write name="data" property="a30"/>   </td>
			
			<td><bean:write name="data" property="a31"/>   </td>
			
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
	if(request.getAttribute(IFinbillimpdataConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinbillimpdataConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
