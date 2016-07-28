<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
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
    
    String party_id=LoginHelper.getPartyId(request);
    String detp_name=rayoo.common.pub.PubHelper.getDepartmentNameByUserPartyId(party_id);
    System.out.println(party_id+"detp_name:"+detp_name);
%>
<html>
<fmt:bundle basename="rayoo.finance.finpaymentmanage.finpayment.finpayment_resource" prefix="rayoo.finance.finpaymentmanage.finpayment.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	   if(checkAllForms()){
           form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=insert";//&total_amount="+$id("total_amount").value;
           form.submit();
           return true ;
		}
	}
  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function checkAllForms() {
	    var checkResult = true;
	    rmTempStatusIsAlert = false;
	    rmTempStatusIsFocus = false;
	    setAllVenusInputsDefault();
	    var payment_type_bd = $id("payment_type_bd").value;
	    var cust_id = $id("cust_id").value;
	    if(payment_type_bd == null || payment_type_bd == "" || payment_type_bd == "null"){
	       alert("请选择付费类型！");
           checkResult = false;
	    }else if((payment_type_bd == "12" || payment_type_bd == "13") && (cust_id == null || cust_id == "" || cust_id == "null")){
	       alert("请选择受款客户！");
	       checkResult = false;
	    }else{
	       for (var i=0;i<document.forms.length;i++) {
            for (var j=0;j<document.forms[i].elements.length;j++) {
	                var thisInput = document.forms[i].elements[j];
	                if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
	                    var rtValue = check(thisInput);
	                    if(checkResult && rtValue == false) {
	                        checkResult = false;
	                    }
	                }
	            }
	        }
	    } 
	    return checkResult;
	}
	
	//编辑支付年月时，触发查询金额
	function setAmount(){
	   var service_year = $id("service_year").value;
	   var payment_type_bd = $id("payment_type_bd").value;
       var cust_id = $id("cust_id").value;
       if(service_year.length>=4){
          checkMonth(service_year);
          if(payment_type_bd == "12" || payment_type_bd == "13"){
             getAmount(cust_id,service_year,payment_type_bd);
          }
	   }
	}
	
	//验证年月格式
	function checkMonth(service_year){
	  if(service_year=="") return true;  
	  var rtn=true;
	  var s=service_year+"";
	  //alert(s.length);
	  if(s.length!=4) rtn=false;
	  if(!/^\d{4}$/.test(service_year)) rtn=false;
	  if(!rtn){
	     alert("请填写正确的年份格式（例如：2013）！");  
	     $id("service_year").value = "";
	  }
	  return rtn;
	}
	
	//当选择付费类型为残保金和欠薪保障金时触发查询金额
	function setAmount1(val){
	   var service_year = $id("service_year").value;
	   var cust_id = $id("cust_id").value;
	   if((val == "12" || val == "13") && service_year != null && service_year != "" && service_year != "null" && cust_id != null && cust_id != "" && cust_id != "null"){
	       getAmount(cust_id,service_year,val);
	   }
	}
	
	//异步获取该客户残保金或欠薪保障金总金额
	function getAmount(cust_id,year,payType){
	   var url = "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=getAmount&cust_id=" + cust_id+"&year="+year+"&payType="+payType;
       jQuery.ajax({
           url: url,
           type: 'post',
           dataType: 'html',
           async: false,
           timeout: 80000,
           error: function() {
               alert('Error loading XML document');
               return null;
           },
           success: function(text) {
               $id("total_amount").value = text;
           }
       });
	}
</script>
	</head>
	<body>
	<form name="form" method="post">
	<div id="right">
	<script language="javascript">
	    if(<%=isModify%>)
	        writeTableTopFesco("<fmt:message key='page_insertfinpayment'/>",'<%=request.getContextPath()%>/');
	    else
        writeTableTopFesco("<fmt:message key='page_insertfinpayment'/>",'<%=request.getContextPath()%>/');
    </script> 
<script type="text/javascript">
function rtnFuncCustomer(arg){
    var lookup = $id("cust_id");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    var service_year = $id("service_year").value;
    var payment_type_bd = $id("payment_type_bd").value;
    if((payment_type_bd == "12" || payment_type_bd == "13") && service_year != null && service_year != "" && service_year != "null"){
        getAmount(arg[0],service_year,payment_type_bd);
    }
    return false;
}

function rtnFuncUser(arg){
    var lookup = $id("emp_id");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    return false;
}
</script> 
	<div class="ringht_x">
	<div id="ccChild1" class="box_xinzeng">
	<table width="100%" height="35" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><fmt:message key='payment_type_bd'/></td>
            <td class="td_2">
            <d:select dictTypeId="PAYMENT_TYPE_BD" property="payment_type_bd"  id="payment_type_bd" value="6"  style="width:190px" nullLabel="--请选择--" onchange="setAmount1(this.value);"/></td>	    
			<td class="td_1"><fmt:message key='receiver_type_bd'/></td>
			<td class="td_2">
			<d:select dictTypeId="RECEIVER_TYPE_BD" property="receiver_type_bd"  id="receiver_type_bd" style="width:190px" nullLabel="--请选择--"/>
            </td>
			<td class="td_1"><fmt:message key='cust_name'/></td>
			<td class="td_2">
			<div>
			<w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_id" name="cust_id" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="440" width="600"  style="width:170px"/>
			</div>
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='emp_name'/></td>
			<td class="td_2">
			<w:lookup onReturnFunc="rtnFuncUser" readonly="false" id="emp_id"   name="emp_id" lookupUrl="/FinpaymentAction.do?cmd=getAllEmployeeByCondition" messagekey="select_emp" height="440" width="600" style="width:170px">

			</w:lookup>
			
			
			<td class="td_1"><fmt:message key='receiver_name'/></td>
			<td class="td_2"><input name="receiver_name" inputName="受款方"
				type="text" class="sText" id="receiver_name" value="" /></td>
			<td class="td_1"><fmt:message key='payment_month'/></td>
			<td class="td_2"><input name="payment_month" inputName="支付年月"
				type="text" class="sText" id="payment_month" value=""/></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='invoice_num'/></td>
			<td class="td_2"><input name="invoice_num" inputName="单据数量" type="text" class="sText" id="invoice_num" value="1" validate="notNull;isNum;" maxLength="8" onkeyup="if(isNaN(value))execCommand('undo')"/></td>
			<td class="td_1"><fmt:message key='apply_user_name'/></td>
            <td class="td_2"><input type="text" style="width:190px"
                class="text_field_reference_readonly" validators="isSearch"
                hiddenInputId="product_supplier" name="apply_user_name"
                inputName="申请人" maxLength="10"
                value="<%=LoginHelper.getLoginName(request)%>" /></td>
                    <input type="hidden" name="apply_user_id" id="apply_user_id" value="<%=LoginHelper.getPartyId(request)%>">
			<td class="td_1"><fmt:message key='apply_amount'/></td>
			<td class="td_2"><input name="apply_amount" inputName="申请支付金额"
				type="text" class="sText" id="apply_amount" value="" maxLength="15" onkeyup="if(isNaN(value))execCommand('undo')" validate="notNull;"/></td>
		</tr>
		<tr>
			<td class="td_1">应付年份</td>
			<td class="td_2"><input name="service_year" inputName="应付年份"
                type="text" class="sText" id="service_year" value="" onpropertychange="setAmount();" maxlength="4"/></td>
			<td class="td_1">实收总额</td>
			<td class="td_2">
			     <input name="total_amount" inputName="已收款总金额" type="text" class="sText" id="total_amount" value="" readonly="readonly"/>
			</td>
			<td class="td_1"></td>
            <td class="td_2"><!--<w:date name="service_year" format="yyyy-MM-dd"   value="${requestScope.CurrentTimestamp}"  width="170px"/>
            --></td>
		</tr>
        <tr>
            <td class="td_1"><fmt:message key='payment_purpose'/></td>
            <td colspan="5" class="td_2"><textarea name="payment_purpose"
                inputName="付款用途" rows="3" class="xText_d" id="payment_purpose"></textarea></td>
        </tr>
		<tr>
			<td class="td_1"><fmt:message key='payment_reason'/></td>
			<td colspan="5" class="td_2"><textarea name="payment_reason"
				inputName="付款原因" rows="3" class="xText_d" id="payment_reason"></textarea></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='payment_desc'/></td>
			<td colspan="5" class="td_2"><textarea name="payment_desc"
				inputName="备注" rows="3" class="xText_d" id="payment_desc"></textarea></td>
		</tr>
	</table>
	<div class="mx_button"><input type="button" class="foot_icon_2"
		value="提交支付申请" <au:authorityBtn code="sqzf_save" type="1"/> 
		onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
</div>
	</div>

	<input type="hidden" name="id" value=""> <input type="hidden"
		name="create_date" />
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
	jQuery(function(){
	    //魏佳新增--默认当前日期的年月
	    var myDate = new Date();
	    var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
	    var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
	    //var day = myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
	    if(month<10){
	      month = "0"+month;
	    }
	    var ym = year.toString()+month.toString();
	    document.getElementById("payment_month").value=ym;
	});
	
	
    $id("emp_id").beforeOpenDialog = function(lookup1){
        lookup1.params = [];
        //alert($id("cust_id").getValue());
        lookup1.addParam("cust_id", $id("cust_id").getValue());
        //alert(lookup1.getParamURL());
        return true;
    }


<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		//out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}

%>
</script>
