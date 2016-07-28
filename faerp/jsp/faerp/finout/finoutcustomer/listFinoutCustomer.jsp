<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>财务外包客户维护</title>
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
        var url = "<%=request.getContextPath()%>/CustomerAction.do?cmd=find&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=客户修改');
    }  
    function deleteMulti_onClick(){  //删除用户
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
           if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/Finout_customerAction.do?cmd=checkDelCutomer&ids=" + ids,
            dataType : "html",
            success : function(data) {
                   if(data=="true"){
                        alert("用户删除成功！");
                        simpleQuery_onClick();
                        }else{
                        alert("该用户下有有效的合同，不能删除！");
                        return;
                        }
                        }  });
    }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/jsp/faerp/finout/finoutcustomer/insertFinoutCustomer.jsp";
        window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=客户新增');
    }
    
    function callBack(reg){
        alert("操作完成！");
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function insertcallBack(reg){
        if(reg=="0"){
            alert("新增成功！");
        }else{
            alert("新增失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
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
        var url = "<%=request.getContextPath()%>/CustomerAction.do?cmd=detail&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=430px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看客户信息');
    }

    function exportExcel_onClick(){  //导出Excel
        form.action="<%=request.getContextPath()%>/Finout_customerAction.do?cmd=exportExcel_Finout";
        form.submit();
    }  
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    /*
     * 撤户
     *	
     */
    function cust_del_onClick(){
    	 var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    	 if(ids.length > 1) {  
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
    	jQuery.ajax({
	        type : "post",
	        url : "<%=request.getContextPath()%>/CustomerAction.do?cmd=checkDelCutomer&ids=" + ids,
	        dataType : "html",
	        success : function(data) {
	               if(!data){
	               		alert("撤户成功！");
	               		$id("datacell1").reload();
        				$id("datacell1").refresh();
	               }else{
	               		var alertMsg = "该客户 :\n";
	               		var strArray = data.split(",");
	               		for (var i=0;i<strArray.length;i++){
	               			if(strArray[i] == '1'){
	               				alertMsg += "        最近3月有员工在职，或者有员工入职和离职 \n";
	               			}else if(strArray[i] == '2'){
	               				alertMsg += "        最近3月有生成账单  \n";
	               			}else if(strArray[i] == '3'){
	               				alertMsg += "        有人在缴社保公积金\n";
	               			}else if(strArray[i] == '4'){
	               				alertMsg += "        有在用员工 \n";
	               			}else if(strArray[i] == '5'){
	               				alertMsg += "        有在保员工 \n";
	               			}
	               		}
	               		alertMsg += "        ------不能撤户！"
	               		alert(alertMsg);
	               }
	          }
	       	});
    }
    
    //查询可撤账户
    function check_del_onClick(){
    	exportReport();
    }
    
    
    function exportReport(){
          	form.action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showDelCustomerPrintReport.jsp?raq=customer_del.raq&company_id="+document.getElementById('company_id').value;
            form.submit();
       
    }
</script>


	</head>
	<body>

	<form name="form" method="post" id="datacell_formid"
		action="<%=request.getContextPath()%>/CustomerAction.do"><input
		type="hidden" name="cmd" value="queryAll" /> <input type="hidden"
		name="backFlag" id="backFlag" value="true"> <input
		type="hidden" name="company_id" id="company_id"
		value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
	<div id="right"><script language="javascript">
	writeTableTopFesco('客户维护','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">


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
			<td align="left">客户编号</td>
			<td align="left"><input type="text" class="text_field"
				id="customer_code" name="customer_code" value="" inputName="客户编号"
				maxLength="25" /></td>
			<td align="left">客户名称</td>
			<td align="left"><input type="text" class="text_field"
				id="customer_name" name="customer_name" value="" inputName="客户名称"
				maxLength="25" /></td>
			<td align="left"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="left">客户类别</td>
			<td align="left"><%=gap.rm.tools.helper.RmJspHelper
                            .getSelectField("customer_type", -1,
                                    "CUSTOMER_TYPE", "", "", false)%>
			</td>
			<td align="left">行业类别</td>
			<td align="left"><r:comboSelect id="trade_type"
				name="trade_type1"
				queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
				textField="name" valueField="id" xpath="CustomerSelectVo"
				width="200px" nullText="请选择" /></td>
			<td align="left"><input name="button_ok" class="icon_1"
				type="button" value='<fmt:message key="query"/>'
				onClick="javascript:simpleQuery_onClick()"> <input
				type="reset" class="icon_1" /></td>
			<td align="left"></td>
		</tr>
	</table>
	</div>





	<div id="ccParent1" class="button">
	<div class="button_right"><input class="a" type="button" value="<fmt:message key="view"/>" <au:authorityBtn code="cwwb_cust_view" type="1"/> onClick="detail_onClick();"> 
	<input class="c" type="button" value="<fmt:message key="insert"/>" <au:authorityBtn code="cwwb_cust_add" type="1"/> onClick="toAdd_onClick();"><!-- <au:authorityBtn code="cust_add" type="1"/> -->
	<input class="b" type="button" value="<fmt:message key="modify"/>" <au:authorityBtn code="cwwb_cust_modify" type="1"/> onClick="findCheckbox_onClick();"> 
	<input class="e" type="button" value="<fmt:message key="export"/>" <au:authorityBtn code="cwwb_cust_exp" type="1"/> onClick="exportExcel_onClick();"> 
	<input class="d" type="button" value="<fmt:message key="remove_user"/>" <au:authorityBtn code="cwwb_cust_del" type="1" /> onClick="deleteMulti_onClick();"> 
	<!--    <input class="approdetial" type="button" value="休眠客户查询" onClick="check_del_onClick();">-->
	</div>
	<div class="clear"></div>
	</div>

	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/Finout_customerAction.do?cmd=queryCustomerData"
		width="98%" height="318px" xpath="CustomerVo"
		paramFormId="datacell_formid">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="id" label="操作" width="50px"
			onRefreshFunc="setCheckboxStatus" align="center"></r:field>
		<r:field fieldName="customer_name" label="客户名称" width="250px"></r:field>
		<r:field fieldName="customer_code" label="客户编号" width="110px"></r:field>
		<r:field fieldName="customer_property" label="客户性质"
			allowModify="false" width="110px">
			<d:select dictTypeId="CUSTOMER_PROPERTY"></d:select>
		</r:field>
		<r:field fieldName="country_area" label="国家地区" allowModify="false"
			width="110px">
			<r:comboSelect id="country_area" name="country_area"
				queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData"
				textField="name" valueField="id" xpath="CustomerSelectVo"
				nullText="" />
		</r:field>
		<r:field fieldName="customer_type" label="客户类别" allowModify="false"
			width="110px">
			<d:select dictTypeId="CUSTOMER_TYPE"></d:select>
		</r:field>
		<r:field fieldName="add_trade_type" label="行业类别" allowModify="false"
			width="110px">
		</r:field>
		<r:field fieldName="create_user_name" label="录入人" width="110px"></r:field>
		<r:field fieldName="create_date" label="录入时间" allowModify="false"
			width="110px">
			<w:date format="YYYY-MM-DD" />
		</r:field>
	</r:datacell></div>

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
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
