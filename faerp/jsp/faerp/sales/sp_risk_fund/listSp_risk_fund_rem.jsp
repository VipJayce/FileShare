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
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ISp_risk_fund_remConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ISp_risk_fund_remConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    Sp_risk_fund_remVo resultVo = null;  //定义一个临时的vo变量
%>

<%@page import="rayoo.sales.sp_risk_fund_rem.vo.Sp_risk_fund_remVo"%>
<%@page import="rayoo.sales.sp_risk_fund_rem.util.ISp_risk_fund_remConstants"%>
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
        form.action="<%=request.getContextPath()%>/Sp_risk_fund_remAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function risk_fund_inQuery_onClick(){  //简单的模糊查询
        $id("datacell_risk_in").loadData();
        $id("datacell_risk_in").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/sales/sal_quotation_tpl/insertSal_quotation_tpl.jsp";
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
        jq("#risk_fund_rem_content").hide();
        jq("#sp_risk_fund_rem_id").val(ids[0]);
        
        jq("#classify").val("2");
        jq("#customer_id").val(datacellDatas[ids[0]].getProperty("customer_id"));
        
        simpleQuery_item();
        jq("#risk_fund_rem_item_content").show();
        
    }
function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
function risk_fund_rem_item_content_back(){
    jq("#classify").val("1");
    jq("#risk_fund_rem_item_content").hide();
    jq("#risk_fund_rem_content").show();
    
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

    $id("datacell_item").isQueryFirst = false;//
    $id("cost_center_id").isQueryFirst = false;//

    $id("customer_name").onReturnFunc = function (returnValue){
	    var lookup = $id("customer_name");
	    //lookup.value = returnValue[0];//ID
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

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/Sp_risk_fund_remAction.do" id="datacell_formid">
<input type="hidden" id="sp_risk_fund_rem_id" name="sp_risk_fund_rem_id" value="">
<input type="hidden" id="classify" name="classify" value="1">
<input type="hidden" id="customer_id" name="customer_id" value="">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">

<!--  收入 大项 start	-->
	<div class="ringht_s" id="risk_fund_rem_content">
	 
	 <div class="xz_title" style="padding-top: 10px"><fmt:message key="risk_income_money_list"/></div>
	 <!--查询 -->
	  <div class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
		    <td align="right" width="60px" >&nbsp;<fmt:message key="choose_customer"/></td>
	        <td align="left"  width="180px" >
	        <w:lookup readonly="false" id="customer_name" validateAttr="allowNull=false;" name="customer_name"
	            lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
	            messagekey="choose_customer" height="450" width="610" /> 
	            <input id="cust_id" name="cust_id" type="hidden" />
	            </td>
	        <td align="right"><fmt:message key="cost_center_customer"/></td>
	        <td align="left"  width="80px" >
	           <r:comboSelect id="cost_center_id"  
	            name="cost_center_id"  
	            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
	            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
	            width="180" messagekey="please_choose">
	        </r:comboSelect></td>
            <td align="right"><fmt:message key="bill_month"/></td>
            <td width="200px">
                
                <h:text id="bill_month" name="bill_month"  style="width:60px"
                validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/> 
               <fmt:message key="format"/></span>
                
                </td>
	        <td align="left">
	           <div align="left">&nbsp;&nbsp;
	           <input type="button" class="icon_1" value="<fmt:message key="query"/>" onclick="risk_fund_inQuery_onClick();" />
                </div>
             </td>
	  </tr>
<!--	  <tr>-->
<!--	 -->
<!--	      <td>成本中心</td>-->
<!--			<td><select name="select" class="sSelect" id="select">-->
<!--			    <option value="">请选择</option>-->
<!--			    <option value="fr">广东加多宝集团公司</option>-->
<!--			    <option value="ro">上海对外贸易有限公司</option>-->
<!--			</select></td>-->
<!--			<td>账单月</td>-->
<!--			<td><w:date format="yyyy-MM-dd" width="100px" name="bill_month" /></td>-->
<!--			<td width="167">-->
<!--			-->
<!--			</td>-->
<!--	  -->
<!--	  </tr>-->
	  </table>
	  </div>
	
	
	 
	
	                    
	<div id="ccParent1" class="button"> 
	 <div class="button_right">
	                <ul>
	                    <li class="a_1">      <a onClick="javascript:viewItem();"><fmt:message key="view_details"/> </a></li>
	                </ul>
	                
	         </div>
	           <div class="clear"></div>            
	</div>
	 
	 
	 
	<!-- <div id="values_div" class="box" > -->
	      <div style="padding: 8 10 8 8;">
	         <r:datacell id="datacell_risk_in" queryAction="/FAERP/Sp_risk_fund_remAction.do?cmd=queryForDatacell" width="98%" height="290px" 
	         xpath="Sp_risk_fund_remVo" paramFormId="datacell_formid">
	         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	         <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
	         <r:field fieldName="customer_name" messagekey="customer_name" width="300px" ></r:field>
	         <r:field fieldName="customer_code" messagekey="customer_code" width="250px" ></r:field>
<!--	         <r:field fieldName="cost_center_id" label="成本中心" width="250px" ></r:field>-->
	         <r:field fieldName="record_month" messagekey="bill_month" width="150px" ></r:field>
	         <r:field fieldName="rem_sum" messagekey="rem_sum" width="100px" ></r:field>
	         
	         </r:datacell>
	       </div>
	<!--</div>-->
	 
	 
	
	</div>
	
	<!--  收入 大项 end  -->
	
	
	
<!--  收入 明细 start   -->
    <div class="ringht_s" id="risk_fund_rem_item_content" style="display: none;">
     
            <div class="xz_title" style="padding-top: 10px"><fmt:message key="risk_income_customer_list"/> </div>
            &nbsp;&nbsp;<input type="button" class="icon_1" value="<fmt:message key="go_back"/>" onClick="javascript:risk_fund_rem_item_content_back();"/>
          <div style="padding: 8 10 8 8;">
             <r:datacell id="datacell_item" queryAction="/FAERP/Sp_risk_fund_remAction.do?cmd=queryForDatacell" width="98%" height="380px" 
             xpath="Sp_risk_fund_remVo" paramFormId="datacell_formid">
             <r:toolbar location="bottom" tools="nav,pagesize,info"/>
             <r:field fieldName="empoyee_code" messagekey="emp_code" width="250px" ></r:field>
             <r:field fieldName="empoyee_name" messagekey="emp_name" width="250px" ></r:field>
             <r:field fieldName="rem_sum" messagekey="rem_sum" width="100px" ></r:field>
             
             </r:datacell>
           </div>
     
    </div>
    
    <!--  收入 明细 end  -->
	
	
	
</div>
</form>
</fmt:bundle>
</body>
</html>

