<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page
	import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IFinpaymentConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IFinpaymentConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    FinpaymentVo resultVo = null; //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.salse.finpayment.finpayment_resource" prefix="rayoo.salse.finpayment.">
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
	//跳转支付明细页面
	function findCheckbox_Itme() {  //从多选框到支付明细页面
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
<script type="text/javascript">
function rtnFunc(arg){
    var lookup = $id("cust_id");
    alert(arg) ;
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    return false;
}
</script> 
	</head>
	<body>

	<form name="form" id="form" method="post"
		action="<%=request.getContextPath()%>/FinpaymentAction.do"><input
		type="hidden" name="cmd" value="queryAll">
	<div id="right"><script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">
	<form name="form" action="" method="post">
	<div id="right">
	<div class="ringht_s"><!--查询 -->
	<div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="135" rowspan="2" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_conditions"/></div>
			</td>
			<td width="100"><fmt:message key="money_customer"/></td>
			<td width="240">
			<div><w:lookup onReturnFunc="rtnFunc" readonly="true"
                id="cust_id"
                lookupUrl="/CustomersimpleAction.do?cmd=queryAllGetByID"
                messagekey="choose_customer" height="500" width="810" /></div>
			</td>
			<td width="100"><fmt:message key="money_emp"/></td>
			<td width="240"><select name="emp_id" inputName="emp_id" class="sSelect"
				id="emp_id">
				<option value=""><fmt:message key="please_choose"/></option>
				<option value="ro"><fmt:message key="bjysdxshfgs"/></option>
				<option value="fr"><fmt:message key="sxtzyxgs"/></option>
			</select></td>
			<td width="60"><fmt:message key="money_customer_name"/></td>
			<td width="200"><input type="text" value="" class="sText"
				name="receiver_name" inputName="受款方名称" id="receiver_name"/></td>
		</tr>
		<tr>
			<td><fmt:message key="payment_type"/></td>
			<td><input type="text" value="" class="sText" id="user3" /></td>
			<td><fmt:message key="money_type"/></td>
			<td><input type="text" value="" class="sText" name="receiver_type_bd" inputName="受款方类型" id="receiver_type_bd" /></td>
			<td width="60">&nbsp;</td>
			<td width="200">
			<div align="center"><input type="button" class="icon_1"
				value="<fmt:message key="query"/>" onClick="javascript:simpleQuery_onClick()"/></div>
			</td>
		</tr>
	</table>
	</div>
	<!--查询 end--> <!--按钮--><!--按钮 end--> <!--表格 -->
	<div class="button"><!--
            <div class="button_left">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="24"><a href="###"><img src="../images/button_1.gif"/></a></td>
                    <td width="20"><a href="###"><img src="../images/button_2.gif"/></a></td>
                    <td width="19"><a href="###"><img src="../images/button_3.gif"/></a></td>
                    <td width="22"><a href="###"><img src="../images/button_4.gif"/></a></td>
                  </tr>
                </table>

            </div>
            -->
	<div class="button_right">
	<ul>
		<li class="h_1"><a href="javascript:findCheckbox_Itme()" ><fmt:message key="payment_examine"/></a></li>
	</ul>
	</div>
	<div class="clear"></div>
	</div>
	<div class="box" id="values_div">
	<table width="100%" cellspacing="0" class="datagrid1">
		<tr>
			<th class="fex_row"><input type='checkbox'
                onclick="checkAllList_onClick(this);" pdType='control'
                control='checkbox_template' /></th>
			<th width="13%" class="fixedHeaderTr"><fmt:message key="payment_type"/></th>
			<th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"receiver_type_bd")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"receiver_type_bd")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"receiver_type_bd")%>">
            </a><fmt:message key="money_type"/></th>
            
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"receiver_name")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"receiver_name")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"receiver_name")%>">
            </a><fmt:message key="money_customer_name"/></th>
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_amount")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_amount")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_amount")%>">
            </a><fmt:message key="payment_money"/></th>
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_date")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_date")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_date")%>">
            </a><fmt:message key="shengqing_date"/></th>
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"process_ins_id")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"process_ins_id")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"process_ins_id")%>">
            </a><fmt:message key="licheng_jindu"/></th>
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_date")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_date")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_date")%>">
            </a><fmt:message key="create_date"/></th>
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_user_id")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_user_id")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_user_id")%>">
            </a><fmt:message key="create_person"/></th>
            <th><a
                href="/FAERP/FinpaymentAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payment_reason")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payment_reason")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payment_reason")%>">
            </a><fmt:message key="payment_zuoyong"/></th>
		</tr>
		<logic:iterate name="beans" id="data" scope="request" indexId="indexs">
            <tr>
                <td class="fex_row"><input type="checkbox"
                    name="checkbox_template"
                    value="<bean:write name="data" property="id"/>"
                    displayName="<bean:write name="data" property="id"/>" /></td>
                <td><fmt:message key="buyibao"/></td>
                <td><bean:write name="data" property="receiver_type_bd" /> </td>
                <td><bean:write name="data" property="receiver_name" /> </td>
                <td><bean:write name="data" property="apply_amount" /> </td>
                <td><bean:write name="data" property="apply_date" /> </td>
                <td><bean:write name="data" property="process_ins_id" /> </td>
                <td><bean:write name="data" property="create_date" /> </td>
                <td><bean:write name="data" property="apply_user_id" /> </td>
                <td><bean:write name="data" property="payment_reason" /> </td>
            </tr>
        </logic:iterate>
	</table>
	</div>
	<!--表格 end--> <!--翻页 --><!--翻页 end--></div>
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
