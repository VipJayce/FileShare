<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.received.finbillimpdata2.vo.Finbillimpdata2Vo" %>
<%@ page import="rayoo.finance.received.finbillimpdata2.util.IFinbillimpdata2Constants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IFinbillimpdata2Constants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IFinbillimpdata2Constants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Finbillimpdata2Vo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/Finbillimpdata2Action.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/Finbillimpdata2Action.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/received/finbillimpdata2/insertFinbillimpdata2.jsp";
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
		form.action="<%=request.getContextPath()%>/Finbillimpdata2Action.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/Finbillimpdata2Action.do">
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
			<td align="right">is_failure</td>
			<td align="left">
				<input type="text" class="text_field" name="is_failure" inputName="is_failure" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">failure_reason</td>
			<td align="left">
				<input type="text" class="text_field" name="failure_reason" inputName="failure_reason" maxLength="1000"/>
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
			<td align="right">emp_code</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_id_card_no</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id_card_no" inputName="emp_id_card_no" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_name</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" maxLength="64"/>
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
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">d</td>
			<td align="left">
				<input type="text" class="text_field" name="d" inputName="d" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">e</td>
			<td align="left">
				<input type="text" class="text_field" name="e" inputName="e" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">f</td>
			<td align="left">
				<input type="text" class="text_field" name="f" inputName="f" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">g</td>
			<td align="left">
				<input type="text" class="text_field" name="g" inputName="g" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">h</td>
			<td align="left">
				<input type="text" class="text_field" name="h" inputName="h" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">i</td>
			<td align="left">
				<input type="text" class="text_field" name="i" inputName="i" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">j</td>
			<td align="left">
				<input type="text" class="text_field" name="j" inputName="j" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">k</td>
			<td align="left">
				<input type="text" class="text_field" name="k" inputName="k" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">l</td>
			<td align="left">
				<input type="text" class="text_field" name="l" inputName="l" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">m</td>
			<td align="left">
				<input type="text" class="text_field" name="m" inputName="m" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">n</td>
			<td align="left">
				<input type="text" class="text_field" name="n" inputName="n" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">o</td>
			<td align="left">
				<input type="text" class="text_field" name="o" inputName="o" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">p</td>
			<td align="left">
				<input type="text" class="text_field" name="p" inputName="p" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">q</td>
			<td align="left">
				<input type="text" class="text_field" name="q" inputName="q" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">r</td>
			<td align="left">
				<input type="text" class="text_field" name="r" inputName="r" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">s</td>
			<td align="left">
				<input type="text" class="text_field" name="s" inputName="s" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">t</td>
			<td align="left">
				<input type="text" class="text_field" name="t" inputName="t" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">u</td>
			<td align="left">
				<input type="text" class="text_field" name="u" inputName="u" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">v</td>
			<td align="left">
				<input type="text" class="text_field" name="v" inputName="v" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">w</td>
			<td align="left">
				<input type="text" class="text_field" name="w" inputName="w" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">x</td>
			<td align="left">
				<input type="text" class="text_field" name="x" inputName="x" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">y</td>
			<td align="left">
				<input type="text" class="text_field" name="y" inputName="y" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">z</td>
			<td align="left">
				<input type="text" class="text_field" name="z" inputName="z" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">aa</td>
			<td align="left">
				<input type="text" class="text_field" name="aa" inputName="aa" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ab</td>
			<td align="left">
				<input type="text" class="text_field" name="ab" inputName="ab" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ac</td>
			<td align="left">
				<input type="text" class="text_field" name="ac" inputName="ac" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ad</td>
			<td align="left">
				<input type="text" class="text_field" name="ad" inputName="ad" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ae</td>
			<td align="left">
				<input type="text" class="text_field" name="ae" inputName="ae" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">af</td>
			<td align="left">
				<input type="text" class="text_field" name="af" inputName="af" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ag</td>
			<td align="left">
				<input type="text" class="text_field" name="ag" inputName="ag" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ah</td>
			<td align="left">
				<input type="text" class="text_field" name="ah" inputName="ah" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ai</td>
			<td align="left">
				<input type="text" class="text_field" name="ai" inputName="ai" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">aj</td>
			<td align="left">
				<input type="text" class="text_field" name="aj" inputName="aj" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ak</td>
			<td align="left">
				<input type="text" class="text_field" name="ak" inputName="ak" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">al</td>
			<td align="left">
				<input type="text" class="text_field" name="al" inputName="al" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">am</td>
			<td align="left">
				<input type="text" class="text_field" name="am" inputName="am" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">an</td>
			<td align="left">
				<input type="text" class="text_field" name="an" inputName="an" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ao</td>
			<td align="left">
				<input type="text" class="text_field" name="ao" inputName="ao" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ap</td>
			<td align="left">
				<input type="text" class="text_field" name="ap" inputName="ap" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">aq</td>
			<td align="left">
				<input type="text" class="text_field" name="aq" inputName="aq" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ar</td>
			<td align="left">
				<input type="text" class="text_field" name="ar" inputName="ar" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">as1</td>
			<td align="left">
				<input type="text" class="text_field" name="as1" inputName="as1" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">at</td>
			<td align="left">
				<input type="text" class="text_field" name="at" inputName="at" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">au</td>
			<td align="left">
				<input type="text" class="text_field" name="au" inputName="au" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">av</td>
			<td align="left">
				<input type="text" class="text_field" name="av" inputName="av" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">aw</td>
			<td align="left">
				<input type="text" class="text_field" name="aw" inputName="aw" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ax</td>
			<td align="left">
				<input type="text" class="text_field" name="ax" inputName="ax" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ay</td>
			<td align="left">
				<input type="text" class="text_field" name="ay" inputName="ay" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">az</td>
			<td align="left">
				<input type="text" class="text_field" name="az" inputName="az" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ba</td>
			<td align="left">
				<input type="text" class="text_field" name="ba" inputName="ba" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bb</td>
			<td align="left">
				<input type="text" class="text_field" name="bb" inputName="bb" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bc</td>
			<td align="left">
				<input type="text" class="text_field" name="bc" inputName="bc" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bd" inputName="bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">be</td>
			<td align="left">
				<input type="text" class="text_field" name="be" inputName="be" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bf</td>
			<td align="left">
				<input type="text" class="text_field" name="bf" inputName="bf" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bg</td>
			<td align="left">
				<input type="text" class="text_field" name="bg" inputName="bg" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bh</td>
			<td align="left">
				<input type="text" class="text_field" name="bh" inputName="bh" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bi</td>
			<td align="left">
				<input type="text" class="text_field" name="bi" inputName="bi" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bj</td>
			<td align="left">
				<input type="text" class="text_field" name="bj" inputName="bj" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bk</td>
			<td align="left">
				<input type="text" class="text_field" name="bk" inputName="bk" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bl</td>
			<td align="left">
				<input type="text" class="text_field" name="bl" inputName="bl" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bm</td>
			<td align="left">
				<input type="text" class="text_field" name="bm" inputName="bm" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bn</td>
			<td align="left">
				<input type="text" class="text_field" name="bn" inputName="bn" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bo</td>
			<td align="left">
				<input type="text" class="text_field" name="bo" inputName="bo" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bp</td>
			<td align="left">
				<input type="text" class="text_field" name="bp" inputName="bp" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bq</td>
			<td align="left">
				<input type="text" class="text_field" name="bq" inputName="bq" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">br</td>
			<td align="left">
				<input type="text" class="text_field" name="br" inputName="br" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bs</td>
			<td align="left">
				<input type="text" class="text_field" name="bs" inputName="bs" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bt</td>
			<td align="left">
				<input type="text" class="text_field" name="bt" inputName="bt" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bu</td>
			<td align="left">
				<input type="text" class="text_field" name="bu" inputName="bu" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bv</td>
			<td align="left">
				<input type="text" class="text_field" name="bv" inputName="bv" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bw</td>
			<td align="left">
				<input type="text" class="text_field" name="bw" inputName="bw" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bx</td>
			<td align="left">
				<input type="text" class="text_field" name="bx" inputName="bx" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">by1</td>
			<td align="left">
				<input type="text" class="text_field" name="by1" inputName="by1" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bz</td>
			<td align="left">
				<input type="text" class="text_field" name="bz" inputName="bz" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ca</td>
			<td align="left">
				<input type="text" class="text_field" name="ca" inputName="ca" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cb</td>
			<td align="left">
				<input type="text" class="text_field" name="cb" inputName="cb" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cc</td>
			<td align="left">
				<input type="text" class="text_field" name="cc" inputName="cc" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cd</td>
			<td align="left">
				<input type="text" class="text_field" name="cd" inputName="cd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ce</td>
			<td align="left">
				<input type="text" class="text_field" name="ce" inputName="ce" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cf</td>
			<td align="left">
				<input type="text" class="text_field" name="cf" inputName="cf" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cg</td>
			<td align="left">
				<input type="text" class="text_field" name="cg" inputName="cg" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ch</td>
			<td align="left">
				<input type="text" class="text_field" name="ch" inputName="ch" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ci</td>
			<td align="left">
				<input type="text" class="text_field" name="ci" inputName="ci" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cj</td>
			<td align="left">
				<input type="text" class="text_field" name="cj" inputName="cj" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ck</td>
			<td align="left">
				<input type="text" class="text_field" name="ck" inputName="ck" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cl</td>
			<td align="left">
				<input type="text" class="text_field" name="cl" inputName="cl" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cm</td>
			<td align="left">
				<input type="text" class="text_field" name="cm" inputName="cm" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cn</td>
			<td align="left">
				<input type="text" class="text_field" name="cn" inputName="cn" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">co</td>
			<td align="left">
				<input type="text" class="text_field" name="co" inputName="co" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cp</td>
			<td align="left">
				<input type="text" class="text_field" name="cp" inputName="cp" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cq</td>
			<td align="left">
				<input type="text" class="text_field" name="cq" inputName="cq" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cr</td>
			<td align="left">
				<input type="text" class="text_field" name="cr" inputName="cr" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cs</td>
			<td align="left">
				<input type="text" class="text_field" name="cs" inputName="cs" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ct</td>
			<td align="left">
				<input type="text" class="text_field" name="ct" inputName="ct" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cu</td>
			<td align="left">
				<input type="text" class="text_field" name="cu" inputName="cu" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cv</td>
			<td align="left">
				<input type="text" class="text_field" name="cv" inputName="cv" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cw</td>
			<td align="left">
				<input type="text" class="text_field" name="cw" inputName="cw" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cx</td>
			<td align="left">
				<input type="text" class="text_field" name="cx" inputName="cx" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cy</td>
			<td align="left">
				<input type="text" class="text_field" name="cy" inputName="cy" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cz</td>
			<td align="left">
				<input type="text" class="text_field" name="cz" inputName="cz" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">da</td>
			<td align="left">
				<input type="text" class="text_field" name="da" inputName="da" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">db</td>
			<td align="left">
				<input type="text" class="text_field" name="db" inputName="db" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dc</td>
			<td align="left">
				<input type="text" class="text_field" name="dc" inputName="dc" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dd</td>
			<td align="left">
				<input type="text" class="text_field" name="dd" inputName="dd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">de</td>
			<td align="left">
				<input type="text" class="text_field" name="de" inputName="de" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">df</td>
			<td align="left">
				<input type="text" class="text_field" name="df" inputName="df" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dg</td>
			<td align="left">
				<input type="text" class="text_field" name="dg" inputName="dg" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dh</td>
			<td align="left">
				<input type="text" class="text_field" name="dh" inputName="dh" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">di</td>
			<td align="left">
				<input type="text" class="text_field" name="di" inputName="di" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dj</td>
			<td align="left">
				<input type="text" class="text_field" name="dj" inputName="dj" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dk</td>
			<td align="left">
				<input type="text" class="text_field" name="dk" inputName="dk" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dl</td>
			<td align="left">
				<input type="text" class="text_field" name="dl" inputName="dl" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dm</td>
			<td align="left">
				<input type="text" class="text_field" name="dm" inputName="dm" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dn</td>
			<td align="left">
				<input type="text" class="text_field" name="dn" inputName="dn" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">do1</td>
			<td align="left">
				<input type="text" class="text_field" name="do1" inputName="do1" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dp</td>
			<td align="left">
				<input type="text" class="text_field" name="dp" inputName="dp" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dq</td>
			<td align="left">
				<input type="text" class="text_field" name="dq" inputName="dq" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dr</td>
			<td align="left">
				<input type="text" class="text_field" name="dr" inputName="dr" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ds</td>
			<td align="left">
				<input type="text" class="text_field" name="ds" inputName="ds" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dt</td>
			<td align="left">
				<input type="text" class="text_field" name="dt" inputName="dt" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">du</td>
			<td align="left">
				<input type="text" class="text_field" name="du" inputName="du" maxLength="1000"/>
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
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_imp_batch_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_imp_batch_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_imp_batch_id")%>">
           	</a>	
       
			 bill_imp_batch_id</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_failure")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_failure")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_failure")%>">
           	</a>	
       
			 is_failure</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"failure_reason")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"failure_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"failure_reason")%>">
           	</a>	
       
			 failure_reason</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id")%>">
           	</a>	
       
			 emp_id</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_code")%>">
           	</a>	
       
			 emp_code</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id_card_no")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id_card_no")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id_card_no")%>">
           	</a>	
       
			 emp_id_card_no</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_name")%>">
           	</a>	
       
			 emp_name</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 cust_id</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
           	</a>	
       
			 cust_code</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
           	</a>	
       
			 cust_name</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"d")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"d")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"d")%>">
           	</a>	
       
			 d</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e")%>">
           	</a>	
       
			 e</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"f")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"f")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"f")%>">
           	</a>	
       
			 f</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"g")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"g")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"g")%>">
           	</a>	
       
			 g</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"h")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"h")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"h")%>">
           	</a>	
       
			 h</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"i")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"i")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"i")%>">
           	</a>	
       
			 i</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"j")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"j")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"j")%>">
           	</a>	
       
			 j</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"k")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"k")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"k")%>">
           	</a>	
       
			 k</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"l")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"l")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"l")%>">
           	</a>	
       
			 l</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"m")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"m")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"m")%>">
           	</a>	
       
			 m</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"n")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"n")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"n")%>">
           	</a>	
       
			 n</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"o")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"o")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"o")%>">
           	</a>	
       
			 o</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p")%>">
           	</a>	
       
			 p</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"q")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"q")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"q")%>">
           	</a>	
       
			 q</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"r")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"r")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"r")%>">
           	</a>	
       
			 r</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"s")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"s")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"s")%>">
           	</a>	
       
			 s</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"t")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"t")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"t")%>">
           	</a>	
       
			 t</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"u")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"u")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"u")%>">
           	</a>	
       
			 u</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"v")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"v")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"v")%>">
           	</a>	
       
			 v</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"w")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"w")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"w")%>">
           	</a>	
       
			 w</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"x")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"x")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"x")%>">
           	</a>	
       
			 x</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"y")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"y")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"y")%>">
           	</a>	
       
			 y</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"z")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"z")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"z")%>">
           	</a>	
       
			 z</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"aa")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"aa")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"aa")%>">
           	</a>	
       
			 aa</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ab")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ab")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ab")%>">
           	</a>	
       
			 ab</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ac")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ac")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ac")%>">
           	</a>	
       
			 ac</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ad")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ad")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ad")%>">
           	</a>	
       
			 ad</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ae")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ae")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ae")%>">
           	</a>	
       
			 ae</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"af")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"af")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"af")%>">
           	</a>	
       
			 af</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ag")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ag")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ag")%>">
           	</a>	
       
			 ag</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ah")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ah")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ah")%>">
           	</a>	
       
			 ah</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ai")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ai")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ai")%>">
           	</a>	
       
			 ai</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"aj")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"aj")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"aj")%>">
           	</a>	
       
			 aj</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ak")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ak")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ak")%>">
           	</a>	
       
			 ak</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"al")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"al")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"al")%>">
           	</a>	
       
			 al</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"am")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"am")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"am")%>">
           	</a>	
       
			 am</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"an")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"an")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"an")%>">
           	</a>	
       
			 an</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ao")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ao")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ao")%>">
           	</a>	
       
			 ao</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ap")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ap")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ap")%>">
           	</a>	
       
			 ap</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"aq")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"aq")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"aq")%>">
           	</a>	
       
			 aq</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ar")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ar")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ar")%>">
           	</a>	
       
			 ar</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"as1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"as1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"as1")%>">
           	</a>	
       
			 as1</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"at")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"at")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"at")%>">
           	</a>	
       
			 at</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"au")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"au")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"au")%>">
           	</a>	
       
			 au</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"av")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"av")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"av")%>">
           	</a>	
       
			 av</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"aw")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"aw")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"aw")%>">
           	</a>	
       
			 aw</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ax")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ax")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ax")%>">
           	</a>	
       
			 ax</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ay")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ay")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ay")%>">
           	</a>	
       
			 ay</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"az")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"az")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"az")%>">
           	</a>	
       
			 az</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ba")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ba")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ba")%>">
           	</a>	
       
			 ba</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bb")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bb")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bb")%>">
           	</a>	
       
			 bb</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bc")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bc")%>">
           	</a>	
       
			 bc</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bd")%>">
           	</a>	
       
			 bd</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"be")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"be")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"be")%>">
           	</a>	
       
			 be</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bf")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bf")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bf")%>">
           	</a>	
       
			 bf</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bg")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bg")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bg")%>">
           	</a>	
       
			 bg</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bh")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bh")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bh")%>">
           	</a>	
       
			 bh</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bi")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bi")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bi")%>">
           	</a>	
       
			 bi</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bj")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bj")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bj")%>">
           	</a>	
       
			 bj</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bk")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bk")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bk")%>">
           	</a>	
       
			 bk</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bl")%>">
           	</a>	
       
			 bl</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bm")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bm")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bm")%>">
           	</a>	
       
			 bm</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bn")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bn")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bn")%>">
           	</a>	
       
			 bn</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bo")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bo")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bo")%>">
           	</a>	
       
			 bo</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bp")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bp")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bp")%>">
           	</a>	
       
			 bp</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bq")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bq")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bq")%>">
           	</a>	
       
			 bq</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"br")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"br")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"br")%>">
           	</a>	
       
			 br</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bs")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bs")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bs")%>">
           	</a>	
       
			 bs</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bt")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bt")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bt")%>">
           	</a>	
       
			 bt</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bu")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bu")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bu")%>">
           	</a>	
       
			 bu</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bv")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bv")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bv")%>">
           	</a>	
       
			 bv</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bw")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bw")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bw")%>">
           	</a>	
       
			 bw</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bx")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bx")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bx")%>">
           	</a>	
       
			 bx</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"by1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"by1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"by1")%>">
           	</a>	
       
			 by1</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bz")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bz")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bz")%>">
           	</a>	
       
			 bz</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ca")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ca")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ca")%>">
           	</a>	
       
			 ca</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cb")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cb")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cb")%>">
           	</a>	
       
			 cb</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cc")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cc")%>">
           	</a>	
       
			 cc</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cd")%>">
           	</a>	
       
			 cd</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ce")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ce")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ce")%>">
           	</a>	
       
			 ce</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cf")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cf")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cf")%>">
           	</a>	
       
			 cf</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cg")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cg")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cg")%>">
           	</a>	
       
			 cg</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ch")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ch")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ch")%>">
           	</a>	
       
			 ch</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ci")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ci")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ci")%>">
           	</a>	
       
			 ci</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cj")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cj")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cj")%>">
           	</a>	
       
			 cj</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ck")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ck")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ck")%>">
           	</a>	
       
			 ck</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cl")%>">
           	</a>	
       
			 cl</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cm")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cm")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cm")%>">
           	</a>	
       
			 cm</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cn")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cn")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cn")%>">
           	</a>	
       
			 cn</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"co")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"co")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"co")%>">
           	</a>	
       
			 co</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cp")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cp")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cp")%>">
           	</a>	
       
			 cp</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cq")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cq")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cq")%>">
           	</a>	
       
			 cq</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cr")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cr")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cr")%>">
           	</a>	
       
			 cr</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cs")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cs")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cs")%>">
           	</a>	
       
			 cs</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ct")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ct")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ct")%>">
           	</a>	
       
			 ct</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cu")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cu")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cu")%>">
           	</a>	
       
			 cu</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cv")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cv")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cv")%>">
           	</a>	
       
			 cv</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cw")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cw")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cw")%>">
           	</a>	
       
			 cw</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cx")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cx")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cx")%>">
           	</a>	
       
			 cx</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cy")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cy")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cy")%>">
           	</a>	
       
			 cy</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cz")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cz")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cz")%>">
           	</a>	
       
			 cz</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"da")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"da")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"da")%>">
           	</a>	
       
			 da</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"db")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"db")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"db")%>">
           	</a>	
       
			 db</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dc")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dc")%>">
           	</a>	
       
			 dc</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dd")%>">
           	</a>	
       
			 dd</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"de")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"de")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"de")%>">
           	</a>	
       
			 de</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"df")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"df")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"df")%>">
           	</a>	
       
			 df</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dg")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dg")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dg")%>">
           	</a>	
       
			 dg</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dh")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dh")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dh")%>">
           	</a>	
       
			 dh</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"di")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"di")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"di")%>">
           	</a>	
       
			 di</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dj")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dj")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dj")%>">
           	</a>	
       
			 dj</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dk")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dk")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dk")%>">
           	</a>	
       
			 dk</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dl")%>">
           	</a>	
       
			 dl</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dm")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dm")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dm")%>">
           	</a>	
       
			 dm</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dn")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dn")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dn")%>">
           	</a>	
       
			 dn</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"do1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"do1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"do1")%>">
           	</a>	
       
			 do1</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dp")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dp")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dp")%>">
           	</a>	
       
			 dp</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dq")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dq")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dq")%>">
           	</a>	
       
			 dq</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dr")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dr")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dr")%>">
           	</a>	
       
			 dr</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ds")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ds")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ds")%>">
           	</a>	
       
			 ds</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dt")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dt")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dt")%>">
           	</a>	
       
			 dt</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"du")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"du")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"du")%>">
           	</a>	
       
			 du</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/Finbillimpdata2Action.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
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
			
			<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="cust_code"/>   </td>
			
			<td><bean:write name="data" property="cust_name"/>   </td>
			
			<td><bean:write name="data" property="d"/>   </td>
			
			<td><bean:write name="data" property="e"/>   </td>
			
			<td><bean:write name="data" property="f"/>   </td>
			
			<td><bean:write name="data" property="g"/>   </td>
			
			<td><bean:write name="data" property="h"/>   </td>
			
			<td><bean:write name="data" property="i"/>   </td>
			
			<td><bean:write name="data" property="j"/>   </td>
			
			<td><bean:write name="data" property="k"/>   </td>
			
			<td><bean:write name="data" property="l"/>   </td>
			
			<td><bean:write name="data" property="m"/>   </td>
			
			<td><bean:write name="data" property="n"/>   </td>
			
			<td><bean:write name="data" property="o"/>   </td>
			
			<td><bean:write name="data" property="p"/>   </td>
			
			<td><bean:write name="data" property="q"/>   </td>
			
			<td><bean:write name="data" property="r"/>   </td>
			
			<td><bean:write name="data" property="s"/>   </td>
			
			<td><bean:write name="data" property="t"/>   </td>
			
			<td><bean:write name="data" property="u"/>   </td>
			
			<td><bean:write name="data" property="v"/>   </td>
			
			<td><bean:write name="data" property="w"/>   </td>
			
			<td><bean:write name="data" property="x"/>   </td>
			
			<td><bean:write name="data" property="y"/>   </td>
			
			<td><bean:write name="data" property="z"/>   </td>
			
			<td><bean:write name="data" property="aa"/>   </td>
			
			<td><bean:write name="data" property="ab"/>   </td>
			
			<td><bean:write name="data" property="ac"/>   </td>
			
			<td><bean:write name="data" property="ad"/>   </td>
			
			<td><bean:write name="data" property="ae"/>   </td>
			
			<td><bean:write name="data" property="af"/>   </td>
			
			<td><bean:write name="data" property="ag"/>   </td>
			
			<td><bean:write name="data" property="ah"/>   </td>
			
			<td><bean:write name="data" property="ai"/>   </td>
			
			<td><bean:write name="data" property="aj"/>   </td>
			
			<td><bean:write name="data" property="ak"/>   </td>
			
			<td><bean:write name="data" property="al"/>   </td>
			
			<td><bean:write name="data" property="am"/>   </td>
			
			<td><bean:write name="data" property="an"/>   </td>
			
			<td><bean:write name="data" property="ao"/>   </td>
			
			<td><bean:write name="data" property="ap"/>   </td>
			
			<td><bean:write name="data" property="aq"/>   </td>
			
			<td><bean:write name="data" property="ar"/>   </td>
			
			<td><bean:write name="data" property="as1"/>   </td>
			
			<td><bean:write name="data" property="at"/>   </td>
			
			<td><bean:write name="data" property="au"/>   </td>
			
			<td><bean:write name="data" property="av"/>   </td>
			
			<td><bean:write name="data" property="aw"/>   </td>
			
			<td><bean:write name="data" property="ax"/>   </td>
			
			<td><bean:write name="data" property="ay"/>   </td>
			
			<td><bean:write name="data" property="az"/>   </td>
			
			<td><bean:write name="data" property="ba"/>   </td>
			
			<td><bean:write name="data" property="bb"/>   </td>
			
			<td><bean:write name="data" property="bc"/>   </td>
			
			<td><bean:write name="data" property="bd"/>   </td>
			
			<td><bean:write name="data" property="be"/>   </td>
			
			<td><bean:write name="data" property="bf"/>   </td>
			
			<td><bean:write name="data" property="bg"/>   </td>
			
			<td><bean:write name="data" property="bh"/>   </td>
			
			<td><bean:write name="data" property="bi"/>   </td>
			
			<td><bean:write name="data" property="bj"/>   </td>
			
			<td><bean:write name="data" property="bk"/>   </td>
			
			<td><bean:write name="data" property="bl"/>   </td>
			
			<td><bean:write name="data" property="bm"/>   </td>
			
			<td><bean:write name="data" property="bn"/>   </td>
			
			<td><bean:write name="data" property="bo"/>   </td>
			
			<td><bean:write name="data" property="bp"/>   </td>
			
			<td><bean:write name="data" property="bq"/>   </td>
			
			<td><bean:write name="data" property="br"/>   </td>
			
			<td><bean:write name="data" property="bs"/>   </td>
			
			<td><bean:write name="data" property="bt"/>   </td>
			
			<td><bean:write name="data" property="bu"/>   </td>
			
			<td><bean:write name="data" property="bv"/>   </td>
			
			<td><bean:write name="data" property="bw"/>   </td>
			
			<td><bean:write name="data" property="bx"/>   </td>
			
			<td><bean:write name="data" property="by1"/>   </td>
			
			<td><bean:write name="data" property="bz"/>   </td>
			
			<td><bean:write name="data" property="ca"/>   </td>
			
			<td><bean:write name="data" property="cb"/>   </td>
			
			<td><bean:write name="data" property="cc"/>   </td>
			
			<td><bean:write name="data" property="cd"/>   </td>
			
			<td><bean:write name="data" property="ce"/>   </td>
			
			<td><bean:write name="data" property="cf"/>   </td>
			
			<td><bean:write name="data" property="cg"/>   </td>
			
			<td><bean:write name="data" property="ch"/>   </td>
			
			<td><bean:write name="data" property="ci"/>   </td>
			
			<td><bean:write name="data" property="cj"/>   </td>
			
			<td><bean:write name="data" property="ck"/>   </td>
			
			<td><bean:write name="data" property="cl"/>   </td>
			
			<td><bean:write name="data" property="cm"/>   </td>
			
			<td><bean:write name="data" property="cn"/>   </td>
			
			<td><bean:write name="data" property="co"/>   </td>
			
			<td><bean:write name="data" property="cp"/>   </td>
			
			<td><bean:write name="data" property="cq"/>   </td>
			
			<td><bean:write name="data" property="cr"/>   </td>
			
			<td><bean:write name="data" property="cs"/>   </td>
			
			<td><bean:write name="data" property="ct"/>   </td>
			
			<td><bean:write name="data" property="cu"/>   </td>
			
			<td><bean:write name="data" property="cv"/>   </td>
			
			<td><bean:write name="data" property="cw"/>   </td>
			
			<td><bean:write name="data" property="cx"/>   </td>
			
			<td><bean:write name="data" property="cy"/>   </td>
			
			<td><bean:write name="data" property="cz"/>   </td>
			
			<td><bean:write name="data" property="da"/>   </td>
			
			<td><bean:write name="data" property="db"/>   </td>
			
			<td><bean:write name="data" property="dc"/>   </td>
			
			<td><bean:write name="data" property="dd"/>   </td>
			
			<td><bean:write name="data" property="de"/>   </td>
			
			<td><bean:write name="data" property="df"/>   </td>
			
			<td><bean:write name="data" property="dg"/>   </td>
			
			<td><bean:write name="data" property="dh"/>   </td>
			
			<td><bean:write name="data" property="di"/>   </td>
			
			<td><bean:write name="data" property="dj"/>   </td>
			
			<td><bean:write name="data" property="dk"/>   </td>
			
			<td><bean:write name="data" property="dl"/>   </td>
			
			<td><bean:write name="data" property="dm"/>   </td>
			
			<td><bean:write name="data" property="dn"/>   </td>
			
			<td><bean:write name="data" property="do1"/>   </td>
			
			<td><bean:write name="data" property="dp"/>   </td>
			
			<td><bean:write name="data" property="dq"/>   </td>
			
			<td><bean:write name="data" property="dr"/>   </td>
			
			<td><bean:write name="data" property="ds"/>   </td>
			
			<td><bean:write name="data" property="dt"/>   </td>
			
			<td><bean:write name="data" property="du"/>   </td>
			
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
	if(request.getAttribute(IFinbillimpdata2Constants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinbillimpdata2Constants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
