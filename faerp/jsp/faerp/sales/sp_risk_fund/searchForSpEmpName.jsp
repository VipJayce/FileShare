<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salse.sp_risk_fund.sp_risk_fund_resource" prefix="rayoo.salse.sp_risk_fund.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function showListData(){
	    $id("datacell2").loadData();
	    $id("datacell2").refresh();
    }
    
    function toOK_onClick() {
        entity=choose_row("datacell2");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("emp_id");
        returnAry[1] = entity.getProperty("emp_name");
        returnAry[2] = entity.getProperty("emp_code");
        returnAry[3] = entity.getProperty("id_card");
        returnAry[4] = entity.getProperty("cust_name");
        returnAry[5] = entity.getProperty("cust_code");
        returnAry[6] = entity.getProperty("cust_id");
        window.returnValue=returnAry;
        window.close();
    }
    
    function choose_row(dcId){
	    dc = $id(dcId);
	    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key="select_one_record"/>");
           return;
        }
        return obj;
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
        return false;
    }

</script>
</head>
<body>

<form name="form" method="post" id="employee_formid">
 
<div id="right">
<div class="ringht_s" >
 
 
<div id="ccChild0" class="search"> 
<table width="90%" border="0" cellspacing="0" cellpadding="0">
		<tr>
            <td width="175" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key="query_conditions"/></div>
            </td>
        </tr>
		<tr>
			<td width="23%" align="right"><fmt:message key="employee_name"/></td>
			<td width="27%" align="left">
			  <input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>			</td>
			<td width="21%" align="right"><fmt:message key="only_number"/></td>
			<td width="29%" align="left">
		      <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
			</tr>
		<tr>
		  <td align="right"><fmt:message key="id_card"/></td>
		  <td align="left"><input type="text" class="text_field" name="id_card1" inputName="身份证号" maxLength="64"/>          </td>
			<td align="right"><fmt:message key="customer_code"/></td>
			<td align="left"><input type="text" readonly="readonly" value="${customer_code }" class="text_field" name="cust_code1" inputName="客户编号" maxLength="64"/>            </td>
			</tr>
		<tr>
		  <td align="right"></td>
		  <td align="left">
		      
		  </td>
		  <td align="right"></td>
		  <td align="left">
		      <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">          
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
		  </td>
        </tr>
</table>
</div>

<div id="ccParent1" class="button"> 
	 <div class="button_right">
		<ul>
			<li class="g">      <a onClick="javascript:toOK_onClick();"><fmt:message key="confirm"/></a></li>
		</ul>
	</div>
    <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/Sp_risk_fund_expAction.do?cmd=searchEmployee"
        width="95%"
        xpath="EmppostVo"
        paramFormId="employee_formid"
        readonly="true"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" messagekey="employee_name" width="100px">
           <h:text disabled="true"/>
       </r:field>    
      <r:field fieldName="emp_code" messagekey="only_number">
        <h:text disabled="true"/>
      </r:field>
      <r:field fieldName="cust_name" messagekey="customer_name" width="230px">
        <h:text disabled="true"/>
      </r:field>
      <r:field fieldName="cust_code" messagekey="customer_code"  width="150px">
        <h:text disabled="true"/>
      </r:field>
      <r:field fieldName="cust_id" messagekey="cust_id">
        <h:text disabled="false"/>
      </r:field>
    </r:datacell>
</div>

</div>
</div>
</form>
</fmt:bundle>
<script type="text/javascript">
$id("datacell2").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    toOK_onClick();
}
</script>
</body>
</html>
