<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/jsp/include/rmGlobal_insert.jsp" %>
<html>
<fmt:bundle basename="rayoo.finance.bill.billmodify.billmodify_resource" prefix="rayoo.finance.bill.billmodify.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function generatebill_onClick(){
        var datacell_cp = $id("datacell_cp");
        if(datacell_cp.isModefied == true){
	        if (datacell_cp.submit() == true){
	            alert("数据修改成功！");
	        }
	    }
        closePage();
    }
    
    function closePage(){
       window.close();
       var dc = window.opener.$id("datacell");
       dc.reload();
    }
</script>
</head>
<body>
<form action="" id="form4datacell_cp" name="form">
  <input type="hidden" id="bill_id" name="bill_id" value="${billVo.id}">
  <div id="right">
    <div class="ringht">
      <div id="s_p_list_div"  style="">
        <div style="padding: 8 10 8 8;">
          <div class="xz_title" style="padding-top: 10px" align="center">${billVo.cust_name} ${billVo.bill_year_month} <fmt:message key="ibd_bill_item"/></div>
            <div align="right"><fmt:message key="bill_code"/>：${billVo.bill_code} </div>
          </div>
          <r:datacell id="datacell_cp" 
                queryAction="/FAERP/BillmodifyAction.do?cmd=ibdBillModifyQuery&bill_id=${billVo.id}" width="99%" height="450px"
                submitAction="/FAERP/BillmodifyAction.do?cmd=updateIbdBill"
                xpath="FinbillitemVo" paramFormId="form4datacell_cp"
                submitXpath="FinbillitemVo"
                    >
            <r:field fieldName="employee_name" messagekey="emp_name" width="300px"></r:field>
            <r:field fieldName="employee_code" messagekey="emp_code" width="300px" ></r:field>
            <r:field fieldName="product_name" messagekey="product_name" width="300px" ></r:field>
            <r:field fieldName="amount" messagekey="amount_" width="100px" >
                <h:text validateAttr="allowNull=false;type=number;"/>
            </r:field>
          </r:datacell>
        </div>
      </div>
    </div>
    <div id="ccChild1"     class="box_xinzeng" style="height: 30px;" align="center">
      <%if(request.getAttribute("isView")==null) {%>
      <input id="update_button" type="button" class="icon_2" value="<fmt:message key='button_submit'/>" onClick="javascript:generatebill_onClick()" />
      <%} %>
      <input id="return_button" type="button" class="icon_2" value="<fmt:message key='button_close'/>" onClick="javascript:closePage()"/>
    </div>
  </div>
</form>
</body>
</fmt:bundle>
</html>
