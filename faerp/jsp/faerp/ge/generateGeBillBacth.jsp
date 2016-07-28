<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>

<html>
    <fmt:bundle basename="" prefix="">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
  	
    function generatebill_onClick(dotype){
    var bill_year_month = $id("bill_year_month").value ;
    var cust_service_man=$id("customer_service").getValue() ;
    var cust_group=document.getElementById("cust_group").value;
    var flagBill = false;
   if (bill_year_month  == null ||bill_year_month==""){
       alert("账单年月不能为空!") ;
       return false ;
    }
    if (cust_service_man  == null||cust_service_man ==""){
       alert("客服不能为空!") ;
       return false ;
    }
    if(cust_group==null ||  cust_group==""){
        alert("请选择客户组!");
        return false;
    }
    $id("exportbutton").disabled="disabled"  ;
    $id("exportbutton1").disabled="disabled"  ;
    if(dotype=="1"){
        _$.ajax({
                type : "post",
                url : "/FAERP/BillCreateAction.do?cmd=generateBillThreadGEBatch&bill_year_month="+bill_year_month+"&cust_service_man="+cust_service_man+"&dotype="+dotype+"&cust_group="+cust_group+"&flag_Bill="+flagBill,
                dataType : "html",
                success : function(data) {
                    alert(data) ;
                    $id("exportbutton").disabled=""  ;
                    $id("exportbutton1").disabled=""  ;
                }
        });
    }
    if(dotype=="2"){
        _$.ajax({
        type : "post",
        url : "/FAERP/BillCreateAction.do?cmd=generateBillGECheck&bill_year_month="+bill_year_month+"&cust_service_man="+cust_service_man+"&dotype="+dotype+"&cust_group="+cust_group,
        dataType : "html",
        async:false,
        success : function(data) {
            //alert(data) ;
            if(data==null || data==""){
                flagBill = false;
                //alert(flagBill) ;
                _$.ajax({
                type : "post",
                url : "/FAERP/BillCreateAction.do?cmd=generateBillThreadGEBatch&bill_year_month="+bill_year_month+"&cust_service_man="+cust_service_man+"&dotype="+dotype+"&cust_group="+cust_group+"&flag_Bill="+flagBill,
                dataType : "html",
                success : function(data) {
                    alert(data) ;
                    $id("exportbutton").disabled=""  ;
                    $id("exportbutton1").disabled=""  ;
                }
                });
            }else{
                flagBill = true;
                //alert(flagBill) ;
                var dataString  = formatData(data);
                 if(confirm("以下账单数据财务已入账，是否继续账单计算！"+"\n\r"+dataString)){
//                    _$.ajax({
//                    type : "post",
//                    url :"/FAERP/BillCreateAction.do?cmd=sendEmailToARTeam&data="+data,
//                    dataType : "html",
//                    async:false,
//                    success : function(dt) {
//                        alert("已邮件通知AR取消入账，其他账单正在重算中。");
//                        alert(dt);
//                    } });
                    _$.ajax({
                   type : "post",
                   url : "/FAERP/BillCreateAction.do?cmd=generateBillThreadGEBatch&bill_year_month="+bill_year_month+"&cust_service_man="+cust_service_man+"&dotype="+dotype+"&cust_group="+cust_group+"&flag_Bill="+flagBill,
                   dataType : "html",
                   success : function(data) {
                    alert(data) ;
                    $id("exportbutton").disabled=""  ;
                    $id("exportbutton1").disabled=""  ;
                   }});
                 }
            }
        }
    });
    }
    }
    
    function formatData(data){
        var dataJson = eval("(" + data + ")");
        //var dataString = "账单金额"+"                "+"客户编号"+"\n\r";
        var dataString = "账单编号为：";
        for(var i=0;i<dataJson.length;i++){
            var custCode = dataJson[i].custCode;
            var billAmount = dataJson[i].billAmount.toString();
            var billCode = dataJson[i].billCode;
            if(custCode.length<20){
                var custLength = custCode.length;
                for(var x=0;x<20-(custLength);x++){  
                    custCode += "=";  
                } 
            }
            //dataString += billAmount+custCode+"\n\r";
            if(i<dataJson.length-1){
                dataString += billCode+"、";
            }else{
                dataString += billCode
            }
        }
        //alert(dataString);
        return dataString;
    }
    
	
</script>
	</head>
	<body>

<form name="form" method="post" id="datacell_formid">
	<div id="right">
	<script language="javascript">
	   writeTableTopFesco("批量生成GE账单",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<div class="ringht_s">
	&nbsp;
	&nbsp;
	&nbsp;
	&nbsp;
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0"
				cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1"><span style="color: red">*</span>账单年月</td>
					<td class="td_2">
					   <input type="text" class="text_field" name="bill_year_month" id="bill_year_month" inputName="账单年月" maxLength="50" value=""/>
					</td>
				     <td   class="td_1"><span style="color: red">*</span>客服</td>
                      <td  class="td_2">
                         <r:comboSelect id="customer_service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                          textField="name" valueField="partyid" xpath="Partyrelation" width="170px" messagekey="please_select" />
                      </td>
		            </tr>
		            <tr>
		            <td class="td_1"><span style="color: red">*</span>客户组</td>
		            <td class="td_2">
		            <r:comboSelect id="cust_group" name="cust_group" queryAction="/FAERP/Cust_groupAction.do?cmd=queryListCustname"
                      textField="cust_group_name" valueField="cust_group_code" xpath="Cust_groupVo" width="200px"  messagekey="please_select"/> 
		            </td>
		            <td class="td_1"></td>
                    <td class="td_2"></td>
		            </tr>
			</table>
			</div>
			<div class="foot_button">
			     <input  id="exportbutton"  class="icon_1" type="button"    value="生成账单"    onClick="generatebill_onClick(1);">
			     &nbsp;&nbsp;&nbsp;
			     <input  id="exportbutton1"  class="icon_1" type="button"    value="重算账单"    onClick="generatebill_onClick(2);">
			</div>
			</div>
			</td>
		</tr>
	</table>
	
	</form>
</fmt:bundle>
</body>
</html>
