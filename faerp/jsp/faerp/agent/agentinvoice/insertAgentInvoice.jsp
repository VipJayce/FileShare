<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面

    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
   function checkNum1(num){
 
           var pattern =/^[0-9]{1,16}\.?[0-9]{1,2}$/;
        if(!pattern.exec(num)){
          return false;
        }
        return true;
   }
   function data_onClick(){
   var lookup=$id("payment_id");
    lookup.setValue("");
}
	function insert_onClick(){  //插入单条数据
              var invoice_code=document.getElementById("invoice_code").value;
               var agent_name=document.getElementById("agent_name").value;
                 var invoice_amount =document.getElementById("invoice_amount").value;
                    var payment_name=document.getElementById("payment_id").value;
              if(invoice_code==""||invoice_code==null){
                 alert("票据号不能为空");
                 return;
              }
                                if(invoice_amount==null ||  invoice_amount==""){
          
                alert("票据金额不能为空");
                return;
          
            }
                               if(invoice_amount!=null&& invoice_amount!=""){
            if(!checkNum1(invoice_amount)){
                alert("票据金额只能为数字（包括小数）");
                return;
            }
        }
              if(agent_name==""||agent_name==null){
              alert("供应商不能为空");
              return;
              }
                  if(payment_name==""||payment_name==null){
              alert("支付记录不能为空");
              return;
              }

		var param=jQuery("#datacell_formid").serialize();  
        var url="<%=request.getContextPath()%>/AgentInvoiceAction.do?cmd=insertInvoice&"+param;
        jQuery.post(url,function(data){
         if(data!=""){
           alert("保存成功！");
           window.close();
         }else{
               alert("保存失败！");
                window.close();
         }
        })
	}

  	function update_onClick(){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return ;
		}
		   var invoice_amount =document.getElementById("invoice_amount").value;
		        var invoice_code=document.getElementById("invoice_code").value;
              var agent_name=document.getElementById("agent_name").value;
              var payment_name=document.getElementById("payment_id").value;

        
              if(invoice_code==""||invoice_code==null){
                 alert("票据号不能为空");
                 return;
              }
                  if(invoice_amount==null || invoice_amount==""){
          
                alert("票据金额不能为空");
                return;
          
            }
                             if(invoice_amount!=null&& invoice_amount!=""){
            if(!checkNum1(invoice_amount)){
                alert("票据金额只能为数字（包括小数）");
                return;
            }
            }
              if(agent_name==""||agent_name==null){
              alert("供应商不能为空");
              return;
              }
              if(payment_name==""||payment_name==null){
              alert("支付记录不能为空");
              return;
              }
                      
               
    	     var param=jQuery("#datacell_formid").serialize();      
        var url="<%=request.getContextPath()%>/AgentInvoiceAction.do?cmd=updateInvoice&"+param;
        jQuery.post(url,function(data){

         if(data!=0){
           alert("修改成功！");
           window.close();
         }else{
               alert("修改失败！");
                window.close();
         }
        })
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="id" value="${bean.id }">
<input type="hidden" id="agent_name" name="agent_name" value="${bean.agent_name }">
<input type="hidden" id="agent_code" name="agent_code" value="${bean.agent_code }"  onpropertychange="data_onClick()">
<div id="right">
 <div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
		<td class="td_1" ><span class="style_required_red">* </span>票据号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invoice_code" name="invoice_code" inputName="invoice_code" value="${bean.invoice_code }" maxLength="64" />
            </td>
                    <td  class="td_1" ><span class="style_required_red">* </span>票据金额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="invoice_amount" name="invoice_amount" inputName="invoice_amount" maxLength="21" integerDigits="18" decimalDigits="2" value="${bean.invoice_amount }"/>
            </td>
		</tr>
		<tr>
		<td class="td_1" ><span class="style_required_red">* </span>供应商名称</td>
            <td class="td_2 ">
            <w:lookup readonly="true" id="agent_id" validateAttr="allowNull=false;" name="agent_id"
            lookupUrl="/FAERP/AgentAction.do?cmd=getAllagentByCondition" style="width:187px"
            dialogTitle="选择客户" height="450" width="610" displayValue="${bean.agent_name}" value="${bean.agent_id }"  />
            </td>
                <td class="td_1" ><span class="style_required_red">* </span>支付申请记录</td>
            <td class="td_2 ">
            <w:lookup readonly="true" id="payment_id" validateAttr="allowNull=false;" name="payment_id"
            lookupUrl="/FAERP/AgentInvoiceAction.do?cmd=getinvoiceByCondition" style="width:187px" 
            dialogTitle="选择支付记录" height="450" width="610" displayValue="${bean.payment_purpose}" value="${bean.payment_id }" />
            </td>
		</tr>
	
		
	<tr>
			<td class="td_1" >开票日期</td>
			<td class="td_2">
				<w:date allowInput="true" id="invoice_date" name="invoice_date" format="yyyy-MM-dd" width="187px" property="bean/invoice_date"/>  
			</td>
			<td class="td_1" >票据日期</td>
            <td class="td_2">
            <w:date allowInput="true" id="bill_date" name="bill_date" format="yyyy-MM-dd" width="187px" property="bean/bill_date"/>  
              
            </td>
		</tr>
		<tr>
            <td class="td_1">备注</td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="2" name="inv_desc" inputName="inv_desc" maxLength="1000" >${bean.inv_desc }</textarea>
            </td>
        </tr>
		
	
	</table>
 

            
   
   
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
</div></div>


</form>
</fmt:bundle>

</body>
</html>

<script language="javascript">
$id("agent_id").onReturnFunc=function(returnValue){
   var lookup=$id("agent_id");
    lookup.value=returnValue[0];
    lookup.displayValue = returnValue[1];
     jQuery("#agent_name").val(returnValue[1]);   
       jQuery("#agent_code").val(returnValue[2]);   
       
    return false;
}

$id("payment_id").beforeOpenDialog=function(lookup){
     lookup.params = [];
       var agent_id=document.getElementById("agent_id").value;
       if(agent_id!=null && agent_id!=""){
   
         lookup.addParam("agent_id",agent_id);
           return true;
       }else{
        alert("请先选择供应商！");
        return false;
       }
}
$id("payment_id").onReturnFunc=function(returnValue){
   var lookup=$id("payment_id");
    lookup.value=returnValue[0];
    lookup.displayValue = returnValue[1];
  
       
    return false;
}
   
</script>
