<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.employeepost.empentry.empsendinfo.empsendinfo_resource" prefix="rayoo.employeepost.empentry.empsendinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="emp_entry"/></title>
</head>
<script type="text/javascript">
jQuery(function(){
    $id("dc_send").isQueryFirst = false;
});
//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);        
    return false;
}
//查看明细
function viewItem(){
    dc = $id("dc_send");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key="select_one_record"/>");
        return ;
    }
    sendId = clz.getValue("id");
    var url="<%=request.getContextPath()%>/empSendListAction.do?cmd=detail&id="+ sendId;
    //showModalCenter("<%=request.getContextPath()%>/empSendListAction.do?cmd=detail&id=" + sendId,null,null,
                                                                                       // 800,500,"委派单详细");
   window.open(url,"","height=550px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key="send_info"/>");
}
//员工派出
function toAddEmpPage() {

	dc = $id("dc_send");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key="select_one_record"/>");
        return ;
    }
    sendId = clz.getValue("id");
    send_name = clz.getValue("send_name");
    custid = clz.getValue("customer_id");
    var customer_code = clz.getValue("customer_code");
    is_tax=clz.getValue("is_tax");
    //2015-3-11 yangyuting add 检查选择的该户是否已经撤户
    var flags=false;
     jQuery.ajax({
           url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=getCustomerIsChehu&customer_code='+customer_code,
           type: 'GET',
           dataType: 'html',
            async: false,
           timeout: 80000,
           error: function(){
               alert('查询该客户是否已经撤户失败， 请联系管理员。');
           },
           success: function(text){
               if(text!=null){     
                  if(text=="1"){
                    alert("您选择的客户已经撤户。如果需要派入请撤消撤户，再进行派入工作！");
                   } 
                   else{
                   flags=true;
                   }
               }else{
                  alert("客户编号不能为空。");
               }
           }
           });
        if(flags==false){
            return;
        } 
          if(is_tax!=null&&is_tax!=""){
                window.open('<%=request.getContextPath()%>/EmpSendInfoAction.do?cmd=toAddEmpPage&id=' + sendId + '&sendName=' +encodeURIComponent(send_name) + '&customer_id=' + custid,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
          }else{
	            alert("<fmt:message key="no_is_tax_property"/>");
	            return;
         }                      
                                

 
}
//导出
function exportEmpSend(){
    $id("sendForm").action = "<%=request.getContextPath()%>/empSendListAction.do";
    $id("h_cmd").value = "export";
    $id("sendForm").submit();
}
//查询
function qrySend(){
	if(qryCheck()){
		$id("dc_send").reload();
	}
    
}
//验证查询条件
function qryCheck(){
    return true;
}
</script>
<body>
<form id="sendForm" method="post">
<input type="hidden" id="h_cmd" name="cmd"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key="emp_entry"/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
      <div class="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="135" rowspan="3" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div></td>
            <td width="80"><fmt:message key="contract_code"/></td>
            <td width="220">
            	<input name="contract_code" class="sText" id="t_contract_code"/>
            </td>
            <td width="60"><fmt:message key="contract_name"/></td>
            <td width="220">
                <input name="contract_name" class="sText" id="t_contract_name"/>
            </td>
            <td width="60"><fmt:message key="contract_type"/></td>
            <td width="220">
                <d:select name="contract_type" dictTypeId="CONTRACT_TYPE_BD" nullLabel="请选择" />
            </td>
          </tr>
          <tr>
            <td width="80"><fmt:message key="send_code"/></td>
            <td width="220"><input name="send_code" class="sText" id="t_send_code"/></td>
            <td width="60"><fmt:message key="send_name"/></td>
            <td width="220">
                <input name="send_name" class="sText" id="t_send_name"/>
            </td>
            <td width="60"><fmt:message key="customer_name"/></td>
            <td width="220">
                <w:lookup name="customer_name" onReturnFunc="rtnFunc" id="lk_clz" 
                lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="500" width="810"/>
            </td>
            <td><input onclick="qrySend()" type="button" class="icon_1" value="<fmt:message key="query"/>" /></td>
          </tr>
        </table>
      </div>
        <!--查询 end-->
        <!--按钮-->
        <div class="button">
            <div class="button_right">
                <!--<ul>
                    <li class="a_2"><a onclick="viewItem()" href="javascript:void(0);">查看委派单</a></li>
                    <li class="p"><a onclick="toAddEmpPage()" href="javascript:void(0);">员工派出</a></li>
                    <li class="e"><a onclick="exportEmpSend()" href="javascript:void(0);">导出</a></li>                    
                </ul>
            -->
            <input class="a_2" type="button"   value="<fmt:message key="view_send"/>"  <au:authorityBtn code="view_send" type="1"/>  onClick="viewItem();">
            <input class="p" type="button"   value="<fmt:message key="emp_entry"/>"  <au:authorityBtn code="emp_SendOut" type="1"/>  onClick="toAddEmpPage();">
            <input class="e" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="emp_SendOut_exp" type="1"/>  onClick="exportEmpSend();">
            </div>
            <div class="clear"></div>
        </div>
        <!--按钮 end-->
        <!--表格 -->
        <r:datacell 
              id="dc_send"
              queryAction="/FAERP/empSendListAction.do?cmd=simpleQuery"
              submitAction="/FAERP/empSendListAction.do?cmd=update"
              width="100%"
              height="320px"
              xpath="SendVo"
              submitXpath="SendVo"
              paramFormId="sendForm"
              readonly="true"
              >
             <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field fieldName="contract_code" messagekey="contract_code">
              </r:field>
               <r:field fieldName="contract_name" messagekey="contract_name" >
              </r:field>
              <r:field fieldName="contract_type_bd" messagekey="contract_type" >
              	<d:select dictTypeId="CONTRACT_TYPE_BD"/>
              </r:field>
              <r:field fieldName="send_code" messagekey="send_code" >
              </r:field>
              <r:field fieldName="send_name" messagekey="send_name" >
              </r:field>
              <r:field fieldName="cust_send_name" messagekey="cust_send_name" >
              </r:field>
              <r:field fieldName="cust_rece_name" messagekey="cust_rece_name" >
              </r:field>
              <r:field fieldName="cust_payee" messagekey="cust_payee" >
              </r:field>
              <r:field fieldName="cust_bill" messagekey="cust_bill" >
              </r:field>
              <r:field fieldName="cost_center_name" messagekey="cost_center_name" >
              </r:field>
              <r:field fieldName="send_cs" messagekey="send_cs" >
              </r:field>
              <r:field fieldName="rece_cs" messagekey="rece_cs" >
              </r:field>
              <r:field fieldName="payment_day" messagekey="payment_day" >
              </r:field>
                 <r:field fieldName="is_tax" messagekey="is_tax"  width="0">
              </r:field>
        </r:datacell>
        <!--表格 end-->
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script type="text/javascript">
$id("dc_send").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    toAddEmpPage();
}
</script>
