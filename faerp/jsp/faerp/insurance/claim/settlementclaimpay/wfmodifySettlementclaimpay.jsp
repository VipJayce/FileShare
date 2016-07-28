<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.vo.SettlementclaimpayVo" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.util.ISettlementclaimpayConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	SettlementclaimpayVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISettlementclaimpayConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SettlementclaimpayVo)request.getAttribute(ISettlementclaimpayConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
	String insurId ="";
	String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=update";
    	form.submit();
    	}
	}
    
    //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    
    //审批操作
    function saveAndagainApproval_onClick(){
     if(checkAllForms()){
        var message =addAppReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/SettlementclaimpayAction.do?message="+message[0];
        document.getElementById("cmd").value="saveAndAgainApproval";
        form.submit();
     }
    }
    
    //撤销操作
    function cancelOperate_onClick(){
        //撤销原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/SettlementclaimpayAction.do?message="+message[0];
        document.getElementById("cmd").value="cancelOperate";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">
 <input  type="hidden"  value="" name="cmd" id="cmd"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
<table class="table_noFrame" >
    <tr>
         <td >
        <input name="button_back" style="background: url(/FAERP/images/templatestyle/btnbg.jpg); BORDER-BOTTOM: #4999d8 1px solid;" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <input name="button_app" style="background: url(/FAERP/images/templatestyle/btnbg.jpg); BORDER-BOTTOM: #4999d8 1px solid;" type="button" value="保存并重提审批"  onclick="javascript:saveAndagainApproval_onClick();" >
        <input name="button_back" style="background: url(/FAERP/images/templatestyle/btnbg.jpg); BORDER-BOTTOM: #4999d8 1px solid;" type="button" value="撤销"  onclick="javascript:cancelOperate_onClick();" >
        </td>
    </tr>
</table>

<div id="right">
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>付款单编号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sett_claim_pay_code" inputName="付款单编号" maxLength="64"  readonly="readonly""/>
			</td>
			<td class="td_1" ><span class="style_required_red">* </span>批次号 </td>
            <td class="td_2 ">
               <input type="text" class="text_field" name="batch_num" inputName="批次号 " value="" maxLength="250" validate="notNull;" readonly="readonly"/>    
            </td>
			<td class="td_1" ><span class="style_required_red">* </span>保险公司</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="insurance_agent_name" inputName="保险公司" readonly="readonly" value="" maxLength="64" validate="notNull;"/>
				<input type="hidden" name="insurance_agent_id" id="insurance_agent_id">
            </td>			
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>付款类型</td>
			<td class="td_2 ">
			     <d:select dictTypeId="PAY_TYPE" name="pay_type" property="bean/pay_type" />
			</td>
			<td class="td_1" >本次合计</td>
            <td class="td_2"><input type="text" class="text_field" name="total_count" inputName="本次合计" maxLength="64"  readonly="readonly""/></td>
			<td class="td_1" >&nbsp;</td>
            <td class="td_2">&nbsp;</td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="5" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="2" name="remark" inputName="备注" maxLength="1000" ></textarea>
			</td>
		</tr>
	</table>
	<div id="values_div"> 
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SettlementclaimpayAction.do?cmd=searchSettlementclaimpayData&payid=${bean.id}"
        submitAction="/FAERP/SettlementclaimpayAction.do?cmd=insert"
        width="98%"
        height="450px"
        xpath="SettlementclaimpayVo"
        submitXpath="SettlementclaimpayVo"
        paramFormId="datacell_formid"
        >  
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" width="240px" label="员工姓名">
      </r:field>
      <r:field fieldName="account_num" width="296px" label="银行账号">
      </r:field>
      <r:field fieldName="bank_name" width="300px" label="开户行">
      </r:field>
      <r:field fieldName="amount" width="180px" label="金额">
      </r:field>
      <r:field fieldName="item_batch_num" width="0px" label="">
      </r:field>
      <r:field fieldName="emp_code" width="0px" label="">
      </r:field>
      <r:field fieldName="emp_id" width="0px" label="">
      </r:field>
      <r:field fieldName="invoice_code" width="0px" label="">
      </r:field>
      <r:field fieldName="id_card" width="0px" label="">
      </r:field>
    </r:datacell>
</div>	
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />
<input type="hidden" name="company_id" />
<input type="hidden" name="approval_state" />
<input type="hidden" name="create_dept" />
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
		System.out.println("insurId"+insurId+"****"+resultVo.getInsurance_agent_id());          
		if(insurId.equals(resultVo.getInsurance_agent_id())){            
%>
    document.getElementById("insurance_agent_id").selected="selected";
<%}}%>
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
