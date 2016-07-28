<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.finance.receivable.finbill.vo.FinbillVo"%>
<%@ page
	import="rayoo.finance.receivable.finbill.util.IFinbillConstants"%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IFinbillConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IFinbillConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    FinbillVo resultVo = null; //定义一个临时的vo变量
%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/FinbillAJAXAction.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>

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
		form.action="<%=request.getContextPath()%>/FinbillAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/FinbillAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
	    if(form.cust_name.value == "") {
	       form.cust_id.value="";
	    }
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finbill/insertFinbill.jsp";
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
		form.action="<%=request.getContextPath()%>/FinbillAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
	</head>
	<body>

	<form name="form" method="post" action="<%=request.getContextPath()%>/FinbillAction.do">
		<input type="hidden" name="cmd" value="queryAll" id="cmd">
	<div id="right"><script language="javascript">
	writeTableTopFesco('查询应收列表页面','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<style type="text/css">
.xz_title {
	border-bottom: 1px solid #CCCCCC;
	font-weight: bold;
	margin-bottom: 10px;
	padding: 0 0 2px 10px;
}

.search .td_1 {
	background: none repeat scroll 0 0 #F1F7F9;
	text-align: right;
	width: 15%;
}

.search td {
	height: 30px;
	padding: 0 10px;
}
</style>
	<div class="ringht_s">
	<hr style="color: #cccccc; margin: 10px 10px 10px 10px;">
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title">查询条件</div>
			</td>
			<td />
			<td />
			<td></td>
			<td />
		</tr>
		<tr>
			<td align="right">客户名称</td>
			<td align="left"><input type="text" class="text_field_reference_readonly" validators="isSearch" hiddenInputId="cust_name" id="cust_name" name="cust_name" inputName="客户名称"
				maxLength="10" value="${reqeustScope.cust_name }" /> 
				<input type="hidden" name="cust_id" id="cust_id" value="${reqeustScope.cust_id }" />
				<img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getcustomerList();" /></td>
			<td align="right">成本中心</td>
			<td align="left">
			     <select name="cost_center_id" id="cost_center_id"> <option value="">--请选择--</option></select>
			      <input type="hidden" id="hid_cost_center_id" value="${requestScope. cost_center_id}">
			</td>
			<td align="right"></td>
		</tr>

		<tr>
			<td align="right">应收年月</td>
			<td align="left"><input type="text" class="text_field" name="bill_year_month" inputName="应收年月" maxLength="64" /></td>
			<td align="right">实收状态 </td>
			<td align="left">
			     <%=gap.rm.tools.helper.RmJspHelper.getSelectField( "bill_gather_status_bd", -1,"GATHER_STATUS_BD", request.getAttribute("bill_gather_status_bd") == null ? "" : String.valueOf(request.getAttribute("bill_gather_status_bd")), "inputName='实收状态'", false)%>
			</td>
			<td align="right"></td>
		</tr>

		<tr>
			<td align="right">欠款金额(大于)</td><!-- TODO 这里的欠款金额需改成 outstanding_amount -->
			<td align="left"><input type="text" class="text_field"
				name="_from" inputName="欠款金额大于"
				value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right">开票状态</td>
			<td align="left">
			<%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_invoice_status_bd", -1,"INVOICE_STATUS_BD", request.getAttribute("bill_invoice_status_bd") == null ? "" : String.valueOf(request.getAttribute("bill_invoice_status_bd")), "inputName='开票状态'", false)%>
			</td>
			<td align="right"></td>
		</tr>

		<tr>
			<td align="right">欠款金额(小于)</td>
			<td align="left"><input type="text" class="text_field"
				name="_to" inputName="欠款金额小于" value="" columnSize=""
				decimalDigits="2" /></td>
			<td align="right">客服代表</td>
			<td align="left"><select>
				<option>待定</option>
			</select></td>
			<td align="right"></td>
		</tr>

		<tr>
			<td align="right">应收类型</td>
			<td align="left">
			     <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_type_bd", -1,"FB_BILL_TYPE_BD",  request.getAttribute("bill_type_bd") == null ? "" : String.valueOf(request.getAttribute("bill_type_bd")),"inputName='应收类型'", false)%>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>

		<tr>
			<td colspan="5" align="center"><input name="button_ok"
				class="icon_1" type="button" value='<fmt:message key="query"/>'
				onClick="javascript:simpleQuery_onClick()"></td>
		</tr>
	</table>
	</div>





	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="e_3">
		<a href="###" id="a_exp">导出excel</a>
		</li>
		<li class="a_1">
		<a href="###" id="a_detail">应收明细</a>
		</li>
	</ul>

	</div>
	<div class="clear"></div>
	</div>


<!-- 显示table的DIV -->
<div id="values_div" class="box" style="height: 380px;">
	<table width="100%" cellspacing="0" class="datagrid1">
		<tr>
			<th><input type='checkbox'
				onclick="checkAllList_onClick(this);" pdType='control'
				control='checkbox_template' /></th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
			</a> 客户编号</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
			</a> 客户名称</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_name")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_name")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_name")%>">
			</a> 成本中心</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_year_month")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_year_month")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_year_month")%>">
			</a> 应收年月</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_amount")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_amount")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_amount")%>">
			</a> 应收金额</th>
			<th><a
                href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"verification_amount")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"verification_amount")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"verification_amount")%>">
            </a> 实收金额</th>
            <th><a
                href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"rate_odds")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"rate_odds")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"rate_odds")%>">
            </a> 调整金额</th>
            <th><a
                href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"outstanding_amount")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"outstanding_amount")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"outstanding_amount")%>">
            </a> 欠款金额</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_gather_status_bd")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_gather_status_bd")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_gather_status_bd")%>">
			</a> 实收状态</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_invoice_status_bd")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_invoice_status_bd")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_invoice_status_bd")%>">
			</a> 开票状态</th>
			<th><a
                href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_type_bd")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_type_bd")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_type_bd")%>">
            </a> 应收类型</th>
             <th><a
                href="">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"todo")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"todo")%>">
            </a> 客服</th>
		</tr>
		<logic:iterate name="beans" id="data" scope="request" indexId="indexs">
			<tr>
				<td style="height: 33px;"><input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>"
					displayName="<bean:write name="data" property="id"/>" />
					<input type="hidden" name="id" value="${data.id }">
				</td>
				<!-- 客户编号 -->
				<td><center>&nbsp;<bean:write name="data" property="cust_code" /></center></td>
			     <!-- 客户名称 -->
				<td><center>&nbsp;<bean:write name="data" property="cust_name" /></center></td>
				 <!-- 成本中心 -->
				<td><center>&nbsp;<bean:write name="data" property="cost_center_name" /></center></td>
                <!-- 应收年月 -->
				<td><center>&nbsp;<bean:write name="data" property="bill_year_month" /></center></td>
				<!-- 应收金额 -->
				<td align="right">
				    &nbsp;<fmt:formatNumber value="${data.bill_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/>
				</td>
				<!-- 实收金额 -->
                <td  align="right">
                    &nbsp;<fmt:formatNumber value="${data.verification_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/>
                </td>
				<!-- 调整金额 -->
				<td align="right">&nbsp;<fmt:formatNumber value="${data.rate_odds}" pattern="###,###,###,###.##"  minFractionDigits="2"/></td>
                <!-- 欠款/余额 -->
				<td  align="right">
				    &nbsp;<fmt:formatNumber value="${data.outstanding_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/>
				</td>
				 <!-- 实收状态 -->
                <td><center>&nbsp; <bean:define id="bill_gather_status_bd" name="data" property="bill_gather_status_bd"/>
                    <%=BaseDataHelper.getNameByCode("GATHER_STATUS_BD",String.valueOf(bill_gather_status_bd))%></center>
                </td>
                <!-- 开票状态 -->
				<td><center>&nbsp;<bean:define id="bill_invoice_status_bd" name="data" property="bill_invoice_status_bd"/>
                    <%=BaseDataHelper.getNameByCode("INVOICE_STATUS_BD",String.valueOf(bill_invoice_status_bd))%></center>
				</td>
				<!-- 账单类型/应收类型 -->
                <td><center>&nbsp;<bean:define id="bill_type_bd" name="data" property="bill_type_bd"/>
                    <%=BaseDataHelper.getNameByCode("FB_BILL_TYPE_BD",String.valueOf(bill_type_bd))%></center>
                </td>
                <td>&nbsp;(客服TODO)</td>
			</tr>
		</logic:iterate>
	</table>
	</div>
	<!-- 显示table的DIV结束 -->
	<jsp:include page="/jsp/include/page.jsp" />
	
	   <div style="width:47%; float:left; margin-left:15px; font-weight:bold; margin-top:10px;">到款及核销表</div>
    <div style="width:48%; float:left; margin-left:25px; font-weight:bold; margin-top:10px;">开票信息表</div>
    <div style="float:left; width:47%;" id="values_div2" class="box">
         <table width="100%" cellspacing="0" class="datagrid1">
          <tr>
             <th width="6%">到款编号</th>
             <th width="5%">到款金额</th>
             <th width="8%"> 到款时间</th>
             <th width="7%"> 核销金额</th>
             <th width="7%"> 核销时间</th>
             <th width="7%">核销人</th>
           </tr>
         </table>
      </div>
    <div style="float:right; width:48%;" id="values_div4" class="box">
             <table width="100%" cellspacing="0" class="datagrid1">
               <tr>
                 <th width="6%">开票状态</th>
                 <th width="5%">开票时间</th>
                 <th width="8%">审批状态</th>
                 <th width="7%"> 审批人</th>
                 <th width="7%"> 审批时间</th>
                 <th width="7%"> 审批意见</th>
               </tr>
             </table>
         </div>
    </div>
	
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
	if(request.getAttribute(IFinbillConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IFinbillConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>

  function getcustomerList(){
       var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;'); 
        if(data==undefined) return;
        document.form.cust_id.value = data[0];
        document.form.cust_name.value=data[2];
        customerSelected(document.form.cust_id.value);
}   


function  customerSelected (cust_id, selectValue) {
      FinbillAJAXAction.getCostCenterByCustomerID(cust_id, {callback:function(data){
                    setSelectForBean("cost_center_id",data,"id","cost_center_name", $("#hid_cost_center_id").val() );
                }
            });
    }

$(document).ready(function(){
    if ($("#cust_id").val() != "" && $("#cust_name").val() != "") {
        customerSelected(document.form.cust_id.value);
    }
    
    $("#a_detail").bind("click", function(){
        alert('此处调用他人页面。');
    });
    
    
    $("#a_exp").bind("click", function(){
        $("#cmd").val("exportToExcel");
        $("form").submit();
        $("#cmd").val("queryAll");
    });
    
    
}); 

</script>
