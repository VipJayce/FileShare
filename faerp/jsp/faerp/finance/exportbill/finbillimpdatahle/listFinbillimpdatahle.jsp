<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.exportbill.finbillimpdatahle.finbillimpdatahle_resource" prefix="rayoo.finance.exportbill.finbillimpdatahle.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
function rtnFunc(arg){
 //alert(arg[0]+"="+arg[1]+"="+arg[2]+"="+arg[3]) ;
    var lookup = $id("cust_id");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    $id("c_cust_code").value = arg[1] ;
    return false;
}

	function simpleQuery_onClick(){  //简单的模糊查询
		$id("isonequery").value ="no" ;
		 $id("datacell1").loadData();
         $id("datacell1").refresh();
  	}
  	
  	
  	function exportTableData_onClick(){
            var billyearmonth=document.getElementById("billyearmonth").value;
            var c_cust_code=document.getElementById("c_cust_code").value;
            $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpdatahleAction.do?cmd=exportHLE&billyearmonth="+billyearmonth+"&c_cust_code"+c_cust_code;
            $id("datacell_formid").submit();
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="isonequery" name="isonequery" value="yes"/>
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key='page_finbillimpdatahle'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
			<td/>
			<td/>
			  <td></td>
            	<td/>
		</tr>
		<tr>
		<td align="right"><fmt:message key='billyearmonth'/></td>
		<td align="left">
		<input  id="billyearmonth" name="billyearmonth" type="text" class="text_field"/></td>
			<td><fmt:message key='select_cust'/></td>
			<td>
			<w:lookup onReturnFunc="rtnFunc" readonly="true" id="cust_id" lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:170px" messagekey="select_cust" height="500" width="810"/>
			<input type="hidden" id="c_cust_code" name="c_cust_code"/>
			</td>
			<td/>
			
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value="<fmt:message key='button_query'/>" onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value="<fmt:message key='button_reset'/>" onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
		
		
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
		 <input class="e_3" type="button"   value="<fmt:message key='button_exp'/>"  <au:authorityBtn code="hlr_zddc" type="1"/>  onClick="exportTableData_onClick();">
		 </div>
           <div class="clear"></div>			
</div>
  <div style="padding: 8 10 8 8;">
  <r:datacell 
               id="datacell1"
               queryAction="/FAERP/FinbillimpdataAction.do?cmd=queryHailarData"
               width="99%"
               height="320px" 
               xpath="FinbillimpdataVo"
               paramFormId="datacell_formid"
               readonly="true"
               >
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="bill_year_month" messagekey="billyearmonth" width="70px">
               </r:field>
               <r:field fieldName="cust_name" messagekey="cust_name" width="200px">
               </r:field>
               <r:field fieldName="cust_code" messagekey="cust_code" width="70px">
               </r:field>
               <r:field fieldName="emp_name" messagekey="emp_name" width="70px">
               </r:field>
               <r:field fieldName="emp_code" messagekey="emp_code" width="70px">
               </r:field>
               <r:field fieldName="emp_id_card_no" messagekey="emp_id_card_no" width="140px">
               </r:field>
               <r:field fieldName="user_name" label="客服名称" width="70px">
               </r:field>
               <r:field fieldName="dept_name" label="客服部门" width="120px">
               </r:field>
               <r:field fieldName="A1" messagekey="a1" width="70px">
               </r:field>
               <r:field fieldName="a2" messagekey="a2" width="70px">
               </r:field>
               <r:field fieldName="a3" messagekey="a3" width="70px">
               </r:field>
               <r:field fieldName="a4" messagekey="a4" width="70px">
               </r:field>
               <r:field fieldName="a5" messagekey="a5" width="70px">
               </r:field>
               <r:field fieldName="a6" messagekey="a6" width="70px">
               </r:field>
               <r:field fieldName="a7" messagekey="a7" width="70px">
               </r:field>
               <r:field fieldName="a8" messagekey="a8" width="70px">
               </r:field>
               <r:field fieldName="a9" messagekey="a9" width="70px">
               </r:field>
               <r:field fieldName="a10" messagekey="a10" width="70px">
               </r:field>
               <r:field fieldName="a11" messagekey="a11" width="70px">
               </r:field>
               <r:field fieldName="a12" messagekey="a12">
               </r:field>
               <r:field fieldName="a13" messagekey="a13" width="70px">
               </r:field>
               <r:field fieldName="a14" messagekey="a14" width="70px">
               </r:field>
               <r:field fieldName="a15" messagekey="a15" width="70px">
               </r:field>
               <r:field fieldName="a16" messagekey="a16" width="70px">
               </r:field>
               <r:field fieldName="a17" messagekey="a17">
               </r:field>
               <r:field fieldName="a18" messagekey="a18" width="70px">
               </r:field>
               <r:field fieldName="a19" messagekey="a19" width="70px">
               </r:field>
               <r:field fieldName="a20" messagekey="a20">
               </r:field>
               <r:field fieldName="a21" messagekey="a21" width="70px">
               </r:field>
               <r:field fieldName="a22" messagekey="a22" width="70px">
               </r:field>
               <r:field fieldName="a23" messagekey="a23" width="70px">
               </r:field>
               <r:field fieldName="a24" messagekey="a24" width="70px">
               </r:field>
               <r:field fieldName="a25" messagekey="a25" width="70px">
               </r:field>
               <r:field fieldName="a26" messagekey="a26" width="70px">
               </r:field>
               <r:field fieldName="a27" messagekey="a27">
               </r:field>
               <r:field fieldName="a28" messagekey="a28">
               </r:field>
               <r:field fieldName="a29" messagekey="a29">
               </r:field>
               <r:field fieldName="a30" messagekey="a30">
               </r:field>
               <r:field fieldName="a31" messagekey="a31">
               </r:field>
             </r:datacell>
             </div>
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>

