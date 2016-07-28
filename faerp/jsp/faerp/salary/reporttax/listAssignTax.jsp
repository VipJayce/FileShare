<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<html>
<fmt:bundle basename="rayoo.salary.reporttax.reporttax_resource" prefix="rayoo.salary.reporttax.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_assigntax'/></title>

</head>
<body>
   <div id="right" class="search"> 
   <form name="form_assignTax" id="form_assignTax" method="post" action="<%=request.getContextPath()%>/ReporttaxAction.do">
	<table width="98%" border="0" cellspacing="1" cellpadding="0"
		style="margin-left: 10px;">
		<tr>
			<td width="10%" class="td_1" align="center"><fmt:message key='customer_name'/></td>
			<td width="15%" class="td_2"><w:lookup
				onReturnFunc="rtnFuncCustomer" id="lk_cust"
				name="customer_name"
				lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
				messagekey="select_cust" height="440" width="600" style="width:170px" />
			</td>
			<td width="10%" class="td_1" align="center"><fmt:message key='submit_user'/></td>
			<td width="15%" class="td_2">
				<r:comboSelect id="combo_cs" name="cs_name"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="name"
                       xpath="CustServiceVo"
                       width="150px"
                       nullText="" />
			</td>
			<td width="10%" class="td_1" align="center"><fmt:message key='tax_name'/></td>
			<td width="15%" class="td_2">
			<r:comboSelect id="combo_tax" name="tax_name"
                       queryAction="/FAERP/ReporttaxAction.do?cmd=qryTaxTeam"
                       textField="user_name"
                       valueField="user_name"
                       xpath="CustTaxVo"
                       width="150px"
                       nullText="" />
			</td>
			<td width="10%" class="td_1" align="center"><fmt:message key='dept_name'/></td>
			<td width="15%" class="td_2">
				 <input name=dept_name class="sText" id="t_dept_name"/>
			</td>
		</tr>
		<tr>
			<td width="15%" class="td_1" align="center"><fmt:message key='is_assign_tax'/></td>
			<td width="10%" class="td_2">
				 <input type="radio" name="is_assign_tax" value="1"/><fmt:message key='is_assign_tax_1'/>
				 <input type="radio" name="is_assign_tax" value="0"/><fmt:message key='is_assign_tax_0'/>
			</td>
			<td colspan="6" align="center" class="td_2">
				<input type="button" onclick="toselect_onclick()" class="icon_1" value="<fmt:message key='button_search'/>" />
			</td>
		</tr>
	</table>
	</form>
	<br/>
	 <r:datacell id="dc_assigntax"
	            queryAction="/FAERP/ReporttaxAction.do?cmd=qryAssignTax"
	            submitAction="/FAERP/ReporttaxAction.do?cmd=update"
	            width="99%" xpath="CustTaxVo" submitXpath="CustTaxVo"
	            paramFormId="form_assignTax">
	            <r:toolbar location="bottom" tools="nav,pagesize,info" />
	            <r:field fieldName="customer_id" 
              	label="<input type='checkbox' onclick='chk_all(this)' />" 
              	sortAt="none" width ="30px" onRefreshFunc="showchkbox"/>
	            <r:field fieldName="customer_code" messagekey="customer_code" width="150px">
	            </r:field>
	            <r:field fieldName="customer_name" messagekey="customer_name" width="250px">
	            </r:field>
	            <r:field fieldName="cs_name" messagekey="submit_user" width="150px">
	            </r:field>
	            <r:field fieldName="dept_name" messagekey="dept_name" width="150px">
	            </r:field>
	            <r:field fieldName="tax_name" messagekey="tax_name" width="150px">
	            </r:field>
	        </r:datacell>
	    <table width="98%" border="0" cellspacing="1" cellpadding="0" style="margin-left: 10px;"> 
		   <tr>
		   <td width="50%" class="td_1" align="right">
	        <fmt:message key='tax_name_n'/><r:comboSelect id="combo_tax2" name="tax_name_n"
                       queryAction="/FAERP/ReporttaxAction.do?cmd=qryTaxTeam"
                       textField="user_name"
                       valueField="user_name"
                       xpath="CustTaxVo"
                       width="150px" 
                       nullText="" />
           </td>
		   <td width="50%" align="left" class="td_1">
		   	<input type="button" onclick="assignTax()" class="icon_3" value="<fmt:message key='button_assignTax'/>" />
		   </td>
		   </tr>
	        
	        
	    </table>
	</div>
	       
</body>
<script type="text/javascript">
function toselect_onclick() { 
   $id("dc_assigntax").reload() ;
}
 function rtnFuncCustomer(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    return false;
 }
 //全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
    } else {
        jQuery(":checkbox").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id' tax_id='" + entity.getProperty("tax_id") + "' value='" + entity.getProperty("customer_id") + "' />";
}
//获得选中的记录
function getChkedRecord(){
	var ids = new Array();
	var tax_ids = new Array();
	var rst = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            tax_ids.push(this.tax_id);
        }
    });
    
    var len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_one_1'/>");
    	return "";
    }
    rst.push(len);
    rst.push(tax_ids.join());
    return rst;
}
//分配报税专员
function assignTax(){
	var taxer = $id("combo_tax2").getSelectEntity();
	if(!taxer.getValue("user_id")){
		alert("<fmt:message key='alert_select_tax'/>");
		return;
	}
    var rst = getChkedRecord();
    var ids = rst[0];
	var tax_ids = rst[1];
    if(ids.length<=0){
    	return;
    }
    var tax_str = "&user_id="+taxer.getValue("user_id")+"&dept_id="+taxer.getValue("dept_id")+"&user_name="+
    			encodeURI(taxer.getValue("user_name"))+"&tax_ids="+tax_ids;
    showProgressBar();			
    jQuery.post("<%=request.getContextPath()%>/ReporttaxAction.do?cmd=assignTax&cust_ids="+ids+tax_str,function(data){
           if(data > 0){
           	hideProgressBar();
            alert("<fmt:message key='alert_tax_success'/>");
            $id("dc_assigntax").reload();
            $id("combo_tax2").selectOptionByIndex(0);
           }else{r
           	hideProgressBar();
           	alert("<fmt:message key='alert_tax_fail'/>");
           	$id("combo_tax2").selectOptionByIndex(0);
           }
    });
    
}
</script>
</fmt:bundle>
</html>
