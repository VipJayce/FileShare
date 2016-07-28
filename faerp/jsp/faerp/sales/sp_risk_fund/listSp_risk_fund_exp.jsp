<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="rayoo.sales.sp_risk_fund_exp.vo.Sp_risk_fund_expVo"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    Sp_risk_fund_expVo resultVo = null;  //定义一个临时的vo变量
%>

<%@page import="rayoo.sales.sal_quotation_tpl.util.ISal_quotation_tplConstants"%>
<html>
<fmt:bundle basename="rayoo.salse.sp_risk_fund.sp_risk_fund_resource" prefix="rayoo.salse.sp_risk_fund.">
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
        
        var datacell = $id("datacell_risk_in");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("app_state")!='1'){
            alert('<fmt:message key="cannot_be_modified"/>');
            return;
        }else{
            form.action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?id=" + ids;
	        form.cmd.value = "find";
	        form.submit();
       }
       
        
    }
    function submit_appState_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        
        var datacell = $id("datacell_risk_in");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("app_state")!='1'){
            alert('<fmt:message key="cannot_examine"/>');
            return;
        }else{
            form.action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?id=" + ids;
	        form.cmd.value = "createWF";
	        form.submit();
       }
       
    }
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        for(var i = 0 ; i < ids.length; i++){
             var id = ids[i];
             var entity = datacellDatas[id];
             if(entity.getProperty("app_state")!='1'){
	            alert(entity.getValue("empoyee_name") + ' <fmt:message key="cannot_be_delete"/>');
	            return;
	        }
             var is_use = entity.getValue("is_use");
             if(is_use == "1"){
                 alert(entity.getValue("name") + "<fmt:message key="cited_cannot_be_deleted"/>");
                 return;
             }else {
             }
        }
        
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            
            form.submit();
        }
    }
    function risk_fund_expQuery_onClick(){  //简单的模糊查询
        $id("datacell_risk_in").loadData();
        $id("datacell_risk_in").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/sales/sp_risk_fund/insertSp_risk_fund_exp.jsp";
        form.submit();
    }
    function viewItem(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        jq("#risk_fund_in_content").hide();
        jq("#sp_risk_fund_exp_id").val(ids[0]);
        simpleQuery_item();
        jq("#risk_fund_in_item_content").show();
        
    }
function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
function risk_fund_in_item_content_back(){
    jq("#risk_fund_in_item_content").hide();
    jq("#risk_fund_in_content").show();
    
}
var datacellDatas = {};
function simpleQuery_item(){  //简单的模糊查询
    $id("datacell_item").loadData();
    $id("datacell_item").refresh();
}
//选择客户
/*
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    
    jq("#customer_code").val(arg[1]);        
    return false;
}
*/

jq(function(){
    $id("customer_name").onReturnFunc = function (returnValue){
        var lookup = $id("customer_name");
//        lookup.value = returnValue[0];
        lookup.value = returnValue[2];
        lookup.displayValue = returnValue[2];
        jq("#cust_id").val(returnValue[0]);
        $id("cost_center_id").addParam("cust_id", returnValue[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        var dc1 =   $id("datacell1");
        dc1.loadData();
        dc1.refresh();
        return false;
    }
});
function rtnFuncEmployee(arg){
    var lookup = $id("empoyee_name");
    
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    
    jq("#empoyee_id").val(arg[0]);//emp_id
    /*
    if(arg[2] !=null &&arg[2]!=''){
        $id("emp_code").value = arg[2] ;
    }
    
    $id("emp_id_card").value = arg[3] ;
    */
    return false;
}


</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do" id="datacell_formid">
<input type="hidden" id="sp_risk_fund_exp_id" name="sp_risk_fund_exp_id" value="">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true">

<div id="right">

<!--  支出 start	-->
	<div class="ringht_s" id="risk_fund_in_content">
	 
	 <div class="xz_title" style="padding-top: 10px"><fmt:message key="risk_capital_spending_list"/></div>
	 <!--查询 -->
	  <div class="search" style="">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		    <td width="135" rowspan="2" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div></td>
<!--		    <td width="60">客户编号</td>-->
<!--		    <td width="240"><input type="text" value="" class="sText" id="user"/></td>-->
		    <td width="60"><fmt:message key="customer_name"/></td>
		        <td>
		        
		        <w:lookup readonly="false" id="customer_name" validateAttr="allowNull=false;" name="customer_name"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
                messagekey="choose_customer" height="450" width="610" /> 
                <input id="cust_id" name="cust_id" type="hidden" />
                
		        </td>
		
		    <td><fmt:message key="employee_name"/></td>
		    <td>
		      <w:lookup onReturnFunc="rtnFuncEmployee" readonly="false" id="empoyee_name" name= "empoyee_name"  validateAttr="allowNull=false;"
                value="${bean.empoyee_name }" displayValue="${bean.empoyee_name}"
                lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" messagekey="choose_employee" height="450" width="800"  style="width:170px"/>
                
                <input type="hidden" id="empoyee_id" name="empoyee_id" value="${bean.empoyee_id }">
                
		    </td>
		  </tr>
		  <tr>
<!--		    <td>员工编号</td>-->
<!--		    <td><input type="text" value="" class="sText" id="user"/></td>-->
		    <td><fmt:message key="exp_type"/></td>
		    <td>
		      <d:select name="exp_type" disabled="false" dictTypeId="SP_EXP_TYPE" nullLabel="请选择" style="width:170px"/>
		    </td>
		    <td><fmt:message key="app_state"/></td>
		    <td>
		      <d:select name="app_state" disabled="false" dictTypeId="APPROVE_BD" nullLabel="请选择"  style="width:170px"/>
		    </td>
		    <td width="150" ><div align="center">
		      <input type="button" class="icon_1" value="<fmt:message key="query"/>" onclick="risk_fund_expQuery_onClick();" />
		    </div></td>
		  </tr>
		  </table>
			    
	  </div>
	
	
	 
	
	 <div id="ccParent1" class="button"> 
	   <div class="button_right">
	                <ul>
	                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
	                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
	                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
	                    <li class="bl_1">      <a  onClick="javascript:submit_appState_onClick();"><fmt:message key="sumbit_examine"/> </a> </li>
	                </ul>
	                
	   </div>
	   <div class="clear"></div>            
	</div>
	 
	 
	<!-- <div id="values_div" class="box" > -->
	      <div style="padding: 8 10 8 8;">
	         <r:datacell id="datacell_risk_in" queryAction="/FAERP/Sp_risk_fund_expAction.do?cmd=queryForDatacell" 
	         width="98%" height="290px"
             
	         xpath="Sp_risk_fund_expVo" paramFormId="datacell_formid">
	         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	         <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
	         <r:field fieldName="empoyee_name" messagekey="employee_name" width="100px" ></r:field>
	         <r:field fieldName="empoyee_id" messagekey="employee_code" width="150px" ></r:field>
	         <r:field fieldName="customer_name" messagekey="customer_name" width="250px" ></r:field>
	         <r:field fieldName="customer_code" messagekey="customer_code" width="100px" ></r:field>
	         <r:field fieldName="exp_mony" messagekey="exp_money" width="100px" ></r:field>
	         <r:field fieldName="exp_type" messagekey="exp_type" width="100px" >
	           <d:select disabled="true" dictTypeId="SP_EXP_TYPE" />
	         </r:field>
	         <r:field fieldName="app_state" messagekey="app_state" width="100px" >
	           
	           <d:select disabled="true" dictTypeId="APPROVE_BD" />
	           
	         </r:field>
	         
	         </r:datacell>
	       </div>
	<!--</div>-->
	 
	 
	
	</div>
	
	<!--  支出  end  -->
	
	
	
</div>
</form>
</fmt:bundle>
</body>
</html>

