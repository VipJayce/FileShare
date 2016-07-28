<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.finpaymentmanage.finpayment.finpayment_resource" prefix="rayoo.finance.finpaymentmanage.finpayment.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='page_advancequery'/></title>
<script language="javascript">
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

	function rtnFuncCustomer(arg){
	    var lookup = $id("cust_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    return false;
	}
	
	function rtnFuncUser(arg){
	    var lookup = $id("emp_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    return false;
	}

    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key='alert_select_one'/>");
           return;
        }
     return obj;
    }
    
    function toDetailPage_onClick(){
            dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("<fmt:message key='alert_select_one'/>");
                return ;
            }
            var is_have_item = clz.getValue("is_have_item");
            if(is_have_item==null||is_have_item=="0"){
                  alert("<fmt:message key='alert_is_have_item'/>");
                  return;
            }else if(is_have_item=="1"){
                   //alert("有明细id="+clz.getValue("id"));payment_type_bd
                   var url="<%=request.getContextPath()%>/jsp/faerp/finance/finpaymentmanage/finpayment/payDetail.jsp?id="+clz.getValue("id")+"&payment_type_bd="+clz.getValue("payment_type_bd"); 
                   url=url+'&_ts='+(new Date()).getTime(); 
                   var width = window.screen.width-20;
                   var height = window.screen.height-80;
                   //showModalCenter(url, window, "", 1280, 800, "<fmt:message key='page_viewdetail'/>");  //增加子岗位
                   window.open(url, "Sample","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,copyhistory=yes,width="+width+",height="+height+",left=0,top=0")
            }
    }
    
     jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    
    
               //导出数据
       function exportToExcel() {  
           if(confirm("<fmt:message key='alert_is_export'/>")) {
          
           //魏佳新增--【垫付查询】导出明细需增加‘AP主管审核意见’一栏 开始
            var dc = $id("datacell1");
            var clz = dc.getActiveEntity();
            var contract_id = clz.getValue("id");
            var payment_type_bd=clz.getValue("payment_type_bd");
            var wfname = "";
            var wfname1 = "";
            if((payment_type_bd!=null &&payment_type_bd == "1") || (payment_type_bd!=null&&payment_type_bd == "2")){
			    wfname="SheBaoGongJiJinPayWorkFlow";
			    wfname1="SheBaoGongJiJinPayWorkFlow";
			}else{
			    wfname="PayWorkFlow";
			    wfname1="PayWorkFlow";
			}
             //魏佳新增--【垫付查询】导出明细需增加‘AP主管审核意见’一栏 结束
             
            form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=exportToExcel1&contract_id="+contract_id+"&wfname="+wfname+"&wfname1="+wfname1;
            form.submit();
            }
        }  
        
        //垫付重算
        function reCal(){
            var dataCelObj = choose_row("datacell1");
            var paymentID = dataCelObj.getValue("id");
            var payment_type_bd = dataCelObj.getValue("payment_type_bd");
            //1社保2公积金4代发工资5代扣税金
            if(payment_type_bd == "1" || payment_type_bd == "2" || payment_type_bd == "4" || payment_type_bd == "5" ){
                document.getElementById("reCalButton").disabled=true;
                var urlStr = "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=reCalPayment&paymentID="+paymentID;
	            jQuery.ajax({
	                    type : "post",
	                    url : urlStr,
	                    dataType : "html",
	                    error: function(){
	                         alert('Ajax Error!');
	                         document.getElementById("reCalButton").disabled=false;
	                         return;
	                     },success : function(data) {
	                       if(data != "null"){
	                           alert(data);
	                           document.getElementById("reCalButton").disabled=false;
	                       }
	                    }
	                });
            }else{
                alert("对不起垫付重算仅支持，社保、公积金、代发工资、代扣税金！");
            }
        }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="">
<div id="right">
	<script language="javascript">
		writeTableTopFesco("<fmt:message key='page_advancequery'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
        <tr>
            <td align="right"><fmt:message key='cust_name'/></td>
            <td align="left">    
            <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_id" name="cust_id" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="440" width="600"  style="width:170px"/>            </td>
            <td align="right"><fmt:message key='cust_code'/></td>
            <td align="left">
            <input type="text" style="width:190px" name="customer_code" maxLength="50" value=""/>  
            <!-- 
             <lookup onReturnFunc="rtnFuncUser" readonly="true" id="emp_id" name="emp_id" lookupUrl="/FinpaymentAction.do?cmd=getAllEmployeeByCondition" dialogTitle="选择员工" height="440" width="600" style="width:170px"/>
             -->
            </td>
            <td width="100" align="right"><fmt:message key='receiver_name_'/></td>
            <td width="213" align="left">
            <input type="text" style="width:190px" name="receiver_name" inputName="受款方名称" maxLength="50" value=""/>            </td>
        </tr>
        
        
        <tr>
            <td align="right"><fmt:message key='payment_type_bd'/></td>
            <td align="left">
                <d:select dictTypeId="PAYMENT_TYPE_BD"  property="payment_type_bd" id="payment_type_bd" nullLabel="--请选择--" style="width:190px"/>            </td>
            <td align="right"><fmt:message key='receiver_type_bd'/></td>
            <td align="left">
               <d:select dictTypeId="RECEIVER_TYPE_BD"  property="receiver_type_bd" id="receiver_type_bd" nullLabel="--请选择--" style="width:190px"/>           </td>
            <td align="right"><fmt:message key='apply_date'/></td>
            <td align="left"><w:date format="yyyy-MM-dd" id="apply_date_from" name="apply_date_from" width="70px"/>至<w:date format="yyyy-MM-dd" id="apply_date_to" name="apply_date_to" width="70px"/></td>
        </tr>
        
        <tr>
          <td align="right"><fmt:message key='apply_amount'/></td>
          <td align="left"><input type="text" class="text_field" name="apply_amount_from" inputName="申请付款金额" maxLength="50" value="" style="width:85px"/>至<input type="text" class="text_field" name="apply_amount_to" inputName="申请付款金额" maxLength="50" value="" style="width:85px"/></td>
          <td align="right"><fmt:message key='reimburse_amount'/></td>
          <td align="left">
            <input type="text" class="text_field" name="reimburse_amount_from" inputName="垫付金额" maxLength="50" value="" style="width:85px"/>至<input type="text" class="text_field" name="reimburse_amount_to" inputName="垫付金额" maxLength="50" value="" style="width:85px"/></td>
		  <td align="right"><fmt:message key='reimburse_status_bd'/></td>
            <td align="left"><d:select dictTypeId="REIMBURSE_STATUS_BD"  property="reimburse_status_bd" id="reimburse_status_bd" nullLabel="--请选择--" style="width:190px"/></td>
        </tr>
        <tr>
          <td style="padding-top:0;">&nbsp;</td>
          <td align="right"><fmt:message key='reimburse_finished_date'/></td>
          <td align="left">
		  <w:date format="yyyy-MM-dd" id="reimburse_finished_date_from" name="reimburse_finished_date_from" width="73px"/>至<w:date format="yyyy-MM-dd" id="reimburse_finished_date_to" name="reimburse_finished_date_to" width="73px"/>
		  </td>
          <td align="right"><fmt:message key='cashier_operate_date'/></td>
            <td align="left"><w:date format="yyyy-MM-dd" id="cashier_operate_date_from" name="cashier_operate_date_from" width="73px"/>至<w:date format="yyyy-MM-dd" id="cashier_operate_date_to" name="cashier_operate_date_to" width="73px"/></td>
       
		  <td colspan="2" align="center"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset()"></td>
        </tr>
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="h_1">      <a  onClick="javascript:toDetailPage_onClick();">查看明细</a> </li>
                </ul>
         -->
         <input type="button" class="h_1" value="<fmt:message key='button_viewdetail'/>" <au:authorityBtn code="dfcx_ckmx" type="1"/> onClick="toDetailPage_onClick();" />
         <input type="button" class="e" value="<fmt:message key='button_export'/>" <au:authorityBtn code="dfcx_dc" type="1"/> onClick="exportToExcel();" />
         <input type="button" id = "reCalButton" class="h_1" value="垫付重算" <au:authorityBtn code="dfcx_dfcs" type="1"/> onClick="reCal();" />
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinpaymentAction.do?cmd=searchFinpaymentData1" 
        width="98%"
        height="318px"
        xpath="FinpaymentVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="id" label="id" width="0"></r:field>
      <r:field fieldName="receiver_type_bd" messagekey="receiver_type_bd">
      <d:select dictTypeId="RECEIVER_TYPE_BD"></d:select>
      </r:field>
      <r:field fieldName="receiver_name" messagekey="receiver_name_">
        <h:text/>
      </r:field>
      <r:field fieldName="payment_type_bd" messagekey="payment_type_bd" >
        <d:select dictTypeId="PAYMENT_TYPE_BD"></d:select>
      </r:field>
       <r:field fieldName="invoice_num" messagekey="invoice_num" >
        <h:text/>
      </r:field>     
      <r:field fieldName="apply_amount" messagekey="apply_amount_1" >
        <h:text/>
      </r:field>
      <r:field fieldName="applyusername" messagekey="apply_user_name" >
       <h:text/>
      </r:field>
      <r:field fieldName="create_date" messagekey="apply_date" >
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      
      <r:field fieldName="audit_amount" messagekey="apply_amount_" >
        <h:text/>
      </r:field>
      <r:field fieldName="reimburse_amount" messagekey="reimburse_amount" >
       <h:text/>
      </r:field>
      <r:field fieldName="reimburse_status_bd" messagekey="reimburse_status_bd">
        <d:select dictTypeId="REIMBURSE_STATUS_BD"></d:select>
      </r:field>
      <r:field fieldName="reimburse_finished_date" messagekey="reimburse_finished_date"  width="130px" >
        <w:date/>
      </r:field>
      <r:field fieldName="payment_purpose" messagekey="payment_purpose" width="250px">
        <h:text/>
      </r:field>       
    </r:datacell>
    </div>
</div>
</div>
</form>

</body>
</fmt:bundle>
</html>

