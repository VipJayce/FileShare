<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%@ page import="gap.rm.tools.helper.RmStringHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.finpaymentmanage.finpayment.finpayment_resource" prefix="rayoo.finance.finpaymentmanage.finpayment.">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>

</head>


<%
String payment_type_bd=request.getParameter("payment_type_bd");
String wfname="";
String wfname1="";
if((payment_type_bd!=null&&"1".equals(payment_type_bd))||(payment_type_bd!=null&&"2".equals(payment_type_bd))){
    wfname="SheBaoGongJiJinPayWorkFlow";
    wfname1="SheBaoGongJiJinPayWorkFlow";
    request.setAttribute("wfname",wfname);
    request.setAttribute("wfname1",wfname1);
}else{
    wfname="PayWorkFlow";
    wfname1="PayWorkFlow";
    request.setAttribute("wfname",wfname);
    request.setAttribute("wfname1",wfname1);
}
%>
<body>
<form name="form" id="datacell_formid" method="post">
	<div class="ringht_s">
				<div id="ccChild0" class="search" >
				<table align="left" style="width: 100%;height: 60px;" border="0" cellspacing="0" cellpadding="0">
				 <tr>
		            <td width="128" rowspan="5" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
		            <td width="114"/>
		            <td width="148"/>
	                <td width="107"/>    
	                <td width="247"/>
                </tr>
                <tr style="font-size: 12px;height: 27px;"> 
	                  <td align="right" >唯一号</td>
                      <td align="left"><input type="text" class="text_field" style="margin-right: 25px;" name="emp_code_s" maxLength="50" value=""/></td>
                    <td align="right">姓名</td>
                    <td align="left"><input type="text" class="text_field" name="emp_name_s" maxLength="50" value=""/></td>
                </tr>
                <tr style="font-size: 12px;height: 27px;">
                    <td align="right">产品</td>
                    <td align="left"><input type="text" class="text_field" style="margin-right: 25px;" name="product_name_s" maxLength="50" value=""/></td>
                    <td align="right">实收金额范围</td>
                    <td align="left">
                        <input type="text" style="width: 100px;" name="amountFrom" class="text_field" maxLength="50" value=""/>至
                        <input type="text" style="width: 100px;" name="amountTo" class="text_field" maxLength="50" value=""/>
                    </td>
                    <td  align="left">
                            <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">
                            <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset()">
                    </td>
                </tr>
		</table>
	</div>
	<div id="TabCon1">
		      <div id="values_div3" style="width:100%;height:330px; margin:5 0 0 8;">
		                        <r:datacell 
                            id="celllist1"
                            queryAction="/FAERP/FinpaymentitemAction.do?cmd=searchPaymentItemData4Welfare&payment_id=${param.id}"
                            paramFormId="datacell_formid" 
                            width="99%" height="330px" 
                            xpath="FinpaymentitemVo"
                            pageSize="11"
                            >
                    
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="cust_code" messagekey="cust_code" width="90px" allowModify="false">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" messagekey="customer_name" width="180px" allowModify="false">
                            <h:text />
                          </r:field>
                          <r:field fieldName="emp_code" messagekey="emp_code" width="90px" allowModify="false">
                            <h:text />
                          </r:field>
                          <r:field fieldName="emp_name" messagekey="emp_name_" width="90px" allowModify="false">
                            <h:text />
                          </r:field>
                          <r:field fieldName="product_name" messagekey="product_name" width="90px" allowModify="false">
                            <h:text />
                          </r:field>
                          <r:field fieldName="start_month" label="开始月" width="100px">
                          </r:field>
                            <r:field fieldName="end_month" label="结束月" width="100px">
                          </r:field>    
                            <r:field fieldName="bank_name" label="开户行" width="150px">
                          </r:field>
                            <r:field fieldName="account_num" label="帐号" width="130px">
                          </r:field>
                          <r:field fieldName="payment_amount" messagekey="payment_amount" width="90px" allowModify="false">
                            <h:text />
                          </r:field>
                          <r:field fieldName="amount" messagekey="amount" width="90px" allowModify="false">
                            <h:text/>
                          </r:field>
                        </r:datacell>
        </div>
</div>

<%
if(!payment_type_bd.equals("4")){
%>
 <div style="margin:5 0 5 8;"><fmt:message key='title_approveinfo'/></div>
              <div id="TabCon1">
              <div id="values_div3" style="width:100%;height:200px; margin:3 0 20 8;">
                               <r:datacell 
                            queryAction="/FAERP/SalcontractAction.do?cmd=getSalcontractSPInto&contract_id=${param.id}&wfname=${requestScope.wfname}&wfname1=${requestScope.wfname1}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="99%" height="220px" 
                            xpath="GapwfWorkItem" readonly="true">
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="activityname" messagekey="activityname" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="performername" messagekey="performername" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="statereason" messagekey="statereason" width="300px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="createddate" messagekey="createddate" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                          <r:field fieldName="completeddate" messagekey="completeddate" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                         
                          <r:field fieldName="state" messagekey="state" width="100px">
                            <h:text/>
                          </r:field>
                        </r:datacell>
        </div>
</div>
<%
}
%>
</div>
	</form>

<script language="javascript">
_$(document).ready(function() {
     if($id("celllist1")==null)return;
    $id("celllist1").afterRefresh = function(){
        var Me = $id("celllist1");
        var rows = Me.allTR;
        //合计行不进行操作
        for (var i=0;i<rows.length-1;i++ ){
          var entity1 = Me.dataset.get(i);
          var cells = rows[i].cells;
          for (var j=0;j<cells.length;j++ ){
            var cell = cells[j];
            var field = Me.getField(cell);
            var payment_amount;
            var amount;
            if(field.fieldName=="payment_amount"){
                payment_amount =entity1.getProperty(field.fieldName);
            }
            if(field.fieldName=="amount"){
                amount =entity1.getProperty(field.fieldName);
                  if (payment_amount != amount) {
                        cell.firstChild.title = "<fmt:message key='payment_amount_tip'/>" + (payment_amount -amount);
                        cell.style.backgroundColor = "red";
                  }
            }
          }
        }        
        //增加合计内容
        //addCountData();
    }
});

//查询按钮，简单模糊查询
 function showListData(){
     $id("celllist1").loadData();
     $id("celllist1").refresh();
 }
 
 $id("celllist1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
     //如果双击的不是合计行
	 if($id("celllist1").getCurrentRowCount() != (rowNo+1)){
	    var service_year_month = entity.getValue("service_year_month");
	    var product_id = entity.getValue("product_id");
	    var emp_post_id = entity.getValue("emp_post_id");
	    var url = "<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finbillitem/finbillitemDetail.jsp?service_year_month="+service_year_month+"&product_id="+product_id+"&emp_post_id="+emp_post_id;
	    //window.open(url, "Sample","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,copyhistory=yes,width=900,height=400left=100,top=20");
	    showModalCenter(url, window, "", 900, 400, "订单详情");
	 }
    
}
//添加合计
/**function addCountData(){
    var url = "<%=request.getContextPath()%>/FinpaymentitemAction.do?cmd=ajaxCountMoneyData&payment_id=<%=RmStringHelper.prt(request.getParameter("id"))%>";
    _$.ajax({
           type : "post",
           url : url,
           dataType : "html",
           success : function(data) {
             //员工金额总计
             var p_money_count = cutStr(data,"p_money_count");
             //客户金额总计
             var e_money_count = cutStr(data,"e_money_count");
             //总和统计
             var payment_amount_count = cutStr(data,"payment_amount_count");
             //实收金额统计
             var actual_amount_count = cutStr(data,"actual_amount_count");
             var dc = $id("celllist1");
             dc.addRow();
             dc.endEdit();
             //获得datacell的总记录数
             var rc = dc.getCurrentRowCount();
             //给合计行设值
             dc.setCellValue(dc.getCell(rc-1,1),"合计");
             dc.setCellValue(dc.getCell(rc-1,6),p_money_count);
             dc.setCellValue(dc.getCell(rc-1,7),e_money_count);
             dc.setCellValue(dc.getCell(rc-1,8),payment_amount_count);
             dc.setCellValue(dc.getCell(rc-1,9),actual_amount_count);
           }
     });
}

//截取字符串 startStr为返回的key的值(注意startStr不要有模糊的值 如a 与ab) str为整个字符串
function cutStr(str,startStr){
    //找到符合字符串的下标
    var strSub = str.indexOf(startStr);
    //从key开始截取字符串
    var cutStr = str.substring(strSub+startStr.length+2);
    //找到对应value后面,的下标
    var strValueSub = cutStr.indexOf(',');
    //获得value的值
    if(strValueSub != -1){
        var strValue = cutStr.substring(1,strValueSub-1);
    }else{
        //因为type后面没有逗号 所以直接出去最后的 “}拿值
        var strValue = cutStr.substring(1,cutStr.length-2);
    }
    return strValue;
}**/
</script>

</fmt:bundle>