<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支付审核列表</title>
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
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }
    
    function toPayAudit_onClick(){
    entity=choose_row("datacell1");
    var tid=entity.getProperty("id");
    //alert("tid="+tid);
     form.action="<%=request.getContextPath()%>/FinpaymentAction.do?id=" + tid;
     form.cmd.value = "find";
     form.submit();
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="">
<div id="right">
	<script language="javascript">
		writeTableTopFesco('支付审核列表','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right">受款客户</td>
            <td align="left">    
            <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_id" name="cust_id" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/>
            </td>
            <td align="right">受款员工</td>
            <td align="left">
             <w:lookup onReturnFunc="rtnFuncUser" readonly="true" id="emp_id" name="emp_id" lookupUrl="/FinpaymentAction.do?cmd=userpop" dialogTitle="选择员工" height="440" width="600" style="width:170px"/>
             </td>
            <td width="100" align="right">受款方名称</td>
            <td width="213" align="left">
            <input type="text" class="text_field" name="receiver_name" inputName="受款方名称" maxLength="50" value=""/>
            </td>
        </tr>
        
        
        <tr>
            <td align="right">付款类型</td>
            <td align="left">
                <d:select dictTypeId="PAYMENT_TYPE_BD"  property="payment_type_bd" id="payment_type_bd" nullLabel="--请选择--" style="width:190px"/>
            </td>
            <td align="right">受款方类型</td>
            <td align="left">
               <d:select dictTypeId="RECEIVER_TYPE_BD"  property="receiver_type_bd" id="receiver_type_bd" nullLabel="--请选择--" style="width:190px"/>
           </td>
           <td align="right">&nbsp;</td>
           <td align="left">&nbsp;</td>
        </tr>
        
        <tr>
            <td/>
            <td/>
              <td>&nbsp;</td>
                <td/><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
        </tr>
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="h_1">      <a  onClick="javascript:toPayAudit_onClick();">支付审核</a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinpaymentAction.do?cmd=searchFinpaymentData"
        width="98%"
        height="304px"
        xpath="FinpaymentVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="payment_type_bd" label="付款类型" >
        <d:select dictTypeId="PAYMENT_TYPE_BD"></d:select>
      </r:field>
      <r:field fieldName="receiver_type_bd" label="受款方类型">
      <d:select dictTypeId="RECEIVER_TYPE_BD"></d:select>
      </r:field>
      <r:field fieldName="receiver_name" label="受款方名称">
        <h:text/>
      </r:field>
      <r:field fieldName="apply_amount" label="申请付款金额" >
        <h:text/>
      </r:field>
      <r:field fieldName="apply_date" label="申请日期" >
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="audit_status" label="流程进度" >
        <h:text/>
      </r:field>
      <r:field fieldName="cashier_operate_date" label="启动时间" >
       <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="applyusername" label="启动者" >
       <h:text/>
      </r:field>
      <r:field fieldName="payment_purpose" label="付款用途">
        <h:text/>
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

