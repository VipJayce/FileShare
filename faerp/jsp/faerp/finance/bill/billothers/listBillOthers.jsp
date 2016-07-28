<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/jsp/faerp/finance/common-d.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>

<head>
	<script type='text/javascript'
		src='<%=request.getContextPath()%>/dwr/interface/FinbillAJAXAction.js'></script>
	<script type='text/javascript'
		src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript'
		src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>一次性收费</title>
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
		form.action="<%=request.getContextPath()%>/BillOthersAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/BillOthersAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "multQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/bill/billothers/insertBillOthers.jsp";
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
		form.action="<%=request.getContextPath()%>/BillOthersAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
		
    //*******************以下为对一次性收费div的操作js********************
    //
    function showNewdiv(){
        selectAllRows();
        var ids = findSelections("checkbox_template","id");  //取得复选框的选择项
        if(ids == null) {  //如果ids为空
             return;
        }
        var obj=document.getElementById("xlTab");
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            var xlid=ids[i];
            var j=document.getElementById(xlid).rowIndex;
            obj.deleteRow(j);
        }
    }
    

</script>
	</head>
	<body>

<div id="right"  style="height:900">
<script language="javascript">
    writeTableTopFesco('一次性收费','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">
    
    <div id="ccChild0" class="search">
	<form name="form" method="post"
		action="<%=request.getContextPath()%>/BillOthersAction.do">
		<input		type="hidden" name="cmd" value="queryAll">

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right">客户名称</td>
			<td align="left"><input type="text"
				class="text_field_reference_readonly" validators="isSearch"
				hiddenInputId="cost_center_name" id="cost_center_name"
				name="cost_center_name" inputName="客户名称" maxLength="10"
				value="${reqeustScope.cost_center_name }" /> <input type="hidden"
				name="cust_id" id="cust_id" value="${reqeustScope.cust_id }" /> <img
				class="refButtonClass" src="<venus:base/>/images/au/09.gif"
				onClick="javascript:getcustomerList();" /></td>
			<td align="right">成本中心</td>
			<td align="left"><select name="cost_center_id"
				id="cost_center_id">
				<option value="">--请选择--</option>
			</select> <input type="hidden" id="hid_cost_center_id"
				value="${requestScope. cost_center_id}"></td>
			<td align="right"></td>
            <td align="right">应收年月</td>
            <td align="left"><input type="text" class="text_field"
                name="bill_year_month" inputName="应收年月" maxLength="64" /></td>			
                            <td colspan="5" align="center"><input name="button_ok"
                class="icon_1" type="button" value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery_onClick()"></td>
		</tr>
	</table>
	</div>
	<div id="values_div" class="box">
	<table width="100%" cellspacing="0" class="datagrid1">
		<tr>
			<th class="fex_row"><input type='radio'
				onclick="checkAllList_onClick(this);" pdType='control'
				control='checkbox_template'  /></th>
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
			</a> 客户成本中心</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_year_month")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_year_month")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_year_month")%>">
			</a> 应收年月</th>
            <th><a
                href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"version")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"version")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_type_bd")%>">
            </a> 版本号</th>
            <th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_amount")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_amount")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_amount")%>">
			</a> 应收金额</th>
            <th><a
                href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_type_bd")%>">
            <img
                src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_type_bd")%>"
                border="0"
                title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_type_bd")%>">
            </a> 应收类型</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_date")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_date")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_date")%>">
			</a> 生成时间</th>
			<th><a
				href="/FAERP/FinbillAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"create_user_id")%>">
			<img
				src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"create_user_id")%>"
				border="0"
				title="<%=royoo.common.TagSortUitl.getSortTitle(request,"create_user_id")%>">
			</a> 生成人</th>
		</tr>
		<logic:iterate name="billBeans" id="data" scope="request" indexId="indexs">
			<tr>
				<td class="fex_row"><input type="radio"
					name="checkbox_template"
					value="<bean:write name="data" property="id"/>"
					displayName="<bean:write name="data" property="id"/>"  onclick="showSmalldiv('<bean:write name="data" property="id"/>');" /> <input
					type="hidden" name="id" value="${data.id }"></td>
				<td>
				<center>&nbsp;<bean:write name="data" property="cust_code" /></center>
				</td>
				<td>
				<center>&nbsp;<bean:write name="data" property="cust_name" /></center>
				</td>

				<td>
				<center>&nbsp;<bean:write name="data"
					property="cost_center_name" /></center>
				</td>

				<td>
				<center>&nbsp;<bean:write name="data"
					property="bill_year_month" /></center>
				</td>

				<td>
				<center>&nbsp;<bean:define id="bill_type_bd" name="data"
					property="bill_type_bd" /> <%=BaseDataHelper.getNameByCode("FB_BILL_TYPE_BD",String.valueOf(bill_type_bd))%></center>
				</td>

				<td>
				<center>&nbsp;<bean:write name="data"
					property="bill_amount" /> </center>
				</td>
				<td>
				<center>&nbsp;<bean:write name="data"
					property="verification_amount" /> </center>
				</td>
				<td>
				<center>&nbsp;<bean:write name="data"
					property="balance_amount" /></center>
				</td>

				<td>
				<center>&nbsp;<bean:define id="bill_invoice_status_bd"
					name="data" property="bill_invoice_status_bd" /> <%=BaseDataHelper.getNameByCode("INVOICE_STATUS_BD",String.valueOf(bill_invoice_status_bd))%></center>
				</td>
			</tr>
		</logic:iterate>
	</table>
	</div>
	
	<jsp:include page="/jsp/include/page.jsp" />

</form>

	<!-- 一次性收费列表 -->
<div style="width:100%; float:left;">

 <!--一次性收费表格 -->
    <form id="datacell_param"><input id="bill_id" name="bill_id" type="hidden"  value="" /></form>
    <script>
        function checkAll(){
           alert(document.getElementById("dd").checked);
           document.getElementById("dd").checked = true;
           return false;
        }
        function createButton(value,entity,rowNo,cellNo){
            return "<input type='checkbox' id='dd' />";
        }


    </script>
        <r:datacell id="bilotherlist"
            queryAction="/FAERP/BillOthersAction.do?cmd=searchXltype"
             submitAction="/FAERP/BillOthersAction.do?cmd=insert4dc"
            xpath="BillOthersVo"
            submitXpath="BillOthersVo" 
            width="100%"
            height="300"
            paramFormId="datacell_param"
        >
        <r:toolbar tools="edit:add del save reload nav:"/>
            <r:field fieldName="charge_item_bd" sortAt="none" label="<input type='radio' name='checkall' value='' onclick='javascript:checkAll();return true;' />"  
            onRefreshFunc="createButton"
             >
             
             </r:field>
            <r:field fieldName="charge_item_bd" label="项目名称" sortAt="server"  >
             <d:select dictTypeId="PAYMENT_MONTH"></d:select>
             </r:field>
            <r:field fieldName="amount" label="金额"  >
             <h:text validateAttr="type=number;message=年度调整月输入有误;allowNull=false"/> 
            </r:field>
            <r:field fieldName="charge_desc" label="备注">
             <h:text  validateAttr="allowNull=false"/>            
            </r:field>
            <r:field fieldName="last_update_date" label="修改日期" >
             <h:text  />            
            </r:field>

        </r:datacell>
    </div>
</div>
</div>
<!-- 一次性收费列表 end -->
</fmt:bundle>

</body>
</html>

<script language="javascript">

  function getcustomerList(){
        var ids = window.showModalDialog('<venus:base/>/CustomerAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_id.value=ids[0];
        document.form.cost_center_name.value=ids[1];
        customerSelected(document.form.cust_id.value);
}   

    //显示当前账单下的一次性收费
    function showSmalldiv(div_id){
        //alert(div_id);
        //设置账单查询条件
        $id("bill_id").value = div_id;
        $id("bilotherlist").loadData();
        $id("bilotherlist").refresh();
    }

function  customerSelected (cust_id, selectValue) {
      FinbillAJAXAction.getCostCenterByCustomerID(cust_id, {callback:function(data){
                    setSelectForBean("cost_center_id",data,"id","cost_center_name", $j("#hid_cost_center_id").val() );
                }
            });
    }

    
</script>
