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
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     //简单的模糊查询
    function simpleQuery_onClick(){   
        var start_pay_year_month =  _$("#start_pay_year_month").val();//支付服务起始月
        var end_pay_year_month =  _$("#end_pay_year_month").val();//支付服务截止月
        var start_bill_year_month =  _$("#start_bill_year_month").val();//账单服务起始月
        var end_bill_year_month =  _$("#end_bill_year_month").val();//账单服务截止月
        var emp_code = _$("#emp_code").val();//员工编号
        var cust_id = _$("#select_cust_id").val();//客户id
        
        if((emp_code == null || emp_code =="") && (cust_id == null || cust_id =="")){
            alert("请输入员工编号或者选择一个客户");
            return;
        }
        if( (start_pay_year_month==null || start_pay_year_month=="") &&  (end_pay_year_month==null || end_pay_year_month=="") && (start_bill_year_month==null || start_bill_year_month=="")  && (end_bill_year_month==null || end_bill_year_month=="") ){
            alert("请至少输入一个时间年月");
            return;
        }
        
        var productSelect = _$("#productSelect").val();//产品类型
        var big_product_type;//产品大类
        var small_product_type;//小类
        if(productSelect ==1){
            big_product_type = 999;//大类999 小类1为社保
            small_product_type = 1;
        }else if(productSelect ==2){
            big_product_type = 999;//大类999 小类2为公积金
            small_product_type = 2;
        }else{
            big_product_type = productSelect;//大类103 101分别为个税和工资
        }
        if( (start_pay_year_month != null && start_pay_year_month != "") || (end_pay_year_month != null && end_pay_year_month != "") ){
            $id("datacell1").queryAction = "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=queryPaymentByEmp";
            $id("datacell1").addParam("big_product_type",big_product_type);
            $id("datacell1").addParam("small_product_type",small_product_type);
            $id("datacell1").addParam("cust_id",cust_id);
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }else{
             //$id("datacell1").addParam("big_product_type","null");
	         //$id("datacell1").loadData();
	         //$id("datacell1").refresh();
        }
        if( (start_bill_year_month != null && start_bill_year_month != "") || (end_bill_year_month != null && end_bill_year_month != "") ){
            $id("datacell2").queryAction = "<%=request.getContextPath()%>/FinbillAction.do?cmd=queryIncomeByEmp";
	        $id("datacell2").addParam("start_bill_year_month",start_bill_year_month);
	        $id("datacell2").addParam("end_bill_year_month",end_bill_year_month);
	        $id("datacell2").addParam("emp_code",emp_code);
	        $id("datacell2").addParam("big_product_type",big_product_type);
            $id("datacell2").addParam("small_product_type",small_product_type);
            $id("datacell2").addParam("cust_id",cust_id);
            $id("datacell2").loadData();
            $id("datacell2").refresh();
        }else{
          //  $id("datacell2").addParam("big_product_type","null");
         //   $id("datacell2").loadData();
         //   $id("datacell2").refresh();
        }
    }
    
    //选择客户的返回方法
    function rtnFuncCustomer(arg){
        var lookup = $id("customer_id");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        _$("#select_cust_id").val(arg[0]);
        return false;
    }
    
    //导出
    function exportData(flag){
        var start_pay_year_month =  _$("#start_pay_year_month").val();//支付服务起始月
        var end_pay_year_month =  _$("#end_pay_year_month").val();//支付服务截止月
        var start_bill_year_month =  _$("#start_bill_year_month").val();//账单服务起始月
        var end_bill_year_month =  _$("#end_bill_year_month").val();//账单服务截止月
        var emp_code = _$("#emp_code").val();//员工编号
        var cust_id = _$("#select_cust_id").val();//客户id
        
        if((emp_code == null || emp_code =="") && (cust_id == null || cust_id =="")){
            alert("请输入员工编号或者选择一个客户");
            return;
        }
        if( (start_pay_year_month==null || start_pay_year_month=="") &&  (end_pay_year_month==null || end_pay_year_month=="") && flag=="1"){
            alert("请输入支付服务年月");
            return;
        }
        
        if( (start_bill_year_month==null || start_bill_year_month=="")  && (end_bill_year_month==null || end_bill_year_month=="")  && flag=="2"){
            alert("请输入账单服务年月");
            return;
        }
        
        var productSelect = _$("#productSelect").val();//产品类型
        var big_product_type = "";//产品大类
        var small_product_type = "";//小类
        if(productSelect ==1){
            big_product_type = 999;//大类999 小类1为社保
            small_product_type = 1;
        }else if(productSelect ==2){
            big_product_type = 999;//大类999 小类2为公积金
            small_product_type = 2;
        }else{
            big_product_type = productSelect;//大类103 101分别为个税和工资
        }
        
        var param = jQuery("#datacell_formid").serialize();
        form.action="/FAERP/FinpaymentAction.do?cmd=exportPayIncomeData&big_product_type="+big_product_type+"&small_product_type="+small_product_type+"&flag="+flag;
        form.submit();
    }
    
</script>
 

</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=queryPaymentByEmp" >
<div id="right">
    <script language="javascript">
           writeTableTopFesco('员工收支查询','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_s">
       <!--  div ccChild0 start -->
       <div id="ccChild0" class="search"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                     <tr>
                       <td width="174" rowspan="10" style="padding-top:0;" height="40px;"><div class="search_title">查询条件</div> </td>
                     </tr>
                     <tr>
                       <td align="left">支付服务年月</td>
                       <td align="left">
                           <input type="text" class="text_field" style="width:87px" id="start_pay_year_month"  name="start_pay_year_month" value="" inputName="支付服务起始年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
              到
                           <input type="text" class="text_field" style="width:87px" id="end_pay_year_month"  name="end_pay_year_month" value="" inputName="支付服务截止年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                       </td>
                       <td align="left">账单服务年月</td>
                       <td align="left">
                           <input type="text" class="text_field" style="width:87px" id="start_bill_year_month"  name="start_bill_year_month" value="" inputName="账单服务起始年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
              到
                           <input type="text" class="text_field" style="width:87px" id="end_bill_year_month"  name="end_bill_year_month" value="" inputName="账单服务截止年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                       </td>
                     </tr>
                     <tr>
                       <td align="left">产品类型</td>
                       <td align="left">
                            <select id="productSelect">
                                <option value="">请选择</option>
                                <option value="1">社保</option>
                                <option value="2">公积金</option>
                                <option value="103">个税</option>
                                <option value="101">工资</option>
                            </select>
                       </td>
                       <td align="left">员工编号</td>
                       <td align="left">
                           <input type="text" class="text_field" id="emp_code" name="emp_code" value="" inputName="员工编号"/>
                       </td>
                        <td align="left">                 
                          <input name="button_ok" class="icon_1"   type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
                          <input type="reset" class="icon_1"  />
                        </td>
                     </tr>
                     <tr>
                       <td align="left">选择客户</td>
                       <td align="left">
                            <div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
					            id="customer_id" name="customer_id" property="customer_id"
					            displayProperty="customer_name"
					            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
					            messagekey="select_customer" height="440" width="600" style="width:188px" /></div>
			            </td>
				        <input type="hidden" id="select_cust_id"  name="select_cust_id" value="" />
                      </tr>
            </table>
       </div>
        <!--  div ccChild0 end -->
        <div style="margin-top: 5px;">
            <div class="xz_title" style="width:45%;float: left;">支出信息</div>
            <div class="xz_title" style="width:48%;float: right;">收入信息</div>
        </div>
        
        <!--  div start -->
        <div style="padding: 8 10 8 8;">
            <div style="float: left;margin-top: -12px;">
                <div  class="button_right">
                    <input class="approdetial" type="button"   value="支出导出"  <au:authorityBtn code="szcx_zcdc" type="1"/>  onClick="exportData(1);">
                </div>
                 <r:datacell id="datacell1" queryAction="/FAERP/FinpaymentAction.do?cmd=queryPaymentByEmp" 
                 width="530px" height="300px" xpath="IncomePaymentVo" paramFormId="datacell_formid" pageSize="50"  >
                     <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                     <r:field fieldName="emp_name" label="员工姓名" width="80px" allowModify="false"> <h:text/> </r:field>    
                     <r:field fieldName="emp_code" label="员工编号" width="80px" allowModify="false"> <h:text/> </r:field>
                     <r:field fieldName="product_name" label="产品名称" width="80px" allowModify="false"><h:text/></r:field>    
                     <r:field fieldName="payment_month" label="支付年月" width="60px" allowModify="false"><h:text/></r:field>
                     <r:field fieldName="service_year_month" label="服务年月" width="60px" allowModify="false"><h:text/></r:field>
                     <r:field fieldName="payment_amount" label="支付金额" width="135px" allowModify="false"><h:text/></r:field>
                  </r:datacell>
            </div>
             <div style="float: right;margin-right:11px;margin-top: -12px;">
                    <div  class="button_right">
                        <input class="approdetial" type="button"   value="收入导出"  <au:authorityBtn code="szcx_srdc" type="1"/>  onClick="exportData(2);">
                    </div>
                     <r:datacell id="datacell2" queryAction="/FAERP/FinbillAction.do?cmd=queryIncomeByEmp" paramFormId="datacell_formid"
                       width="550px" height="300px" xpath="IncomePaymentVo" 
                       pageSize="50" >
                     <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                         <r:field fieldName="emp_name" label="员工姓名" width="80px" allowModify="false">  <h:text/> </r:field>    
                         <r:field fieldName="emp_code" label="员工编号" width="80px" allowModify="false">  <h:text/> </r:field>
                         <r:field fieldName="product_name" label="产品名称" width="80px" allowModify="false"> <h:text/> </r:field>    
	                     <r:field fieldName="bill_year_month" label="账单年月" width="60px" allowModify="false"> <h:text/> </r:field>
	                     <r:field fieldName="service_year_month" label="服务年月" width="60px" allowModify="false"> <h:text/> </r:field>
	                     <r:field fieldName="amount" label="账单金额" width="155px" allowModify="false"> <h:text/> </r:field>
                     </r:datacell>
             </div>
             
        </div>
        <!--  div end -->
</div>
</div>
</form>
</body>
</html>

<script language="javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
    $id("datacell2").isQueryFirst = false;
});

 //新增合计行 dc datacell对象 amount_number 金额所在列
    function setTotal(dc,amount_number){
       var dcCount = dc.getCurrentRowCount();//获得当前记录数
       if(dcCount>0){
          var amount;//金额
          var totalAmount = 0;//统计金额
          for(var i=0;i<dcCount;i++){
             amount = dc.getCellValue(dc.getCell(i,amount_number));
             totalAmount = parseFloat(totalAmount)+parseFloat(amount);
          }
          dc.addRow();
          dc.setCellValue(dc.getCell(dc.getCurrentRowCount()-1,0),"合计");
          dc.setCellValue(dc.getCell(dc.getCurrentRowCount()-1,amount_number),totalAmount.toFixed(2));//设值
          dc.endEdit();
      }
    }
    

 $id("datacell1").afterRefresh = function(){
    setTotal($id("datacell1"),5);
 }
  $id("datacell2").afterRefresh  = function(){
    setTotal($id("datacell2"),5);
 }
</script>   
