<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.vo.SettlementclaimpayVo" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.util.ISettlementclaimpayConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	SettlementclaimpayVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SettlementclaimpayVo)request.getAttribute(ISettlementclaimpayConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	SettlementclaimpayVo totalandamount1 = (SettlementclaimpayVo)request.getAttribute("totalandamount1");
    SettlementclaimpayVo totalandamount2 = (SettlementclaimpayVo)request.getAttribute("totalandamount2");
    SettlementclaimpayVo totalandamountbynocard = (SettlementclaimpayVo)request.getAttribute("totalandamountbynocard");
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
    }
    
    //tab切换
    function setTabSyn ( i ) {
        selectTabSyn(i);
    }
    
    function selectTabSyn ( i ) {    
        var id = document.getElementById("id").value;
        switch(i) {
            case 1:
	            document.getElementById('bg').className='social_xixi1';
	            document.getElementById("TabCon1").style.display="block";
	            document.getElementById("TabCon2").style.display="none";
	            document.getElementById("font1").style.color="#ffffff";
	            document.getElementById("font2").style.color="#000000";
                break;
            case 2:
                /*jQuery.ajax({
	                url: "<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=checksettlementclaimpayState&settlementclaimpay_id="+id+"&date="+new Date()+"",
	                type: 'GET',
	                dataType: 'html',
	                async: false,
	                timeout: 10000,
	                error: function(){
	                    alert('Error loading XML document');
	                    return  null;
	                },
	                success: function(text){  //返回的结果3为审批通过，审批通过才可以查看导出汇总。
	                    if (text!="3") { 
		                   setTabSyn(1);document.getElementById('bg').className='social_xixi1';
		                   alert("该申请单未审批通过，不能查看汇总！");
		                   return;
		                } else {
		                   document.getElementById('bg').className='social_xixi2';
		                   document.getElementById("TabCon1").style.display="none";
		                   document.getElementById("TabCon2").style.display="block";
		                   document.getElementById("font1").style.color="#000000";
		                   document.getElementById("font2").style.color="#ffffff";
		                }
	                }
	            });  */
	            document.getElementById('bg').className='social_xixi2';
                document.getElementById("TabCon1").style.display="none";
                document.getElementById("TabCon2").style.display="block";
                document.getElementById("font1").style.color="#000000";
                document.getElementById("font2").style.color="#ffffff";
	            break;
        }
    }
    
    function exportExcel_onClick(num)
    {
        var id = document.getElementById("id").value;
	    if(confirm('是否确定要导出数据？')) {
		    form.action="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=exportToExcel&settlementclaimpay_id="+id+"&type="+num;
		    form.submit();
	    }
    }
</script>
</head>
<body> 
<form name="form" method="post" id="datacell_formid">	
<input type="hidden" name="id" value="${bean.id}">
       <div id="right">
       <div class="ringht_s">
    	<div class="social_tab">
       <div id="bg" class="social_xixi1">
         <div id="font1" class="social_tab1" onMouseDown="setTabSyn(1);"> 付款申请单详细 </div>
         <div id="font2" class="social_tab2" onMouseDown="setTabSyn(2);"> 付款申请单汇总 </div>
       </div>
       <div id="TabCon1" style="display:block;">
         <!--表格1-->
         <div class="xz_title" style="margin-top:10px;">付款申请单详细</div>
<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="10%">付款单编号</td>
			<td class="td_2" width="20%"><%=RmStringHelper.prt(resultVo.getSett_claim_pay_code())%></td>			
			<td class="td_1" width="10%">批次号</td>
			<td class="td_2" width="20%"><%=RmStringHelper.prt(resultVo.getBatch_num())%></td>
			<td class="td_1" width="10%">保险公司</td>
            <td class="td_2" width="30%"><%=RmStringHelper.prt(resultVo.getInsurance_agent_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >付款类型</td>
			<td class="td_2" ><%=BaseDataHelper.getNameByCode("PAY_TYPE",String.valueOf(resultVo.getPay_type())) %></td>
			<td class="td_1" >审批状态</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("APPROVAL_STATE_BD",String.valueOf(resultVo.getApproval_state())) %></td>
            <td class="td_1" >本次合计</td>
            <td class="td_2"><%=RmStringHelper.prt(resultVo.getTotal_count())%></td>
		</tr>
		<tr>
			<td class="td_1" >备注</td>
			<td class="td_2" colspan="5"><%=RmStringHelper.prt(resultVo.getRemark())%>&nbsp;</td>
		</tr>
	</table>
</div>
<div id="values_div"> 
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SettlementclaimpayAction.do?cmd=searchSettlementclaimpayData&payid=${bean.id}"
        width="98%"
        height="302px"
        xpath="SettlementclaimpayVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" width="200px" label="员工姓名">
      </r:field>
      <r:field fieldName="account_num" width="200px" label="银行账号">
      </r:field>
      <r:field fieldName="bank_name" width="200px" label="开户行">
      </r:field>
      <r:field fieldName="amount" width="130px" label="金额">
      </r:field>
    </r:datacell>
</div>
<div class="foot_button"><input type="button" class="foot_icon_1" value='关闭'  onclick="javascript:back_onClick();" /></div>
</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">


<div id="TabCon2" style="display:none;">
         <div class="xz_title" style="margin-top:10px;">付款申请单汇总 </div>  
         <div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="10%">工行笔数</td>
            <td class="td_2" width="20%"><%=RmStringHelper.prt(totalandamount1.getTotal_number())%></td>            
            <td class="td_1" width="10%">工行总金额</td>
            <td class="td_2" width="20%"><%=RmStringHelper.prt(totalandamount1.getTotal_amount()) %></td>
        </tr>
        <tr>
            <td class="td_1" >招行或它行笔数</td>
            <td class="td_2" ><%=RmStringHelper.prt(totalandamount2.getTotal_number())%></td>
            <td class="td_1" >招行或它行总金额</td>
            <td class="td_2" ><%=RmStringHelper.prt(totalandamount2.getTotal_amount())%></td>
        </tr>
        <tr>
            <td class="td_1" >无生产笔数</td>
            <td class="td_2" ><%=RmStringHelper.prt(totalandamountbynocard.getTotal_number()) %></td>
            <td class="td_1" >无生产总金额</td>
            <td class="td_2" ><%=RmStringHelper.prt(totalandamountbynocard.getTotal_amount())%></td>
        </tr>
        <tr>
            <td class="td_1" >合计总金额</td>
            <td class="td_2" colspan="4"><%=RmStringHelper.prt(resultVo.getTotal_count())%></td>
        </tr>
    </table>
</div>
        <div class="button_right">
                <ul>
                    <li class="e">     <a  onClick="javascript:exportExcel_onClick(1);"><fmt:message key="export" /> </a> </li>                    
                </ul>  
                <ul>
                    <li class="e_3">     <a  onClick="javascript:exportExcel_onClick(2);">财务导出 </a> </li>                    
                </ul>               
         </div>                 
<div id="values_div"> 
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/SettlementclaimpayAction.do?cmd=findSettlementclaimpaytotalData&payid=${bean.id}"
        width="98%"
        height="318px"
        xpath="SettlementclaimpayVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" width="100px" label="员工姓名">
      </r:field>
      <r:field fieldName="account_num" width="140px" label="银行账号">
      </r:field>
      <r:field fieldName="bank_name" width="160px" label="开户行">
      </r:field>
      <r:field fieldName="amount" width="80px" label="金额">
      </r:field>
      <r:field fieldName="id_card" width="110px" label="员工身份证">
      </r:field>
      <r:field fieldName="customer_name" width="140px" label="公司名称">
      </r:field>
    </r:datacell>
</div>
<div class="foot_button"><input type="button" class="foot_icon_1" value='关闭'  onclick="javascript:back_onClick();" /></div>
</div></div></div></div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	/*jQuery(document).ready(function() {
    $id("datacell1").afterRefresh = function() {
          var total=0;
          var Me = $id("datacell1");
          var rows = Me.allTR;
          for (var i=0;i<rows.length;i++ ){
            var entity1 = Me.dataset.get(i);
            total += parseFloat(entity1.getProperty("amount"));
          }          
          document.getElementById("total_count").innerHTML = total;
    }
});*/
</script>
</body>
</html>
