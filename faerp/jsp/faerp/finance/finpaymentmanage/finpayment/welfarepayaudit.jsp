<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
    //判断是否为修改页面
    FinpaymentVo resultVo = null; //定义一个临时的vo变量
    boolean isModify = false; //定义变量,标识本页面是否修改(或者新增)
    if (request.getParameter("isModify") != null) { //如果从request获得参数"isModify"不为空
        isModify = true; //赋值isModify为true
        if (request.getAttribute(IFinpaymentConstants.REQUEST_BEAN) != null) { //如果request中取出的bean不为空
            resultVo = (FinpaymentVo) request
                    .getAttribute(IFinpaymentConstants.REQUEST_BEAN); //从request中取出vo, 赋值给resultVo
        }
    }
%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	   if(checkAllForms()){
           form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=insert";
           form.submit();
           return true ;
		}
	}
  	function submit_onClick(){  //保存修改后的单条数据
  	var type_bd2=jQuery('input:radio[name="type_bd2"]:checked').val(); 
	  	if(type_bd2=="1"){
	  	        if(checkAllForms()){
		            form.action="<%=request.getContextPath()%>/payWorkFlowAction.do?cmd=backOperate";
		            form.submit();
		        }
	  	}else{
	  	         if(checkAllForms()){
                    form.action="<%=request.getContextPath()%>/payWorkFlowAction.do?cmd=appOperate";
                    form.submit();
                }
	  	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=toListPage";
        form.submit();
    }
    
</script>
</head>
<body>
<form name="form" id="datacell_formid" method="post">

<div id="right">
<script language="javascript">
       writeTableTopFesco('支付审核','<%=request.getContextPath()%>/');
</script> 
<script type="text/javascript">
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


        //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
      var message =addAppReason("<%=request.getContextPath()%>");
      //alert('message='+message);
      if(message==null)return;
        //alert('操作成功！');
        form.action="<venus:base/>/FinpaymentAction.do?message="+message[0];
        document.getElementById("cmd").value="appOperate";
        form.submit();
         
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/FinpaymentAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
    }
    
</script> 
	<div class="ringht_s">
	<div id="ccChild1" class="box_xinzeng" style="height:330px; overflow-y:hidden;">
	<table width="100%" height="35" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">申请人</td>
			<td class="td_2"><input type="text" style="width:190px"
				class="text_field_reference_readonly" validators="isSearch"
				hiddenInputId="product_supplier" name="apply_user_name"
				inputName="申请人" maxLength="10" readonly="true" 
				value="<%=OrgHelper.getPartyVoByID(resultVo.getApply_user_id().toString()).getName()%>" />
				</td>
				    <input type="hidden" name="apply_user_id" id="apply_user_id">
				    <input type="hidden" name="taskuid" value="${taskuid}">
				    <input type="hidden" name="cmd">
                    
			<td class="td_1">受款方类型</td>
			<td class="td_2">
			<d:select dictTypeId="RECEIVER_TYPE_BD" property="receiver_type_bd"  value="${bean.receiver_type_bd}" id="receiver_type_bd" style="width:190px" nullLabel="--请选择--" disabled="true"/>
            </td>
            <td class="td_1">受款方</td>
            <td class="td_2"><input name="receiver_name" inputName="受款方"
                type="text" class="sText" id="receiver_name" value="${bean.receiver_name}" /></td>
		</tr>
		<tr>
			<td class="td_1">付费类型</td>
			<td class="td_2">
			<d:select dictTypeId="PAYMENT_TYPE_BD" property="payment_type_bd"  value="${bean.payment_type_bd}" id="payment_type_bd" style="width:190px" nullLabel="--请选择--" disabled="true"/>
			<td class="td_1">单据数量</td>
			<td class="td_2"><input name="invoice_num" inputName="单据数量" type="text"  readonly="readonly"  class="sText" id="invoice_num" value="${bean.invoice_num}" validate="notNull;isNum;" maxLength="8" onkeyup="if(isNaN(value))execCommand('undo')"/></td>
			<td class="td_1">申请支付金额</td>
			<td class="td_2"><input name="apply_amount" inputName="申请支付金额"
				type="text" class="sText" id="apply_amount" value="${bean.apply_amount}" maxLength="8" onkeyup="if(isNaN(value))execCommand('undo')" validate="notNull;"  readonly="readonly"  readonly="readonly"/></td>
		</tr>
		<tr>
			<td class="td_1">申请日期</td>
			<td class="td_2"><w:date name="apply_date" format="yyyy-MM-dd" width="170px" property="bean/apply_date" readOnly="true"/>
			</td>
			<td class="td_1">垫付状态</td>
			<td class="td_2">
			<d:select dictTypeId="REIMBURSE_STATUS_BD" property="reimburse_status_bd"  value="${bean.reimburse_status_bd}" id="reimburse_status_bd" style="width:190px" nullLabel="--请选择--" disabled="true" />
			</td>
			<td class="td_1">垫付金额</td>
			<td class="td_2"><input name="reimburse_amount" inputName="受款方" type="text" class="sText" id="reimburse_amount" value="${bean.reimburse_amount}" readonly="readonly" /></td>
		</tr>
		<tr>
            <td class="td_1">支付年月</td>
            <td class="td_2"><input name="payment_month" inputName="支付年月"
                type="text" class="sText" id="payment_month" value="${bean.payment_month}" readonly="readonly"/></td>
             <td class="td_1"></td>
             <td  class="td_2"></td>
             <td class="td_1"></td>
             <td  class="td_2"></td>
        </tr>
        <tr>
            <td class="td_1">付款用途</td>
            <td colspan="5" class="td_2"><textarea name="payment_purpose" style="width:99%;color: black;" readonly="readonly"
                inputName="付款用途" rows="3" class="xText_d" id="payment_purpose">${bean.payment_purpose}</textarea></td>
        </tr>
		<tr>
			<td class="td_1">付款原因</td>
			<td colspan="5" class="td_2"><textarea name="payment_reason" style="width:99%;color: black;" readonly="readonly"
				inputName="付款原因" rows="3" class="xText_d" id="payment_reason">${bean.payment_reason}</textarea></td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="5" class="td_2"><textarea name="payment_desc" style="width:99%;color: black;" readonly="readonly"
				inputName="备注" rows="3" class="xText_d" id="payment_desc">${bean.payment_desc}</textarea></td>
		</tr>
	</table>
	</div>
	           <div class="social_tab">
                  <%
				    if(resultVo.getIs_have_item()!=null&&!resultVo.getIs_have_item().equals("null")){
		          %>
               <div>支付明细</div>
              
                <div class="button" style="padding: 5 0 0 0;">
			       <div class="button_right">
			           <ul>
			             <li class="e_3"><a href="###" onClick="javascript:exportEXCEL_onClick('${bean.id}');">导出excel</a></li>
			           </ul>
			         <div class="clear"></div>
			       </div>
			    </div>
    
		      <div id="TabCon1">
		      <div id="values_div3" style="width:100%;height:200px; margin-top:5px;">
		                        <r:datacell 
                            id="celllist1"
                            queryAction="/FAERP/FinpaymentitemAction.do?cmd=searchPaymentItemData4Welfare&payment_id=${bean.id}"
                            paramFormId="datacell_formid" 
                            width="100%" height="305px" 
                            xpath="FinpaymentitemVo"
                            readonly="true"
                            >
                    
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="cust_code" label="客户编号" width="100px">
                          </r:field>
                          <r:field fieldName="cust_name" label="客户名称" width="200px">
                          </r:field>
                          <r:field fieldName="emp_code" label="员工编号" width="100px">
                          </r:field>
                          <r:field fieldName="emp_name" label="员工姓名" width="100px">
                          </r:field>
                          <r:field fieldName="product_name" label="产品名称" width="100px">
                          </r:field>
                            <r:field fieldName="start_month" label="开始月" width="100px">
                          </r:field>
                            <r:field fieldName="end_month" label="结束月" width="100px">
                          </r:field>    
                            <r:field fieldName="bank_name" label="开户行" width="150px">
                          </r:field>
                            <r:field fieldName="account_num" label="帐号" width="130px">
                          </r:field>
                           <r:field fieldName="payment_amount" label="总额" width="100px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="amount" label="实收金额" width="100px">
                          </r:field>
                        </r:datacell>
        </div>
        </div>
             <%
                    }
             %> 
             
             <div style="margin:5 0 0 0;">审批信息</div>
             <div style="margin:5 0 0 0;">
                            <r:datacell 
                            queryAction="/FAERP/SalcontractAction.do?cmd=getSalcontractSPInto&contract_id=${bean.id}&wfname=PayWorkFlow&wfname1=PayWorkFlow"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="98%" height="220px" 
                            xpath="GapwfWorkItem" readonly="true">
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="activityname" label="任务名" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="performername" label="任务处理人" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="statereason" label="审批意见" width="300px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="createddate" label="任务发起时间" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                          <r:field fieldName="completeddate" label="任务完成时间" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                         
                          <r:field fieldName="state" label="当前状态" width="100px">
                            <h:text/>
                          </r:field>
                        </r:datacell>
            </div>

      <div class="foot_button">
        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <%
        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
        %>
        <input name="button_app" class="foot_icon_2" type="button" value="审批"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
        <%} %>
      </div>


    </div>
    
</div>
</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
_$(document).ready(function() {
     if($id("celllist1")==null)return;
    $id("celllist1").afterRefresh = function(){
        var Me = $id("celllist1");
        var rows = Me.allTR;
        for (var i=0;i<rows.length;i++ ){
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
		                cell.firstChild.title = '垫付：' + (payment_amount -amount);
		                cell.style.backgroundColor = "red";
		          }
            }
          }
        }        
    }
});


  function exportEXCEL_onClick(payment_id){
      if(payment_id != null && payment_id !=""){
           var url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showReportFin_Payment.jsp?raq=Welfare_fin_payment_item.raq&payment_id="+payment_id+"&arg2";
           showModalCenter(url, window, "", screen.width-300, screen.height-350, "导出数据");  
      }else{
         alert("数据异常，请联系管理员！");
         return;
      }
  }


<%  //取出要修改的那条记录，并且回写表单
	//if(isModify) {  //如果本页面是修改页面
	//	out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	//}
%>
</script>
